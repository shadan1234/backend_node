import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:node/common/widgets/loader.dart';
import 'package:node/features/home/services/home_services.dart';

import '../../../constants/global_variable.dart';
import '../../../models/product.dart';

class CategoryDealsScreen extends StatefulWidget {
  static const String routeName = '/category-deals';
  final String category;
  const CategoryDealsScreen({super.key, required this.category});

  @override
  State<CategoryDealsScreen> createState() => _CategoryDealsScreenState();
}

class _CategoryDealsScreenState extends State<CategoryDealsScreen> {
  final HomeServices homeServices = HomeServices();
  List<Product>? productList;
  @override
  void initState() {
    // TODO: implement initState
    fetchCategoryProducts();
    super.initState();
  }

  fetchCategoryProducts() async {
    productList = await homeServices.fetchCategoryProducts(
        context: context, category: widget.category);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBar(
            flexibleSpace: Container(
              decoration:
                  BoxDecoration(gradient: GlobalVariables.appBarGradient),
            ),
            title: Text(
              widget.category,
              style: TextStyle(color: Colors.black),
            ),
          )),
      body: productList == null
          ? Loader()
          : Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Keep shopping for ${widget.category}',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 170,
                  child: GridView.builder(
                      itemCount: productList!.length,
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.only(left: 15),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          childAspectRatio: 1.4,
                          mainAxisSpacing: 10),
                      itemBuilder: (context, index) {
                        final product = productList![index];
                        return Column(
                          children: [
                            SizedBox(
                              height: 130,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black12, width: 0.5)),
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Image.network(product.images[0]),
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.only(
                                left: 0,
                                top : 5,
                                right: 15
                              ),
                              child: Text(product.name,maxLines: 1,overflow: TextOverflow.ellipsis,),
                            )
                          ],
                        );
                      }),
                )
              ],
            ),
    );
  }
}
