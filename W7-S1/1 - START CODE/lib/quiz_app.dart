import 'package:flutter/material.dart';
import 'package:flutterwithronan/W7-S1/1%20-%20START%20CODE/lib/screens/welcome_screen.dart';
import 'package:flutterwithronan/W7-S1/1%20-%20START%20CODE/lib/widgets/app_button.dart';
import 'model/quiz.dart';
Color appColor = Colors.blue[500] as Color;
 
class QuizApp extends StatefulWidget {
  const QuizApp(this.quiz, {super.key});

  final Quiz quiz;

  @override
  State<QuizApp> createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: appColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const WelcomeScreen(),
              AppButton("Click me",
              onTap: () { 
                print('Button clicked!');
               }
              ,
              )
            ],
          ),
        ),
      ),
    );
  }
}
