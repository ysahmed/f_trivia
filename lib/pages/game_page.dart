import 'package:f_trivia/providers/game_page_provider.dart';
import 'package:f_trivia/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:provider/provider.dart';

class GamePage extends StatelessWidget {
  double? _deviceHeight, _deviceWidth;
  final String difficultyLevel;
  var unescape = HtmlUnescape();

  GamePage({super.key, required this.difficultyLevel});

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: ChangeNotifierProvider(
        create: (context) => GamePageProvider(difficulty: difficultyLevel),
        child: Scaffold(
          body: SizedBox(
            height: _deviceHeight,
            width: _deviceWidth,
            child: Consumer<GamePageProvider>(
              builder: (context, value, child) {
                var pageProvider = context.read<GamePageProvider>();

                if (pageProvider.questions.isEmpty) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.amber,
                    ),
                  );
                }

                return Builder(builder: (context) {
                  if (value.end) {
                    return _gameEndUI(
                        pageProvider.startOver, pageProvider.correctCount);
                  }
                  return _gameUI(context, pageProvider);
                });
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _gameUI(BuildContext context, GamePageProvider pageProvider) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: _deviceWidth! * 0.08),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            unescape.convert(pageProvider.getCurrentQuestion()),
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
          Column(
            children: [
              _button(
                onPressed: () async {
                  await _showIsCorrectDialog(
                      context, pageProvider.checkAnswer("True"));
                  pageProvider.getNext();
                },
                color: Colors.green,
                text: "True",
              ),
              const SizedBox(
                height: 8,
              ),
              _button(
                onPressed: () async {
                  await _showIsCorrectDialog(
                      context, pageProvider.checkAnswer("False"));
                  pageProvider.getNext();
                },
                color: Colors.red,
                text: "false",
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _gameEndUI(VoidCallback callback, int correctCount) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Game End!',
          style: TextStyle(
            fontSize: 30,
          ),
        ),
        Text(
          'Score: $correctCount/10',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: correctCount >= 5 ? Colors.green : Colors.red,
          ),
        ),
        _button(onPressed: callback, color: Colors.blue, text: "Start over!"),
      ],
    );
  }

  Widget _button({
    required VoidCallback onPressed,
    required Color color,
    required String text,
  }) =>
      Button(
          onPressed: onPressed,
          color: color,
          height: _deviceHeight! * 0.10,
          width: _deviceWidth! * 0.80,
          text: text);

  Future<void> _showIsCorrectDialog(
      BuildContext context, bool isCorrect) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: isCorrect ? Colors.green : Colors.red,
        icon: Icon(
          isCorrect ? Icons.check_circle : Icons.cancel_sharp,
        ),
      ),
    );

    await Future.delayed(
      const Duration(seconds: 1),
      () => Navigator.pop(context),
    );
  }
}
