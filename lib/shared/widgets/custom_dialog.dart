ñimport 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String message;
  final List<Widget>? actions;
  final Widget? content;
  final IconData? icon;
  final Color? iconColor;

  const CustomDialog({
    super.key,
    required this.title,
    required this.message,
    this.actions,
    this.content,
    this.icon,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      title: Row(
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              color: iconColor ?? Theme.of(context).primaryColor,
              size: 24,
            ),
            const SizedBox(width: 8),
          ],
          Text(title),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(message),
          if (content != null) ...[
            const SizedBox(height: 16),
            content!,
          ],
        ],
      ),
      actions: actions ??
          [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cerrar'),
            ),
          ],
    );
  }

  static Future<void> show({
    required BuildContext context,
    required String title,
    required String message,
    List<Widget>? actions,
    Widget? content,
    IconData? icon,
    Color? iconColor,
  }) {
    return showDialog(
      context: context,
      builder: (context) => CustomDialog(
        title: title,
        message: message,
        actions: actions,
        content: content,
        icon: icon,
        iconColor: iconColor,
      ),
    );
  }
}