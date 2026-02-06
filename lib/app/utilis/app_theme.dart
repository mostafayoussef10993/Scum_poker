import 'package:flutter/material.dart';
import 'package:scum_poker/app/utilis/image_asset_path.dart';

class ThemeBackground extends StatelessWidget {
  final Widget child;
  const ThemeBackground({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final imagePath = brightness == Brightness.light
        ? ImageAssets.lightBG
        : ImageAssets.darkBG;
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover),
      ),
      child: child,
    );
  }
}
