import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:snake_game/screens/game_screen.dart';
import 'dart:math' as math;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }
  
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // Calculate responsive font sizes based on screen width
    final titleFontSize = size.width * 0.12; // Reduced from 0.16
    final subtitleFontSize = size.width * 0.08; // Reduced from 0.1
    final iconSize = size.width * 0.35; // Slightly reduced from 0.4

    return Scaffold(
      body: Stack(
        children: [
          // Animated background
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.green.shade900,
                      Colors.green.shade700,
                      Colors.black,
                    ],
                    stops: const [0.0, 0.6, 1.0],
                    transform: GradientRotation(_animationController.value * math.pi / 4),
                  ),
                ),
                child: CustomPaint(
                  painter: GridPatternPainter(
                    progress: _animationController.value,
                  ),
                ),
              );
            },
          ),
          
          // Content
          SafeArea(
            child: Center( // Added Center widget to ensure everything is centered
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center, // Ensure children are centered horizontally
                  children: [
                    const Spacer(flex: 1),
                    
                    // Game logo/title with snake image
                    Center( // Added Center widget for title alignment
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Snake icon with animated glow effect
                          TweenAnimationBuilder<double>(
                            tween: Tween<double>(begin: 0.5, end: 1.0),
                            duration: const Duration(milliseconds: 2000),
                            curve: Curves.easeInOut,
                            builder: (context, value, child) {
                              return ShaderMask(
                                shaderCallback: (Rect bounds) {
                                  return RadialGradient(
                                    center: Alignment.center,
                                    radius: 0.5 + (0.3 * math.sin(_animationController.value * 2 * math.pi)),
                                    colors: [
                                      Colors.green.shade300,
                                      Colors.transparent,
                                    ],
                                    stops: [
                                      0.7 * value,
                                      1.0,
                                    ],
                                  ).createShader(bounds);
                                },
                                child: Icon(
                                  Icons.pets,
                                  size: iconSize,
                                  color: Colors.green.shade200,
                                ),
                              );
                            },
                          ),
                          
                          // Game title with shader mask for shimmer effect
                          Column(
                            mainAxisSize: MainAxisSize.min, // Ensure column takes minimum space
                            mainAxisAlignment: MainAxisAlignment.center, // Center content vertically
                            children: [
                              ShaderMask(
                                shaderCallback: (Rect bounds) {
                                  return LinearGradient(
                                    colors: [
                                      Colors.white,
                                      Colors.green.shade300,
                                      Colors.white,
                                    ],
                                    stops: const [0.0, 0.5, 1.0],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    transform: GradientRotation(_animationController.value * math.pi),
                                  ).createShader(bounds);
                                },
                                child: Text(
                                  'SNAKE',
                                  textAlign: TextAlign.center, // Ensure text is centered
                                  style: GoogleFonts.pressStart2p(
                                    fontSize: titleFontSize,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    letterSpacing: 4.0,
                                    shadows: [
                                      Shadow(
                                        blurRadius: 20.0,
                                        color: Colors.black.withAlpha((0.7 * 255).toInt()),
                                        offset: const Offset(5.0, 5.0),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              ShaderMask(
                                shaderCallback: (Rect bounds) {
                                  return LinearGradient(
                                    colors: [
                                      Colors.amber.shade300,
                                      Colors.amber.shade600,
                                      Colors.amber.shade300,
                                    ],
                                    stops: const [0.0, 0.5, 1.0],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    transform: GradientRotation(_animationController.value * math.pi * 0.5),
                                  ).createShader(bounds);
                                },
                                child: Text(
                                  'GAME',
                                  textAlign: TextAlign.center, // Ensure text is centered
                                  style: GoogleFonts.pressStart2p(
                                    fontSize: subtitleFontSize,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    letterSpacing: 6.0,
                                    shadows: [
                                      Shadow(
                                        blurRadius: 15.0,
                                        color: Colors.black.withAlpha((0.7 * 255).toInt()),
                                        offset: const Offset(3.0, 3.0),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    const Spacer(flex: 1),
                    
                    // Play button with animation - wrapped in Center
                    Center(
                      child: TweenAnimationBuilder<double>(
                        tween: Tween<double>(begin: 0.95, end: 1.05),
                        duration: const Duration(milliseconds: 1500),
                        curve: Curves.easeInOut,
                        builder: (context, scale, child) {
                          return AnimatedBuilder(
                            animation: _animationController,
                            builder: (context, _) {
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.green.shade300.withAlpha(((0.3 + 0.2 * math.sin(_animationController.value * 2 * math.pi)) * 255).toInt()),
                                      blurRadius: 20,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                                child: Transform.scale(
                                  scale: scale,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
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
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      backgroundColor: Colors.green.shade600,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: size.width * 0.15,
                                        vertical: 20.0,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30.0),
                                      ),
                                      elevation: 10,
                                      shadowColor: Colors.black.withAlpha((0.6 * 255).toInt()),
                                    ),
                                    child: Text(
                                      'PLAY',
                                      style: GoogleFonts.pressStart2p(
                                        fontSize: 22, 
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 3.0,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // How to play button with animated border - wrapped in Center
                    Center(
                      child: AnimatedBuilder(
                        animation: _animationController,
                        builder: (context, child) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              gradient: LinearGradient(
                                colors: [
                                  Colors.green.shade300.withAlpha(((0.3 + 0.2 * math.sin(_animationController.value * 2 * math.pi)) * 255).toInt()),
                                  Colors.transparent,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => Dialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    elevation: 20,
                                    backgroundColor: Colors.transparent,
                                    child: Container(
                                      padding: const EdgeInsets.all(20.0),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Colors.green.shade800,
                                            Colors.green.shade900,
                                            Colors.black.withAlpha((0.9 * 255).toInt()),
                                          ],
                                          stops: const [0.0, 0.7, 1.0],
                                        ),
                                        borderRadius: BorderRadius.circular(20.0),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withAlpha((0.5 * 255).toInt()),
                                            blurRadius: 15,
                                            spreadRadius: 5,
                                          ),
                                        ],
                                        border: Border.all(
                                          color: Colors.green.shade500.withAlpha((0.3 * 255).toInt()),
                                          width: 2,
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'HOW TO PLAY',
                                            style: GoogleFonts.rubik(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              letterSpacing: 2.0,
                                            ),
                                          ),
                                          const SizedBox(height: 20),
                                          SingleChildScrollView(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                _buildInstructionStep(
                                                  icon: Icons.arrow_forward,
                                                  text: 'Use the arrows to control the snake',
                                                ),
                                                _buildInstructionStep(
                                                  icon: Icons.food_bank,
                                                  text: 'Eat apples to grow and score points',
                                                ),
                                                _buildInstructionStep(
                                                  icon: Icons.warning,
                                                  text: 'Avoid hitting walls, obstacles, or yourself',
                                                ),
                                                _buildInstructionStep(
                                                  icon: Icons.favorite,
                                                  text: 'You have 5 lives to start with',
                                                ),
                                                _buildInstructionStep(
                                                  icon: Icons.emoji_events,
                                                  text: 'Try to achieve the highest score!',
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 20),
                                          ElevatedButton(
                                            onPressed: () => Navigator.pop(context),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.white,
                                              foregroundColor: Colors.green.shade900,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(20.0),
                                              ),
                                              elevation: 5,
                                              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                                            ),
                                            child: Text(
                                              'GOT IT',
                                              style: GoogleFonts.rubik(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.1,
                                  vertical: 15.0,
                                ),
                                elevation: 0,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  side: BorderSide(
                                    color: Colors.green.shade300.withAlpha((0.5 * 255).toInt()),
                                    width: 2,
                                  ),
                                ),
                              ),
                              child: Text(
                                'HOW TO PLAY',
                                style: GoogleFonts.rubik(
                                  fontSize: 16, 
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.5,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    
                    const Spacer(flex: 1),
                    
                    // Version number and credits - wrapped in Center
                    Center(
                      child: AnimatedBuilder(
                        animation: _animationController,
                        builder: (context, child) {
                          return Opacity(
                            opacity: 0.5 + 0.2 * math.sin(_animationController.value * 2 * math.pi),
                            child: Text(
                              'Version 1.0',
                              style: GoogleFonts.rubik(
                                color: Colors.green.shade100,
                                fontSize: 12,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInstructionStep({required IconData icon, required String text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.green.shade600.withAlpha((0.3 * 255).toInt()),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: Colors.green.shade300,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.rubik(
                color: Colors.white,
                fontSize: 16,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GridPatternPainter extends CustomPainter {
  final double progress;
  
  GridPatternPainter({required this.progress});
  
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.green.shade700.withAlpha((0.1 * 255).toInt())
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    
    const spacing = 30.0;
    final timeOffset = progress * 2 * math.pi;
    
    // Draw horizontal lines
    for (double y = 0; y < size.height; y += spacing) {
      final adjustedY = y + 5 * math.sin(timeOffset + y / 30);
      canvas.drawLine(
        Offset(0, adjustedY),
        Offset(size.width, adjustedY),
        paint,
      );
    }
    
    // Draw vertical lines
    for (double x = 0; x < size.width; x += spacing) {
      final adjustedX = x + 5 * math.sin(timeOffset + x / 30);
      canvas.drawLine(
        Offset(adjustedX, 0),
        Offset(adjustedX, size.height),
        paint,
      );
    }
    
    // Draw some random dots
    final dotPaint = Paint()
      ..color = Colors.green.shade300.withAlpha((0.3 * 255).toInt())
      ..style = PaintingStyle.fill;
    
    final random = math.Random(42); // Fixed seed for consistency
    
    for (int i = 0; i < 50; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final radius = 1 + random.nextDouble() * 3;
      
      // Make dots pulse
      final pulseFactor = 0.7 + 0.3 * math.sin(timeOffset * 2 + i);
      
      canvas.drawCircle(
        Offset(x, y),
        radius * pulseFactor,
        dotPaint,
      );
    }
  }
  
  @override
  bool shouldRepaint(GridPatternPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
