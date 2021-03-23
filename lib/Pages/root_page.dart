import 'package:be_aware/Model/UserModel.dart';
import 'package:be_aware/Pages/LoginScreen.dart';
import 'package:be_aware/Util/MyNavigator.dart';
import 'package:be_aware/Util/global.dart' as globalKey;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum AuthStatus {
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  LOGGED_IN,
  INVITE,
}

class RootPage extends StatefulWidget {
  @override
  _RoutePageState createState() => _RoutePageState();
}

class _RoutePageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.NOT_DETERMINED;
  String _userId = "";
  BuildContext _context;
  @override
  Widget build(BuildContext context) {
    _context = context;
    return FutureBuilder(
      future: globalKey.auth.getCurrentUser(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return afterHasData(snapshot.data);
        } else {
          return notDataLogin();
        }
      },
    );
  }

  void loginCallback() {
    globalKey.auth.getCurrentUser().then((user) {
      globalKey.firebaseUser = user;
      _userId = user.uid.toString();
      authStatus = AuthStatus.LOGGED_IN;
      Provider.of<UserModel>(context, listen: false).signIn(user);
      MyNavigator.goToHome(context);
    });
  }

  void subscribeCallback() {
    globalKey.auth.getCurrentUser().then((user) {
      globalKey.firebaseUser = user;
      _userId = user.uid.toString();
      authStatus = AuthStatus.LOGGED_IN;
      Provider.of<UserModel>(context, listen: false).signIn(user);
      MyNavigator.goToAppairage(context);
    });
  }

  void logoutCallback() {
    setState(() {
      authStatus = AuthStatus.NOT_LOGGED_IN;
      _userId = "";
      globalKey.firebaseUser = null;
    });
  }

  Widget notDataLogin() {
    return new LoginScreen(
      loginCallback: loginCallback,
      subscribeCallback: subscribeCallback,
    );
  }

  Widget afterHasData(User user) {
    globalKey.firebaseUser = user;
    authStatus =
        user?.uid == null ? AuthStatus.NOT_LOGGED_IN : AuthStatus.LOGGED_IN;

    if (user != null) {
      _userId = user?.uid;
    }
    switch (authStatus) {
      case AuthStatus.NOT_DETERMINED:
        /*return new HomeScreen(
          userId: "invite",
          auth: null,
          logoutCallback: null);*/
        return buildWaitingScreen();
        break;
      case AuthStatus.INVITE:
      case AuthStatus.NOT_LOGGED_IN:
        return new LoginScreen(
          loginCallback: loginCallback,
          subscribeCallback: subscribeCallback,
        );
        break;
      /*case AuthStatus.INVITE:
        globalKey.logoutCallback = logoutCallback;
        Provider.of<UserModel>(context, listen: false)
            .signIn('invite');
        MyNavigator.goToHome(context);
        break;*/
      case AuthStatus.LOGGED_IN:
        globalKey.logoutCallback = logoutCallback;
        if (_userId.length > 0 && _userId != null) {
          print(_userId);
          Provider.of<UserModel>(context, listen: false).signIn(user);
          MyNavigator.goToAppairage(context);
          //MyNavigator.goToHome(context);
        } else
          return buildWaitingScreen();
        break;
      default:
        return buildWaitingScreen();
    }
    return buildWaitingScreen();
  }

  Widget buildWaitingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }
}
