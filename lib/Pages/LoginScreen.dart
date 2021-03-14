import 'package:be_aware/Util/MyNavigator.dart';
import 'package:be_aware/Util/global.dart';
import 'package:be_aware/Model/UserModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback loginCallback;

  LoginScreen({this.loginCallback});
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  BuildContext _buildContext;

  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  String _email;
  String _password;
  bool _isLoginForm = true;

  String _lastName;
  String _firstName;

  @override
  Widget build(BuildContext context) {
    _buildContext = context;

    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
        child: Column(
          children: [
            Text(
              'BeAware',
              style: Theme.of(_buildContext).textTheme.headline5,
            ),
            _showForm(),
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
        showTextAndButton()
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
          showSecondaryButton()
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

  String validatePassword(String value) {
    if (!(value.length > 5) && value.isNotEmpty) {
      return "Le mot de passe doit contenir au moins 6 caractères";
    }
    return null;
  }

  bool validateAndSave() {
    final form = _formKey.currentState;
    print(_formKey);
    print(_formKey.currentState);
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit() async {
    //Future<FirebaseUser> firebaseUser;
    // setState(() {
    //   _errorMessage = "";
    //   _isLoading = true;
    // });
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
                }
              });
            });
          } catch (e) {
            print('Error: $e');
            setState(() {
              // _isLoading = false;
              // _errorMessage = e.message;
              _formKey.currentState.reset();
            });
          }
        } else {
          await auth.signUp(_email, _password, "");
          //widget.auth.sendEmailVerification();
          //_showVerifyEmailSentDialog();
          print('Signed up user: $userId');
          setState(() {
            _isLoginForm = true;
          });
        }
        // setState(() {
        //   _isLoading = false;
        // });

        if (userId != null && userId.length > 0 && _isLoginForm) {
          widget.loginCallback();
        }
      } catch (e) {
        print('Error: $e');
        setState(() {
          // _isLoading = false;
          // _errorMessage = e.message;
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
