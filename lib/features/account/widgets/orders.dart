import 'package:flutter/material.dart';
import 'package:node/common/widgets/loader.dart';
import 'package:node/constants/global_variable.dart';
import 'package:node/features/account/services/account_services.dart';
import 'package:node/features/account/widgets/single_product.dart';
import 'package:node/features/order_details/screens/order_details.dart';

import '../../../models/order.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List<Order>? orders;
  final AccountServices accountServices = AccountServices();
  @override
  void initState() {
    fetchOrders();
    super.initState();
  }

  void fetchOrders() async {
    orders = await accountServices.fetchOrders(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? Loader()
        : Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                      left: 15,
                    ),
                    child: const Text(
                      'Your orders',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      left: 15,
                    ),
                    child: Text(
                      'See All',
                      style:
                          TextStyle(color: GlobalVariables.selectedNavBarColor),
                    ),
                  )
                ],
              ),
              // Display orders
              Container(
                height: 170,
                padding: const EdgeInsets.only(left: 10, top: 20, right: 0),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: orders!.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, OrderDetailsScreen.routeName,arguments: orders![index]);
                      },
                      child: SingleProduct(image: orders![index].products[0].images[0]));
                  },
                ),
              )
            ],
          );
  }
}
