import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GlowingContainer extends StatelessWidget {
  final Widget child;
  final Color glowColor;
  final double glowIntensity;
  final double borderRadius;
  final EdgeInsets padding;
  final BoxBorder? border;
  final Gradient? gradient;
  
  const GlowingContainer({
    Key? key,
    required this.child,
    this.glowColor = Colors.green,
    this.glowIntensity = 0.5,
    this.borderRadius = 16.0,
    this.padding = const EdgeInsets.all(16.0),
    this.border,
    this.gradient,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: glowColor.withAlpha((glowIntensity * 255).toInt()),
            blurRadius: 20,
            spreadRadius: 1,
          ),
        ],
        border: border,
        gradient: gradient ?? LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            glowColor.withAlpha((0.8 * 255).toInt()),
            glowColor.withAlpha((0.6 * 255).toInt()),
          ],
        ),
      ),
      child: child,
    );
  }
}

class AnimatedPressableButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color foregroundColor;
  final double borderRadius;
  final EdgeInsets padding;
  final double elevation;
  
  const AnimatedPressableButton({
    Key? key,
    required this.child,
    required this.onPressed,
    this.backgroundColor = Colors.green,
    this.foregroundColor = Colors.white,
    this.borderRadius = 30.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    this.elevation = 5.0,
  }) : super(key: key);
  
  @override
  State<AnimatedPressableButton> createState() => _AnimatedPressableButtonState();
}

class _AnimatedPressableButtonState extends State<AnimatedPressableButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) => _controller.reverse(),
      onTapCancel: () => _controller.reverse(),
      onTap: widget.onPressed,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              padding: widget.padding,
              decoration: BoxDecoration(
                color: widget.backgroundColor,
                borderRadius: BorderRadius.circular(widget.borderRadius),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha((0.3 * 255).toInt()),
                    blurRadius: widget.elevation,
                    offset: Offset(0, widget.elevation / 2),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: DefaultTextStyle(
                style: GoogleFonts.rubik(
                  color: widget.foregroundColor,
                  fontWeight: FontWeight.bold,
                ),
                child: widget.child,
              ),
            ),
          );
        },
      ),
    );
  }
}

class GradientText extends StatelessWidget {
  final String text;
  final Gradient gradient;
  final TextStyle style;
  
  const GradientText({
    Key? key,
    required this.text,
    required this.gradient,
    required this.style,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => gradient.createShader(bounds),
      child: Text(
        text,
        style: style.copyWith(color: Colors.white),
      ),
    );
  }
}

class AnimatedBackground extends StatelessWidget {
  final List<Color> colors;
  final List<double> stops;
  final Widget child;
  final double animationValue;
  
  const AnimatedBackground({
    Key? key,
    required this.colors,
    this.stops = const [0.0, 0.5, 1.0],
    required this.child,
    required this.animationValue,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colors,
          stops: stops,
          transform: GradientRotation(animationValue * 0.5),
        ),
      ),
      child: child,
    );
  }
}
