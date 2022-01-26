import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wiifd/screens/settings/settings_model.dart';
import 'package:wiifd/screens/todo_screen/todo_model.dart';
import 'package:wiifd/utilties/app_colors.dart';

import '../main.dart';

class DeleteAlert extends ConsumerStatefulWidget {
  final String id;

  DeleteAlert({required this.id});

  @override
  _ConsumerTodoAlertDiState createState() => _ConsumerTodoAlertDiState();
}

class _ConsumerTodoAlertDiState extends ConsumerState<DeleteAlert> {
  ButtonStyle buttonStyle = OutlinedButton.styleFrom(
      side: BorderSide(width: 1.3, color: AppColor().primaryColor!));

  @override
  Widget build(BuildContext context) {
    final kaaaa = ref.watch(todoProvider);

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)), //this right here
        child: Container(
          height: MediaQuery.of(context).size.height * 0.45,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                      height: 190, child: Image.asset('assets/images/th.gif')),
                ),
                Center(
                  child: Text(
                    "So you're telling me you finished this task?",
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                ),
                kaaaa.when(
                  loading: () => Center(child: CircularProgressIndicator()),
                  error: (error) => Text(
                    error,
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.w600),
                  ),
                  data: (d) => Text(""),
                ),
                Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.19,
                            child: OutlinedButton(
                                style: buttonStyle,
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Nope")),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.19,
                            child: OutlinedButton(
                                style: buttonStyle,
                                onPressed: () async {
                                  await ref
                                      .read(todoProvider.notifier)
                                      .deleteTodo(widget.id);
                                  ref.refresh(settingsProvider);
                                  Navigator.pop(context);
                                  logger.d("Delete it...");
                                },
                                child: Text("Yes")),
                          ),
                        ],
                      ),
                    ))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
