//つまり成功、失敗によって型が変わる場合に使う
import 'package:fpdart/fpdart.dart';
import 'package:nijimas/core/failure.dart';

typedef FutureEither<T> = Future<Either<Failure, T>>;

//Failureかvoid
typedef FutureVoid = FutureEither<void>;
