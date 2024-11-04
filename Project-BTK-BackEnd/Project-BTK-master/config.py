import os
import google.generativeai as genai
from dotenv import load_dotenv

load_dotenv()


def configure_gemini():
    genai.configure(api_key=os.getenv("GEMINI_API_KEY"))
    return genai


# İstek ayarları (örn. sıcaklık, top_p, top_k)
generation_config = {
  "temperature": 1,
  "top_p": 0.95,
  "top_k": 64,
  "max_output_tokens": 8192,
  "response_mime_type": "text/plain",
}
