import 'package:bloc_shopper/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginBloc _bloc;

  void _onLogin() {
    _bloc.add(
      SignInEvent(
        _usernameController.text,
        _passwordController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _bloc ??= LoginBloc();
    return BlocConsumer<LoginBloc, LoginState>(
      cubit: _bloc,
      listener: (context, state) {
        if (state is LoginSuccess)
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("You're now logged in!"),
            ),
          );
        if (state is LoginFailure)
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Login"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(labelText: "Username/e-mail"),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: "Password"),
                ),
                SizedBox(height: 16),
                ElevatedButton.icon(
                  label: Text("Login"),
                  icon: state is LoginLoading
                      ? SizedBox(
                          height: 16,
                          width: 16,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.black),
                            strokeWidth: 2.0,
                          ),
                        )
                      : Icon(Icons.login),
                  onPressed: state is LoginLoading ? null : _onLogin,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
