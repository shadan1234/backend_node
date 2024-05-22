
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:node/features/home/widgets/address_box.dart';
import 'package:node/features/home/widgets/carousel_image.dart';
import 'package:node/features/home/widgets/deal_of_the_day.dart';
import 'package:node/features/home/widgets/top_category.dart';
import 'package:node/features/search/screens/search_screen.dart';
import 'package:node/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../../../constants/global_variable.dart';

class HomeScreen extends StatefulWidget {
 static const String routeName='/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  void navigateToSearchScreen(String query){
     Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  @override
  Widget build(BuildContext context) {
      final user=Provider.of<UserProvider>(context).user;
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
      )
     , body:SingleChildScrollView(
       child: Column(children: [
            AddressBox(),
            SizedBox(height: 10,),
            TopCategories(),
            SizedBox(height: 10,),
            CarouselImage(),
            DealOfDay(),
        ],),
     )
    );
  }
}