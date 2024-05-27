import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:node/constants/error_handling.dart';
import 'package:node/constants/global_variable.dart';
import 'package:node/constants/utils.dart';
import 'package:node/features/auth/screens/auth_screen.dart';
import 'package:node/models/user.dart';
import 'package:node/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/order.dart';

class AccountServices{
   Future<List<Order>> fetchOrders(
     {required BuildContext context,
       
      }
   )async{
     
     
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Order>orderList=[];
    try {
     
      
      http.Response res = await http.get(
        Uri.parse('$uri/api/orders/me'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      
      );
       debugPrint(res.body);
     
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
          // List<Order> me map karna hai ie dart model me map karo from json then display on frontend part
          for(int i=0;i<jsonDecode(res.body).length ;i++){
           orderList.add(Order.fromJson(jsonEncode(jsonDecode(res.body)[i])));
          }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    print(orderList);
    return orderList;
  }
  void logOut({required BuildContext context})async{
        try {
           SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
           await sharedPreferences.setString('x-auth-token', '');
           Navigator.pushNamedAndRemoveUntil(context, AuthScreen.routeName, (route) => false ,);
        } catch (e) {
          showSnackBar(context, e.toString());
        }
  }
}
