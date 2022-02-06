import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wiifd/data_model/todo_info_model.dart';
import 'package:wiifd/screens/todo_screen/todo_model.dart';
import 'package:wiifd/utilties/app_colors.dart';

class TodoInfoTile extends ConsumerWidget {
  final TodoInfo? todoInfo;

  TodoInfoTile({this.todoInfo});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timeConverter = ref
        .watch(todoProvider.notifier)
        .timeToNotifyConverter(todoInfo!.notifyTime!);
    return LayoutBuilder(builder: (_, constraints) {
      final heightC = constraints.biggest.height;
      final widthC = constraints.biggest.width;
      return Padding(
        padding:
            const EdgeInsets.only(left: 18.0, right: 18.0, bottom: 10, top: 12),
        child: Container(
          width: widthC * 0.3,
          child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: AppColor().cardColor,
              child: Theme(
                data: ThemeData().copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  textColor: Colors.black,
                  trailing: SizedBox.shrink(),
                  leading: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      height: heightC * 1,
                      width: widthC * 0.12,
                      decoration: BoxDecoration(
                          color: AppColor().greyColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          "${todoInfo!.availableCoins} Coins",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 13),
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    todoInfo!.title!,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  subtitle: Align(
                    alignment: Alignment.topLeft,
                    child: Row(
                      children: [
                        Icon(
                          Icons.timer,
                          color: Colors.grey[700],
                          size: 15,
                        ),
                        Text(
                          "${timeConverter.toString()}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 2, bottom: 20),
                          child: Text(
                            "${todoInfo!.description}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey[900],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
        ),
      );
    });
  }
}
