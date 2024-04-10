import 'package:logger/web.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'logger_provider.g.dart';

@riverpod
Logger logger(LoggerRef ref) {
  return Logger();
}
