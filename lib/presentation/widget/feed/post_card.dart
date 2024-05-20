import 'package:flutter/material.dart';
import 'package:nijimas/domain/response/post_response.dart';

class PostCard extends StatelessWidget {
  final PostResponse postResponse;
  const PostCard({super.key, required this.postResponse});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(postResponse.username),
        Text(postResponse.mainCategory),
        Text(postResponse.subCategory1 ?? ''),
        Text(postResponse.subCategory2 ?? ''),
        Text(postResponse.postText ?? ''),
        Text(postResponse.photoUrl.toString()),
        Text(postResponse.expense?.toString() ?? ''),
        Text(postResponse.location ?? ''),
        Text(postResponse.publicTypeNo),
        Text(postResponse.createdAt.toString()),
      ],
    );
  }
}
