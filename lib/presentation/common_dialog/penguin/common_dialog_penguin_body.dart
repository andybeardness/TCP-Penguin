import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tcp_penguin/app/localization/app_localizations.dart';

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
      duration: const Duration(seconds: 5),
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
    final theme = Theme.of(context);

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final angleX = math.sin(_controller.value * 2 * math.pi) * 0.1;
        final angleY = math.cos(_controller.value * 2 * math.pi) * 0.1;

        return Transform(
          alignment: FractionalOffset.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.005)
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
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(50),
                borderRadius: BorderRadius.circular(32),
                border: Border.all(color: Colors.white.withAlpha(100)),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("🐧", style: TextStyle(fontSize: 64)),

                  Text(
                    'TCP Penguin',
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    AppLocalizations.of(context)!.penguinDialog.developedBy,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    AppLocalizations.of(context)!.penguinDialog.aboutApp,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    AppLocalizations.of(context)!.penguinDialog.aboutGithub,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 8),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white.withAlpha(100),
                      foregroundColor: Colors.white,
                      elevation: 0,
                    ),
                    onPressed: () => context.pop(),
                    child: Text(
                      AppLocalizations.of(context)!.penguinDialog.closeButton,
                    ),
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
