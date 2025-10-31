import 'package:flutter/material.dart';
import 'package:tcp_penguin/presentation/common_dialog/penguin/common_dialog_penguin_body.dart';

class CommonDialogPenguin {
  static void show({required BuildContext context}) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return const CommonDialogPenguinBody();
      },
    );
  }
}
