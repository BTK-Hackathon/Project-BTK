from pydantic import BaseModel

# Kullanıcı istek modeli
class UserRequest(BaseModel):
    task: str  # Görev adı (örn. "ödev çözme" veya "konu anlatma")
    content: str  # Kullanıcının gönderdiği içerik
    response: str
