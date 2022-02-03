import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:wiifd/screens/settings/settings_model.dart';
import 'package:wiifd/screens/todo_screen/todo_model.dart';
import 'package:wiifd/utilties/app_colors.dart';

import 'payment_model.dart';

class PaymentScreen extends ConsumerWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final payemtPackages = ref.watch(paymentModelProvider);
    final purchase = ref.watch(paymentModelProvider.notifier);
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image(image: AssetImage('assets/images/coin.gif')),
              ),
              payemtPackages.when(
                  notPurchased: () => Text('Not purchased'),
                  error: (e) => Text("Something went wrong"),
                  purchase: (package) => ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: package.length,
                        itemBuilder: (context, int index) {
                          final packages = package[index];
                          return Column(
                            children: [
                              PayWallScreen(
                                package: packages,
                                onClickedPackage: (package) async {
                                  await purchase.makePurchase(package);
                                  ref.refresh(settingsProvider);
                                  ref.refresh(todoProvider);
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        },
                      )),
            ],
          )),
    );
  }
}

class PayWallScreen extends StatelessWidget {
  final Package? package;

  final ValueChanged<Package> onClickedPackage;

  const PayWallScreen(
      {Key? key, required this.package, required this.onClickedPackage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = package!.product;

    return Padding(
      padding: const EdgeInsets.only(left: 18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text("Title: ${product.title}"),
            subtitle: Text("Description: ${product.description}"),
            trailing: Text("Price: ${product.priceString}"),
            onTap: () => onClickedPackage(package!),
          ),
        ],
      ),
    );
  }
}
