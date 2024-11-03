import 'dart:async';
import 'package:btk_project/Ui/screen/chat/chat_screen.dart';
import 'package:flutter/material.dart';

class QuestionScreen extends StatefulWidget {
  final String? question;

  const QuestionScreen({
    super.key,
    this.question,
  });

  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  int _currentQuestionIndex = 0;
  int _score = 0;
  List<Map<String, dynamic>> _questions = [];
  bool _isLoading = true;
  Timer? _timer;
  int _remainingSeconds = 300; // 5 dakika = 300 saniye

  @override
  void initState() {
    super.initState();
    _fetchQuestions();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel(); // Timer'ı kapat
    super.dispose();
  }

  Future<void> _fetchQuestions() async {
    await Future.delayed(const Duration(seconds: 1)); // Simülasyon için gecikme

    setState(() {
      _questions = [
        {
          'question':
              'Bir bahçede 3 grup, her biri 5 ağaç dikecektir. Ancak bir grup, dikilecek ağaç sayısını 3 katına çıkarır. Etkinlik sonunda toplam kaç ağaç dikildi?',
          'options': [
            '15',
            '18',
            '20',
            '12',
            '25',
          ],
          'answer': '20'
        },
        {
          'question':
              'Bir öğrenci, sınav hazırlık döneminde günde 4 saat çalışarak haftada 5 gün çalışmayı hedefliyor. Ancak ders konuları beklediğinden daha yoğun olduğu için hafta sonunda fazladan 2 saat çalışmaya karar veriyor. Bu şekilde çalıştığı her hafta, bir sonraki hafta 30 dakika daha fazla çalışarak hazırlık süresini artırıyor. 6 hafta sonunda bu öğrenci toplam kaç saat çalışmış olur?',
          'options': [
            '120 saat',
            '140 saat',
            '135 saat',
            '160 saat',
            '150 saat'
          ],
          'answer': '135 saat',
        },
        {
          'question':
              'Bir marketten üç çeşit meyve almak isteyen bir öğrenci, bütçesini dengeli kullanmak istiyor. Elinde 120 TL’si var ve meyvelerin kilogram fiyatları sırasıyla 15 TL, 20 TL ve 25 TL. Toplamda 5 kilogram meyve alması gerekiyor ve her meyveden en az 1 kilogram almak istiyor. Bu durumda öğrencinin aldığı her meyveden kaç kilogram alması gerektiğini ve harcayacağı toplam miktarı hesaplayın.',
          'options': [
            '1 kg, 2 kg, 2 kg — 120 TL',
            '2 kg, 1 kg, 2 kg — 110 TL',
            '1 kg, 3 kg, 1 kg — 125 TL',
            '2 kg, 2 kg, 1 kg — 130 TL',
            '1 kg, 2 kg, 2 kg — 115 TL'
          ],
          'answer': '1 kg, 2 kg, 2 kg — 120 TL',
        },
        {
          'question':
              'Bir kitap okuma yarışmasına katılan öğrenciler, yarışma boyunca toplam 600 sayfa okumuştur. Öğrenciler yarışmayı haftada 4 gün, günde 1 saat okuyarak 5 haftada tamamlamışlardır. Ancak bazı günler 30 dakika ekstra okuma yaparak programlarını tamamlamışlardır. Eğer her okuma saati başına 20 sayfa okuyorlarsa, öğrencilerin haftalık kaç gün ekstra süreyle okuma yaptıklarını bulun.',
          'options': [
            '1 gün',
            '2 gün',
            '3 gün',
            '4 gün',
            ' 5 gün',
          ],
          'answer': '3 gün',
        },
        {
          'question':
              'Bir spor kulübü, öğrenciler için bir koşu etkinliği düzenlemektedir. Katılımcılar, her hafta koşularını 2 kilometre artırarak koşmaktadır. İlk hafta 3 kilometre koşan öğrenciler, her hafta mesafeyi artırarak 8 hafta boyunca koşuya devam ederler. Toplamda kaç kilometre koşmuş olacaklarını ve son hafta kaç kilometre koşmaları gerektiğini hesaplayın.',
          'options': [
            '48 km, 17 km',
            '52 km, 18 km',
            '56 km, 17 km',
            '60 km, 19 km',
            ' 52 km, 18 km'
          ],
          'answer': '52 km, 18 km',
        },
      ];
      _isLoading = false;
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _remainingSeconds--;
      });

      if (_remainingSeconds <= 0) {
        _timer?.cancel();
        _showResult();
      }
    });
  }

  void _answerQuestion(String answer) {
    if (answer == _questions[_currentQuestionIndex]['answer']) {
      setState(() {
        _score++;
      });
    }

    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    } else {
      _timer?.cancel(); // Sınav sona erdiğinde timer'ı kapat
      _showResult();
    }
  }

  void _showResult() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text('Sonuç'),
          content: Text('Puanınız: $_score/${_questions.length}'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dialog'u kapat
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (context) => const ChatScreen(
                            sessionTitle: '',
                          )),
                ); // QuestionScreen'den çık ve ChatScreen'e git
              },
              child: const Text('Tamam'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(title: const Text('Quiz Soruları')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    double progress = _remainingSeconds / 300; // İlerleme oranını hesapla

    return Scaffold(
      backgroundColor: const Color(0xFF2C2C2C),
      appBar: AppBar(
        leading: backButton(context),
        title: const Text(
          'Quiz Soruları',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF2C2C2C),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LinearProgressIndicator(
              value: progress,
              minHeight: 10,
              backgroundColor: Colors.grey[300],
              color: Colors.blue,
            ),
            const SizedBox(height: 20),
            Text(
              'Kalan Süre: ${(_remainingSeconds ~/ 60).toString().padLeft(2, '0')}:${(_remainingSeconds % 60).toString().padLeft(2, '0')}',
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white60),
            ),
            const SizedBox(height: 20),
            Text(
              _questions[_currentQuestionIndex]['question'],
              style: const TextStyle(fontSize: 22, color: Colors.white60),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _questions[_currentQuestionIndex]['options']
                  .map<Widget>((option) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: ElevatedButton(
                          onPressed: () => _answerQuestion(option),
                          child: Text(option,
                              style: const TextStyle(fontSize: 18)),
                        ),
                      ))
                  .toList(),
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
}
