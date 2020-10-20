import 'package:flutter/material.dart';
import 'package:flutter_firebase_example/models/user.dart' as model;
import 'package:flutter_firebase_example/screens/home/home.dart';
import 'package:provider/provider.dart';

import 'authenticate/authenticate.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<model.User>(context);

    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
