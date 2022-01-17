import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wiifd/data_model/todo_info_model.dart';
import 'package:wiifd/data_source/supabase_db.dart';
import 'package:wiifd/screens/settings/settings.dart';
import 'package:wiifd/screens/settings/settings_model.dart';
import 'package:wiifd/screens/todo_screen/todo_info.dart';
import 'package:wiifd/screens/todo_screen/todo_model.dart';
import 'package:wiifd/utilties/app_colors.dart';
import 'package:date_format/date_format.dart';
import 'package:wiifd/utilties/time_convertor.dart';
import '../main.dart';
import 'todo_text_input.dart';

class ButtonNavWidget extends ConsumerStatefulWidget {
  const ButtonNavWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<ButtonNavWidget> createState() => _ButtonNavWidgetState();
}

class _ButtonNavWidgetState extends ConsumerState<ButtonNavWidget> {
  TextEditingController _timeController = TextEditingController();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  String? _time, _hours, _min;

  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);

  showTime(BuildContext context) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (pickedTime != null) {
      setState(() {
        selectedTime = pickedTime;
        _hours = selectedTime.hour.toString();
        _min = selectedTime.minute.toString();
        _time = _hours! + ':' + _min!;
        _timeController.text = _time!;
        _timeController.text = formatDate(
            DateTime(DateTime.now().year, DateTime.now().month,
                DateTime.now().year, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();
      });
    }
  }

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    TodoInfoScreen(),
    SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    _timeController.text = formatDate(
        DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
        [hh, ':', nn, " ", am]).toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColor().backgroundColor,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: ' ',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppColor().primaryColor,
        onTap: _onItemTapped,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 53.0),
        child: Container(
          height: 40,
          width: 40,
          child: FloatingActionButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: AppColor().primaryColor,
            onPressed: () {
              showTodoDialog();
            },
            tooltip: 'Increment',
            child: Icon(Icons.add),
            elevation: 2.0,
          ),
        ),
      ),
    );
  }

  showTodoDialog() {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)), //this right here
              child: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TodoTextInput(
                        textController: _titleController,
                        hint: "Title",
                        textFieldHeight:
                            MediaQuery.of(context).size.height * 0.05,
                      ),
                      TodoTextInput(
                        textController: _descriptionController,
                        hint: "Description",
                        textFieldHeight:
                            MediaQuery.of(context).size.height * 0.09,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text("When to remind?"),
                      Container(
                          height: MediaQuery.of(context).size.height * 0.05,
                          width: MediaQuery.of(context).size.width * 0.8,
                          decoration: BoxDecoration(
                              color: AppColor().greyColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Center(
                              child: Padding(
                            padding:
                                const EdgeInsets.only(left: 12.0, right: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    height: 50,
                                    width: 100,
                                    child: TextField(
                                      enabled: false,
                                      controller: _timeController,
                                    )),
                                InkWell(
                                  onTap: () {
                                    showTime(context);
                                  },
                                  child: Icon(
                                    Icons.timer_sharp,
                                    color: AppColor().primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ))),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 2,
                        decoration: BoxDecoration(),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              primary: AppColor().primaryColor),
                          onPressed: () {
                            final state = ref
                                .read(todoProvider.notifier)
                                .addTodo(
                                    title: _titleController.text,
                                    description: _descriptionController.text);
                            print("saved");
                            _titleController.clear();
                            _descriptionController.clear();
                            ref.refresh(settingsProvider);

                            Navigator.pop(context);
                          },
                          child: Text(
                            "Save",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
