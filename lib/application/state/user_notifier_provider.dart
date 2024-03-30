import 'package:nijimas/application/usecase/auth.dart';
import 'package:nijimas/core/provider/firebase_provider.dart';
import 'package:nijimas/domain/model/auth_user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_notifier_provider.g.dart';

@riverpod
class UserNotifier extends _$UserNotifier {
  @override
  Future<AuthUser?> build() async {
    final firebaseAuth = ref.read(firebaseAuthProvider);
    final user = firebaseAuth.currentUser;
    if (user == null) {
      return null;
    }
    final idToken = await user.getIdToken();
    if (idToken == null) {
      return null;
    }
    return AuthUser(uid: user.uid, idToken: idToken);
  }

  Future<void> signInWithGoogle() async {
    final auth = ref.read(authUseCaseProvider);
    state = (await auth.signInWithGoogle()) as AsyncValue<AuthUser?>;
  }
}
