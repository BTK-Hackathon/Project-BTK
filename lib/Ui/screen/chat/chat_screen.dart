import 'package:btk_project/product/extension/context_extesion.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../question/question_screen.dart';

class ChatScreen extends StatefulWidget {
  final String sessionTitle; // Yeni parametre ekliyoruz

  const ChatScreen(
      {super.key, required this.sessionTitle}); // Yapıcıya ekliyoruz

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final WebSocketChannel _channel = WebSocketChannel.connect(
    Uri.parse(
        'ws://10.0.2.2:8000/ws/ask_gemini'), // WebSocket URL'sini güncelleyin
  );

  String _response = '';
  bool isSending = false; // Gönderim durumunu kontrol etmek için bir bayrak
  final String userId =
      '12345'; // Örnek kullanıcı ID'si, bunu uygulamanıza uygun hale getirin.

  Future<void> sendRequest() async {
    if (isSending) {
      setState(() {
        _response = "Zaten bir istek gönderildi. Lütfen yanıtı bekleyin.";
      });
      return;
    }

    isSending = true;

    final task = _taskController.text;
    _channel.sink.add(task);

    _channel.stream.listen((message) {
      setState(() {
        _response = message;
      });

      isSending = false;
    }, onError: (error) {
      setState(() {
        _response = "Bir hata oluştu: $error";
      });

      isSending = false;
    });
  }

  Future<void> saveConversation() async {
    final task = _taskController.text;
    final content = _contentController.text;
    final response = _response;

    _channel.sink.add("kaydet|$task|$content|$response");

    await Future.delayed(const Duration(milliseconds: 500));
    Navigator.pop(context, task); // task değerini MainScreen'e geri gönder
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2C2C2C),
      appBar: AppBar(
        backgroundColor: Color(0xFF2C2C2C), // AppBar rengi
        title: Text(widget.sessionTitle), // sessionTitle'ı kullan
        actions: [
          IconButton(
            icon: const Icon(
              Icons.question_answer,
              color: Colors.white,
            ), // Soru ikonu
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const QuestionScreen(),
                ),
              );
            },
          ),
        ],
        leading: backButton(context),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _taskController,
              decoration: const InputDecoration(
                labelText: 'Yapay Zekaya Yaptırılmak İstenilen İşlem',
                labelStyle: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            TextField(
              controller: _contentController,
              decoration: const InputDecoration(
                labelText: 'Sorulacak Soru',
                labelStyle: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: sendRequest,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 0),
                foregroundColor: Colors.white,
                backgroundColor: Colors.blueAccent, // Yazı rengi
                elevation: 15, // Gölge efekti
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // Kenar yuvarlama
                ),
                padding: const EdgeInsets.symmetric(
                    vertical: 10, horizontal: 30), // İç boşluk
              ),
              child: const Text(
                'Gönder',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ), // Yazı stili
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                saveConversation();
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 0),
                foregroundColor: Colors.white,
                backgroundColor: Colors.green, // Yazı rengi
                elevation: 10, // Gölge efekti
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // Kenar yuvarlama
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 30,
                ),
              ),
              child: const Text(
                'Kaydet',
                style: TextStyle(
                    color: Colors.white70,
                    fontSize: 18,
                    fontWeight: FontWeight.bold), // Yazı stili
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Yanıt:',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white70),
            ),
            SizedBox(height: context.dynamicHeight(0.1)),
            Flexible(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    _response.isNotEmpty
                        ? _response
                        : 'Nasıl Yardımcı Olabilirim?',
                    style: const TextStyle(fontSize: 24, color: Colors.white),
                    softWrap: true, // Metnin sarmalanmasını sağlar
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Positioned backButton(BuildContext context) {
    return Positioned(
      child: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }
}
