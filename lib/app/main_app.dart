import 'package:btk_hackathon/feature/home/view/main_screen.dart';
import 'package:flutter/material.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _currentPage = 0;
  final PageController _pageController = PageController();

  final List<Widget> _pages = [
    Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/image5.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      padding: const EdgeInsets.all(16.0),
      child: const Text(
        'Fastest Payment in the world',
        style: TextStyle(fontSize: 24, color: Colors.white),
        textAlign: TextAlign.center,
      ),
    ),
    Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/image10.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      padding: const EdgeInsets.all(16.0),
      child: const Text(
        'Smallest Payment in the world',
        style: TextStyle(fontSize: 24, color: Colors.white),
        textAlign: TextAlign.center,
      ),
    ),
    Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/image3.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: const Text(
        'Best Payment in the world',
        style: TextStyle(fontSize: 24, color: Colors.white),
        textAlign: TextAlign.center,
      ),
    ),
  ];

  void _nextPage(BuildContext context) {
    debugPrint('Next button clicked!'); // Butona tıklandığında log mesajı
    if (_currentPage < _pages.length - 1) {
      _currentPage++;
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Son sayfadaysanız, ana ekrana yönlendirin
      Navigator.of(context, rootNavigator: true).pushReplacement(
        MaterialPageRoute(builder: (context) => MainScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blueGrey,
        body: Stack(
          children: [
            PageView(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: _pages,
            ),
            Positioned(
              bottom: 80,
              left: 20,
              right: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_pages.length, (index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _currentPage == index ? 12 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _currentPage == index ? Colors.white : Colors.grey,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  );
                }),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Builder(builder: (BuildContext newContext) {
                return ElevatedButton(
                  onPressed: () => _nextPage(newContext),
                  child: const Text('Next'),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
