import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_shopper/models/catalog.dart';
import 'package:provider_shopper/models/login.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CatalogScreen extends StatelessWidget {

  //TODO Fix: The following NoSuchMethodError was thrown building CatalogScreen(dirty, dependencies: [_DefaultInheritedProviderScope<List<CafeItem>>, _LocalizationsScope-[GlobalKey#f9375], _InheritedTheme]):

  @override
  Widget build(BuildContext context) {
    var itemsList = Provider.of<List<CafeItem>>(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/adddata'),
        child: Icon(Icons.add),
        backgroundColor: Theme
            .of(context)
            .primaryColor,
      ),
      body: CustomScrollView(slivers: [
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
              return _MyListItem(index, itemsList);
            }, childCount: itemsList.length)),
      ]),
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
  final List<CafeItem> itemsList;

  _MyListItem(this.index, this.itemsList, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme
        .of(context)
        .textTheme
        .title;
    var item = itemsList.elementAt(index);

    return InkWell(
      onTap: () => Navigator.pushNamed(context, '/profile'),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Column(
          children: [
            Container(
                height: 130,
                child: CachedNetworkImage(
                  placeholder: (context, url) => CircularProgressIndicator(),
                  imageUrl: item.imageUrl,
                  fit: BoxFit.fitHeight,
                )),
            Row(children: [
              Expanded(
                child: Text(item.title, style: textTheme),
              ),
              SizedBox(width: 10),
              Expanded(
                flex: 0,
                child: Text('5', style: textTheme),
              ),
            ])
          ],
        ),
      ),
    );
  }
}
