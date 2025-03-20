import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GameInfoBar extends StatelessWidget {
  final int snakeLength;
  
  const GameInfoBar({
    Key? key,
    required this.snakeLength,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Colors.black.withAlpha((0.9 * 255).toInt()),
            Colors.green.shade900.withAlpha((0.9 * 255).toInt()),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.4 * 255).toInt()),
            blurRadius: 6,
            offset: const Offset(0, -2),
          ),
        ],
        border: Border(
          top: BorderSide(
            color: Colors.green.shade700.withAlpha((0.3 * 255).toInt()),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Snake length display with modern design
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.green.shade800.withAlpha((0.8 * 255).toInt()),
                  Colors.green.shade700.withAlpha((0.8 * 255).toInt()),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha((0.3 * 255).toInt()),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
              border: Border.all(
                color: Colors.green.shade300.withAlpha((0.3 * 255).toInt()),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.straighten_rounded,
                  color: Colors.green.shade200,
                  size: 18,
                  shadows: [
                    Shadow(
                      color: Colors.black.withAlpha((0.5 * 255).toInt()),
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                const SizedBox(width: 8),
                Text(
                  'LENGTH: $snakeLength',
                  style: GoogleFonts.rubik(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    letterSpacing: 0.5,
                    shadows: [
                      Shadow(
                        color: Colors.black.withAlpha((0.5 * 255).toInt()),
                        blurRadius: 2,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Control hint with enhanced design
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.grey.shade800.withAlpha((0.5 * 255).toInt()),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.grey.shade600.withAlpha((0.3 * 255).toInt()),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.touch_app_rounded,
                  color: Colors.amber.shade300,
                  size: 16,
                ),
                const SizedBox(width: 6),
                Text(
                  'ARROW CONTROLS',
                  style: GoogleFonts.rubik(
                    color: Colors.white.withAlpha((0.8 * 255).toInt()),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
