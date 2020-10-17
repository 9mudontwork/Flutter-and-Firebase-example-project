import 'package:flutter/material.dart';
import 'package:flutter_firebase_example/screens/home/home.dart';

import 'authenticate/authenticate.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return หน้าแรก หรือ auth widget
    return Authenticate();
  }
}
