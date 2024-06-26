import 'package:flutter/material.dart';
import 'package:node/features/account/services/account_services.dart';
import 'package:node/features/account/widgets/account_button.dart';

class TopButtons extends StatelessWidget {
  const TopButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AccountButton(text: 'Your orders', onTap: () {}),
            AccountButton(text: 'Turn Seller', onTap: () {})
            ],
        ),SizedBox(height: 10,),
        Row(
          children: [
            AccountButton(text: 'Log out', onTap: () {
             AccountServices().logOut(context: context);
            }),
            AccountButton(text: 'Your Wish List', onTap: () {})
            ],
        ),
      ],
    );
  }
}
