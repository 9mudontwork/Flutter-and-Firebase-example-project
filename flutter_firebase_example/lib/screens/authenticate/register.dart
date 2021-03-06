import 'package:flutter/material.dart';
import 'package:flutter_firebase_example/screens/services/auth.dart';
import 'package:flutter_firebase_example/shared/constants.dart';
import 'package:flutter_firebase_example/shared/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();

  bool loading = false;

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              title: Text('ลงทะเบียน Firebase Example'),
              actions: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.person),
                  label: Text('เข้าสู่ระบบ'),
                  onPressed: () {
                    widget.toggleView();
                  },
                ),
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'อีเมล'),
                      validator: (value) =>
                          value.isEmpty ? 'กรุณากรอกอีเมล' : null,
                      onChanged: (value) {
                        setState(() => email = value);
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'รหัสผ่าน'),
                      validator: (value) => value.length < 6
                          ? 'รหัสผ่านต้องมากกว่า 6 ตัวอักษร'
                          : null,
                      obscureText: true,
                      onChanged: (value) {
                        setState(() => password = value);
                      },
                    ),
                    SizedBox(height: 20),
                    RaisedButton(
                      color: Colors.pink[400],
                      child: Text(
                        'ลงทะเบียน',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() => loading = true);
                          dynamic registerResult = await _authService
                              .registerWithEmailAndPassword(email, password);
                          if (registerResult == null) {
                            setState(() {
                              error = 'รูปแบบอีเมลไม่ถูกต้อง';
                              loading = false;
                            });
                          }
                        }
                      },
                    ),
                    SizedBox(height: 20),
                    Text(
                      error,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
