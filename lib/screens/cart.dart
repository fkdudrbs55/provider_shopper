import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_shopper/models/cart.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart', style: Theme.of(context).textTheme.headline),
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.yellow,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: _CartList(),
              ),
            ),
            Divider(height: 4, color: Colors.black),
            _CartTotal()
          ],
        ),
      ),
    );
  }
}

class _CartList extends StatelessWidget {

  Widget _buildConfirmationDialog(BuildContext context, cart, item){

    return new AlertDialog(
        title: const Text('Remove item from cart?'),
        actions: <Widget>[
          new FlatButton(
              onPressed: () {
                cart.remove(item);
                Navigator.of(context).pop();
              },
              child: const Text('Yes')),
          new FlatButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('No'))
        ]);
  }

  @override
  Widget build(BuildContext context) {
    var itemNameStyle = Theme.of(context).textTheme.body2;
    var cart = Provider.of<CartModel>(context);

    return ListView.builder(
        itemCount: cart.items.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.done),
            title: Text(
              cart.items[index].name,
              style: itemNameStyle,
            ),
            onTap:
                () =>
                showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        _buildConfirmationDialog(
                            context, cart, cart.items[index])),
          );
        });

// Test wrapping
//    return Scaffold(
//        body:ListView.builder(
//            itemCount: cart.items.length,
//            itemBuilder: (context, index){
//              return Container(
//                child: ListTile(
//                  leading: Icon(Icons.done),
//                  title: Text(
//                    cart.items[index].name,
//                    style: itemNameStyle,
//                  ),
//                  onTap:
//                      () =>
//                          showDialog(
//                              context: context,
//                              builder: (BuildContext context) => _buildConfirmationDialog(context, cart, cart.items[index])),
//                  ),
//              );
//            }));
      }

  }





class _CartTotal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var hugeStyle =
    Theme.of(context).textTheme.headline;

    return SizedBox(
      height: 200,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<CartModel>(
                builder: (context, cart, child) =>
                    Text('\$${cart.totalPrice}', style: hugeStyle)),
            SizedBox(width: 24),
            FlatButton(
              onPressed: () {
                Scaffold.of(context).showSnackBar(
                    SnackBar(content: Text('Buying not supported yet.')));
              },
              color: Colors.white,
              child: Text('BUY'),
            ),
          ],
        ),
      ),
    );
  }
}