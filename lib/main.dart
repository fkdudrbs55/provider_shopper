import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_shopper/common/DatabaseService.dart';
import 'package:provider_shopper/common/theme.dart';
import 'package:provider_shopper/models/catalog.dart';
import 'package:provider_shopper/models/login.dart';
import 'package:provider_shopper/screens/catalog.dart';
import 'package:provider_shopper/screens/login.dart';
import 'package:provider_shopper/screens/profile.dart';
import 'package:provider_shopper/screens/addData.dart';
import 'package:provider_shopper/screens/detailPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final LoginModel _auth = LoginModel.instance();
  final bool isLogged = await _auth.isLogged();
  final MyApp myApp = MyApp(
    initialRoute: isLogged ? '/catalog' : '/',
  );
  runApp(myApp);
}

class MyApp extends StatelessWidget {

  final String initialRoute;

  MyApp({this.initialRoute});

  @override
  Widget build(BuildContext context) {
    final DatabaseService _db = DatabaseService();

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => LoginModel.instance()),


//          Provider(create: (context) => CatalogModel()),

//        ChangeNotifierProxyProvider<CatalogModel, CartModel>(
//          create: (context) => CartModel(),
//          update: (context, catalog, cart) {
//            cart.catalog = catalog;
//            return cart;
//          },
//        ),
//        StreamProvider<CafeItem>.value(value: Firestore.instance.collection(path)),

          StreamProvider<List<CafeItem>>.value(value: _db.streamCafeList()),

        ],
        child: Consumer(
            builder: (context, LoginModel user, _) {
              return MaterialApp(
                title: 'Provider Demo',
                theme: appTheme,
                initialRoute: initialRoute,
                routes: {
                  '/': (context) => LoginScreen(),
                  '/catalog': (context) => CatalogScreen(),
                  '/profile': (context) => ProfileScreen(),
                  '/adddata': (context) => AddDataScreen(),
                },
              );
            }
        )
    );
  }
}