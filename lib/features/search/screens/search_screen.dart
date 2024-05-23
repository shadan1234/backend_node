import 'package:flutter/material.dart';
import 'package:node/common/widgets/loader.dart';
import 'package:node/features/home/widgets/address_box.dart';
import 'package:node/features/product_details/screens/product_details_screen.dart';
import 'package:node/features/search/services/serach_services.dart';
import 'package:node/features/search/widget/searched_product.dart';

import '../../../constants/global_variable.dart';
import '../../../models/product.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = '/search-screen';
  final String searchQuery;
  const SearchScreen({super.key, required this.searchQuery});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Product>? products;
  final SearchServices searchServices = SearchServices();
  @override
  void initState() {
    fetchSearchedProducts();
    super.initState();
  }
  void navigateToSearchScreen(String query){
     Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }
  void fetchSearchedProducts() async {
    products = await searchServices.fetchSearchedProduct(
        context: context, searchQuery: widget.searchQuery);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
           appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 15),
                  child: Material(
                    borderRadius: BorderRadius.circular(7),
                    elevation: 1,
                    child: TextFormField(
                      onFieldSubmitted: navigateToSearchScreen,
                      decoration: InputDecoration(
                        prefixIcon: InkWell(
                          onTap: (){},
                          child: const Padding(padding: EdgeInsets.only(left: 6),
                          child: Icon(Icons.search,color: Colors.black,size: 23,),
                          ),

                        ),
                        filled: true,fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(top: 10),
                        border: const OutlineInputBorder(borderRadius:BorderRadius.all(Radius.circular(7),),
                        
                        borderSide: BorderSide.none,
                         ),
                         enabledBorder: const OutlineInputBorder(borderRadius:BorderRadius.all(Radius.circular(7),),
                        
                        borderSide: BorderSide(color: Colors.black38, width: 1, ),
                         ),
                         hintText: 'Search Amazon.in',
                         hintStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17
                         )
                      ),
                      
                    ),
                  )
                ),
              ),
             Container(
              color: Colors.transparent,
              height: 42,
              margin: EdgeInsets.symmetric(horizontal:10),
              child: Icon(Icons.mic,color: Colors.black,size: 25,),
             )
            ],
          ),
        ),
      ),
      body:products == null
        ? Loader()
        :  Column(children: [ 
                  AddressBox(),
                  SizedBox(height: 10,),
                  Expanded(child: ListView.builder(
                    itemCount: products!.length,
                    itemBuilder: (context,index ){
                      return GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, ProductDetailScreen.routeName,arguments: products![index]);
                        },
                        child: SearchedProduct(product: products![index]));
                    }

                    )
                    ),
           ],),
          );
  }
}
