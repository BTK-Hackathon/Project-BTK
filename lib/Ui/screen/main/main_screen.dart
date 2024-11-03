import 'package:flutter/material.dart';
import '../../../product/widgets/category_card.dart';
import '../chat/chat_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<String> tasks = []; // Task değerlerini saklamak için bir liste

  void _addTask(String task) {
    setState(() {
      tasks.add(task); // tasks listesine yeni bir görev ekleyin
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2C2C2C),
      appBar: AppBar(
        leading: backButton(context),
        backgroundColor: Color(0xFF2C2C2C),
        title:
            const Text('BTK-Hackathon', style: TextStyle(color: Colors.white)),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white60,
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const ChatScreen(
                      sessionTitle: '',
                    )),
          );

          if (result != null) {
            _addTask(result.toString()); // Yeni görevi listeye ekleyin
          }
        },
        child: const Icon(Icons.add, color: Colors.black),
      ),
      body: SingleChildScrollView(
        // Kaydırılabilir hale getirmek için
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16.0),
              // GridView burada değil, aşağıda yer alacak
              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                shrinkWrap: true, // İçerik alanını kaplamasını sağlar
                physics:
                    NeverScrollableScrollPhysics(), // Kaydırmayı devre dışı bırakır
                children: [
                  // Sabit kartlar
                  CategoryCard(
                    title: 'Population',
                    chatNumber: 'Sohbet 1', // Numaralandırma
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const ChatScreen(sessionTitle: 'Population'),
                        ),
                      );
                    },
                  ),
                  CategoryCard(
                    title: 'Alternatives to an alarm clock',
                    chatNumber: 'Sohbet 2', // Numaralandırma
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ChatScreen(
                              sessionTitle: 'Alternatives to an alarm clock'),
                        ),
                      );
                    },
                  ),
                  // Dinamik kartlar
                  ...tasks.asMap().entries.map((entry) {
                    int index = entry.key; // Indeks numarasını al
                    String task = entry.value; // Görevi al
                    return CategoryCard(
                      title: task,
                      chatNumber: 'Sohbet ${index + 3}', // Numaralandırma
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ChatScreen(sessionTitle: task),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ],
              ),
            ],
          ),
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
}
