import 'package:flutter/material.dart';
import 'package:wiifd/utilties/app_colors.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image(image: AssetImage('assets/images/coin.gif')),
              ),
              Container(
                  height: 100,
                  width: double.infinity,
                  child: OutlinedButton(
                      style: TextButton.styleFrom(),
                      onPressed: () {},
                      child: Text(
                        "Get 50 Coins",
                        style: TextStyle(color: Colors.black),
                      )))
            ],
          )),
    );
  }
}
