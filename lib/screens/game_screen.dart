import 'package:flutter/material.dart';
import 'package:snake_game/controllers/game_controller.dart';
import 'package:snake_game/screens/game_over_screen.dart';
import 'package:snake_game/widgets/game_board.dart';
import 'package:snake_game/widgets/game_controls.dart';
import 'package:snake_game/widgets/game_header.dart';
import 'package:snake_game/widgets/game_info_bar.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  static const int boardWidth = 20;
  static const int boardHeight = 15;
  
  late GameController gameController;
  bool isGameInitialized = false;
  double? cellSize;
  
  @override
  void initState() {
    super.initState();
    
    // Initialize game controller
    gameController = GameController(
      boardWidth: boardWidth,
      boardHeight: boardHeight,
      onUpdate: () {
        if (mounted) setState(() {});
      },
      onGameOver: handleGameOver,
    );
  }
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    
    // Calculate cell size
    cellSize = getCellSize(context);
    
    // Initialize game when cell size is available
    if (!isGameInitialized && cellSize != null) {
      gameController.cellSize = cellSize;
      gameController.initialize(cellSize!);
      isGameInitialized = true;
    }
  }
  
  double getCellSize(BuildContext context) {
    // Calculate cell size based on available width for a column layout
    final screenSize = MediaQuery.of(context).size;
    final availableWidth = screenSize.width * 0.95; // Use 95% of width
    final availableHeight = screenSize.height * 0.5; // Use 50% of height for game board
    
    // Choose the more constraining dimension to ensure cells fit both width and height
    final heightBasedCellSize = availableHeight / boardHeight;
    final widthBasedCellSize = availableWidth / boardWidth;
    
    return heightBasedCellSize < widthBasedCellSize 
        ? heightBasedCellSize 
        : widthBasedCellSize;
  }
  
  void handleGameOver() {
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => GameOverScreen(
            score: gameController.score,
            snakeLength: gameController.snake.parts.length,
          ),
        ),
      );
    }
  }
  
  @override
  void dispose() {
    gameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Show loading indicator if game is not yet initialized
    if (cellSize == null || !isGameInitialized || gameController.food == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Game Header
            GameHeader(
              lives: gameController.lives,
              score: gameController.score,
              highScore: gameController.highScore,
              isPlaying: gameController.isPlaying,
              isSoundOn: gameController.isSoundOn,
              onTogglePlayPause: gameController.togglePlayPause,
              onToggleSound: gameController.toggleSound,
            ),
            
            // Game Board
            Expanded(
              flex: 6,
              child: GameBoard(
                snake: gameController.snake,
                food: gameController.food!,
                obstacles: gameController.obstacles,
                cellSize: cellSize!,
                boardWidth: boardWidth,
                boardHeight: boardHeight,
              ),
            ),
            
            // Game Info Bar
            GameInfoBar(
              snakeLength: gameController.snake.parts.length,
            ),
            
            // Game Controls
            Expanded(
              flex: 3,
              child: GameControls(
                onDirectionChange: gameController.changeDirection,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
