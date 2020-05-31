import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../authentication/authentication.dart';
import './signin/signin_bloc.dart';
import './signin_form.dart';
import '../../repositories/user_repository.dart';

class LoginPage extends StatelessWidget {
    final UserRepository userRepository;

    LoginPage({Key key, @required this.userRepository})
        : assert(userRepository != null),
            super(key: key);

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text('Login'),
            ),
            body: BlocProvider(
                create: (context) {
                    return LoginBloc(
                        authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
                        userRepository: userRepository,
                    );
                },
                child: LoginForm(),
            ),
        );
    }
}