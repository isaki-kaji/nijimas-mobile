// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_form_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PostFormData {
  MainCategory get mainCategory => throw _privateConstructorUsedError;
  List<String> get subCategories => throw _privateConstructorUsedError;
  String get postText => throw _privateConstructorUsedError;
  List<Uint8List?> get images => throw _privateConstructorUsedError;
  String get expense => throw _privateConstructorUsedError;
  String get publicTypeNo => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PostFormDataCopyWith<PostFormData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostFormDataCopyWith<$Res> {
  factory $PostFormDataCopyWith(
          PostFormData value, $Res Function(PostFormData) then) =
      _$PostFormDataCopyWithImpl<$Res, PostFormData>;
  @useResult
  $Res call(
      {MainCategory mainCategory,
      List<String> subCategories,
      String postText,
      List<Uint8List?> images,
      String expense,
      String publicTypeNo});
}

/// @nodoc
class _$PostFormDataCopyWithImpl<$Res, $Val extends PostFormData>
    implements $PostFormDataCopyWith<$Res> {
  _$PostFormDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mainCategory = null,
    Object? subCategories = null,
    Object? postText = null,
    Object? images = null,
    Object? expense = null,
    Object? publicTypeNo = null,
  }) {
    return _then(_value.copyWith(
      mainCategory: null == mainCategory
          ? _value.mainCategory
          : mainCategory // ignore: cast_nullable_to_non_nullable
              as MainCategory,
      subCategories: null == subCategories
          ? _value.subCategories
          : subCategories // ignore: cast_nullable_to_non_nullable
              as List<String>,
      postText: null == postText
          ? _value.postText
          : postText // ignore: cast_nullable_to_non_nullable
              as String,
      images: null == images
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<Uint8List?>,
      expense: null == expense
          ? _value.expense
          : expense // ignore: cast_nullable_to_non_nullable
              as String,
      publicTypeNo: null == publicTypeNo
          ? _value.publicTypeNo
          : publicTypeNo // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PostFormDataImplCopyWith<$Res>
    implements $PostFormDataCopyWith<$Res> {
  factory _$$PostFormDataImplCopyWith(
          _$PostFormDataImpl value, $Res Function(_$PostFormDataImpl) then) =
      __$$PostFormDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {MainCategory mainCategory,
      List<String> subCategories,
      String postText,
      List<Uint8List?> images,
      String expense,
      String publicTypeNo});
}

/// @nodoc
class __$$PostFormDataImplCopyWithImpl<$Res>
    extends _$PostFormDataCopyWithImpl<$Res, _$PostFormDataImpl>
    implements _$$PostFormDataImplCopyWith<$Res> {
  __$$PostFormDataImplCopyWithImpl(
      _$PostFormDataImpl _value, $Res Function(_$PostFormDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mainCategory = null,
    Object? subCategories = null,
    Object? postText = null,
    Object? images = null,
    Object? expense = null,
    Object? publicTypeNo = null,
  }) {
    return _then(_$PostFormDataImpl(
      mainCategory: null == mainCategory
          ? _value.mainCategory
          : mainCategory // ignore: cast_nullable_to_non_nullable
              as MainCategory,
      subCategories: null == subCategories
          ? _value._subCategories
          : subCategories // ignore: cast_nullable_to_non_nullable
              as List<String>,
      postText: null == postText
          ? _value.postText
          : postText // ignore: cast_nullable_to_non_nullable
              as String,
      images: null == images
          ? _value._images
          : images // ignore: cast_nullable_to_non_nullable
              as List<Uint8List?>,
      expense: null == expense
          ? _value.expense
          : expense // ignore: cast_nullable_to_non_nullable
              as String,
      publicTypeNo: null == publicTypeNo
          ? _value.publicTypeNo
          : publicTypeNo // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$PostFormDataImpl with DiagnosticableTreeMixin implements _PostFormData {
  const _$PostFormDataImpl(
      {required this.mainCategory,
      required final List<String> subCategories,
      required this.postText,
      required final List<Uint8List?> images,
      required this.expense,
      required this.publicTypeNo})
      : _subCategories = subCategories,
        _images = images;

  @override
  final MainCategory mainCategory;
  final List<String> _subCategories;
  @override
  List<String> get subCategories {
    if (_subCategories is EqualUnmodifiableListView) return _subCategories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_subCategories);
  }

  @override
  final String postText;
  final List<Uint8List?> _images;
  @override
  List<Uint8List?> get images {
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_images);
  }

  @override
  final String expense;
  @override
  final String publicTypeNo;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PostFormData(mainCategory: $mainCategory, subCategories: $subCategories, postText: $postText, images: $images, expense: $expense, publicTypeNo: $publicTypeNo)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PostFormData'))
      ..add(DiagnosticsProperty('mainCategory', mainCategory))
      ..add(DiagnosticsProperty('subCategories', subCategories))
      ..add(DiagnosticsProperty('postText', postText))
      ..add(DiagnosticsProperty('images', images))
      ..add(DiagnosticsProperty('expense', expense))
      ..add(DiagnosticsProperty('publicTypeNo', publicTypeNo));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostFormDataImpl &&
            (identical(other.mainCategory, mainCategory) ||
                other.mainCategory == mainCategory) &&
            const DeepCollectionEquality()
                .equals(other._subCategories, _subCategories) &&
            (identical(other.postText, postText) ||
                other.postText == postText) &&
            const DeepCollectionEquality().equals(other._images, _images) &&
            (identical(other.expense, expense) || other.expense == expense) &&
            (identical(other.publicTypeNo, publicTypeNo) ||
                other.publicTypeNo == publicTypeNo));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      mainCategory,
      const DeepCollectionEquality().hash(_subCategories),
      postText,
      const DeepCollectionEquality().hash(_images),
      expense,
      publicTypeNo);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PostFormDataImplCopyWith<_$PostFormDataImpl> get copyWith =>
      __$$PostFormDataImplCopyWithImpl<_$PostFormDataImpl>(this, _$identity);
}

abstract class _PostFormData implements PostFormData {
  const factory _PostFormData(
      {required final MainCategory mainCategory,
      required final List<String> subCategories,
      required final String postText,
      required final List<Uint8List?> images,
      required final String expense,
      required final String publicTypeNo}) = _$PostFormDataImpl;

  @override
  MainCategory get mainCategory;
  @override
  List<String> get subCategories;
  @override
  String get postText;
  @override
  List<Uint8List?> get images;
  @override
  String get expense;
  @override
  String get publicTypeNo;
  @override
  @JsonKey(ignore: true)
  _$$PostFormDataImplCopyWith<_$PostFormDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
