import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'google_signin_provider.g.dart';

@riverpod
GoogleSignIn googleSignin(GoogleSigninRef ref) {
  return GoogleSignIn();
}
