# Eğitim Koçu - Yapay Zeka Destekli Eğitim Platformu

## Proje Hakkında

Bu projede, eğitim kategorisinde genç yaş grubundaki kullanıcıların yanlış düşünce yapısını tespit eden ve geliştirmeye yönelik bir yapay zeka koçluk sistemi oluşturmayı amaçladık. Özellikle sorulara dair yanlış yaklaşımları analiz eden bu sistem, yalnızca soruların cevaplarını sağlamakla kalmaz, aynı zamanda yanlış düşünceleri tetikleyen unsurları belirler ve kullanıcılara doğru düşünme yollarını gösterir.

## Özellikler

- **Yapay Zeka Destekli Çözüm ve Analiz:** Yapay zeka, kullanıcı tarafından sorulan soruları analiz ederek teknik sorunları tespit eder ve kullanıcının yanlış düşünce yollarını düzeltir.
- **Koçluk Desteği:** Kullanıcının soru sorma şeklini ve düşünce yapısını analiz eder ve kişiye özel rehberlik sunar.
- **İki Metin Kutusu Sistemi:** Kullanıcı, bir metin kutusunda sorusunu, diğerinde ise yapamadığı veya anlamadığı noktaları belirtir. Bu şekilde, yapay zeka daha özelleştirilmiş yanıtlar sunar.
- **Sohbet Kaydı:** Kullanıcıların yapay zeka ile gerçekleştirdikleri tüm konuşmalar kaydedilir, böylece kullanıcılar geçmiş sohbetlere erişebilir ve hatalı yaklaşımlarını gözden geçirebilir.
- **Kısa Sınav Hazırlığı:** Yapay zeka, kullanıcının eksik ve hatalı yönlerine göre otomatik bir kısa sınav hazırlar. Ancak bu özellik, teknik nedenlerle yalnızca backend'de aktif durumdadır ve frontend'de gösterim sağlanamamaktadır.

## Teknolojiler

- **Frontend:** Flutter
- **Backend:** Python FastAPI, WebSocket protokolü

## Kurulum

1. **Gereksinimleri Karşılayın:**
   - Flutter kurulumu ve yapılandırması için [Flutter Kurulum Kılavuzu](https://docs.flutter.dev/get-started) sayfasına göz atın.
   - Python ve FastAPI kurulumu için terminalde aşağıdaki komutları çalıştırın:

     ```bash
     pip install fastapi
     pip install uvicorn
     ```

2. **Proje Dosyalarını İndirin:**
   - Projeyi klonlayın veya zip olarak indirin:

     ```bash
     git clone https://github.com/kullaniciadi/proje-adi.git
     cd proje-adi
     ```

3. **Backend Sunucusunu Başlatın:**
   - Aşağıdaki komut ile FastAPI backend sunucusunu çalıştırın:

     ```bash
     uvicorn main:app --reload --host 0.0.0.0 --port 8000
     ```

4. **Flutter Uygulamasını Çalıştırın:**
   - Flutter uygulamasını çalıştırmak için aşağıdaki komutu kullanın:

     ```bash
     flutter run
     ```

## Kullanım

- Uygulama açıldıktan sonra kullanıcı iki metin kutusu görecektir:
  - **Soru Metin Kutusu:** Kullanıcı burada sorusunu belirtir.
  - **Sorun Metin Kutusu:** Kullanıcı burada yapamadığı veya anlamadığı noktaları detaylandırır.

- Kaydetme özelliğiyle, kullanıcı sohbet geçmişine erişerek yanlış düşüncelerini gözden geçirebilir.
- Backend tarafından sağlanan ancak frontend'de görüntülenemeyen **Kısa Sınav** özelliği, kullanıcının eksik yönlerini analiz eder ve iyileştirmeye yönelik öneriler sunar.

## Teknik Detaylar

### Yapay Zeka Koçluk Mekanizması

Yapay zeka modelimiz, kullanıcının eksik veya hatalı yönlerini analiz ederek ona geri bildirim sağlar ve hatalı düşünme yollarını düzeltir. Modelden gelen öneriler, kullanıcının daha bilinçli bir düşünce yapısına sahip olmasına yardımcı olacak şekilde tasarlanmıştır. Ancak şu anda kısa sınav özelliği teknik bir aksaklık nedeniyle frontend’de sunulamamaktadır.

### Teknik Sorunlar ve Çözümler

- **Kısa Sınav Gönderimi:** Yapay zeka modeli, kullanıcının eksik yönlerini belirleyip kısa sınav önerilerini hazırlayabilmektedir. Ancak, backend'de çalışan bu özellik frontend'e aktarılmada bir sorun yaşamaktadır.
- **WebSocket Bağlantısı:** WebSocket bağlantıları, kullanıcıya gerçek zamanlı geri bildirim sunarak sorulara yönelik hızlı analiz sağlar.

## Lisans

Bu proje, [MIT Lisansı](LICENSE) ile lisanslanmıştır.
