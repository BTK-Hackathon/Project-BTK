import 'package:btk_hackathon/feature/home/view/mixin/chat_screen.dart';
import 'package:btk_hackathon/feature/home/view/widget/category_card.dart';
import 'package:btk_hackathon/feature/home/view/mixin/search_bar.dart';
import 'package:flutter/material.dart';

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
      appBar: AppBar(
        title: Text('BTK-Hackathon'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ChatScreen()),
          );

          // `result` null değilse yeni bir görevi listeye ekleyin
          if (result != null) {
            _addTask(result
                .toString()); // `result` burada `task` değerine eşit olacak
          }
        },
        child: Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SearchBar(),
            SizedBox(height: 16.0),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                children: [
                  // Sabit kartlar
                  CategoryCard(title: 'Population'),
                  CategoryCard(title: 'Alternatives to an alarm clock'),
                  // Dinamik kartlar
                  ...tasks.map((task) => CategoryCard(title: task)).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
