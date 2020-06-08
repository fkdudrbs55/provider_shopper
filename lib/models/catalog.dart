import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CatalogModel extends ChangeNotifier {

  final databaseReference = Firestore.instance;

}

class CafeItem {
  final String title;
  final String imageUrl;

  CafeItem(this.title, this.imageUrl);

}

