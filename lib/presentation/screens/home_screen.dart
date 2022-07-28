import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/util/app/cubit.dart';
import 'package:todo/core/util/app/states.dart';
import 'package:todo/presentation/screens/schedule_screen.dart';
import 'package:todo/presentation/style/colors.dart';
import 'package:todo/presentation/widget/components.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override

  Widget build(BuildContext context) {

    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppInsertIntoDBState) {
        }
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return DefaultTabController(
          length: 4,
          child: Scaffold(

              appBar: AppBar(
                  titleSpacing: 35,
                  title: const Text(
                    'Board',
                  ),
                  actions: [
                    IconButton(
                        onPressed: () {
                          navigateTo(context, const ScheduleScreen());
                          },
                        icon: Icon(
                          Icons.calendar_today,
                          color: IconTheme.of(context).color,
                        )),
                  ],
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(80.0),
                    child: Container(
                      height: 60,
                      width: double.infinity,
                      decoration:  const BoxDecoration(
                        border: Border.symmetric(horizontal: BorderSide(
                          color: AppColors.lightGrey,
                        )),
                      ),
                      child: TabBar(
                        tabs: cubit.tabs,
                        onTap: (index) {
                          cubit.changeIndexTabBar(index);
                        },
                        indicatorSize: TabBarIndicatorSize.label,
                        isScrollable: true,
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.grey,
                        indicatorColor: Colors.black,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                      ),
                    ),
                  )),
              body: TabBarView(
                children: cubit.screens,
              ),
          ),
        );
      },
    );
  }
}
