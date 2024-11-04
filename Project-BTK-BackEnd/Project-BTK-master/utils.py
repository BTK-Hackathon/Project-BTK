import re

# Cevabı temizleyen fonksiyon
def clean_response(response_text):
    # İlk olarak, yıldız karakterlerini temizle (çarpma işlemi olanları koruyarak)
    cleaned_text = re.sub(r'\s*\*\s*', '', response_text)
    # Ardından, gereksiz yeni satırları kaldır
    # Sadece bir yeni satır bırak
    cleaned_text = re.sub(r'\n+', '\n', cleaned_text.strip())
    return cleaned_text
