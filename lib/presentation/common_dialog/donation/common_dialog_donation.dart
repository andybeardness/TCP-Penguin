import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CommonDialogDonationEntity {
  final String title;
  final String subtitle;
  final String cancelText;
  final String confirmText;
  final String confirmUrl;

  CommonDialogDonationEntity({
    required this.title,
    required this.subtitle,
    required this.cancelText,
    required this.confirmText,
    required this.confirmUrl,
  });
}

class CommonDialogDonation {
  static void show({
    required BuildContext context,
    required CommonDialogDonationEntity entity,
    required Function() onCancel,
    required Function() onConfirm,
  }) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => AlertDialog(
        title: Text(entity.title),
        content: Text(entity.subtitle),
        actions: [
          TextButton(onPressed: onCancel, child: Text(entity.cancelText)),
          ElevatedButton(
            onPressed: () async {
              onConfirm();
              final url = Uri.parse(entity.confirmUrl);
              await launchUrl(url, mode: LaunchMode.externalApplication);
            },
            child: Text(entity.confirmText),
          ),
        ],
      ),
    );
  }
}
