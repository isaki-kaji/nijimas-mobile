import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/core/constants/constants.dart';
import 'package:nijimas/core/providers/storage_repository_provider.dart';
import 'package:nijimas/core/providers/user_notifier_provider.dart';
import 'package:nijimas/core/utils.dart';
import 'package:nijimas/models/post_model/nijimas_post_model.dart';
import 'package:nijimas/repositories/nijimas_repository.dart';
import 'package:uuid/uuid.dart';

final nijimasControllerProvider =
    NotifierProvider<NijimasController, bool>(NijimasController.new);

class NijimasController extends Notifier<bool> {
  late final NijimasRepository _nijimasRepository;
  late final StorageRepository _storageRepository;
  late final Ref _ref;

  @override
  bool build() {
    _nijimasRepository = ref.watch(nijimasRepositoryProvider);
    _storageRepository = ref.watch(storageRepositoryProvider);
    _ref = ref;
    return false;
  }

  Future<bool> doNijimas({
    required BuildContext context,
    required isPublic,
  }) async {
    bool isPushed = false;
    state = true;
    String postId = const Uuid().v1();
    final user = ref.watch(userProvider);

    final nijimasPost = NijimasPost(
      id: postId,
      uid: user!.uid,
      geoPoint: GeoPoint(22.2, 22.2),
      imageUrls: [],
      favoriteUids: [],
      favoriteCount: 0,
      isPublic: isPublic,
      tags: [],
      createdAt: DateTime.now(),
    );

    final res = await _nijimasRepository.doNijimas(nijimasPost);

    state = false;

    res.fold((l) => showErrorSnackBar(context, Constants.errorMessage),
        (r) => isPushed = true);

    return isPushed;
  }
}
