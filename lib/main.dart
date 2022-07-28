import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/util/notification_services.dart';
import 'package:todo/presentation/screens/home_screen.dart';

import 'core/util/app/cubit.dart';
import 'core/util/bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  BlocOverrides.runZoned(
    () {
      NotificationServices().initializeNotification();
      runApp(const MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..initDatabase(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            iconTheme: const IconThemeData(
              color: Colors.black54,
            ),
            appBarTheme: const AppBarTheme(
                titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontFamily: 'Edu',
                    fontWeight: FontWeight.w600),
                backgroundColor: Colors.white,
                elevation: 0.0,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarIconBrightness: Brightness.dark,
                  statusBarColor: Colors.white,
                )),
            scaffoldBackgroundColor: Colors.white,
            fontFamily: 'Edu'),
        home: const HomeScreen(),
      ),
    );
  }
}
