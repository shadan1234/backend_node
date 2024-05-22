import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DealOfDay extends StatelessWidget {
  const DealOfDay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(left: 10, top: 15),
            child: const Text(
              'Deal of the day ',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Image.network(
            'https://images.unsplash.com/photo-1715966966827-25a227141ee9?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwzfHx8ZW58MHx8fHx8',
            height: 235,
            fit: BoxFit.fitHeight,
          ),
          Container(
            padding: const EdgeInsets.only(
              left: 15,
            ),
            alignment: Alignment.topLeft,
            child: Text(
              '\$100',
              style: TextStyle(fontSize: 18),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(left: 15, top: 5, right: 40),
            child: const Text(
              'Shadan',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.network(
                  'https://images.unsplash.com/photo-1715645943748-a7cf8a81f1ef?q=80&w=387&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                  fit: BoxFit.fitWidth,
                  width: 100,
                  height: 100,
                ),
                Image.network(
                  'https://images.unsplash.com/photo-1715645943748-a7cf8a81f1ef?q=80&w=387&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                  fit: BoxFit.fitWidth,
                  width: 100,
                  height: 100,
                ),
                Image.network(
                  'https://images.unsplash.com/photo-1715645943748-a7cf8a81f1ef?q=80&w=387&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                  fit: BoxFit.fitWidth,
                  width: 100,
                  height: 100,
                ),
                Image.network(
                  'https://images.unsplash.com/photo-1715645943748-a7cf8a81f1ef?q=80&w=387&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                  fit: BoxFit.fitWidth,
                  width: 100,
                  height: 100,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 15).copyWith(left: 15),
            alignment: Alignment.topLeft,
            child: Text('See all deals',style: TextStyle(color: Colors.cyan[800]),),

          )
        ],
      ),
    );
  }
}
