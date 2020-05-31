import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:provider_shopper/models/login.dart';


class MyLogin extends StatelessWidget {



  @override
  Widget build(BuildContext context) {

    var login = Provider.of<LoginModel>(context);

    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(80.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome',
                style: Theme.of(context).textTheme.headline,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Username',
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Password',
                ),
                obscureText: true,
              ),
              SizedBox(
                height: 24,
              ),
              RaisedButton(
                color: Colors.yellow,
                child: Text('ENTER'),
                onPressed: () {

                  if(login.status == Status.Authenticated){
                    Navigator.pushReplacementNamed(context, '/catalog');
                  } else {
                    print(login.status.toString());
                  }

                },
              )
            ],
          ),
        ),
      ),
    );
  }

  //Connect with Firebase

}