import 'package:flutter/material.dart';
import 'package:snake_game/models/snake.dart' show Direction;

class DirectionButton extends StatelessWidget {
  final Direction direction;
  final IconData icon;
  final VoidCallback onPressed;
  final double size;
  final Color color;
  final Color iconColor;
  final Color shadowColor;

  const DirectionButton({
    Key? key,
    required this.direction,
    required this.icon,
    required this.onPressed,
    this.size = 40,
    this.color = Colors.green,
    this.iconColor = Colors.white,
    this.shadowColor = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onPressed,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                color,
                Color.lerp(color, Colors.black, 0.2)!,
              ],
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: shadowColor,
                blurRadius: 4,
                offset: const Offset(0, 2),
                spreadRadius: 1,
              ),
            ],
            border: Border.all(
              color: Colors.green.shade700,
              width: 2,
            ),
          ),
          child: Icon(
            icon, 
            color: iconColor,
            size: size * 0.5,
          ),
        ),
      ),
    );
  }
}
