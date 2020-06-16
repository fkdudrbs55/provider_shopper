import 'package:cloud_firestore/cloud_firestore.dart';

class CatalogModel {

  final databaseReference = Firestore.instance;

}

class ItemDetail {
  final String ID;
  final String comment;
  final double score;
  final Timestamp timestamp;

  ItemDetail({this.ID, this.comment, this.score, this.timestamp});

  factory ItemDetail.fromFirestore(DocumentSnapshot doc){
    return ItemDetail(
        ID: doc.data['ID'] ?? '',
        comment: doc.data['comment'] ?? '',
        score: doc.data['score'] ?? '',
        timestamp: doc.data['timestamp'] ?? ''
    );
  }
}

class CafeItem {
  final String documentID;
  final String title;
  final String imageUrl;

  CafeItem({this.documentID, this.title, this.imageUrl});

  factory CafeItem.fromFirestore(DocumentSnapshot doc){
    return CafeItem(
        documentID: doc.documentID,
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

