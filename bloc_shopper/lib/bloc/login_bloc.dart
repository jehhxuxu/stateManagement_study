import 'dart:async';

import 'package:bloc/bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is SignInEvent) {
      yield LoginLoading();
      await Future.delayed(Duration(seconds: 3));
      if (event.password == null || event.password.isEmpty) {
        yield LoginFailure("Please check your credentials!");
      }
      yield LoginSuccess();
    }
  }
}
