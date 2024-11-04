from fastapi import FastAPI, HTTPException, WebSocket
from models import UserRequest
from config import generation_config, configure_gemini
from utils import clean_response
import google.generativeai as genai
import firebase_admin
from firebase_admin import credentials, firestore

# API yapılandırması
app = FastAPI()
genai = configure_gemini()  # Gemini API’yi yapılandır

# Firebase'i başlat
cred = credentials.Certificate("btk-hackathon-firebase-adminsdk-6uno2-5e735ca14c.json")  # Firebase kimlik dosyanızın yolu
firebase_admin.initialize_app(cred)
db = firestore.client()  # Firestore istemcisi oluştur

# Modeli tanımlama
model = genai.GenerativeModel(
    model_name="gemini-1.5-flash",
    generation_config=generation_config,
    system_instruction="Öğrencilerin zorlandığı matematik konularında adım adım rehberlik sunan bir öğretmen gibi davran. Amacın, öğrencilerin problem çözme ve analiz becerilerini geliştirmek.",
)

# Firebase'e konuşmayı kaydetme fonksiyonu
async def save_conversation(task, context, response):
    # 'hackathon' koleksiyonuna belge ekle ve chat alt koleksiyonunu oluştur
    document_ref = db.collection('hackathon').document()  # Yeni belge referansı oluştur
    await document_ref.set({
        'task': task,
        'context': context,
        'response': response
    })
    
    # "chat" alt koleksiyonuna ekle
    await document_ref.collection('chat').add({
        'task': task,
        'context': context,
        'response': response
    })
    
    return document_ref.id  # Kaydedilen belgenin kimliğini döndür

# WebSocket ile sürekli etkileşim
@app.websocket("/ws/ask_gemini")
async def ask_gemini(websocket: WebSocket):
    await websocket.accept()  # WebSocket bağlantısını kabul et

    while True:
        data = await websocket.receive_text()  # Kullanıcıdan gelen mesajı al

        # Eğer "kaydet" mesajı alırsak, Firebase'e kaydetme işlemi yapacağız
        if data.lower().startswith("kaydet"):
            parts = data.split("|")
            if len(parts) == 4:  # task, context ve response'u içermelidir
                task = parts[1]
                context = parts[2]
                response = parts[3]
                await save_conversation(task, context, response)  # Firebase'e kaydet
                await websocket.send_text("Konuşma kaydedildi. Görüşmek üzere!")
                break  # Kaydetme işleminden sonra bağlantıyı kapatabiliriz

        # Kullanıcıdan gelen mesaja göre prompt oluşturma
        prompt = f"Görev: {data}"

        try:
            # Model kullanarak içerik oluşturma
            response = model.generate_content(prompt)  # Modelden içerik üret
            clean_text = clean_response(response.text)
            await websocket.send_text(clean_text)  # Temizlenmiş yanıtı gönder
        except Exception as e:
            await websocket.send_text(f"Hata: {str(e)}")  # Hata durumunda mesaj gönder

    await websocket.close()  # Bağlantıyı kapat
