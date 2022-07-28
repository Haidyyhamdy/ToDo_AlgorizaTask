import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo/core/util/app/cubit.dart';
import 'package:todo/core/util/app/states.dart';
import 'package:todo/presentation/style/colors.dart';
import 'package:todo/presentation/widget/schedule_task_widget.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  DateTime _selectedValue = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
              title: const Text(
                'Schedule',
              ),
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(100.0),
                child: Container(
                  height: 90,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    border: Border.symmetric(
                        horizontal: BorderSide(
                      color: AppColors.lightGrey,
                    )),
                  ),
                  margin: const EdgeInsets.only(
                    left: 10,
                  ),
                  child: DatePicker(
                    DateTime.now(),
                    width: 60,
                    daysCount: 7,
                    initialSelectedDate: DateTime.now(),
                    selectionColor: AppColors.green,
                    selectedTextColor: Colors.white,
                    dateTextStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                    onDateChange: (newDate) {
                      setState(() {
                        _selectedValue = newDate;
                      });
                    },
                  ),
                ),
              )),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(children: [
              Row(
                children: [
                  Text(
                    DateFormat.EEEE().format(_selectedValue),
                    style: const TextStyle(fontSize: 18),
                  ),
                  const Spacer(),
                  Text(
                    DateFormat.yMMMd().format(_selectedValue),
                    style: const TextStyle(color: AppColors.darkGrey),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: RefreshIndicator(
                  color: AppColors.green,
                  onRefresh: () async {
                    cubit.getTasks();
                  },
                  child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) => cubit.allTasks[index]
                                  ['date'] ==
                              DateFormat.yMMMd().format(_selectedValue)
                          ? ScheduleTaskWidget(task: cubit.allTasks[index])
                          : Container(),
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 10,
                          ),
                      itemCount: cubit.allTasks.length),
                ),
              )
            ]),
          ),
        );
      },
    );
  }
}
