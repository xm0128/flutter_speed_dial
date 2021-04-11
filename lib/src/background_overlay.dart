library flutter_speed_dial;

import 'package:flutter/material.dart';
import 'global_key_extension.dart';

class BackgroundOverlay extends AnimatedWidget {
  final Color color;
  final double opacity;
  final GlobalKey dialKey;
  final LayerLink layerLink;
  final VoidCallback? onTap;

  BackgroundOverlay({
    Key? key,
    this.onTap,
    required Animation<double> animation,
    required this.dialKey,
    required this.layerLink,
    this.color = Colors.white,
    this.opacity = 0.7,
  }) : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable as Animation<double>;
    return ColorFiltered(
        colorFilter: ColorFilter.mode(
            color.withOpacity(opacity * animation.value), BlendMode.srcOut),
        child: Stack(
          fit: StackFit.expand,
          children: [
            GestureDetector(
              onTap: onTap,
              child: Container(
                decoration: BoxDecoration(
                    color: color, backgroundBlendMode: BlendMode.dstOut),
              ),
            ),
            Positioned(
              width: dialKey.globalPaintBounds!.size.width,
              child: CompositedTransformFollower(
                link: layerLink,
                showWhenUnlinked: false,
                child: IgnorePointer(
                  ignoring: true,
                  child: Container(
                    width: dialKey.globalPaintBounds!.size.width,
                    height: dialKey.globalPaintBounds!.size.height,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
