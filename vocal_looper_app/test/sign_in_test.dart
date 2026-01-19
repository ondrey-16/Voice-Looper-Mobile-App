import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vocal_looper_app/auth/auth_cubit.dart';
import 'package:vocal_looper_app/auth/auth_service.dart';
import 'package:vocal_looper_app/services/user_service.dart';

class MockAuthService extends Mock implements AuthService {}

class MockUserService extends Mock implements UserService {}

void main() {
  group('Correct and incorrect signing in: ', () {
    late AuthService mockAuthService;
    late UserService mockUserService;
    late AuthCubit authCubit;

    const testEmail = 'testemail@gmail.com';
    const testPassword = 'password';
    const incorrectTestPassword = 'incorrect';

    setUp(() {
      mockAuthService = MockAuthService();
      mockUserService = MockUserService();

      when(() => mockAuthService.stateFromAuth).thenReturn(SignedOutState());
      when(
        () => mockAuthService.isSignedInStream,
      ).thenAnswer((_) => Stream.value(false));

      authCubit = AuthCubit(
        authService: mockAuthService,
        userService: mockUserService,
      );
    });

    tearDown(() {
      authCubit.close();
    });

    blocTest<AuthCubit, AuthState>(
      'should return SigningState and then SignedInState',
      build: () {
        when(
          () => mockAuthService.signInWithEmail(
            email: testEmail,
            password: testPassword,
          ),
        ).thenAnswer((_) async => null);

        return authCubit;
      },
      act: (ac) => ac.signInWithEmail(testEmail, testPassword),
      expect: () => [SigningState(), SignedInState(email: testEmail)],
    );

    blocTest<AuthCubit, AuthState>(
      'should return SigningState and then ErrorState',
      build: () {
        when(
          () => mockAuthService.signInWithEmail(
            email: testEmail,
            password: incorrectTestPassword,
          ),
        ).thenAnswer((_) async => 'Wrong password!');

        return authCubit;
      },
      act: (ac) => ac.signInWithEmail(testEmail, incorrectTestPassword),
      expect: () => [SigningState(), ErrorState(error: 'Wrong password!')],
    );
  });
}
