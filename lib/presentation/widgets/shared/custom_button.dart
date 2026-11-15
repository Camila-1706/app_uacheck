import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool isOutlined;
  final bool isLoading;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
    this.backgroundColor,
    this.foregroundColor,
    this.isOutlined = false,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorTexto = foregroundColor ??
        (isOutlined ? Theme.of(context).colorScheme.primary : Colors.white);

    Widget? iconoFinal;
    if (isLoading) {
      iconoFinal = SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          color: colorTexto,
          strokeWidth: 2,
        ),
      );
    } else if (icon != null) {
      iconoFinal = Icon(icon, color: colorTexto, size: 20);
    }

    if (isOutlined) {
      return OutlinedButton.icon(
        onPressed: isLoading ? null : onPressed,
        icon: iconoFinal ?? const SizedBox.shrink(),
        label: Text(
          text,
          style: TextStyle(color: colorTexto, fontWeight: FontWeight.bold),
        ),
        style: OutlinedButton.styleFrom(
          foregroundColor: colorTexto,
          side: BorderSide(color: Theme.of(context).colorScheme.primary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          minimumSize: const Size(double.infinity, 50),
        ),
      );
    } else {
      return ElevatedButton.icon(
        onPressed: isLoading ? null : onPressed,
        icon: iconoFinal ?? const SizedBox.shrink(),
        label: Text(
          text,
          style: TextStyle(color: colorTexto, fontWeight: FontWeight.bold),
        ),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
          backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.primary,
          foregroundColor: colorTexto,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
    }
  }
}