import 'package:flutter/material.dart';
import 'package:snake_game/models/snake.dart' show Direction;

class GameControls extends StatelessWidget {
  final Function(Direction) onDirectionChange;
  
  const GameControls({
    Key? key,
    required this.onDirectionChange,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Colors.green.shade900,
            Colors.green.shade800,
            Colors.black.withAlpha((0.8 * 255).toInt()),
          ],
          stops: const [0.0, 0.7, 1.0],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.5 * 255).toInt()),
            blurRadius: 8,
            offset: const Offset(0, -3),
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // D-pad control layout with enhanced visuals
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Left side - Left button
              SizedBox(
                width: screenSize.width * 0.25,
                child: Center(
                  child: _buildDirectionButton(
                    direction: Direction.left,
                    icon: Icons.arrow_back_rounded,
                    onPressed: () => onDirectionChange(Direction.left),
                  ),
                ),
              ),
              
              // Center - Up and Down buttons vertically stacked
              SizedBox(
                width: screenSize.width * 0.25,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildDirectionButton(
                      direction: Direction.up,
                      icon: Icons.arrow_upward_rounded,
                      onPressed: () => onDirectionChange(Direction.up),
                    ),
                    const SizedBox(height: 20),
                    _buildDirectionButton(
                      direction: Direction.down,
                      icon: Icons.arrow_downward_rounded,
                      onPressed: () => onDirectionChange(Direction.down),
                    ),
                  ],
                ),
              ),
              
              // Right side - Right button
              SizedBox(
                width: screenSize.width * 0.25,
                child: Center(
                  child: _buildDirectionButton(
                    direction: Direction.right,
                    icon: Icons.arrow_forward_rounded,
                    onPressed: () => onDirectionChange(Direction.right),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildDirectionButton({
    required Direction direction,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    // Choose different colors based on direction for visual distinction
    Color baseColor;
    Color iconColor = Colors.white;
    
    switch (direction) {
      case Direction.up:
        baseColor = Colors.blue.shade600;
        break;
      case Direction.down:
        baseColor = Colors.amber.shade600;
        break;
      case Direction.left:
        baseColor = Colors.purple.shade600;
        break;
      case Direction.right:
        baseColor = Colors.green.shade600;
        break;
    }
    
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              baseColor,
              Color.lerp(baseColor, Colors.black, 0.4)!,
            ],
          ),
          boxShadow: [
            // Outer shadow
            BoxShadow(
              color: Colors.black.withAlpha((0.3 * 255).toInt()),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
            // Subtle inner shadow for 3D effect
            BoxShadow(
              color: baseColor.withAlpha((0.4 * 255).toInt()),
              blurRadius: 15,
              spreadRadius: -2,
              offset: const Offset(0, 0),
            ),
          ],
          border: Border.all(
            color: baseColor.withAlpha((0.5 * 255).toInt()),
            width: 2,
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPressed,
            customBorder: const CircleBorder(),
            splashColor: baseColor.withAlpha((0.3 * 255).toInt()),
            highlightColor: baseColor.withAlpha((0.1 * 255).toInt()),
            child: Center(
              child: Icon(
                icon,
                color: iconColor,
                size: 36,
                shadows: [
                  Shadow(
                    color: Colors.black.withAlpha((0.5 * 255).toInt()),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
