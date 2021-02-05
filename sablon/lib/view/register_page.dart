import 'package:flutter/material.dart';
import 'package:sablon/config/base_config.dart';
import 'package:sablon/model/register_user.dart';
import 'package:sablon/view/register_picture_page.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var _formKey = GlobalKey<FormState>();
  String _email;
  String _username;
  String _password;
  String _confirmPassword;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.fromLTRB(20, 40, 20, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _title(context),
                SizedBox(height: 40),
                _formRegister(context),
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
                'Pendaftaran',
                style: BaseConfig.textStyle.copyWith(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Costumer',
                style: BaseConfig.textStyle.copyWith(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
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

  Widget _formRegister(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Data Costumer',
                  style: BaseConfig.textStyle.copyWith(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 45),
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
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Email tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Username',
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    hintText: 'costumerName',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  keyboardType: TextInputType.name,
                  onSaved: (value) => _username = value.trim(),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Username tidak boleh kosong';
                    }
                    return null;
                  },
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
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Password tidak boleh kosong';
                    }
                    if (value.length < 8) {
                      return 'Password harus 8 karakter atau lebih';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    hintText: '*********',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  onSaved: (value) => _confirmPassword = value.trim(),
                  validator: (value) {
                    if (value.trim() != _password) {
                      return 'Confirm password harus sama dengan password di atas';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 70),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 40,
              width: BaseConfig.deviceWidth(context) * 0.35,
              child: OutlineButton(
                color: BaseConfig.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'BATAL',
                  style: BaseConfig.textStyle.copyWith(
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40,
              width: BaseConfig.deviceWidth(context) * 0.35,
              child: RaisedButton(
                color: BaseConfig.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                onPressed: _next,
                child: Text(
                  'SELANJUTNYA',
                  style: BaseConfig.textStyle.copyWith(
                    color: Colors.white,
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _next() {
    var _formState = _formKey.currentState;
    _formState.save();
    if (_formState.validate()) {
      var registerUser = RegisterUser(
        email: _email,
        username: _username,
        password: _password,
      );
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, an, san) {
            return RegisterPicturePage();
          },
          transitionsBuilder: (context, an, san, ch) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: Offset(1, 0),
                end: Offset.zero,
              ).animate(an),
              child: ch,
            );
          },
          settings: RouteSettings(arguments: registerUser),
        ),
      );
    }
  }
}
