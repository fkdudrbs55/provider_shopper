import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_shopper/models/catalog.dart';
import 'package:provider_shopper/models/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';


class CatalogScreen extends StatelessWidget {
  //Hello

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/adddata'),
        child: Icon(Icons.add),
        backgroundColor: Theme
            .of(context)
            .primaryColor,
      ),
      body: CustomScrollView(
        slivers: [
          _MyAppBar(),
          //_MyAppBar 바로 밑에 있는 간격
          SliverToBoxAdapter(child: SizedBox(height: 5)),
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 1.0,
              crossAxisSpacing: 5.0,
            ),
              delegate: SliverChildBuilderDelegate((context, index) {
                if (index > 1) return null;

                return new StreamBuilder<QuerySnapshot>(
                    stream: Firestore.instance.collection("SampleCollection")
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError)
                        return new Text("There is an error");
                      return _MyListItem(index);
                    });
              }
              )
          ),
        ]
      ),
    );
  }
}

class _MyAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      title: Text('Catalog', style: Theme.of(context).textTheme.headline),
      floating: true,
      actions: [
        IconButton(
          icon: Icon(Icons.backspace),
          onPressed: () {
            Provider.of<LoginModel>(context, listen: false).signOut();
            Navigator.pushNamed(context, '/');
          },
        ),
        IconButton(
          icon: Icon(Icons.person),
          onPressed: () => Navigator.pushNamed(context, '/profile'),
        )
      ],
    );
  }
}

class _MyListItem extends StatelessWidget {
  final int index;

  _MyListItem(this.index, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var catalog = Provider.of<CatalogModel>(context);
    var textTheme = Theme.of(context).textTheme.body2;

    return new StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection("SampleCollection")
            .snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) return new Text("There is an error");

          var title = snapshot.data.documents.elementAt(index)['Title'];
          var imageUrl = snapshot.data.documents.elementAt(index)['imageUrl'];

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: LimitedBox(
              maxHeight: 150,
              child: Column(
                children: [
                  Container(
                      height: 130,
                      width: 150,
                      child: CachedNetworkImage(
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        imageUrl: imageUrl,
                      )),
                  Row(children: [
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(title, style: textTheme),
                    ),
                    SizedBox(width: 10),
//              _AddButton(item: item),
                  ])
                ],
              ),
            ),
          );
        });

  }

}
