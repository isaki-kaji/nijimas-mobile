// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_status.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserStatus _$UserStatusFromJson(Map<String, dynamic> json) {
  return _UserStatus.fromJson(json);
}

/// @nodoc
mixin _$UserStatus {
  String get uid => throw _privateConstructorUsedError;
  bool get isFirstSignIn => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserStatusCopyWith<UserStatus> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserStatusCopyWith<$Res> {
  factory $UserStatusCopyWith(
          UserStatus value, $Res Function(UserStatus) then) =
      _$UserStatusCopyWithImpl<$Res, UserStatus>;
  @useResult
  $Res call({String uid, bool isFirstSignIn, DateTime createdAt});
}

/// @nodoc
class _$UserStatusCopyWithImpl<$Res, $Val extends UserStatus>
    implements $UserStatusCopyWith<$Res> {
  _$UserStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? isFirstSignIn = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      isFirstSignIn: null == isFirstSignIn
          ? _value.isFirstSignIn
          : isFirstSignIn // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserStatusImplCopyWith<$Res>
    implements $UserStatusCopyWith<$Res> {
  factory _$$UserStatusImplCopyWith(
          _$UserStatusImpl value, $Res Function(_$UserStatusImpl) then) =
      __$$UserStatusImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String uid, bool isFirstSignIn, DateTime createdAt});
}

/// @nodoc
class __$$UserStatusImplCopyWithImpl<$Res>
    extends _$UserStatusCopyWithImpl<$Res, _$UserStatusImpl>
    implements _$$UserStatusImplCopyWith<$Res> {
  __$$UserStatusImplCopyWithImpl(
      _$UserStatusImpl _value, $Res Function(_$UserStatusImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? isFirstSignIn = null,
    Object? createdAt = null,
  }) {
    return _then(_$UserStatusImpl(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      isFirstSignIn: null == isFirstSignIn
          ? _value.isFirstSignIn
          : isFirstSignIn // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserStatusImpl with DiagnosticableTreeMixin implements _UserStatus {
  const _$UserStatusImpl(
      {required this.uid,
      required this.isFirstSignIn,
      required this.createdAt});

  factory _$UserStatusImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserStatusImplFromJson(json);

  @override
  final String uid;
  @override
  final bool isFirstSignIn;
  @override
  final DateTime createdAt;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'UserStatus(uid: $uid, isFirstSignIn: $isFirstSignIn, createdAt: $createdAt)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'UserStatus'))
      ..add(DiagnosticsProperty('uid', uid))
      ..add(DiagnosticsProperty('isFirstSignIn', isFirstSignIn))
      ..add(DiagnosticsProperty('createdAt', createdAt));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserStatusImpl &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.isFirstSignIn, isFirstSignIn) ||
                other.isFirstSignIn == isFirstSignIn) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, uid, isFirstSignIn, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserStatusImplCopyWith<_$UserStatusImpl> get copyWith =>
      __$$UserStatusImplCopyWithImpl<_$UserStatusImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserStatusImplToJson(
      this,
    );
  }
}

abstract class _UserStatus implements UserStatus {
  const factory _UserStatus(
      {required final String uid,
      required final bool isFirstSignIn,
      required final DateTime createdAt}) = _$UserStatusImpl;

  factory _UserStatus.fromJson(Map<String, dynamic> json) =
      _$UserStatusImpl.fromJson;

  @override
  String get uid;
  @override
  bool get isFirstSignIn;
  @override
  DateTime get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$UserStatusImplCopyWith<_$UserStatusImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
