import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/core/constants/constants.dart';
import 'package:nijimas/core/providers/user_notifier_provider.dart';
import 'package:nijimas/core/utils.dart';
import 'package:nijimas/models/nijimas_model.dart';
import 'package:nijimas/models/post_model.dart';
import 'package:nijimas/repositories/post_repository.dart';
import 'package:routemaster/routemaster.dart';
import 'package:uuid/uuid.dart';

final postControllerProvider =
    NotifierProvider<PostController, bool>(PostController.new);

class PostController extends Notifier<bool> {
  late final PostRepository _postRepository;
  late final Ref _ref;

  @override
  bool build() {
    _postRepository = ref.watch(postRepositoryProvider);
    _ref = ref;
    return false;
  }

  void addPost(
      {required BuildContext context,
      required Nijimas doneNijimas,
      required bool isPublic,
      String? text,
      List<String>? postPhotos,
      required List<String> tags}) async {
    state = true;
    String postId = const Uuid().v1();
    final user = _ref.read(userProvider);

    final Post post = Post(
        postId: postId,
        nijimasId: doneNijimas.nijimasId,
        uid: user!.uid,
        geoPoint: doneNijimas.geoPoint,
        section: doneNijimas.section,
        text: text,
        imageUrls: postPhotos,
        favoriteUids: [],
        favoriteCount: 0,
        isPublic: isPublic,
        tags: tags,
        createdAt: DateTime.now().toUtc());

    final res = await _postRepository.addPost(post);

    state = false;

    res.fold((l) => showErrorSnackBar(context, Constants.errorMessage), (r) {
      showSuccessSnackBar(context, "投稿しました!!");
      Routemaster.of(context).pop();
    });
  }
}
