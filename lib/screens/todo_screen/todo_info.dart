import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wiifd/data_model/todo_info_model.dart';
import 'package:wiifd/screens/settings/settings_model.dart';
import 'package:wiifd/screens/todo_screen/todo_model.dart';
import 'package:wiifd/utilties/app_colors.dart';
import 'package:wiifd/widgets/todo_info_tile.dart';

class TodoInfoScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingP = ref.watch(settingsProvider);
   // final nameState = ref.watch(userInfoAsync);
   // ref.refresh(settingsProvider);

    return LayoutBuilder(
      builder: (_, constraints) {
        final heightC = constraints.biggest.height;
        return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: AppColor().backgroundColor,
              elevation: 0,
              title: ListTile(
                  title: Text(
                    "Hello,",
                    style: TextStyle(color: AppColor().primaryColor),
                  ),
                  subtitle: settingP.when(
                    loaded: (data) => Text(
                      "${data.name}",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                          color: AppColor().primaryColor),
                    ),
                    initializing: () {},
                    error: (e,) => Text('Error: $e'),
                  )),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.12,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: AppColor().greyColor),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        settingP.when(
                            loaded: (data) => Text(
                                  data.availableCoins.toString(),
                                  style: TextStyle(
                                      color: AppColor().primaryColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12),
                                ),
                            error: (e,) => Text('Error: $e'),
                            initializing:  () => Center(child: Text("wait..."))),
                        Text(
                          "Coins",
                          style: TextStyle(
                              color: AppColor().primaryColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            body: Column(
              children: [
                Container(
                  height: heightC * 0.24,
                  child: Image(
                    image: AssetImage("assets/images/todo.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: todoData.length,
                      itemBuilder: (BuildContext context, int index) {
                        return TodoInfoTile(
                          todoInfo: todoData[index],
                        );
                      }),
                )
              ],
            ));
      },
    );
  }
}
