import 'package:flutter/material.dart';
import 'package:node/constants/global_variable.dart';
import 'package:node/features/account/widgets/below_app_bar.dart';
import 'package:node/features/account/widgets/orders.dart';
import 'package:node/features/account/widgets/top_buttons.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  'assets/images/amazon_in.png',
                  width: 120,
                  height: 45,
                  color: Colors.black,
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Icon(Icons.notifications_outlined),
                    ),
                    Icon(Icons.search_rounded),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      body: Column(children: const [
        BelowAppBar(),
        SizedBox(
          height: 10,
        ),
        TopButtons(),
        SizedBox(
          height: 20,
        ),Orders(),
      ]),
    );
  }
}
