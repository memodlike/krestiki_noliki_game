import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      home: TicTacToe(),
    );
  }
}

class TicTacToe extends StatefulWidget {
  @override
  _TicTacToeState createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  List<List<String>> board = [
    ['', '', ''],
    ['', '', ''],
    ['', '', '']
  ];
  String turn = 'X';
  String winner = '';
  bool gameOver = false;

  void checkWinner() {
    // Check rows
    for (int row = 0; row < 3; row++) {
      if (board[row][0] == board[row][1] &&
          board[row][1] == board[row][2] &&
          board[row][0] != '') {
        winner = board[row][0];
        return;
      }
    }

    // Check columns
    for (int col = 0; col < 3; col++) {
      if (board[0][col] == board[1][col] &&
          board[1][col] == board[2][col] &&
          board[0][col] != '') {
        winner = board[0][col];
        return;
      }
    }

    // Check diagonals
    if (board[0][0] == board[1][1] &&
        board[1][1] == board[2][2] &&
        board[0][0] != '') {
      winner = board[0][0];
      return;
    }
    if (board[0][2] == board[1][1] &&
        board[1][1] == board[2][0] &&
        board[0][2] != '') {
      winner = board[0][2];
      return;
    }
    if (winner.isNotEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('The winner is $winner!'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  // Widget winnerText() {
  //   if (winner.isNotEmpty) {
  //     return Text(
  //       'Winner: $winner',
  //       style: TextStyle(
  //         fontSize: 20.0,
  //         fontWeight: FontWeight.bold,
  //       ),
  //     );
  //   }
  //   return Container();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tic Tac Toe'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(20.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.0,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount: 9,
              itemBuilder: (BuildContext context, int index) {
                int row = index ~/ 3;
                int col = index % 3;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (board[row][col].isEmpty) {
                        board[row][col] = turn;
                        if (turn == 'X') {
                          turn = 'O';
                        } else {
                          turn = 'X';
                        }
                      }
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        board[row][col],
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            child: ElevatedButton(
              child: Text('Restart Game'),
              onPressed: () {
                setState(() {
                  board = [
                    ['', '', ''],
                    ['', '', ''],
                    ['', '', '']
                  ];
                  turn = 'X';
                  winner = '';
                  gameOver = false;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
