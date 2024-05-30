import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/mockito.dart';
import 'package:nijimas/application/state/loading_provider.dart';
import 'package:nijimas/application/usecase/user_usecase.dart';
import 'package:nijimas/domain/request/create_user_request.dart';
import 'package:nijimas/domain/response/user_response.dart';
import 'package:nijimas/repository/auth_repository.dart';
import 'package:nijimas/repository/user_repository.dart';
import 'package:nijimas/repository/user_status_repository.dart';
import 'package:mockito/annotations.dart';

import '../../util.dart';
import 'user_usecase_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<UserRepository>(),
  MockSpec<UserStatusRepository>(),
  MockSpec<AuthRepository>(),
  MockSpec<Ref>(),
  MockSpec<Loading>()
])
void main() {
  group('createUser', () {
    late MockUserRepository userRepository;
    late MockUserStatusRepository userStatusRepository;
    late MockAuthRepository authRepository;
    late MockRef ref;
    late MockLoading loading;
    late UserUsecase userUsecase;

    setUp(() {
      userRepository = MockUserRepository();
      userStatusRepository = MockUserStatusRepository();
      authRepository = MockAuthRepository();
      loading = MockLoading();
      ref = MockRef();

      userUsecase = UserUsecase(
        userRepository: userRepository,
        userStatusRepository: userStatusRepository,
        authRepository: authRepository,
        ref: ref,
      );

      when(ref.read(loadingProvider.notifier)).thenReturn(loading);
      when(loading.setFalse()).thenReturn(null);
      when(loading.setTrue()).thenReturn(null);
    });

    test('successfully create a user', () async {
      final req = createRandomUserRequest();
      when(userRepository.createUser(req)).thenAnswer(
        (_) async => UserResponse(uid: req.uid, username: req.username),
      );
      when(userStatusRepository.toggleIsFirstSignIn(any))
          .thenAnswer((_) async => {});

      var isSuccessCalled = false;
      var isFailureCalled = false;
      var isUserAlreadyExistsCalled = false;

      void onSuccess() {
        isSuccessCalled = true;
      }

      void onFailure() {
        isFailureCalled = true;
      }

      void onUserAlreadyExists() {
        isUserAlreadyExistsCalled = true;
      }

      await userUsecase.createUser(
        request: req,
        onSuccess: onSuccess,
        onFailure: onFailure,
        onUserAlreadyExists: onUserAlreadyExists,
      );

      expect(isSuccessCalled, true);
      expect(isFailureCalled, false);
      expect(isUserAlreadyExistsCalled, false);

      verify(userRepository.createUser(req)).called(1);
      verify(userStatusRepository.toggleIsFirstSignIn(any)).called(1);
      verify(authRepository.currentUser).called(1);
      verify(ref.read(loadingProvider.notifier).setTrue()).called(1);
      verify(ref.read(loadingProvider.notifier).setFalse()).called(1);
    });
  });
}

CreateUserRequest createRandomUserRequest() {
  return CreateUserRequest(
      uid: randomString(28),
      username: randomString(5),
      countryCode: randomCountryCode());
}
