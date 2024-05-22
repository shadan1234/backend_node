import 'package:flutter/material.dart';
import 'package:node/common/widgets/loader.dart';
import 'package:node/features/account/widgets/single_product.dart';
import 'package:node/features/admin/screens/add_product_screens.dart';
import 'package:node/features/admin/services/admin_services.dart';

import '../../../models/product.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  final AdminServices adminServices=AdminServices();
  // we user products as nullable instead of empty cuz in empty when 
  //the user first time opens the app it will show loader and even after
  // fetching data from backend that is nothing will be there in backend 
  //and it will show us loader continuously therefore we won't be able to
  // add data to our backend
  List<Product>? products; 
 @override
  void initState() {
    // TODO: implement initState
      fetchAllProducts();
    super.initState();
  }
   fetchAllProducts()async{
   products= await adminServices.fetchAllProducts(context);
   setState(() {
     
   });
   }
   void deleteProduct(Product product,int index){
    adminServices.deleteProduct(context: context, product: product, onSuccess: (){
      products!.removeAt(index);
    });
    setState(() {
      
    });
   }
  void navigateToAddProduct(){
    Navigator.pushNamed(context, AddProductScreen.routeName);
  }
  @override
  Widget build(BuildContext context) {
  
    return products==null? const Loader(): Scaffold(
      body: GridView.builder(
        itemCount: products!.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2), itemBuilder: (context,index){
        final productData=products![index];
        return Column(
         children: [
          SizedBox(height: 130,
          child: SingleProduct(image: productData.images[0],),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
                 Expanded(child: Text(
                   productData.name,overflow: TextOverflow.ellipsis,
                   maxLines: 2,
                 )),
                 IconButton(onPressed:()=> deleteProduct(
                  productData,index
                 ), icon:const Icon(Icons.delete_outline) ),
            ],
          )
          
         ],
        );
      }),
      floatingActionButton: FloatingActionButton(child: const Icon(Icons.add),
      onPressed: navigateToAddProduct,
      tooltip: 'Add a Product',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

    );
  }
}