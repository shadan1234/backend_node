import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:node/constants/error_handling.dart';
import 'package:node/constants/global_variable.dart';
import 'package:node/constants/utils.dart';
import 'package:http/http.dart' as http;
import 'package:node/models/user.dart';
import 'package:node/providers/user_provider.dart';
import 'package:provider/provider.dart';

class AddressServices {
  
  void saveAddress(
      {required BuildContext context,
       required String address,
      }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      
      http.Response res = await http.post(
        Uri.parse('$uri/api/save-user-address'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({'address':address})
      );
     
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
           User user= userProvider.user.copyWith(
              address: jsonDecode(res.body)['address']
            );
            userProvider.setUserFromModel(user);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
  void placeOrder(
      {required BuildContext context,
       required String address,
       required double totalSum,
      }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      
      http.Response res = await http.post(
        Uri.parse('$uri/api/order'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'cart':userProvider.user.cart,
          'address':address,
          'totalPrice':totalSum,

        })
      );
     
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Your order has been placed!');
            User user=userProvider.user.copyWith(
              cart: [],
            );
            userProvider.setUserFromModel(user);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  
}
