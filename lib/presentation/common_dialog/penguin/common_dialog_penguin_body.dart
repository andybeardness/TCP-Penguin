import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CommonDialogPenguinBody extends StatefulWidget {
  const CommonDialogPenguinBody({super.key});

  @override
  State<CommonDialogPenguinBody> createState() =>
      _CommonDialogPenguinBodyState();
}

class _CommonDialogPenguinBodyState extends State<CommonDialogPenguinBody>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: false);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final angleX = math.sin(_controller.value * 2 * math.pi) * 0.1;
        final angleY = math.cos(_controller.value * 2 * math.pi) * 0.1;

        return Transform(
          alignment: FractionalOffset.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateX(angleX)
            ..rotateY(angleY),
          child: child,
        );
      },
      child: AlertDialog(
        backgroundColor: Colors.transparent,
        contentPadding: EdgeInsets.zero,
        content: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(50),
                borderRadius: BorderRadius.circular(32),
                border: Border.all(color: Colors.white.withAlpha(150)),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Text(
                    '🐧 TCP Penguin',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Expanded(
                    child: SingleChildScrollView(
                      child: Text(
                        'Developed by Andy Beardness\n\n'
                        'TCP Penguin is an open-source project aimed at providing a simple and effective TCP port scanning solution for network administrators and security professionals.\n\n'
                        'Feel free to explore the source code on GitHub and contribute to the project!',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white.withAlpha(50),
                      foregroundColor: Colors.white,
                      shadowColor: Colors.transparent,
                    ),
                    onPressed: () => context.pop(),
                    child: const Text('Close'),
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
