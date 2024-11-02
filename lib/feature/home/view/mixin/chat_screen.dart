import 'package:btk_hackathon/feature/home/view/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatScreen extends StatefulWidget {
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

  Future<void> sendRequest() async {
    final task = _taskController.text;
    final content = _contentController.text;

    _channel.sink.add(task); // Görev mesajını gönder

    _channel.stream.listen((message) {
      setState(() {
        _response = message; // Gelen yanıtı güncelle
      });
    });
  }

  Future<void> saveConversation() async {
    final task = _taskController.text;
    final content = _contentController.text;
    final response = _response;

    // "kaydet" mesajını gönderiyoruz
    _channel.sink.add("kaydet|$task|$content|$response");

    // WebSocket işlemi tamamlandıktan sonra ana ekrana geri dön
    await Future.delayed(Duration(milliseconds: 500));
    Navigator.pop(context, task); // task değerini MainScreen'e geri gönder
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chat Sayfası')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _taskController,
              decoration: InputDecoration(labelText: 'Görev (Task)'),
            ),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(labelText: 'İçerik (Content)'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                sendRequest();
              },
              child: Text('Gönder'),
            ),
            ElevatedButton(
              onPressed: () {
                saveConversation(); // Kaydet butonuna tıklandığında konuşmayı kaydet
              },
              child: Text('Kaydet'),
            ),
            SizedBox(height: 20),
            Text(
              'Yanıt:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(_response),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }
}
