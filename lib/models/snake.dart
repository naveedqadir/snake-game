import 'package:flutter/material.dart';

enum Direction { up, down, left, right }

class SnakePart {
  final double x;
  final double y;

  SnakePart(this.x, this.y);
}

class Snake {
  List<SnakePart> parts = [];
  Direction direction = Direction.right;
  int initialLength = 4;

  Snake(int boardWidth, int boardHeight) {
    // Initialize snake at the left side of the board
    for (int i = 0; i < initialLength; i++) {
      parts.add(SnakePart(i.toDouble(), (boardHeight ~/ 2).toDouble()));
    }
  }

  void move() {
    SnakePart head = parts.last;
    double newX = head.x;
    double newY = head.y;

    switch (direction) {
      case Direction.up:
        newY--;
        break;
      case Direction.down:
        newY++;
        break;
      case Direction.left:
        newX--;
        break;
      case Direction.right:
        newX++;
        break;
    }

    parts.add(SnakePart(newX, newY));
    parts.removeAt(0);
  }

  void grow() {
    SnakePart tail = parts.first;
    parts.insert(0, SnakePart(tail.x, tail.y));
  }

  bool checkCollisionWithSelf() {
    SnakePart head = parts.last;
    for (int i = 0; i < parts.length - 1; i++) {
      if (head.x == parts[i].x && head.y == parts[i].y) {
        return true;
      }
    }
    return false;
  }

  bool checkCollisionWithWall(int boardWidth, int boardHeight) {
    SnakePart head = parts.last;
    return head.x < 0 || head.y < 0 || head.x >= boardWidth || head.y >= boardHeight;
  }

  bool checkCollisionWithObstacle(List<Offset> obstacles, double cellSize) {
    SnakePart head = parts.last;
    
    // Direct comparison with obstacles (no need for cellSize)
    for (var obstacle in obstacles) {
      if (head.x == obstacle.dx && head.y == obstacle.dy) {
        return true;
      }
    }
    return false;
  }
}
