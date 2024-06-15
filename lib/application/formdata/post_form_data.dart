import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'post_form_data.freezed.dart';

@freezed
class PostFormData with _$PostFormData {
  const factory PostFormData({
    required String mainCategory,
    required List<String> subCategories,
    required String? postText,
    required List<Uint8List?> images,
    required String? expense,
    required String publicTypeNo,
  }) = _PostFormData;
}
