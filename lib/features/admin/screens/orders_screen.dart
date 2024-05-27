
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:node/common/widgets/loader.dart';
import 'package:node/features/account/widgets/single_product.dart';
import 'package:node/features/admin/services/admin_services.dart';
import 'package:node/features/order_details/screens/order_details.dart';

import '../../../models/order.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<Order>?orderList;
  final AdminServices adminServices=AdminServices();
  @override
  void initState() {
   fetchAllOrders();
    super.initState();
  }
  void fetchAllOrders()async{
   orderList=await  adminServices.fetchAllOrders(context);
   setState(() {
     
   });
  }
  @override
  Widget build(BuildContext context) {
    return orderList==null? const Loader():
    GridView.builder(
      itemCount: orderList!.length,
      gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2) , 
      itemBuilder: (context,index){
        final orderData=orderList![index];
        return GestureDetector(
          onTap: (){
            Navigator.pushNamed(context, OrderDetailsScreen.routeName,arguments: orderData);
          },
          child: SizedBox(height: 400,
          child: SingleProduct(image: orderData.products[0].images[0] ,),
          ),
        ) ; 
      }
      );
  }
}