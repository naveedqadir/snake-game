import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GameHeader extends StatelessWidget {
  final int lives;
  final int score;
  final int highScore;
  final bool isPlaying;
  final bool isSoundOn;
  final VoidCallback onTogglePlayPause;
  final VoidCallback onToggleSound;
  
  const GameHeader({
    Key? key,
    required this.lives,
    required this.score,
    required this.highScore,
    required this.isPlaying,
    required this.isSoundOn,
    required this.onTogglePlayPause,
    required this.onToggleSound,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.green.shade800,
            Colors.green.shade900,
            Colors.black.withAlpha((0.8 * 255).toInt()),
          ],
          stops: const [0.0, 0.7, 1.0],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.5 * 255).toInt()),
            blurRadius: 8,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Lives indicator with animated hearts
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: LinearGradient(
                        colors: [
                          Colors.red.shade900.withAlpha((0.7 * 255).toInt()),
                          Colors.red.shade700.withAlpha((0.7 * 255).toInt()),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha((0.3 * 255).toInt()),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                      border: Border.all(
                        color: Colors.red.shade300.withAlpha((0.3 * 255).toInt()),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        for (int i = 0; i < lives; i++)
                          Padding(
                            padding: const EdgeInsets.only(right: 4),
                            child: Icon(
                              Icons.favorite,
                              color: Colors.red.shade300,
                              size: 22,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withAlpha((0.5 * 255).toInt()),
                                  blurRadius: 4,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                            ),
                          ),
                        for (int i = 0; i < 5 - lives; i++)
                          Padding(
                            padding: const EdgeInsets.only(right: 4),
                            child: Icon(
                              Icons.favorite_border,
                              color: Colors.red.shade200.withAlpha((0.7 * 255).toInt()),
                              size: 22,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              
              // Score display with fancy design
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.amber.shade700.withAlpha((0.8 * 255).toInt()),
                      Colors.amber.shade800.withAlpha((0.8 * 255).toInt()),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha((0.3 * 255).toInt()),
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                  border: Border.all(
                    color: Colors.amber.shade300.withAlpha((0.3 * 255).toInt()),
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      score.toString(),
                      style: GoogleFonts.rubik(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        shadows: [
                          Shadow(
                            color: Colors.black.withAlpha((0.6 * 255).toInt()),
                            blurRadius: 3,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'BEST: $highScore',
                      style: GoogleFonts.rubik(
                        color: Colors.white.withAlpha((0.8 * 255).toInt()),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 10),
          
          // Control buttons with modern design
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Play/Pause button
              _buildActionButton(
                onTap: onTogglePlayPause,
                icon: isPlaying ? Icons.pause : Icons.play_arrow,
                backgroundColor: isPlaying ? Colors.amber.shade600 : Colors.green.shade600,
                borderColor: isPlaying ? Colors.amber.shade400 : Colors.green.shade400,
              ),
              
              const SizedBox(width: 16),
              
              // Sound button
              _buildActionButton(
                onTap: onToggleSound,
                icon: isSoundOn ? Icons.volume_up : Icons.volume_off,
                backgroundColor: isSoundOn ? Colors.blue.shade600 : Colors.grey.shade700,
                borderColor: isSoundOn ? Colors.blue.shade400 : Colors.grey.shade500,
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildActionButton({
    required VoidCallback onTap,
    required IconData icon,
    required Color backgroundColor,
    required Color borderColor,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                backgroundColor,
                backgroundColor.withAlpha((0.8 * 255).toInt()),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha((0.3 * 255).toInt()),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
            border: Border.all(
              color: borderColor.withAlpha((0.5 * 255).toInt()),
              width: 2,
            ),
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 24,
            shadows: [
              Shadow(
                color: Colors.black.withAlpha((0.5 * 255).toInt()),
                blurRadius: 3,
                offset: const Offset(0, 1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
