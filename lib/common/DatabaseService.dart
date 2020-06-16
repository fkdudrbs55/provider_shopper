import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider_shopper/models/catalog.dart';
import 'dart:async';


class DatabaseService {
  final Firestore _db = Firestore.instance;

  Stream<List<CafeItem>> streamCafeList() {
    return _db
        .collection('SampleCollection')
        .snapshots()
        .map(
            (list) =>
            list.documents
                .map((doc) => CafeItem.fromFirestore(doc)).toList());
  }

  Stream<List<ItemDetail>> streamDetailList(CafeItem item) {
    return _db
        .collection('SampleCollection')
        .document(item.documentID)
        .collection('Comments')
        .snapshots()
        .map(
            (list) =>
            list.documents
                .map((doc) => ItemDetail.fromFirestore(doc)).toList());
  }

  /// Query a subcollection
//  Stream<List<Weapon>> streamWeapons(FirebaseUser user) {
//    var ref = _db.collection('heroes').document(user.uid).collection('weapons');
//
//    return ref.snapshots().map((list) =>
//        list.documents.map((doc) => Weapon.fromFirestore(doc)).toList());
//
//  }

  /// Write data
  Future<void> createHero(String heroId) {
    return _db.collection('heroes').document(heroId).setData({ /* some data */
    });
  }

}
