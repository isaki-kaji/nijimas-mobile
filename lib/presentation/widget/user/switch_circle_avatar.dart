import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SwitchCircleAvatar extends StatelessWidget {
  final String? imageUrl;
  final double radius;
  final void Function()? onTap;
  const SwitchCircleAvatar(
      {super.key, required this.imageUrl, this.radius = 20, this.onTap});

  @override
  Widget build(BuildContext context) {
    return onTap != null
        ? GestureDetector(
            onTap: onTap,
            child: _buildWidget(),
          )
        : _buildWidget();
  }

  Widget _buildWidget() {
    return imageUrl == null
        ? CircleAvatar(
            radius: radius,
            child: Icon(Icons.person, size: radius * 0.9),
          )
        : CircleAvatar(
            radius: radius,
            backgroundImage: CachedNetworkImageProvider(
              imageUrl!,
            ),
          );
  }
}
