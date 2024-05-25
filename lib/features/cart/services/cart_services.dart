import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../constants/error_handling.dart';
import '../../../constants/global_variable.dart';
import '../../../constants/utils.dart';
import '../../../models/product.dart';
import '../../../models/user.dart';
import '../../../providers/user_provider.dart';

class CartServices{
void removeFromCart({
    required BuildContext context,
    required Product product,
   
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.delete(Uri.parse('$uri/api/remove-from-cart/${product.id}'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token,
          },
      
          );

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            // User.fromMap(jsonDecode(res.body)); -->this will throw tons of errors cuz we will be naviagted back to the auth screen cuz for a small amt of time the userId was null
       User user=     userProvider.user.copyWith(
              cart: jsonDecode(res.body)['cart'] 
            );
            userProvider.setUserFromModel(user);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

}