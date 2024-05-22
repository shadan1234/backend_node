import 'package:flutter/material.dart';
import 'package:node/constants/global_variable.dart';
import 'package:node/features/home/screens/category_deals_screen.dart';

class TopCategories extends StatelessWidget {
  const TopCategories({super.key});

void navigateToCategoryPage(BuildContext context, category){
Navigator.pushNamed(context, CategoryDealsScreen.routeName,arguments: category);
}
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        itemExtent: 75,
        scrollDirection: Axis.horizontal,
         itemCount: GlobalVariables.categoryImages.length, itemBuilder: (context,index){
        return GestureDetector(
          onTap: ()=>  navigateToCategoryPage(context, GlobalVariables.categoryImages[index]['title'] ),
          child: Column(children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10,),
              child: ClipRRect(borderRadius: BorderRadius.circular(50),
              child: Image.asset(GlobalVariables.categoryImages[index]['image']!,
              fit: BoxFit.cover,
              height: 40,
          
              ) ,
              ),
            ),
            Text(GlobalVariables.categoryImages[index]['title']!,
            style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500),
            ),
          ],),
        );
      }) ,
    );
  }
}