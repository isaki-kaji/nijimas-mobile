import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SwitchCircleAvatar extends StatelessWidget {
  final String? imageUrl;
  const SwitchCircleAvatar({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return imageUrl == null
        ? const CircleAvatar(
            child: Icon(Icons.person),
          )
        : CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(
              imageUrl!,
            ),
          );
  }
}
