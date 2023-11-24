import 'package:flutter/material.dart';

import '../widgets/orders_builder.dart';

class OrdersPage extends StatefulWidget {
  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.blueAccent,
          child: Icon(Icons.logout),
        ),
        backgroundColor: Colors.grey[200],
        body: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(
                height: 50,
              ),
            ),
            SliverToBoxAdapter(
                child: Text("Liste des commandes ",
                    style: TextStyle(fontSize: 25))),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
              ),
            ),
            OrdersBuilder(),
          ],
        ));
  }
}
