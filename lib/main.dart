import 'package:flutter/material.dart';
import 'package:tic_tac_toe2/Start.dart';

import 'UI/Theme/Color.dart';
import 'Utils/Game.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: GameScreen(),
      initialRoute: "/StartPage",
      routes: {
        "/GameScreen": (context) => GameScreen(),
        "/StartPage": (context) => StartPage(),
      },
    );
  }
}

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  String lastValue = "X";
  bool gameOver = false;
  int turn = 0;
  String result = "";
  List<int> scoreBoard = [0, 0, 0, 0, 0, 0, 0, 0];
  Game game = Game();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    game.board = Game.initGameBoard();
    print(game.board);
  }

  @override
  Widget build(BuildContext context) {
    double boardWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Tic Tac Toe"),
        backgroundColor: MainColor.secondaryColor,
      ),
      // backgroundColor: MainColor.primaryColor,
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
            ),
            Text(
              textAlign: TextAlign.center,
              "It's ${lastValue} turn",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 50,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: boardWidth,
              height: boardWidth,
              child: GridView.count(
                crossAxisCount: Game.boardLength ~/ 3,
                padding: EdgeInsets.all(16),
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                children: List.generate(Game.boardLength, (index) {
                  return InkWell(
                    onTap: gameOver
                        ? null
                        : () {
                            if (game.board![index] == "") {
                              setState(() {
                                game.board![index] = lastValue;
                                turn++;
                                gameOver = game.winnerCheck(
                                    lastValue, index, scoreBoard, 3);
                                if (gameOver) {
                                  result = "${lastValue} is the winner";
                                } else if (!gameOver && turn == 9) {
                                  result = "Draw";
                                  gameOver = true;
                                }
                                lastValue == "X"
                                    ? lastValue = "O"
                                    : lastValue = "X";
                              });
                            }
                          },
                    child: Container(
                      height: Game.blocSize,
                      width: Game.blocSize,
                      decoration: BoxDecoration(
                          color: MainColor.secondaryColor,
                          borderRadius: BorderRadius.circular(16.0)),
                      child: Center(
                          child: Text(
                        game.board![index],
                        style: TextStyle(
                            color: game.board![index] == "X"
                                ? Colors.blue
                                : Colors.pink,
                            fontSize: 64),
                      )),
                    ),
                  );
                }),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              result,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 45,
                  fontWeight: FontWeight.bold),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  game.board = Game.initGameBoard();
                  lastValue = "X";
                  gameOver = false;
                  turn = 0;
                  result = "";
                  scoreBoard = [0, 0, 0, 0, 0, 0, 0, 0];
                });
              },
              icon: Icon(Icons.replay),
              color: MainColor.secondaryColor,
              iconSize: 40,
            ),
          ]),
    );
  }
}
