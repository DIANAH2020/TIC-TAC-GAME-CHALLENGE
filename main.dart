import 'dart:io';

class TicTacToe {
  List<List<String>> board;
  String currentPlayer;

  TicTacToe() {
    board = List.generate(3, (_) => List.generate(3, (_) => ' '));
    currentPlayer = 'X';
  }

  void printBoard() {
    for (var row in board) {
      print(row.join(' | '));
      print('---------');
    }
  }

  bool makeMove(int row, int col) {
    if (row < 0 || row >= 3 || col < 0 || col >= 3 || board[row][col] != ' ') {
      return false;
    }
    board[row][col] = currentPlayer;
    return true;
  }

  bool checkWin() {
    // Check rows
    for (var row in board) {
      if (row.every((cell) => cell == currentPlayer)) {
        return true;
      }
    }
    // Check columns
    for (var col = 0; col < 3; col++) {
      if (board[0][col] == currentPlayer &&
          board[1][col] == currentPlayer &&
          board[2][col] == currentPlayer) {
        return true;
      }
    }
    // Check diagonals
    if ((board[0][0] == currentPlayer &&
            board[1][1] == currentPlayer &&
            board[2][2] == currentPlayer) ||
        (board[0][2] == currentPlayer &&
            board[1][1] == currentPlayer &&
            board[2][0] == currentPlayer)) {
      return true;
    }
    return false;
  }

  bool isBoardFull() {
    return board.every((row) => row.every((cell) => cell != ' '));
  }

  void switchPlayer() {
    currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
  }
}

void main() {
  var game = TicTacToe();
  bool gameOver = false;

  print('Welcome to Tic Tac Toe!');
  while (!gameOver) {
    print('\nCurrent board:');
    game.printBoard();

    print('\nPlayer ${game.currentPlayer}, make your move (row column):');
    var input = stdin.readLineSync();
    var coordinates = input.trim().split(' ');
    if (coordinates.length != 2) {
      print('Invalid input. Please provide row and column numbers separated by space.');
      continue;
    }
    var row = int.tryParse(coordinates[0]);
    var col = int.tryParse(coordinates[1]);
    if (row == null || col == null) {
      print('Invalid input. Please provide valid row and column numbers.');
      continue;
    }

    if (game.makeMove(row, col)) {
      if (game.checkWin()) {
        print('\nPlayer ${game.currentPlayer} wins!');
        gameOver = true;
      } else if (game.isBoardFull()) {
        print('\nThe game is a draw!');
        gameOver = true;
      } else {
        game.switchPlayer();
      }
    } else {
      print('\nInvalid move. Please try again.');
    }
  }
}
