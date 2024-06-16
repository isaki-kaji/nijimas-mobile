import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SwitchCircleAvatar extends StatelessWidget {
  final String? imageUrl;
  final double radius;
  const SwitchCircleAvatar(
      {super.key, required this.imageUrl, this.radius = 20});

  @override
  Widget build(BuildContext context) {
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
