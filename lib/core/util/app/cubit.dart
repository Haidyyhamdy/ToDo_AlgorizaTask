import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';
import 'package:todo/core/util/app/states.dart';
import 'package:todo/presentation/screens/board_screen.dart';
import 'package:todo/presentation/screens/complete_task_screen.dart';
import 'package:todo/presentation/screens/favorite_screen.dart';
import 'package:todo/presentation/style/colors.dart';

import '../../../presentation/screens/unComplete_task_screen.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  late Database database;

  void initDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = p.join(databasesPath, 'TODO.db');

    log('Database Initialized');

    openDB(
      path: path,
    );

    emit(AppCreateDBState());
  }

  void openDB({
    required String path,
  }) async {
    openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db
            .execute(
          'CREATE TABLE Tasks (id INTEGER PRIMARY KEY, title TEXT,date TEXT,startTime TEXT,endTime TEXT,remind TEXT,colorNumber INTEGER,isComplete INTEGER,status TEXT)',
        )
            .then((value) {
          log('Table Created');
        }).catchError((onError) {
          log('error when create table ${onError.toString()}');
        });
      },
      onOpen: (Database db) {
        log('Database Opened');
        database = db;
        getTasks();
      },
    );
  }

  int colorNumber = 0;

  List<Color> colors = [
    AppColors.lightBlue,
    AppColors.lightTeal,
    AppColors.lightPink,
    AppColors.lightAmberAccent,
    AppColors.lightIndigo,
    AppColors.lightOrange,
    AppColors.lightPurple,
    AppColors.lightGreen,

  ];
  void changeColorIndex(index) {
    colorNumber = index;
    emit(AppChangeColorIndexState());
  }

  TextEditingController titleController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController remindController = TextEditingController();

  List<String> remindList = [
    '1 day early',
    '1 hour early ',
    '10 minutes early',
    '30 minutes early'
  ];
  void insertTask() {
    database.transaction((txn) async {
      txn.rawInsert(
          'INSERT INTO Tasks(title,date,startTime,endTime,remind,colorNumber,status) VALUES("${titleController.text}","${dateController.text}","${startTimeController.text}","${endTimeController.text}","${remindController.text}","$colorNumber","new")');
    }).then((value) {
      log('Successfully Insert');
      titleController.clear();
      dateController.clear();
      startTimeController.clear();
      endTimeController.clear();
      remindController.clear();
      getTasks();
      emit(AppInsertIntoDBState());
    });
  }

  var newTasks = [];
  var allTasks = [];
  var completeTasks = [];
  var favoriteTasks = [];

  void getTasks() async {
    emit(AppGetDBLoadingState());
    database.rawQuery('SELECT * FROM Tasks').then((value) {
      newTasks = [];
      completeTasks = [];
      favoriteTasks = [];
      allTasks = value;
      value.forEach((element) {
        if (element['status'] == 'new') {
          newTasks.add(element);
        } else if (element['status'] == 'complete') {
          completeTasks.add(element);
        } else if (element['status'] == 'favorite') {
          favoriteTasks.add(element);
          newTasks.add(element);
        }
      });
      log('Get Tasks Successfully');
      emit(AppGetDBState());
    }).catchError((error) {
      log('error when insert ${error.toString()}');
    });
  }

  void updateTask({
    required String status,
    required int id,
  }) {
    database.rawUpdate(
        'UPDATE Tasks SET status=? WHERE ID=?', [status, id]).then((value) {
      log('Updated Successfully');
      getTasks();
      emit(AppUpdateDBState());
    }).catchError((error) {
      log('When Update Found Error${error.toString()}');
    });
  }

  void deleteTask({
    required int id,
  }) {
    database.rawDelete('DELETE FROM Tasks WHERE id = ?', [id]).then((value) {
      log('Deleted Successfully');
      getTasks();
      emit(AppDeleteDBState());
    }).catchError((error) {
      log('Error Found When Delete ${error.toString()}');
    });
  }



  List<Widget> tabs = [
    const Tab(text: "All"),
    const Tab(
      text: "Complete",
    ),
    const Tab(
      text: "UnComplete",
    ),
    const Tab(
      text: "Favorite",
    ),
  ];

  List<Widget> screens = [
    const BoardScreen(),
    const CompleteTaskScreen(),
    const UnCompleteTaskScreen(),
    const FavoriteScreen(),
  ];
  int currentIndex = 0;
  void changeIndexTabBar(int index) {
    currentIndex = index;
    emit(ChangeTabBarIndex());
  }


}
