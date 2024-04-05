import 'package:nijimas/application/usecase/auth_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_provider.g.dart';

@riverpod
class Auth extends _$Auth {
  @override
  bool build() => false;

  void signInWithGoogle() async {
    final auth = ref.read(authUseCaseProvider);
    state = true;
    final user = await auth.signInWithGoogle();
    state = false;
    if (user == null) {
      print("エラースナックバーを表示予定");
    }
  }

  void signInAsGuest() async {
    final auth = ref.read(authUseCaseProvider);
    state = true;
    final user = await auth.signInAsGuest();
    state = false;
    if (user == null) {
      print("エラースナックバーを表示予定");
    }
  }

  void signOut() async {
    final auth = ref.read(authUseCaseProvider);
    await auth.signOut();
  }
}
