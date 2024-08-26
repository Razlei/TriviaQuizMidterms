import 'package:flutter/material.dart';

void main() {
  runApp(QuizApp());
}

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trivia Quiz',
      home: QuizScreen(),
    );
  }
}

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  int _correctAnswers = 0;

  late List<Map<String, dynamic>> _quizData;

  @override
  void initState() {
    super.initState();
    _quizData = List.from(_initialQuizData); // Copy the initial quiz data
    _quizData.shuffle(); // Shuffle the quiz data
  }

  final List<Map<String, dynamic>> _initialQuizData = [
    {
      'question': 'What is the loudest animal?',
      'options': ['Lion', 'Elephant', 'Blue Whale', 'Howler Monkey'],
      'correctAnswer': 'Blue Whale',
    },
    {
      'question': 'what animal can sleep up to three (3) years straight?',
      'options': ['Koala', 'Snail', 'Bat', 'Crocodile'],
      'correctAnswer': 'Snail',
    },
    {
      'question': 'What is the only planet in our solar system that rotates on its side?',
      'options': ['Mercury', 'Venus', 'Uranus', 'Mars'],
      'correctAnswer': 'Uranus',
    },
    {
      'question': 'Which country is both an island and a continent?',
      'options': ['Australia', 'Madagascar', 'New Zealand', 'Greenland'],
      'correctAnswer': 'Australia',
    },
    {
      'question': "Which country is home to the world's oldest continuously inhabited city?",
      'options': ['Egypt', 'Greece', 'Iraq', 'China'],
      'correctAnswer': 'Iraq',
    },
    {
      'question': "What is the world's largest desert that is not covered in sand?",
      'options': ['Sahara Desert', 'Gobi Desert', 'Antartica', 'Artic Desert'],
      'correctAnswer': 'Antartica',
    },
    {
      'question': 'What is the smallest country in the world?',
      'options': ['Philippines', 'Papua New Guinea', 'Vatican City', 'Palau'],
      'correctAnswer': 'Vatican City',
    },
    {
      'question': 'What is the capital city of Canada?',
      'options': ['Toronto', 'Ottawa', 'Montreal', 'Vancouver'],
      'correctAnswer': 'Ottawa',
    },
    {
      'question': 'what is the chemical symbol for the element gold',
      'options': ['Au', 'Ag', 'Gd', 'Gl'],
      'correctAnswer': 'Au',
    },
    {
      'question': 'Which planet is known as the "evening star" or the "morning star" due to its brightness and visibility?',
      'options': ['Mars', 'Venus', 'Mercury', 'Jupiter'],
      'correctAnswer': 'Venus',
    },

  ];

  void _answerQuestion(String selectedAnswer) {
    if (selectedAnswer == _quizData[_currentQuestionIndex]['correctAnswer']) {
      setState(() {
        _correctAnswers++;
      });
    }
    _nextQuestion();
  }

  void _nextQuestion() {
    setState(() {
      if (_currentQuestionIndex < _quizData.length - 1) {
        _currentQuestionIndex++;
      } else {
        // End of quiz, show result
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultScreen(correctAnswers: _correctAnswers, totalQuestions: _quizData.length),
          ),
        ).then((_) {
          // Reset quiz when returning from result screen
          setState(() {
            _currentQuestionIndex = 0;
            _correctAnswers = 0;
            _quizData.shuffle(); // Shuffle the quiz data for the next round
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trivia Quiz'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(_quizData[_currentQuestionIndex]['question']),
          SizedBox(height: 20),
          Column(
            children: (_quizData[_currentQuestionIndex]['options'] as List<String>).map((option) {
              return ListTile(
                title: Text(option),
                onTap: () {
                  _answerQuestion(option);
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class ResultScreen extends StatelessWidget {
  final int correctAnswers;
  final int totalQuestions;

  ResultScreen({required this.correctAnswers, required this.totalQuestions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Result'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('You answered $correctAnswers out of $totalQuestions questions correctly.'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Go back to the quiz screen
              },
              child: Text('Restart Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}
