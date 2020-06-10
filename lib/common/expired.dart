class Expired {
  /// StreamBuilder previously inside CafeItem Widget
//                return new StreamBuilder<QuerySnapshot>(
//                    stream: Firestore.instance.collection("SampleCollection")
//                        .snapshots(),
//                    builder: (BuildContext context,
//                        AsyncSnapshot<QuerySnapshot> snapshot) {
//                      if (snapshot.hasError)
//                        return new Text("There is an error");
//                      return _MyListItem(index);
//                    });

  /// StreamBuilder previously in charge of building CafeItem
//    return new StreamBuilder<QuerySnapshot>(
//        stream: Firestore.instance.collection("SampleCollection")
//            .snapshots(),
//        builder: (BuildContext context,
//            AsyncSnapshot<QuerySnapshot> snapshot) {
//          if (snapshot.hasError) return new Text("There is an error");
//
//          var title = snapshot.data.documents.elementAt(index)['title'];
//          var imageUrl = snapshot.data.documents.elementAt(index)['imageUrl'];
//
//          return Padding(
//            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//            child: LimitedBox(
//              maxHeight: 150,
//              child: Column(
//                children: [
//                  Container(
//                      height: 130,
//                      width: 150,
//                      child: CachedNetworkImage(
//                        placeholder: (context, url) =>
//                            CircularProgressIndicator(),
//                        imageUrl: imageUrl,
//                      )),
//                  Row(children: [
//                    SizedBox(width: 10),
//                    Expanded(
//                      child: Text(title, style: textTheme),
//                    ),
//                    SizedBox(width: 10),
////              _AddButton(item: item),
//                  ])
//                ],
//              ),
//            ),
//          );
//        });
}
