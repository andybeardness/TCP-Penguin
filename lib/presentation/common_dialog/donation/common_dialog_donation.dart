import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CommonDialogDonation {
  static void show({
    required BuildContext context,
    required String title,
    required String subtitle,
    required String cancelText,
    required String confirmText,
    required String confirmUrl,
    required Function() onCancel,
    required Function() onConfirm,
  }) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => AlertDialog(
        title: Text(title, textAlign: TextAlign.center),
        content: Text(subtitle, textAlign: TextAlign.center),
        actions: [
          TextButton(onPressed: onCancel, child: Text(cancelText)),
          ElevatedButton(
            onPressed: () async {
              onConfirm();
              final url = Uri.parse(confirmUrl);
              await launchUrl(url, mode: LaunchMode.externalApplication);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
            ),
            child: Text(confirmText),
          ),
        ],
      ),
    );
  }
}
