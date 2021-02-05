import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sablon/config/base_config.dart';
import 'package:sablon/services/firebase_auth_services.dart';
import 'package:sablon/view/register_page.dart';
import 'package:sablon/widgets/error_message.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _formKey = GlobalKey<FormState>();
  String _email;
  String _password;
  bool _tryLogin = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.fromLTRB(20, 50, 20, 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _title(context),
                SizedBox(height: 70),
                _formLogin(context),
                SizedBox(height: 40),
                _buttonRegister(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _title(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Selamat    Datang',
                style: BaseConfig.textStyle.copyWith(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 15),
            ],
          ),
          Image(
            image: AssetImage('assets/images/background_image.png'),
            height: 150,
            width: 200,
          ),
        ],
      ),
    );
  }

  Widget _formLogin(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Login',
          style: BaseConfig.textStyle.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    hintText: 'costumer@guest.com',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (value) => _email = value.trim(),
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    hintText: '*********',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  onSaved: (value) => _password = value.trim(),
                ),
                SizedBox(height: 15),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Lupa password ? klik disini',
                    style: BaseConfig.textStyle,
                  ),
                ),
                SizedBox(height: 70),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: 40,
                    width: BaseConfig.deviceWidth(context) * 0.5,
                    child: _tryLogin
                        ? SpinKitThreeBounce(
                            color: BaseConfig.primaryColor,
                            size: 15,
                          )
                        : RaisedButton(
                            color: BaseConfig.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            onPressed: _login,
                            child: Text(
                              'LOGIN',
                              style: BaseConfig.textStyle.copyWith(
                                color: Colors.white,
                                letterSpacing: 2,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buttonRegister(BuildContext context) {
    return Container(
      width: BaseConfig.deviceWidth(context) - 40,
      child: Column(
        children: [
          Text('Belum punya akun ?'),
          SizedBox(height: 15),
          SizedBox(
            height: 40,
            width: BaseConfig.deviceWidth(context) * 0.5,
            child: OutlineButton(
              color: BaseConfig.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RegisterPage()));
              },
              child: Text(
                'DAFTAR SEKARANG',
                style: BaseConfig.textStyle.copyWith(
                  letterSpacing: 2,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _login() async {
    var _formState = _formKey.currentState;
    if (_formState.validate()) {
      _formState.save();
      setState(() => _tryLogin = true);
      var _result = await FirebaseAuthServices.login(_email, _password);
      setState(() => _tryLogin = false);
      if (_result.errorMessage != null) {
        errorMessage(context, _result.errorMessage);
        return;
      }
      setState(() => _tryLogin = false);
      Navigator.pushReplacementNamed(context, '/main_page');
    }
  }
}
