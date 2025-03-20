import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:snake_game/models/snake.dart';
import 'package:snake_game/models/food.dart';
import 'package:snake_game/services/audio_service.dart';

class GameController {
  // Game board dimensions
  final int boardWidth;
  final int boardHeight;
  
  // Game state
  Snake snake;
  Food? food;
  List<Offset> obstacles = [];
  int score = 0;
  int highScore = 0;
  int lives = 5;
  bool isPlaying = true;
  bool isSoundOn = true;
  
  // Game timer
  Timer? gameTimer;
  final Duration gameDuration;
  
  // Audio service for sound effects
  final AudioService audioService;
  
  // Callback for state updates
  final Function() onUpdate;
  
  // Callback for game over
  final Function() onGameOver;
  
  GameController({
    required this.boardWidth,
    required this.boardHeight,
    required this.onUpdate,
    required this.onGameOver,
    this.gameDuration = const Duration(milliseconds: 300),
  }) : 
    snake = Snake(boardWidth, boardHeight),
    audioService = AudioService();
  
  void initialize(double cellSize) {
    snake = Snake(boardWidth, boardHeight);
    generateObstacles();
    food = Food.generateFood(
      boardWidth, 
      boardHeight, 
      snake, 
      obstacles, 
      cellSize
    );
    
    score = 0;
    lives = 5;
    isPlaying = true;
    
    // Load audio files
    audioService.loadSounds();
    
    // Start game timer
    gameTimer = Timer.periodic(gameDuration, (timer) {
      if (isPlaying) {
        updateGame();
      }
    });
  }
  
  void generateObstacles() {
    obstacles.clear();
    final random = Random();
    
    // Generate at least 3 obstacles
    for (int i = 0; i < 3; i++) {
      // Use exact integer values for obstacles to match with snake positions
      double x = random.nextInt(boardWidth - 4) + 2.0; 
      double y = random.nextInt(boardHeight).toDouble();
      
      // Ensure obstacle is not placed where snake is initially positioned
      bool validPosition = true;
      for (var part in snake.parts) {
        if ((part.x - x).abs() < 2 && (part.y - y).abs() < 2) {
          validPosition = false;
          break;
        }
      }
      
      if (validPosition) {
        obstacles.add(Offset(x, y));
      } else {
        i--; // Try again
      }
    }
  }
  
  void updateGame() {
    snake.move();
    
    // Check for collisions
    if (snake.checkCollisionWithWall(boardWidth, boardHeight) ||
        snake.checkCollisionWithSelf() ||
        checkCollisionWithObstacle()) {
      handleCollision();
      return;
    }
    
    // Check if snake ate food
    if (food != null && snake.parts.last.x == food!.x && snake.parts.last.y == food!.y) {
      if (isSoundOn) audioService.playEatingSound();
      snake.grow();
      score += 10;
      if (score > highScore) highScore = score;
      food = Food.generateFood(
        boardWidth, 
        boardHeight, 
        snake, 
        obstacles, 
        cellSize!
      );
    }
    
    // Notify listeners of state update
    onUpdate();
  }
  
  // Add a dedicated method to check for obstacle collisions
  bool checkCollisionWithObstacle() {
    final head = snake.parts.last;
    
    for (var obstacle in obstacles) {
      if (head.x == obstacle.dx && head.y == obstacle.dy) {
        return true; // Collision detected
      }
    }
    
    return false;
  }
  
  void handleCollision() {
    if (isSoundOn) audioService.playCollisionSound();
    lives--;
    
    if (lives <= 0) {
      gameOver();
    } else {
      // Reset snake position but keep score
      snake = Snake(boardWidth, boardHeight);
    }
    
    // Notify listeners of state update
    onUpdate();
  }
  
  void gameOver() {
    gameTimer?.cancel();
    onGameOver();
  }
  
  void togglePlayPause() {
    isPlaying = !isPlaying;
    onUpdate();
  }
  
  void toggleSound() {
    isSoundOn = !isSoundOn;
    onUpdate();
  }
  
  void changeDirection(Direction newDirection) {
    // Prevent 180-degree turns
    if ((snake.direction == Direction.up && newDirection == Direction.down) ||
        (snake.direction == Direction.down && newDirection == Direction.up) ||
        (snake.direction == Direction.left && newDirection == Direction.right) ||
        (snake.direction == Direction.right && newDirection == Direction.left)) {
      return;
    }
    
    if (snake.direction != newDirection) {
      if (isSoundOn) audioService.playDirectionChangeSound();
      snake.direction = newDirection;
      onUpdate();
    }
  }
  
  void dispose() {
    gameTimer?.cancel();
    audioService.dispose();
  }
  
  // Cell size cache
  double? cellSize;
}
