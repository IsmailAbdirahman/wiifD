import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfire_ui/i10n.dart';
import 'package:logger/logger.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:wiifd/app_state/settings_state.dart';
import 'package:wiifd/data_source/payment_source.dart';
import 'package:wiifd/utilties/app_colors.dart';
import 'package:wiifd/widgets/button_nav.dart';
import 'screens/payment/payment_screen.dart';
import 'screens/settings/settings.dart';
import 'screens/signing_screen/sign_in_screen.dart';
import 'firebase_options.dart';

var logger = Logger();
var uuid = Uuid();

enum Entitlement { free, pro }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initPlatformState();
  await PaymentSource().initKey();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.white,
  ));

  runApp(ProviderScope(child: MyApp()));
}

Future<void> initPlatformState() async {
  await Purchases.setDebugLogsEnabled(true);
  await Purchases.setup('goog_lfWQhaHxLGYrxrySNKCNlHLQKaa');
}

// void main() => runApp(
//   DevicePreview(
//     enabled: !kReleaseMode,
//     builder: (context) => MyApp(), // Wrap your app
//   ),
// );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        FlutterFireUILocalizations.withDefaultOverrides(const LabelOverrides()),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        FlutterFireUILocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: AppColor().createMaterialColor(Color(0XFF21135D)),
      ),
      home: LoginScreen(),
    );
  }
}

class REvExample extends StatefulWidget {
  const REvExample({Key? key}) : super(key: key);

  @override
  _REvExampleState createState() => _REvExampleState();
}

class _REvExampleState extends State<REvExample> {
  Product? product;
  Entitlement _entitlement = Entitlement.free;
  int coins = 0;
  bool isPurchased = false;

  checkActiveSubscriptions() {
    Purchases.addPurchaserInfoUpdateListener((purchaserInfo) async {
      await updatePurchaseStatus();
    });
  }

  updatePurchaseStatus() async {
    final purchaseInfo = await Purchases.getPurchaserInfo();
    final entitlement = purchaseInfo.entitlements.active.values.toList();
    setState(() {
      _entitlement = entitlement.isEmpty ? Entitlement.free : Entitlement.pro;
    });
  }

  Future<void> initPlatformState() async {
    await Purchases.setDebugLogsEnabled(true);
    await Purchases.setup('goog_lfWQhaHxLGYrxrySNKCNlHLQKaa');
  }

  Future<List<Offering>> fetchOffering() async {
    try {
      final offering = await Purchases.getOfferings();
      final current = offering.current;
      return current == null ? [] : [current];
    } catch (e) {
      logger.e(e);
      return [];
    }
  }

  Future<List<Package>> getPackages() async {
    final offerings = await fetchOffering();
    final packages = offerings
        .map((offer) => offer.availablePackages)
        .expand((pair) => pair)
        .toList();
    return packages;
  }

  Future<bool> makePurchase(Package package) async {
    try {
      await Purchases.purchasePackage(package);
      return true;
    } catch (e) {
      return false;
    }
  }

  restoreUserInfo() async {
    // Later log in provided user Id
    //'my_app_user_id'  can be the userUID
    LogInResult result = await Purchases.logIn("my_app_user_id");
  }

  addCoins() {
    setState(() {
      coins += 50;
    });
  }

  spendCoins() {
    setState(() {
      coins -= 10;
    });
    if (coins == 0) {
      setState(() {
        coins = 0;
        isPurchased = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    checkActiveSubscriptions();
    return SafeArea(
        child: Scaffold(
      body: FutureBuilder<List<Package>>(
        future: getPackages(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final packages = snapshot.data;
            return ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: packages!.length,
              itemBuilder: (context, int index) {
                final package = packages[index];
                return isPurchased == false
                    ? Column(
                        children: [
                          PayWallScreen(
                            package: package,
                            onClickedPackage: (package) async {
                              final isSuccess = await makePurchase(package);
                              if (isSuccess) {
                                setState(() {
                                  isPurchased = true;
                                });
                                addCoins();
                              } else {}
                            },
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          SizedBox(
                            height: 50,
                          ),
                          Text("Total Coins $coins"),
                          ElevatedButton(
                              onPressed: () {
                                spendCoins();
                              },
                              child: Text("Spend 10 Coins")),
                        ],
                      );
                ;
              },
            );
          } else {
            return Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Text("Total Coins $coins"),
                ElevatedButton(
                    onPressed: () {
                      spendCoins();
                    },
                    child: Text("Spend 10 Coins")),
              ],
            );
          }
        },
      ),
    ));
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

// buildPackages() => ListView.builder(
//       shrinkWrap: true,
//       primary: false,
//       itemCount: packages.length,
//       itemBuilder: (context, int index) {
//         final package = packages[index];
//         return buildPackage(context, package);
//       },
//     );

// buildPackage(BuildContext context, Package package) {
//   final product = package.product;
//
//   return Padding(
//     padding: const EdgeInsets.only(left: 18.0),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         ListTile(
//           title: Text("Title: ${product.title}"),
//           subtitle: Text("Description: ${product.description}"),
//           trailing: Text("Price: ${product.priceString}"),
//         ),
//       ],
//     ),
//   );
// }

// // ignore: public_member_api_docs
// class InitialScreen extends StatefulWidget {
//
//   @override
//   State<StatefulWidget> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<InitialScreen> {
//   PurchaserInfo? _purchaserInfo;
//
//   @override
//   void initState() {
//     super.initState();
//     initPlatformState();
//   }
//
//   // Platform messages are asynchronous, so we initialize in an async method.
//   Future<void> initPlatformState() async {
//     await Purchases.setDebugLogsEnabled(true);
//     await Purchases.setup('goog_lfWQhaHxLGYrxrySNKCNlHLQKaa');
//
//     final purchaserInfo = await Purchases.getPurchaserInfo();
//
//     // If the widget was removed from the tree while the asynchronous platform
//     // message was in flight, we want to discard the reply rather than calling
//     // setState to update our non-existent appearance.
//     if (!mounted) return;
//
//     setState(() {
//       _purchaserInfo = purchaserInfo;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (_purchaserInfo == null) {
//       return Scaffold(
//         appBar: AppBar(title: const Text('RevenueCat Sample App')),
//         body: const Center(
//           child: Text('Loading...'),
//         ),
//       );
//     } else {
//       final isPro = _purchaserInfo!.entitlements.active.containsKey('pro_cat');
//       if (isPro) {
//         return  CatsScreen();
//       } else {
//         return  UpsellScreen();
//       }
//     }
//   }
// }
//
// // ignore: public_member_api_docs
// class UpsellScreen extends StatefulWidget {
//
//   @override
//   State<StatefulWidget> createState() => _UpsellScreenState();
// }
//
// class _UpsellScreenState extends State<UpsellScreen> {
//   Offerings? _offerings;
//
//   @override
//   void initState() {
//     super.initState();
//     fetchData();
//   }
//
//   Future<void> fetchData() async {
//     Offerings? offerings;
//     try {
//       offerings = await Purchases.getOfferings();
//     } on PlatformException catch (e) {
//       print(e);
//     }
//
//     if (!mounted) return;
//
//     setState(() {
//       _offerings = offerings;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (_offerings != null) {
//       final offering = _offerings?.current;
//       if (offering != null) {
//         final monthly = offering.monthly;
//         final lifetime = offering.lifetime;
//         if (monthly != null && lifetime != null) {
//           return Scaffold(
//             appBar: AppBar(title: const Text('Upsell Screen')),
//             body: Center(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: <Widget>[
//                   _PurchaseButton(package: monthly),
//                   _PurchaseButton(package: lifetime)
//                 ],
//               ),
//             ),
//           );
//         }
//       }
//     }
//     return Scaffold(
//       appBar: AppBar(title: const Text('Upsell Screen')),
//       body: const Center(
//         child: Text('Loading...'),
//       ),
//     );
//   }
// }
//
// class _PurchaseButton extends StatelessWidget {
//   final Package? package;
//
//   // ignore: public_member_api_docs
//   const _PurchaseButton({@required this.package}) ;
//
//   @override
//   Widget build(BuildContext context) => ElevatedButton(
//     onPressed: () async {
//       try {
//         final purchaserInfo = await Purchases.purchasePackage(package!);
//         final isPro = purchaserInfo.entitlements.all['pro_cat']!.isActive;
//         if (isPro) {
//           return  CatsScreen();
//         }
//       } on PlatformException catch (e) {
//         final errorCode = PurchasesErrorHelper.getErrorCode(e);
//         if (errorCode == PurchasesErrorCode.purchaseCancelledError) {
//           print('User cancelled');
//         } else if (errorCode ==
//             PurchasesErrorCode.purchaseNotAllowedError) {
//           print('User not allowed to purchase');
//         } else if (errorCode == PurchasesErrorCode.paymentPendingError) {
//           print('Payment is pending');
//         }
//       }
//       return  InitialScreen();
//     },
//     child: Text('Buy - (${package!.product.priceString})'),
//   );
// }
//
// // ignore: public_member_api_docs
// class CatsScreen extends StatelessWidget {
//
//   @override
//   Widget build(BuildContext context) => Scaffold(
//     appBar: AppBar(title: const Text('Cats Screen')),
//     body: const Center(
//       child: Text('User is pro'),
//     ),
//   );
// }
