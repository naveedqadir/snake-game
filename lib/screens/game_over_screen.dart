import 'package:flutter/material.dart';
import 'package:snake_game/screens/home_screen.dart';
import 'package:snake_game/screens/game_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;

class GameOverScreen extends StatefulWidget {
  final int score;
  final int snakeLength;
  
  const GameOverScreen({
    Key? key, 
    required this.score, 
    required this.snakeLength,
  }) : super(key: key);

  @override
  State<GameOverScreen> createState() => _GameOverScreenState();
}

class _GameOverScreenState extends State<GameOverScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _rotateAnimation;
  
  @override
  void initState() {
    super.initState();
    
    // Initialize animations
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticOut,
      ),
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 1.0, curve: Curves.easeInOut),
      ),
    );
    
    _rotateAnimation = Tween<double>(begin: 0.0, end: 2 * math.pi).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );
    
    // Start the animation
    _controller.forward();
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.red.shade900,
              Colors.red.shade800,
              Colors.black,
            ],
            stops: const [0.0, 0.6, 1.0],
          ),
        ),
        child: Stack(
          children: [
            // Animated background particles
            Positioned.fill(
              child: CustomPaint(
                painter: ParticlesPainter(
                  progress: _controller.value,
                ),
              ),
            ),
            
            // Game over content
            SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(flex: 1),
                    
                    // Game over title with animation
                    AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _scaleAnimation.value,
                          child: Transform.rotate(
                            angle: _rotateAnimation.value * 0.05 * math.sin(3 * _controller.value * math.pi),
                            child: ShaderMask(
                              shaderCallback: (Rect bounds) {
                                return LinearGradient(
                                  colors: [
                                    Colors.red.shade300,
                                    Colors.red.shade500,
                                    Colors.red.shade300,
                                  ],
                                  stops: const [0.0, 0.5, 1.0],
                                ).createShader(bounds);
                              },
                              child: Text(
                                'GAME OVER',
                                style: GoogleFonts.pressStart2p(
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  letterSpacing: 3.0,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 10.0,
                                      color: Colors.black.withAlpha((0.7 * 255).toInt()),
                                      offset: const Offset(5.0, 5.0),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    
                    const SizedBox(height: 40),
                    
                    // Score card with fancy design and animation
                    AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _fadeAnimation.value,
                          child: Opacity(
                            opacity: _fadeAnimation.value,
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              padding: const EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Colors.red.shade700,
                                    Colors.red.shade900,
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withAlpha((0.5 * 255).toInt()),
                                    blurRadius: 15,
                                    offset: const Offset(0, 10),
                                    spreadRadius: 2,
                                  ),
                                  BoxShadow(
                                    color: Colors.red.shade500.withAlpha((0.3 * 255).toInt()),
                                    blurRadius: 20,
                                    offset: const Offset(0, 0),
                                    spreadRadius: 0,
                                  ),
                                ],
                                border: Border.all(
                                  color: Colors.red.shade300.withAlpha((0.3 * 255).toInt()),
                                  width: 2,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    'YOUR SCORE',
                                    style: GoogleFonts.rubik(
                                      color: Colors.white.withAlpha((0.8 * 255).toInt()),
                                      fontSize: 18,
                                      letterSpacing: 2.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  ShaderMask(
                                    shaderCallback: (Rect bounds) {
                                      return LinearGradient(
                                        colors: [
                                          Colors.white,
                                          Colors.amber.shade300,
                                          Colors.white,
                                        ],
                                        stops: const [0.0, 0.5, 1.0],
                                      ).createShader(bounds);
                                    },
                                    child: Text(
                                      widget.score.toString(),
                                      style: GoogleFonts.rubik(
                                        color: Colors.white,
                                        fontSize: 70,
                                        fontWeight: FontWeight.bold,
                                        shadows: [
                                          Shadow(
                                            color: Colors.black.withAlpha((0.6 * 255).toInt()),
                                            blurRadius: 10,
                                            offset: const Offset(0, 5),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withAlpha((0.2 * 255).toInt()),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: Colors.white.withAlpha((0.1 * 255).toInt()),
                                        width: 1,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.straighten_rounded,
                                          color: Colors.white.withAlpha((0.7 * 255).toInt()),
                                          size: 20,
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          'Snake Length: ${widget.snakeLength}',
                                          style: GoogleFonts.rubik(
                                            color: Colors.white.withAlpha((0.8 * 255).toInt()),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    
                    const SizedBox(height: 50),
                    
                    // Action buttons with animation
                    AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return Opacity(
                          opacity: _fadeAnimation.value,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Play Again button
                              _buildActionButton(
                                onPressed: () {
                                  Navigator.of(context).pushReplacement(
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation, secondaryAnimation) => const GameScreen(),
                                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                        var begin = const Offset(1.0, 0.0);
                                        var end = Offset.zero;
                                        var curve = Curves.easeInOut;
                                        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                                        return SlideTransition(position: animation.drive(tween), child: child);
                                      },
                                    ),
                                  );
                                },
                                icon: Icons.replay_rounded,
                                label: 'PLAY AGAIN',
                                backgroundColor: Colors.green.shade600,
                              ),
                              
                              const SizedBox(width: 16),
                              
                              // Home button
                              _buildActionButton(
                                onPressed: () {
                                  Navigator.of(context).pushReplacement(
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation, secondaryAnimation) => const HomeScreen(),
                                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                        var begin = const Offset(1.0, 0.0);
                                        var end = Offset.zero;
                                        var curve = Curves.easeInOut;
                                        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                                        return SlideTransition(position: animation.drive(tween), child: child);
                                      },
                                    ),
                                  );
                                },
                                icon: Icons.home_rounded,
                                label: 'HOME',
                                backgroundColor: Colors.blue.shade600,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    
                    const Spacer(flex: 2),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildActionButton({
    required VoidCallback onPressed,
    required IconData icon,
    required String label,
    required Color backgroundColor,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 24),
      label: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Text(
          label,
          style: GoogleFonts.rubik(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
          ),
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        elevation: 8,
        shadowColor: Colors.black.withAlpha((0.5 * 255).toInt()),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
    );
  }
}

// Custom painter to draw animated particles in the background
class ParticlesPainter extends CustomPainter {
  final double progress;
  
  ParticlesPainter({required this.progress});
  
  @override
  void paint(Canvas canvas, Size size) {
    final random = math.Random(42);
    const particleCount = 100;
    
    for (int i = 0; i < particleCount; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final baseSize = 1 + random.nextDouble() * 4;
      
      // Make particles move and pulse
      final offset = 20.0 * math.sin(progress * 2 * math.pi + i);
      final pulse = 0.5 + 0.5 * math.sin(progress * 2 * math.pi + i * 0.1);
      
      final particleColor = HSLColor.fromAHSL(
        0.6 * pulse,
        (10 + i % 30).toDouble(),
        0.7,
        0.5 + 0.2 * pulse,
      ).toColor();
      
      final particlePaint = Paint()
        ..color = particleColor
        ..style = PaintingStyle.fill;
      
      canvas.drawCircle(
        Offset(
          (x + offset) % size.width,
          (y - offset / 2) % size.height,
        ),
        baseSize * pulse,
        particlePaint,
      );
    }
    
    // Add some horizontally moving lines for a matrix-like effect
    final linePaint = Paint()
      ..color = Colors.red.shade300.withAlpha((0.2 * 255).toInt())
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    
    for (int i = 0; i < 20; i++) {
      final y = random.nextDouble() * size.height;
      final speed = 50 + random.nextDouble() * 100;
      final x = (progress * speed) % (size.width + 100) - 50;
      
      canvas.drawLine(
        Offset(x, y),
        Offset(x + 30, y),
        linePaint,
      );
    }
  }
  
  @override
  bool shouldRepaint(ParticlesPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
