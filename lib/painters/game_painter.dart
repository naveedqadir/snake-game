import 'package:flutter/material.dart';
import 'package:snake_game/models/snake.dart';
import 'package:snake_game/models/food.dart';

class GamePainter extends CustomPainter {
  final Snake snake;
  final Food food;
  final List<Offset> obstacles;
  final double cellSize;
  final int boardWidth;
  final int boardHeight;
  final bool isPremium;

  GamePainter({
    required this.snake,
    required this.food,
    required this.obstacles,
    required this.cellSize,
    required this.boardWidth,
    required this.boardHeight,
    this.isPremium = true,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Draw fancy background with multiple gradient layers
    final rect = Rect.fromLTWH(0, 0, boardWidth * cellSize, boardHeight * cellSize);
    
    // Base gradient
    final backgroundGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Colors.green.shade900,
        Colors.green.shade700,
        Colors.teal.shade700,
      ],
      stops: const [0.0, 0.6, 1.0],
    );
    
    final backgroundPaint = Paint()
      ..shader = backgroundGradient.createShader(rect)
      ..style = PaintingStyle.fill;
    
    canvas.drawRect(rect, backgroundPaint);
    
    // Add a subtle pattern overlay
    if (isPremium) {
      _drawPatternOverlay(canvas, rect);
    }
    
    // Draw better grid with improved visuals
    _drawEnhancedGrid(canvas, rect);
    
    // Draw obstacles with 3D effect
    for (var obstacle in obstacles) {
      _drawEnhancedObstacle(canvas, obstacle);
    }
    
    // Draw snake with improved visuals and effects
    _drawEnhancedSnake(canvas);
    
    // Draw food with glow and particle effects
    _drawEnhancedFood(canvas);
  }
  
  void _drawPatternOverlay(Canvas canvas, Rect rect) {
    // Draw subtle dot pattern for depth
    final patternPaint = Paint()
      ..color = Colors.white.withAlpha((0.05 * 255).toInt())
      ..style = PaintingStyle.fill;
      
    for (int i = 0; i < boardWidth; i++) {
      for (int j = 0; j < boardHeight; j++) {
        if ((i + j) % 3 == 0) {
          canvas.drawCircle(
            Offset(i * cellSize + cellSize / 2, j * cellSize + cellSize / 2),
            cellSize * 0.05,
            patternPaint,
          );
        }
      }
    }
  }
  
  void _drawEnhancedGrid(Canvas canvas, Rect rect) {
    // Draw main grid lines
    final gridPaint = Paint()
      ..color = Colors.green.shade300.withAlpha((0.15 * 255).toInt())
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;
    
    // Draw horizontal grid lines
    for (int j = 0; j <= boardHeight; j++) {
      canvas.drawLine(
        Offset(0, j * cellSize),
        Offset(boardWidth * cellSize, j * cellSize),
        gridPaint,
      );
    }
    
    // Draw vertical grid lines
    for (int i = 0; i <= boardWidth; i++) {
      canvas.drawLine(
        Offset(i * cellSize, 0),
        Offset(i * cellSize, boardHeight * cellSize),
        gridPaint,
      );
    }
    
    // Draw subtle vignette effect
    final vignetteRect = Rect.fromLTWH(0, 0, boardWidth * cellSize, boardHeight * cellSize);
    final vignetteGradient = RadialGradient(
      center: Alignment.center,
      radius: 1.0,
      colors: [
        Colors.transparent, 
        Colors.black.withAlpha((0.3 * 255).toInt())
      ],
      stops: const [0.7, 1.0],
    );
    
    final vignettePaint = Paint()
      ..shader = vignetteGradient.createShader(vignetteRect)
      ..style = PaintingStyle.fill;
    
    canvas.drawRect(vignetteRect, vignettePaint);
  }
  
  void _drawEnhancedObstacle(Canvas canvas, Offset obstacle) {
    // Draw 3D obstacle with shadow and texture
    final obstacleSize = cellSize * 0.9;
    final obstacleOffset = (cellSize - obstacleSize) / 2;
    
    // Shadow
    final shadowPaint = Paint()
      ..color = Colors.black.withAlpha((0.4 * 255).toInt())
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5);
    
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          obstacle.dx * cellSize + obstacleOffset + 2,
          obstacle.dy * cellSize + obstacleOffset + 3,
          obstacleSize,
          obstacleSize,
        ),
        Radius.circular(cellSize * 0.2),
      ),
      shadowPaint,
    );
    
    // Main obstacle
    final obstacleGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Colors.brown.shade600,
        Colors.brown.shade900,
      ],
    );
    
    final obstaclePaint = Paint()
      ..shader = obstacleGradient.createShader(
        Rect.fromLTWH(
          obstacle.dx * cellSize + obstacleOffset,
          obstacle.dy * cellSize + obstacleOffset,
          obstacleSize,
          obstacleSize,
        ),
      );
    
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          obstacle.dx * cellSize + obstacleOffset,
          obstacle.dy * cellSize + obstacleOffset,
          obstacleSize,
          obstacleSize,
        ),
        Radius.circular(cellSize * 0.2),
      ),
      obstaclePaint,
    );
    
    // Obstacle texture
    final textureLinesPaint = Paint()
      ..color = Colors.brown.shade500.withAlpha((0.6 * 255).toInt())
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    
    final margin = cellSize * 0.25;
    
    // Wooden plank effect
    for (int i = 1; i < 3; i++) {
      double y = obstacle.dy * cellSize + obstacleOffset + obstacleSize * (i / 3);
      canvas.drawLine(
        Offset(obstacle.dx * cellSize + obstacleOffset + margin, y),
        Offset(obstacle.dx * cellSize + obstacleOffset + obstacleSize - margin, y),
        textureLinesPaint,
      );
    }
    
    // Add highlight reflection
    final highlightPaint = Paint()
      ..color = Colors.white.withAlpha((0.15 * 255).toInt())
      ..style = PaintingStyle.fill;
    
    final highlightPath = Path()
      ..moveTo(obstacle.dx * cellSize + obstacleOffset, obstacle.dy * cellSize + obstacleOffset)
      ..lineTo(obstacle.dx * cellSize + obstacleOffset + obstacleSize * 0.3, obstacle.dy * cellSize + obstacleOffset)
      ..lineTo(obstacle.dx * cellSize + obstacleOffset, obstacle.dy * cellSize + obstacleOffset + obstacleSize * 0.3)
      ..close();
    
    canvas.drawPath(highlightPath, highlightPaint);
  }
  
  void _drawEnhancedSnake(Canvas canvas) {
    // Draw snake with 3D appearance and smooth segments
    for (int i = 0; i < snake.parts.length; i++) {
      final part = snake.parts[i];
      final isHead = i == snake.parts.length - 1;
      final isTail = i == 0;
      
      // Calculate segment colors - gradient from tail to head
      final progress = i / snake.parts.length;
      final segmentColor = Color.lerp(
        Colors.green.shade800,
        Colors.green.shade500,
        progress,
      )!;
      
      // For head, use a special color
      final partColor = isHead ? Colors.green.shade400 : segmentColor;
      
      // Draw shadow for 3D effect
      final shadowPaint = Paint()
        ..color = Colors.black.withAlpha((0.3 * 255).toInt())
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);
      
      final shadowRadius = isHead ? cellSize * 0.35 : cellSize * 0.3;
      final segmentMargin = cellSize * 0.1;
      final segmentRect = Rect.fromLTWH(
        part.x * cellSize + segmentMargin + 2,
        part.y * cellSize + segmentMargin + 2,
        cellSize - (segmentMargin * 2),
        cellSize - (segmentMargin * 2),
      );
      
      canvas.drawRRect(
        RRect.fromRectAndRadius(segmentRect, Radius.circular(shadowRadius)),
        shadowPaint,
      );
      
      // Main segment with gradient
      final segmentGradient = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          partColor,
          Color.lerp(partColor, Colors.black, 0.3)!,
        ],
      );
      
      final snakePaint = Paint()
        ..shader = segmentGradient.createShader(Rect.fromLTWH(
          part.x * cellSize + segmentMargin,
          part.y * cellSize + segmentMargin,
          cellSize - (segmentMargin * 2),
          cellSize - (segmentMargin * 2),
        ));
      
      final segmentRRect = RRect.fromRectAndRadius(
        Rect.fromLTWH(
          part.x * cellSize + segmentMargin,
          part.y * cellSize + segmentMargin,
          cellSize - (segmentMargin * 2),
          cellSize - (segmentMargin * 2),
        ),
        Radius.circular(isHead ? cellSize * 0.35 : cellSize * 0.3),
      );
      
      canvas.drawRRect(segmentRRect, snakePaint);
      
      // Add shine/highlight to each segment
      final highlightPaint = Paint()
        ..color = Colors.white.withAlpha((0.4 * 255).toInt())
        ..style = PaintingStyle.fill;
      
      final highlightSize = cellSize * 0.12;
      canvas.drawCircle(
        Offset(
          part.x * cellSize + cellSize * 0.3,
          part.y * cellSize + cellSize * 0.3,
        ),
        highlightSize,
        highlightPaint,
      );
      
      // Draw eyes on snake head
      if (isHead) {
        _drawSnakeHead(canvas, part);
      }
      
      // Draw special tail tip
      if (isTail) {
        _drawSnakeTail(canvas, part, i < snake.parts.length - 1 ? snake.parts[i + 1] : part);
      }
    }
  }
  
  void _drawSnakeHead(Canvas canvas, SnakePart head) {
    final eyePaint = Paint()..color = Colors.white;
    final pupilPaint = Paint()..color = Colors.black;
    
    final eyeSize = cellSize * 0.18;
    final pupilSize = eyeSize * 0.55;
    
    double leftEyeX, leftEyeY, rightEyeX, rightEyeY;
    
    // Position eyes based on direction
    switch (snake.direction) {
      case Direction.up:
        leftEyeX = head.x * cellSize + cellSize / 3;
        leftEyeY = head.y * cellSize + cellSize / 3;
        rightEyeX = head.x * cellSize + cellSize * 2 / 3;
        rightEyeY = head.y * cellSize + cellSize / 3;
        break;
      case Direction.down:
        leftEyeX = head.x * cellSize + cellSize / 3;
        leftEyeY = head.y * cellSize + cellSize * 2 / 3;
        rightEyeX = head.x * cellSize + cellSize * 2 / 3;
        rightEyeY = head.y * cellSize + cellSize * 2 / 3;
        break;
      case Direction.left:
        leftEyeX = head.x * cellSize + cellSize / 3;
        leftEyeY = head.y * cellSize + cellSize / 3;
        rightEyeX = head.x * cellSize + cellSize / 3;
        rightEyeY = head.y * cellSize + cellSize * 2 / 3;
        break;
      case Direction.right:
        leftEyeX = head.x * cellSize + cellSize * 2 / 3;
        leftEyeY = head.y * cellSize + cellSize / 3;
        rightEyeX = head.x * cellSize + cellSize * 2 / 3;
        rightEyeY = head.y * cellSize + cellSize * 2 / 3;
        break;
    }
    
    // Draw eye glow for dramatic effect
    final eyeGlowPaint = Paint()
      ..color = Colors.white.withAlpha((0.3 * 255).toInt())
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
    
    canvas.drawCircle(Offset(leftEyeX, leftEyeY), eyeSize * 1.3, eyeGlowPaint);
    canvas.drawCircle(Offset(rightEyeX, rightEyeY), eyeSize * 1.3, eyeGlowPaint);
    
    // Draw the whites of the eyes
    canvas.drawCircle(Offset(leftEyeX, leftEyeY), eyeSize, eyePaint);
    canvas.drawCircle(Offset(rightEyeX, rightEyeY), eyeSize, eyePaint);
    
    // Draw the pupils with slight offset for snake-like appearance
    final leftPupilOffset = _getPupilOffset(snake.direction);
    final rightPupilOffset = _getPupilOffset(snake.direction);
    
    canvas.drawCircle(
      Offset(leftEyeX + leftPupilOffset.dx, leftEyeY + leftPupilOffset.dy), 
      pupilSize, 
      pupilPaint
    );
    canvas.drawCircle(
      Offset(rightEyeX + rightPupilOffset.dx, rightEyeY + rightPupilOffset.dy), 
      pupilSize, 
      pupilPaint
    );
  }
  
  Offset _getPupilOffset(Direction direction) {
    // Make pupils look slightly in direction of travel
    switch (direction) {
      case Direction.up:
        return const Offset(0, -1);
      case Direction.down:
        return const Offset(0, 1);
      case Direction.left:
        return const Offset(-1, 0);
      case Direction.right:
        return const Offset(1, 0);
    }
  }
  
  void _drawSnakeTail(Canvas canvas, SnakePart tail, SnakePart nextPart) {
    // Direction from tail to next part
    final dx = nextPart.x - tail.x;
    final dy = nextPart.y - tail.y;
    
    // Determine tail direction
    Direction tailDirection;
    if (dx > 0) {
      tailDirection = Direction.left;
    } else if (dx < 0) {
      tailDirection = Direction.right;
    }
    else if (dy > 0) {
      tailDirection = Direction.up;
    }
    else {
      tailDirection = Direction.down;
    }
    
    // Draw a small decorative triangle at the tail end
    final tailPaint = Paint()
      ..color = Colors.green.shade700
      ..style = PaintingStyle.fill;
    
    final tipSize = cellSize * 0.15;
    final tailCenterX = tail.x * cellSize + cellSize / 2;
    final tailCenterY = tail.y * cellSize + cellSize / 2;
    
    final path = Path();
    
    switch (tailDirection) {
      case Direction.up:
        path.moveTo(tailCenterX, tailCenterY + tipSize);
        path.lineTo(tailCenterX - tipSize, tailCenterY - tipSize);
        path.lineTo(tailCenterX + tipSize, tailCenterY - tipSize);
        break;
      case Direction.down:
        path.moveTo(tailCenterX, tailCenterY - tipSize);
        path.lineTo(tailCenterX - tipSize, tailCenterY + tipSize);
        path.lineTo(tailCenterX + tipSize, tailCenterY + tipSize);
        break;
      case Direction.left:
        path.moveTo(tailCenterX + tipSize, tailCenterY);
        path.lineTo(tailCenterX - tipSize, tailCenterY - tipSize);
        path.lineTo(tailCenterX - tipSize, tailCenterY + tipSize);
        break;
      case Direction.right:
        path.moveTo(tailCenterX - tipSize, tailCenterY);
        path.lineTo(tailCenterX + tipSize, tailCenterY - tipSize);
        path.lineTo(tailCenterX + tipSize, tailCenterY + tipSize);
        break;
    }
    
    path.close();
    canvas.drawPath(path, tailPaint);
  }
  
  void _drawEnhancedFood(Canvas canvas) {
    // Draw apple with multiple layers and effects
    
    // Outer glow effect
    final outerGlowPaint = Paint()
      ..color = Colors.red.withAlpha((0.15 * 255).toInt())
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12);
    
    canvas.drawCircle(
      Offset(
        food.x * cellSize + cellSize / 2,
        food.y * cellSize + cellSize / 2,
      ),
      cellSize * 0.9,
      outerGlowPaint,
    );
    
    // Inner glow effect
    final innerGlowPaint = Paint()
      ..color = Colors.red.withAlpha((0.3 * 255).toInt())
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);
    
    canvas.drawCircle(
      Offset(
        food.x * cellSize + cellSize / 2,
        food.y * cellSize + cellSize / 2,
      ),
      cellSize * 0.6,
      innerGlowPaint,
    );
    
    // Main apple shape
    final appleGradient = RadialGradient(
      center: const Alignment(-0.3, -0.3),
      radius: 1.0,
      colors: [
        Colors.red.shade400,
        Colors.red.shade700,
      ],
    );
    
    final foodPaint = Paint()
      ..shader = appleGradient.createShader(Rect.fromLTWH(
        food.x * cellSize + cellSize * 0.2,
        food.y * cellSize + cellSize * 0.2,
        cellSize * 0.6,
        cellSize * 0.6,
      ));
    
    canvas.drawCircle(
      Offset(
        food.x * cellSize + cellSize / 2,
        food.y * cellSize + cellSize / 2,
      ),
      cellSize * 0.4,
      foodPaint,
    );
    
    // Apple stem
    final stemPaint = Paint()
      ..color = Colors.brown.shade700
      ..style = PaintingStyle.fill;
    
    final stemPath = Path();
    stemPath.moveTo(food.x * cellSize + cellSize * 0.48, food.y * cellSize + cellSize * 0.25);
    stemPath.quadraticBezierTo(
      food.x * cellSize + cellSize * 0.4, food.y * cellSize + cellSize * 0.15,
      food.x * cellSize + cellSize * 0.35, food.y * cellSize + cellSize * 0.2,
    );
    stemPath.lineTo(food.x * cellSize + cellSize * 0.35, food.y * cellSize + cellSize * 0.15);
    stemPath.lineTo(food.x * cellSize + cellSize * 0.5, food.y * cellSize + cellSize * 0.15);
    stemPath.lineTo(food.x * cellSize + cellSize * 0.5, food.y * cellSize + cellSize * 0.25);
    stemPath.close();
    
    canvas.drawPath(stemPath, stemPaint);
    
    // Leaf
    final leafPaint = Paint()
      ..color = Colors.green.shade600
      ..style = PaintingStyle.fill;
    
    final leafPath = Path();
    leafPath.moveTo(food.x * cellSize + cellSize * 0.5, food.y * cellSize + cellSize * 0.2);
    leafPath.quadraticBezierTo(
      food.x * cellSize + cellSize * 0.6, food.y * cellSize + cellSize * 0.1,
      food.x * cellSize + cellSize * 0.65, food.y * cellSize + cellSize * 0.2,
    );
    leafPath.quadraticBezierTo(
      food.x * cellSize + cellSize * 0.6, food.y * cellSize + cellSize * 0.22,
      food.x * cellSize + cellSize * 0.5, food.y * cellSize + cellSize * 0.2,
    );
    leafPath.close();
    
    canvas.drawPath(leafPath, leafPaint);
    
    // Apple shine/highlight
    final shinePaint = Paint()
      ..color = Colors.white.withAlpha((0.7 * 255).toInt())
      ..style = PaintingStyle.fill;
    
    canvas.drawCircle(
      Offset(
        food.x * cellSize + cellSize * 0.6,
        food.y * cellSize + cellSize * 0.35,
      ),
      cellSize * 0.08,
      shinePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
