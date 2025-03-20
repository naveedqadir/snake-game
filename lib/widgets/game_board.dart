import 'package:flutter/material.dart';
import 'package:snake_game/models/snake.dart';
import 'package:snake_game/models/food.dart';
import 'package:snake_game/painters/game_painter.dart';

class GameBoard extends StatelessWidget {
  final Snake snake;
  final Food food;
  final List<Offset> obstacles;
  final double cellSize;
  final int boardWidth;
  final int boardHeight;
  
  const GameBoard({
    Key? key,
    required this.snake,
    required this.food,
    required this.obstacles,
    required this.cellSize,
    required this.boardWidth,
    required this.boardHeight,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        // Deep gradient background
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.green.shade900,
            Colors.black,
          ],
          stops: const [0.1, 0.9],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          // Inner shadow
          BoxShadow(
            color: Colors.black.withAlpha((0.5 * 255).toInt()),
            blurRadius: 15,
            offset: const Offset(0, 8),
            spreadRadius: 2,
          ),
          // Subtle outer glow
          BoxShadow(
            color: Colors.green.shade700.withAlpha((0.3 * 255).toInt()),
            blurRadius: 20,
            offset: const Offset(0, 0),
            spreadRadius: 0,
          ),
        ],
        border: Border.all(
          color: Colors.green.shade700.withAlpha((0.5 * 255).toInt()),
          width: 3.0,
        ),
      ),
      // Add a clip to ensure shadows don't spill outside the rounded corners
      clipBehavior: Clip.hardEdge,
      child: Container(
        padding: const EdgeInsets.all(6),
        child: Center(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;
              final height = constraints.maxHeight;
              final availableWidth = width.floorToDouble();
              final availableHeight = height.floorToDouble();
              
              // Calculate cell size to ensure even distribution
              final calculatedCellWidth = availableWidth / boardWidth;
              final calculatedCellHeight = availableHeight / boardHeight;
              final adjustedCellSize = calculatedCellWidth < calculatedCellHeight ? 
                  calculatedCellWidth : calculatedCellHeight;
              
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // Add a subtle inner shadow for depth
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha((0.3 * 255).toInt()),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                      spreadRadius: -2,
                    ),
                  ],
                ),
                clipBehavior: Clip.hardEdge,
                child: RepaintBoundary(
                  child: CustomPaint(
                    isComplex: true,
                    willChange: true,
                    painter: GamePainter(
                      snake: snake,
                      food: food,
                      obstacles: obstacles,
                      cellSize: adjustedCellSize,
                      boardWidth: boardWidth,
                      boardHeight: boardHeight,
                    ),
                    // Calculate exact size needed for all cells
                    size: Size(
                      adjustedCellSize * boardWidth,
                      adjustedCellSize * boardHeight,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
