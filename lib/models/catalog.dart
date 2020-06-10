import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CatalogModel extends ChangeNotifier {

  final databaseReference = Firestore.instance;

}

class CafeItem {
  final String title;
  final String imageUrl;

  CafeItem({this.title, this.imageUrl});

//  factory CafeItem.fromMap(Map data){
//    data = data ?? {};
//    return CafeItem(
//        title: data['title'] ?? '',
//        imageUrl: data['imageUrl'] ?? ''
//    );
//  }

  factory CafeItem.fromFirestore(DocumentSnapshot doc){
    Map data = doc.data;
    return CafeItem(
        title: doc.data['title'] ?? '',
        imageUrl: doc.data['imageUrl'] ?? ''
    );
  }


//  factory Weapon.fromFirestore(DocumentSnapshot doc) {
//    Map data = doc.data;
//
//    return Weapon(
//        id: doc.documentID,
//        name: data['name'] ?? '',
//        hitpoints: data['hitpoints'] ?? 0,
//        img: data['img'] ?? ''
//    );
//  }
}

