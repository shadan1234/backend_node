import 'package:flutter/material.dart';
import 'package:node/common/widgets/loader.dart';
import 'package:node/features/admin/models/sales.dart';
import 'package:node/features/admin/services/admin_services.dart';
import 'package:node/features/admin/widgets/category_product_chart.dart';

class AnalayticsScreen extends StatefulWidget {
  // const String routeName='/analytics';
  // no need cuz this is in the admin part where body is changing and no push navigator is called
  const AnalayticsScreen({super.key});

  @override
  State<AnalayticsScreen> createState() => _AnalayticsScreenState();
}

class _AnalayticsScreenState extends State<AnalayticsScreen> {
final AdminServices adminServices=AdminServices();
int? totalSales ;
List<Sales>? earnings; 
@override
  void initState() {
    getEarnings();
    super.initState();
  }
  getEarnings()async{
var earningData= await adminServices.getEarnings(context);
totalSales=earningData['totalEarnings'];
earnings=earningData['sales'];
setState(() {
  
});
  }
  
  @override
  Widget build(BuildContext context) {
    return earnings==null || totalSales==null ?Loader(): Column(
      children: [
        Text('\$$totalSales',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
       SizedBox(
        height: 250,
         child: CategoryProductsChart(
          earnings: earnings!,
         ),
       ),
      ],
    );
  }
}