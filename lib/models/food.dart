import 'dart:math';
import 'package:flutter/material.dart';
import 'package:snake_game/models/snake.dart';

class Food {
  final double x;
  final double y;
  final Color color;

  Food(this.x, this.y, {this.color = Colors.red});

  static Food generateFood(int boardWidth, int boardHeight, Snake snake, List<Offset> obstacles, double cellSize) {
    final random = Random();
    double foodX, foodY;
    bool validPosition;
    
    // Keep generating new positions until we find a valid one
    do {
      foodX = random.nextInt(boardWidth).toDouble();
      foodY = random.nextInt(boardHeight).toDouble();
      
      // Check if this position overlaps with the snake
      validPosition = !snake.parts.any((part) => part.x == foodX && part.y == foodY);
      
      // Check if this position overlaps with obstacles
      if (validPosition) {
        for (var obstacle in obstacles) {
          if (obstacle.dx == foodX && obstacle.dy == foodY) {
            validPosition = false;
            break;
          }
        }
      }
    } while (!validPosition);
    
    // Randomly choose a color for variety (mainly red shades)
    final colorOptions = [
      Colors.red,
      Colors.redAccent,
      Colors.red.shade700,
      Colors.deepOrange.shade600,
    ];
    
    return Food(
      foodX, 
      foodY, 
      color: colorOptions[random.nextInt(colorOptions.length)],
    );
  }
}
