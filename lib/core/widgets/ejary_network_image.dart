import 'package:flutter/material.dart';

class EjaryNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;

  const EjaryNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final placeholderColor =
        isDark ? const Color(0xFF272B26) : const Color(0xFFEFECE6);

    final img = Image.network(
      imageUrl,
      width: width,
      height: height,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return Container(
          width: width,
          height: height,
          color: placeholderColor,
          child: const Center(
            child: SizedBox(
              width: 22,
              height: 22,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
        );
      },
      errorBuilder: (context, _, __) => Container(
        width: width,
        height: height,
        color: placeholderColor,
        child: const Icon(Icons.home_work_outlined, size: 32),
      ),
    );

    if (borderRadius != null) {
      return ClipRRect(borderRadius: borderRadius!, child: img);
    }
    return img;
  }
}
