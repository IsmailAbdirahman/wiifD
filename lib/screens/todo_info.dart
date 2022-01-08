import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:wiifd/data_model/todo_info_model.dart';
import 'package:wiifd/utilties/app_colors.dart';
import 'package:wiifd/utilties/app_config.dart';
import 'package:wiifd/widgets/todo_info_tile.dart';

class TodoInfoScreen extends StatefulWidget {
  const TodoInfoScreen({Key? key}) : super(key: key);

  @override
  _TodoInfoScreenState createState() => _TodoInfoScreenState();
}

class _TodoInfoScreenState extends State<TodoInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        final heightC = constraints.biggest.height;
        final widthC = constraints.biggest.width;
        return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: AppColor().backgroundColor,
              elevation: 0,
              title: ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Text(
                    "Hello,",
                    style: TextStyle(color: AppColor().primaryColor),
                  ),
                ),
                subtitle: Text(
                  "$userUID",
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      color: AppColor().primaryColor),
                ),
              ),
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
                        Text(
                          "50",
                          style: TextStyle(
                              color: AppColor().primaryColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 12),
                        ),
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
