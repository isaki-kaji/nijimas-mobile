import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nijimas/application/usecase/abstract_auth.dart';
import 'package:nijimas/domain/model/auth_user.dart';
import 'package:nijimas/repository/abstract_auth_repository.dart';
import 'package:nijimas/repository/auth_repository.dart';

final authUseCaseProvider = Provider<AbstractAuthUsecase>((ref) {
  return AuthUseCase(ref.read(authRepositoryProvider));
});

class AuthUseCase extends AbstractAuthUsecase {
  final AbstractAuthRepository _authRepository;

  AuthUseCase(this._authRepository);

  @override
  Future<AuthUser?> signInWithGoogle() async {
    return await _authRepository.signInWithGoogle();
  }

  @override
  Future<void> signOut() async {
    return await _authRepository.signOut();
  }
}
