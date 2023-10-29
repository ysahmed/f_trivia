import 'package:f_trivia/pages/game_page.dart';
import 'package:f_trivia/widgets/button.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late double _deviceHeight, _deviceWidth;
  double _difficultyLevel = 0;
  final List<String> _difficultyText = ['Easy', 'Medium', 'Hard'];

  @override
  Widget build(BuildContext context) {
    _deviceWidth = MediaQuery.of(context).size.width;
    _deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: _deviceHeight,
          width: _deviceWidth,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: _deviceWidth * 0.08,
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      const Text(
                        'Trivia',
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        _difficultyText[_difficultyLevel.toInt()],
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                  Slider(
                    label: _difficultyText[_difficultyLevel.toInt()],
                    min: 0,
                    max: 2,
                    divisions: 2,
                    value: _difficultyLevel,
                    onChanged: (value) {
                      setState(() {
                        _difficultyLevel = value;
                      });
                    },
                  ),
                  Button(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GamePage(
                                difficultyLevel:
                                    _difficultyText[_difficultyLevel.toInt()]),
                          ),
                        );
                      },
                      color: Colors.blue,
                      height: _deviceHeight * 0.1,
                      width: _deviceWidth * 0.8,
                      text: 'Start'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
