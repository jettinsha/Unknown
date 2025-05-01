import 'dart:math';
import 'package:flutter/material.dart';
import '../models/memory_orb.dart';
import '../widgets/memory_orb_widget.dart';
import '../widgets/star_background.dart';
import 'memory_detail_screen.dart';

class GalaxyScreen extends StatefulWidget {
  const GalaxyScreen({super.key});

  @override
  State<GalaxyScreen> createState() => _GalaxyScreenState();
}

class _GalaxyScreenState extends State<GalaxyScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<MemoryOrb> _memories = []; // TODO: Load actual memories

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();
    _loadMemories();
  }

  void _loadMemories() {
    // TODO: Load actual memories from a service or JSON file
    _memories.addAll([
      MemoryOrb(
        id: '1',
        title: 'First Meeting',
        message:
            'Remember when we first met? The coffee shop was packed but somehow we found each other.',
        imagePath: 'assets/images/first_meeting.jpg',
      ),
      // Add more memories here
    ]);
  }

  void _navigateToMemoryDetail(MemoryOrb memory) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            MemoryDetailScreen(
          memory: memory,
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.easeInOutCubic;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 800),
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
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          const StarBackground(),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Your Memory Galaxy',
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      color: Colors.white,
                      shadows: [
                        const Shadow(
                          blurRadius: 10.0,
                          color: Colors.purple,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Stack(
                        children: _memories.asMap().entries.map((entry) {
                          final index = entry.key;
                          final memory = entry.value;
                          final angle = (index / _memories.length) * 2 * pi;

                          return AnimatedBuilder(
                            animation: _controller,
                            builder: (context, child) {
                              final radius = constraints.maxWidth * 0.35;
                              final rotatedAngle =
                                  angle + _controller.value * 2 * pi;

                              return Positioned(
                                left: constraints.maxWidth / 2 +
                                    cos(rotatedAngle) * radius -
                                    50,
                                top: constraints.maxHeight / 2 +
                                    sin(rotatedAngle) * radius -
                                    50,
                                child: MemoryOrbWidget(
                                  memory: memory,
                                  onTap: () => _navigateToMemoryDetail(memory),
                                ),
                              );
                            },
                          );
                        }).toList(),
                      );
                    },
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
