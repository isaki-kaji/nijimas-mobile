import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nijimas/core/theme/my_colors.dart';

class CenterButton extends StatelessWidget {
  final IconData icon;
  final void Function() onTap;

  const CenterButton({super.key, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: SizedBox(
        height: 280,
        child: Card(
          shape: const CircleBorder(),
          elevation: 6.0,
          color: Colors.white,
          child: Center(
            child: FaIcon(
              icon,
              color: MyColors.pinkColor,
              size: 180,
            ),
          ),
        ),
      ),
    );
  }
}
