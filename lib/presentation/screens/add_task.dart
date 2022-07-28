import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo/core/util/app/cubit.dart';
import 'package:todo/core/util/app/states.dart';
import 'package:todo/presentation/style/colors.dart';
import 'package:todo/presentation/widget/app_button.dart';
import 'package:todo/presentation/widget/form_field.dart';

import '../../core/util/notification_services.dart';
import '../widget/components.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {

  String remind = '10 minutes early';

  var formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppInsertIntoDBState) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            ),
            title: const Text('Add Task'),
            bottom: const PreferredSize(
              preferredSize: Size.fromHeight(5),
              child: Divider(),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                height: height,
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Title',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      DefaultTextField(
                        text: 'Design team meeting',
                        type: TextInputType.text,
                        validate: 'title is required',
                        controller: cubit.titleController,
                        suffixIcon: Icons.title,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        'Date',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      DefaultTextField(
                        text: '2021-07-22',
                        type: TextInputType.none,
                        validate: 'Date is required',
                        controller: cubit.dateController,
                        suffixIcon: Icons.calendar_today,
                        onTap: () {
                          showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime.parse('2025-12-30'),
                              builder: (context, child) {
                                return Theme(
                                    data: Theme.of(context).copyWith(
                                        colorScheme: const ColorScheme.light(
                                            primary: AppColors.green)),
                                    child: child!);
                              }).then((value) {
                            cubit.dateController.text =
                                DateFormat.yMMMd().format(value!);
                          });
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Column(
                        children: [
                          Row(
                            children: const [
                              Expanded(
                                child: Text(
                                  'Start Time',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'End Time',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              const SizedBox(
                                height: 5,
                              ),
                              Expanded(
                                child: DefaultTextField(
                                  text: '11:00 AM',
                                  type: TextInputType.none,
                                  validate: 'Start Time is required',
                                  controller: cubit.startTimeController,
                                  suffixIcon: Icons.watch_later_outlined,
                                  onTap: () {
                                    showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                        builder: (context, child) {
                                          return Theme(
                                              data: Theme.of(context).copyWith(
                                                colorScheme:
                                                    const ColorScheme.light(
                                                  primary: AppColors.green,
                                                ),
                                              ),
                                              child: child!);
                                        }).then((value) {
                                      cubit.startTimeController.text =
                                          value!.format(context);
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: DefaultTextField(
                                  text: '12:00 PM',
                                  type: TextInputType.none,
                                  validate: 'End Time is required',
                                  controller: cubit.endTimeController,
                                  suffixIcon: Icons.watch_later_outlined,
                                  onTap: () {
                                    showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.fromDateTime(
                                            DateTime.now().add(
                                                const Duration(minutes: 15))),
                                        builder: (context, child) {
                                          return Theme(
                                              data: Theme.of(context).copyWith(
                                                colorScheme:
                                                    const ColorScheme.light(
                                                  primary: AppColors.green,
                                                ),
                                              ),
                                              child: child!);
                                        }).then((value) {
                                      cubit.endTimeController.text =
                                          value!.format(context);
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        'Remind',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),

                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: AppColors.lightGrey)),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: AppColors.lightGrey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          border: const OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.grey[100],
                        ),
                        hint: Text(' $remind'),
                        borderRadius: BorderRadius.circular(15),
                        iconEnabledColor: AppColors.darkGrey,
                        iconDisabledColor: AppColors.darkGrey,
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: AppColors.darkGrey,
                        ),
                        items: cubit.remindList
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            remind = newValue!;
                          });
                        },
                      ),

                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 90,
                        child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: cubit.colors.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 11, right: 11, top: 50, bottom: 15),
                                child: InkWell(
                                  onTap: () {
                                    cubit.changeColorIndex(index);
                                  },
                                  child: Container(
                                    height: 30,
                                    width: 30,
                                    color: cubit.colors[index],
                                    child: cubit.colorNumber == index
                                        ? const Icon(Icons.done)
                                        : null,
                                  ),
                                ),
                              );
                            }),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      AppButton(
                          text: 'Create a Task',
                          onClick: () {
                            if (formKey.currentState!.validate()) {
                              cubit.insertTask();
                              NotificationServices().scheduleNotification(
                                  1,
                                  2,
                                  cubit.titleController.text,
                                  cubit.endTimeController.text);
                              showToast(text: 'Created One Task', color: AppColors.lightTeal);
                            }
                          })
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

}
