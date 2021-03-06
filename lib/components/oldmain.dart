import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import './screens/counter/counter.dart';
import './screens/timer/timer.dart';
import './screens/posts/posts.dart';

// NOTE Public layout
import './screens/public/screen.dart';
import './screens/public/routes.dart';

// NOTE Public layout
import './screens/private/screen.dart';
import './screens/private/routes.dart';
import './screens/posts/bloc/simple_bloc_delegate.dart';
import 'screens/authentication/authentication_bloc.dart';
import 'screens/authentication/authentication_event.dart';

void main() {
    // Чтобы указать Bloc использовать наш SimpleBlocDelegate,
    // нам просто нужно настроить нашу основную функцию.
    BlocSupervisor.delegate = SimpleBlocDelegate();
    runApp(App());
}

class App extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            // Start the app with the "/" named route. In this case, the app starts
            // on the FirstScreen widget.
            initialRoute: '/posts',
            routes: {
                '/loader': (context) => AppLoader(),
                '/maintenance': (context) => Maintenance(),
                '/counter': (context) => CounterScreen(),
                '/timer': (context) => TimerScreen(),
                '/posts': (context) => PostsScreen(),
                // When navigating to the "/" route, build the FirstScreen widget.
                ...publicRoutes(context),
                // When navigating to the "/second" route, build the SecondScreen widget.
                ...privateRoutes(context),
            },
        );
    }
}

class AppLoader extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        Size size = MediaQuery.of(context).size;
        return Stack(
            alignment: Alignment.center,
            children: <Widget>[
                Positioned(
                    top: 0,
                    bottom: 0,
                    child: Image.asset(
                        'assets/images/preloader.jpg',
                        fit: BoxFit.cover,
                        width: size.width,
                    )),
                SizedBox(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(
                        valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                        strokeWidth: 5,
                    ),
                )
            ],
        );
    }
}

class Maintenance extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        Size size = MediaQuery.of(context).size;
        return Container(
            decoration: BoxDecoration(
                color: Colors.white,
            ),
            child: Image.asset(
                'assets/images/maintenance.gif',
                fit: BoxFit.fitWidth,
                width: size.width,
            ));
    }
}

class LoadingIndicator extends StatelessWidget {
    @override
    Widget build(BuildContext context) => Center(
        child: CircularProgressIndicator(),
    );
}

class HomePage extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text('Home'),
            ),
            body: Container(
                child: Center(
                    child: RaisedButton(
                        child: Text('logout'),
                        onPressed: () {
                            BlocProvider.of<AuthenticationBloc>(context)
                                .add(AuthenticationLoggedOut());
                        },
                    )),
            ),
        );
    }
}