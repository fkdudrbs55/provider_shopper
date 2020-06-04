import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_shopper/models/cart.dart';
import 'package:provider_shopper/models/catalog.dart';
import 'package:provider_shopper/models/login.dart';
import 'package:provider_shopper/common/firestorageservice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class CatalogScreen extends StatelessWidget {

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

            delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  return _MyListItem(index);
                },
                childCount: CatalogModel.itemNames.length),
          ),
        ],
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  final Item item;

  const _AddButton({Key key, @required this.item}) : super(key: key);

  //Add uncheck functionality

  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<CartModel>(context);

    return FlatButton(
      onPressed: cart.items.contains(item)
          ? () => cart.remove(item)
          : () => cart.add(item),
      splashColor: Theme.of(context).primaryColor,
      child: cart.items.contains(item)
          ? Icon(Icons.check, semanticLabel: 'ADDED')
          : Text('ADD'),
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
          icon: Icon(Icons.shopping_cart),
          onPressed: () => Navigator.pushNamed(context, '/cart'),
        ),
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
    var item = catalog.getByPosition(index);
    var textTheme = Theme.of(context).textTheme.body2;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: LimitedBox(
        maxHeight: 150,
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                color: item.color,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(item.name, style: textTheme),
            ),
            SizedBox(width: 10),
            _AddButton(item: item),
          ],
        ),
      ),
    );
  }
}

class Record {
  final String location;
  final String url;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['location'] != null),
        assert(map['imageUrl'] != null),
        location = map['location'],
        url = map['imageUrl'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$location:$url>";
}