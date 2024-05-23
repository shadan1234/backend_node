import 'package:flutter/material.dart';
import 'package:node/common/widgets/stars.dart';

import '../../../models/product.dart';

class SearchedProduct extends StatelessWidget {
  final Product product;
  const SearchedProduct({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Row(
            children: [
              Image.network(
                product.images[0],
                fit: BoxFit.fitWidth,
                height: 135,
                width: 135,
              ),
              Column(
                children: [
                  Container(
                    width: 200,
                    padding: EdgeInsets.only(left: 10, top: 5),
                    child: Text(
                      product.name,
                      style: TextStyle(fontSize: 16),
                      maxLines: 2,
                    ),
                  ),Container(
                    width: 200,
                    padding: EdgeInsets.only(left: 10, top: 5),
                    child: Stars(rating: 4)
                  ),Container(
                    width: 200,
                    padding: EdgeInsets.only(left: 10, top: 5),
                    child: Text('\$${product.price}', style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                    maxLines: 2,
                    ),
                  ),
                  Container(
                    width: 200,
                    padding: EdgeInsets.only(left: 10,),
                    child: Text('Eligible for FREE Shipping'), 
                   
                    ),
                  
                  Container(
                    width: 200,
                    padding: EdgeInsets.only(left: 10, top: 5),
                    child: Text('In Stock', style: TextStyle(
                     color: Colors.teal
                    ),
                    maxLines: 2,
                    ),
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
