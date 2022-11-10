import 'package:flutter/material.dart';
import 'package:tic_tac_toe2/UI/Theme/Color.dart';
import 'package:tic_tac_toe2/main.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Tic Tac Toe"),
        backgroundColor: MainColor.secondaryColor,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 80, 0, 0),
            child: Image.asset(
              "assets/image/start_page_image.jpg",
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 250,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 29),
            child: ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, "/GameScreen"),
              child: Text(
                "Start",
              ),
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(MainColor.secondaryColor),
                  fixedSize: MaterialStateProperty.all(
                    Size.fromWidth(100),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
