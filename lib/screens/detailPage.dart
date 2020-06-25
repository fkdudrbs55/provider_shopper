//TODO Add detail page for individual cafes, new firebase collection for comments
//TODO Add functionality to add comments

//TODO Fix RenderCustomMultiChildLayoutBox object was given an infinite size during layout.

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider_shopper/models/catalog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetailPage extends StatelessWidget {
  final CafeItem item;

  DetailPage(this.item);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection('SampleCollection')
            .document(item.documentID)
            .collection('Comments')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return new CircularProgressIndicator();

          var docs = snapshot.data.documents;

          return Scaffold(
              body: SafeArea(
                  bottom: false,
                  left: false,
                  right: false,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                            child: CachedNetworkImage(
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                              imageUrl: item.imageUrl,
                              fit: BoxFit.fitHeight,
                            )),
                        Row(children: [
                          Expanded(
                            child: Text(item.title),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            flex: 0,
                            child: Text('5'),
                          ),
                        ]),
                        Expanded(
                            child: ListView.builder(
                                itemCount: 1,
                                itemBuilder: (BuildContext context, int index) {
                                  return ListTile(
                                    title: Text(docs.elementAt(index)['ID']),
                                  );
                                }))
                      ])));
        });
  }
}
