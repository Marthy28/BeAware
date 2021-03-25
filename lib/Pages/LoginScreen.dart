import 'package:be_aware/Util/global.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback loginCallback;
  final VoidCallback subscribeCallback;

  LoginScreen({this.loginCallback, this.subscribeCallback});
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  BuildContext _buildContext;

  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  String _email;
  String _password;
  bool _isLoginForm = true;
  bool _isLoading = false;

  String _lastName;
  String _firstName;
  String _errorMessage;

  @override
  Widget build(BuildContext context) {
    _buildContext = context;

    return new Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Text(
              'BeAware',
              style: Theme.of(_buildContext).textTheme.headline5,
            ),
            _showForm(),
            _showCircularProgress()
          ],
        ),
      ),
    );
  }

  Widget _showForm() {
    return new Container(
        child: new Form(
      key: _formKey,
      child: _isLoginForm ? showLogin() : showSubscribe(),
    ));
  }

  Widget showSubscribe() {
    return new Column(
      children: [
        showFirstNameInput(),
        showLastNameInput(),
        showPasswordInput(),
        showEmailInput(),
        //showPhoneNumberInput(),
        showPrimaryButton(),
        showTextAndButton(),
        showErrorMessage()
      ],
    );
  }

  Widget showLogin() {
    return new Container(
      child: new Column(
        children: [
          showEmailInput(),
          showPasswordInput(),
          showPrimaryButton(),
          showSecondaryButton(),
          showErrorMessage()
        ],
      ),
    );
  }

  Widget showTextAndButton() {
    return new Center(
        child: new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Dejà dans la team ?'),
        TextButton(
          onPressed: () {
            setState(() {
              _isLoginForm = !_isLoginForm;
            });
          },
          child: Text("Connecte-toi !",
              style: TextStyle(
                decoration: TextDecoration.underline,
                color: Colors.purple,
                fontWeight: FontWeight.bold,
              )),
        )
      ],
    ));
  }

  Widget showFirstNameInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        style: Theme.of(_buildContext).textTheme.bodyText1,
        decoration: new InputDecoration(
            isDense: true,
            filled: true,
            hintText: 'Prénom',
            hintStyle: Theme.of(_buildContext).textTheme.bodyText1,
            errorStyle: Theme.of(_buildContext).textTheme.bodyText1.copyWith(
                  color: Colors.red,
                ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(20.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(20.0),
            ),
            border: InputBorder.none),
        onChanged: (text) {
          setState(() {
            _firstName = text;
          });
        },
        validator: (value) =>
            value.isEmpty ? "Le prénom ne peut pas être vide" : null,
        onSaved: (value) => _firstName = value.trim(),
      ),
    );
  }

  Widget showLastNameInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        style: Theme.of(_buildContext).textTheme.bodyText1,
        decoration: new InputDecoration(
            isDense: true,
            filled: true,
            hintText: 'Nom',
            hintStyle: Theme.of(_buildContext).textTheme.bodyText1,
            errorStyle: Theme.of(_buildContext).textTheme.bodyText1.copyWith(
                  color: Colors.red,
                ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(20.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(20.0),
            ),
            border: InputBorder.none),
        onChanged: (text) {
          setState(() {
            _lastName = text;
          });
        },
        validator: (value) =>
            value.isEmpty ? "Le nom ne peut pas être vide" : null,
        onSaved: (value) => _lastName = value.trim(),
      ),
    );
  }

  Widget showEmailInput() {
    return Padding(
      padding: _isLoginForm
          ? const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 0.0)
          : const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        style: Theme.of(_buildContext).textTheme.bodyText1,
        decoration: new InputDecoration(
            isDense: true,
            filled: true,
            hintText: 'Email',
            hintStyle: Theme.of(_buildContext).textTheme.bodyText1,
            errorStyle: Theme.of(_buildContext).textTheme.bodyText1.copyWith(
                  color: Colors.red,
                ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(20.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(20.0),
            ),
            border: InputBorder.none),
        validator: (value) =>
            value.isEmpty ? "L'email ne peut pas être vide" : null,
        onChanged: (value) => _email = value.trim(),
      ),
    );
  }

  Widget showPasswordInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        obscureText: true,
        autofocus: false,
        style: Theme.of(_buildContext).textTheme.bodyText1,
        decoration: new InputDecoration(
            filled: true,
            hintText: 'Mot de passe',
            hintStyle: Theme.of(_buildContext).textTheme.bodyText1,
            errorStyle: Theme.of(_buildContext).textTheme.bodyText1.copyWith(
                  color: Colors.red,
                ),
            isDense: true,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(20.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(20.0),
            ),
            border: InputBorder.none),
        validator: (value) => validatePassword(value),
        onChanged: (value) => _password = value.trim(),
      ),
    );
  }

  Widget showPrimaryButton() {
    return new Padding(
        padding: EdgeInsets.fromLTRB(70.0, 20.0, 70.0, 10.0),
        child: SizedBox(
          height: 50.0,
          child: new FlatButton(
            color: Colors.pink,
            //elevation: 5.0,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            child: new Text(
              _isLoginForm ? 'Se connecter' : "S'inscrire",
              style: Theme.of(_buildContext)
                  .textTheme
                  .bodyText1
                  .copyWith(fontSize: 20.0, color: Colors.white),
            ),
            onPressed: validateAndSubmit,
          ),
        ));
  }

  Widget showSecondaryButton() {
    return FlatButton(
        child: RichText(
          text: TextSpan(
            text: 'T\'es pas dans la team ?',
            style: Theme.of(_buildContext)
                .textTheme
                .bodyText1
                .copyWith(fontSize: 16.0),
            children: <TextSpan>[
              TextSpan(
                text: 'Inscris-toi !',
                style: Theme.of(_buildContext).textTheme.bodyText1.copyWith(
                      fontSize: 16.0,
                      color: Colors.purple,
                      fontWeight: FontWeight.w900,
                      decoration: TextDecoration.underline,
                    ),
              ),
            ],
          ),
        ),
        onPressed: toggleFormMode);
  }

  Widget showErrorMessage() {
    if (_errorMessage != null && _errorMessage.length > 0) {
      return new Text(
        _errorMessage,
        style: Theme.of(_buildContext)
            .textTheme
            .bodyText1
            .copyWith(fontSize: 20.0, color: Colors.red, height: 2.0),
      );
    } else {
      return new Container(
        height: 0.0,
      );
    }
  }

  Widget _showCircularProgress() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }

  String validatePassword(String value) {
    if (!(value.length > 5) && value.isNotEmpty) {
      return "Le mot de passe doit contenir au moins 6 caractères";
    }
    return null;
  }

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit() async {
    //Future<FirebaseUser> firebaseUser;

    setState(() {
      _errorMessage = "";
      _isLoading = true;
    });
    String userId = "";

    if (validateAndSave()) {
      try {
        if (_isLoginForm) {
          try {
            await auth.signIn(_email, _password).then((user) {
              setState(() {
                if (user != null) {
                  userId = user?.displayName;
                  print('Signed in: $userId');
                  if (userId != null && userId.length > 0) {
                    widget.loginCallback();
                  }
                }
              });
            });
          } catch (e) {
            print('Error: $e');
            setState(() {
              _isLoading = false;
              _errorMessage = e?.message;
              _formKey.currentState.reset();
            });
          }
        } else {
          var res =
              await auth.fullSignUp(_email, _password, _firstName, _lastName);
          print(res[0]);
          if (res[0] == null || res[0].length <= 0) {
            setState(() {
              _isLoading = false;
              _errorMessage = res[1]?.message;
            });
          } else {
            await auth.signIn(_email, _password).then(
                  (user) => {
                    userId = user.uid,
                    if (userId != null && userId.length > 0)
                      {widget.subscribeCallback()}
                  },
                );
          }
        }
        setState(() {
          _isLoading = false;
        });
      } catch (e) {
        print('Error: $e');
        setState(() {
          _isLoading = false;
          _errorMessage =
              e is FirebaseAuthException ? e?.message : e.toString();
          _formKey.currentState.reset();
        });
      }
    }
  }

  void toggleFormMode() {
    resetForm();
    setState(() {
      _isLoginForm = !_isLoginForm;
    });
  }

  void resetForm() {
    _formKey.currentState.reset();
  }
}
