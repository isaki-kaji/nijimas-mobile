import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor();

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // final dioAuthException = DioException(
      //   requestOptions: options,
      //   message: "User is not signed in",
      // );
      // handler.reject(dioAuthException);
      return;
    }
    final token = await user.getIdToken();
    options.headers["Content-Type"] = "application/json";
    options.headers["Authorization"] = "Bearer $token";
    handler.next(options);
  }
}
