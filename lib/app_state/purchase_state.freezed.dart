// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'purchase_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$PurchaseStateTearOff {
  const _$PurchaseStateTearOff();

  _notPurchased notPurchased() {
    return const _notPurchased();
  }

  _Error error(String errorMessage) {
    return _Error(
      errorMessage,
    );
  }

  _purchased purchase(List<Package> package) {
    return _purchased(
      package,
    );
  }
}

/// @nodoc
const $PurchaseState = _$PurchaseStateTearOff();

/// @nodoc
mixin _$PurchaseState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() notPurchased,
    required TResult Function(String errorMessage) error,
    required TResult Function(List<Package> package) purchase,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? notPurchased,
    TResult Function(String errorMessage)? error,
    TResult Function(List<Package> package)? purchase,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? notPurchased,
    TResult Function(String errorMessage)? error,
    TResult Function(List<Package> package)? purchase,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_notPurchased value) notPurchased,
    required TResult Function(_Error value) error,
    required TResult Function(_purchased value) purchase,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_notPurchased value)? notPurchased,
    TResult Function(_Error value)? error,
    TResult Function(_purchased value)? purchase,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_notPurchased value)? notPurchased,
    TResult Function(_Error value)? error,
    TResult Function(_purchased value)? purchase,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PurchaseStateCopyWith<$Res> {
  factory $PurchaseStateCopyWith(
          PurchaseState value, $Res Function(PurchaseState) then) =
      _$PurchaseStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$PurchaseStateCopyWithImpl<$Res>
    implements $PurchaseStateCopyWith<$Res> {
  _$PurchaseStateCopyWithImpl(this._value, this._then);

  final PurchaseState _value;
  // ignore: unused_field
  final $Res Function(PurchaseState) _then;
}

/// @nodoc
abstract class _$notPurchasedCopyWith<$Res> {
  factory _$notPurchasedCopyWith(
          _notPurchased value, $Res Function(_notPurchased) then) =
      __$notPurchasedCopyWithImpl<$Res>;
}

/// @nodoc
class __$notPurchasedCopyWithImpl<$Res>
    extends _$PurchaseStateCopyWithImpl<$Res>
    implements _$notPurchasedCopyWith<$Res> {
  __$notPurchasedCopyWithImpl(
      _notPurchased _value, $Res Function(_notPurchased) _then)
      : super(_value, (v) => _then(v as _notPurchased));

  @override
  _notPurchased get _value => super._value as _notPurchased;
}

/// @nodoc

class _$_notPurchased implements _notPurchased {
  const _$_notPurchased();

  @override
  String toString() {
    return 'PurchaseState.notPurchased()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _notPurchased);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() notPurchased,
    required TResult Function(String errorMessage) error,
    required TResult Function(List<Package> package) purchase,
  }) {
    return notPurchased();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? notPurchased,
    TResult Function(String errorMessage)? error,
    TResult Function(List<Package> package)? purchase,
  }) {
    return notPurchased?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? notPurchased,
    TResult Function(String errorMessage)? error,
    TResult Function(List<Package> package)? purchase,
    required TResult orElse(),
  }) {
    if (notPurchased != null) {
      return notPurchased();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_notPurchased value) notPurchased,
    required TResult Function(_Error value) error,
    required TResult Function(_purchased value) purchase,
  }) {
    return notPurchased(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_notPurchased value)? notPurchased,
    TResult Function(_Error value)? error,
    TResult Function(_purchased value)? purchase,
  }) {
    return notPurchased?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_notPurchased value)? notPurchased,
    TResult Function(_Error value)? error,
    TResult Function(_purchased value)? purchase,
    required TResult orElse(),
  }) {
    if (notPurchased != null) {
      return notPurchased(this);
    }
    return orElse();
  }
}

abstract class _notPurchased implements PurchaseState {
  const factory _notPurchased() = _$_notPurchased;
}

/// @nodoc
abstract class _$ErrorCopyWith<$Res> {
  factory _$ErrorCopyWith(_Error value, $Res Function(_Error) then) =
      __$ErrorCopyWithImpl<$Res>;
  $Res call({String errorMessage});
}

/// @nodoc
class __$ErrorCopyWithImpl<$Res> extends _$PurchaseStateCopyWithImpl<$Res>
    implements _$ErrorCopyWith<$Res> {
  __$ErrorCopyWithImpl(_Error _value, $Res Function(_Error) _then)
      : super(_value, (v) => _then(v as _Error));

  @override
  _Error get _value => super._value as _Error;

  @override
  $Res call({
    Object? errorMessage = freezed,
  }) {
    return _then(_Error(
      errorMessage == freezed
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_Error implements _Error {
  const _$_Error(this.errorMessage);

  @override
  final String errorMessage;

  @override
  String toString() {
    return 'PurchaseState.error(errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Error &&
            const DeepCollectionEquality()
                .equals(other.errorMessage, errorMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(errorMessage));

  @JsonKey(ignore: true)
  @override
  _$ErrorCopyWith<_Error> get copyWith =>
      __$ErrorCopyWithImpl<_Error>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() notPurchased,
    required TResult Function(String errorMessage) error,
    required TResult Function(List<Package> package) purchase,
  }) {
    return error(errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? notPurchased,
    TResult Function(String errorMessage)? error,
    TResult Function(List<Package> package)? purchase,
  }) {
    return error?.call(errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? notPurchased,
    TResult Function(String errorMessage)? error,
    TResult Function(List<Package> package)? purchase,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(errorMessage);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_notPurchased value) notPurchased,
    required TResult Function(_Error value) error,
    required TResult Function(_purchased value) purchase,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_notPurchased value)? notPurchased,
    TResult Function(_Error value)? error,
    TResult Function(_purchased value)? purchase,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_notPurchased value)? notPurchased,
    TResult Function(_Error value)? error,
    TResult Function(_purchased value)? purchase,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements PurchaseState {
  const factory _Error(String errorMessage) = _$_Error;

  String get errorMessage;
  @JsonKey(ignore: true)
  _$ErrorCopyWith<_Error> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$purchasedCopyWith<$Res> {
  factory _$purchasedCopyWith(
          _purchased value, $Res Function(_purchased) then) =
      __$purchasedCopyWithImpl<$Res>;
  $Res call({List<Package> package});
}

/// @nodoc
class __$purchasedCopyWithImpl<$Res> extends _$PurchaseStateCopyWithImpl<$Res>
    implements _$purchasedCopyWith<$Res> {
  __$purchasedCopyWithImpl(_purchased _value, $Res Function(_purchased) _then)
      : super(_value, (v) => _then(v as _purchased));

  @override
  _purchased get _value => super._value as _purchased;

  @override
  $Res call({
    Object? package = freezed,
  }) {
    return _then(_purchased(
      package == freezed
          ? _value.package
          : package // ignore: cast_nullable_to_non_nullable
              as List<Package>,
    ));
  }
}

/// @nodoc

class _$_purchased implements _purchased {
  const _$_purchased(this.package);

  @override
  final List<Package> package;

  @override
  String toString() {
    return 'PurchaseState.purchase(package: $package)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _purchased &&
            const DeepCollectionEquality().equals(other.package, package));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(package));

  @JsonKey(ignore: true)
  @override
  _$purchasedCopyWith<_purchased> get copyWith =>
      __$purchasedCopyWithImpl<_purchased>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() notPurchased,
    required TResult Function(String errorMessage) error,
    required TResult Function(List<Package> package) purchase,
  }) {
    return purchase(package);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? notPurchased,
    TResult Function(String errorMessage)? error,
    TResult Function(List<Package> package)? purchase,
  }) {
    return purchase?.call(package);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? notPurchased,
    TResult Function(String errorMessage)? error,
    TResult Function(List<Package> package)? purchase,
    required TResult orElse(),
  }) {
    if (purchase != null) {
      return purchase(package);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_notPurchased value) notPurchased,
    required TResult Function(_Error value) error,
    required TResult Function(_purchased value) purchase,
  }) {
    return purchase(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_notPurchased value)? notPurchased,
    TResult Function(_Error value)? error,
    TResult Function(_purchased value)? purchase,
  }) {
    return purchase?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_notPurchased value)? notPurchased,
    TResult Function(_Error value)? error,
    TResult Function(_purchased value)? purchase,
    required TResult orElse(),
  }) {
    if (purchase != null) {
      return purchase(this);
    }
    return orElse();
  }
}

abstract class _purchased implements PurchaseState {
  const factory _purchased(List<Package> package) = _$_purchased;

  List<Package> get package;
  @JsonKey(ignore: true)
  _$purchasedCopyWith<_purchased> get copyWith =>
      throw _privateConstructorUsedError;
}
