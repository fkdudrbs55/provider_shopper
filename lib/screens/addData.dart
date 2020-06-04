import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_shopper/models/login.dart';

class AddDataScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var login = Provider.of<LoginModel>(context);

    return Center(
        child: Container(
      margin: const EdgeInsets.all(10.0),
      width: 150.0,
      height: 150.0,
      color: Colors.white,
      child: FlatButton(child: Text(login.userUID)),
    ));
  }
}
