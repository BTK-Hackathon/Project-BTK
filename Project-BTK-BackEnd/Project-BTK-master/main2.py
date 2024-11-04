from fastapi import FastAPI, HTTPException, WebSocket
from models import UserRequest
from config import generation_config, configure_gemini
from utils import clean_response
import google.generativeai as genai

# API yapılandırması
app = FastAPI()
genai = configure_gemini()  # Gemini API’yi yapılandır

# Modeli tanımlama
model = genai.GenerativeModel(
    model_name="gemini-1.5-flash",
    generation_config=generation_config,
    system_instruction="Öğrencilerin zorlandığı matematik konularında adım adım rehberlik sunan bir öğretmen gibi davran. Amacın, öğrencilerin problem çözme ve analiz becerilerini geliştirmek.",
)

# WebSocket ile sürekli etkileşim
@app.websocket("/ws/ask_gemini")
async def ask_gemini(websocket: WebSocket):
    await websocket.accept()  # WebSocket bağlantısını kabul et

    # Konuşma geçmişi için bir liste
    conversation_history = []

    while True:
        data = await websocket.receive_text()  # Kullanıcıdan gelen mesajı al
        if data.lower() == "kaydet":
            # Konuşma geçmişini dosyaya kaydet
            with open("conversation_history.txt", "w", encoding="utf-8") as f:
                for entry in conversation_history:
                    f.write(f"{entry}\n")
            await websocket.send_text("Konuşma kaydedildi. Görüşmek üzere!")
            break

        # Kullanıcının mesajını geçmişe ekle
        conversation_history.append(f"Kullanıcı: {data}")

        # Geçmişi birleştirerek prompt oluştur
        prompt = "Geçmiş konuşmalar:\n" + "\n".join(conversation_history) + f"\nGörev: {data}"

        try:
            # Model kullanarak içerik oluşturma
            response = model.generate_content(prompt)  # Burada model kullanılıyor
            clean_text = clean_response(response.text)

            # Modelin yanıtını geçmişe ekle
            conversation_history.append(f"Model: {clean_text}")
            await websocket.send_text(clean_text)  # Temizlenmiş yanıtı gönder
        except Exception as e:
            await websocket.send_text(f"Hata: {str(e)}")  # Hata durumunda mesaj gönder

    await websocket.close()  # WebSocket bağlantısını kapat
