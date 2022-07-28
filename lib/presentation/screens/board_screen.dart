import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/util/app/cubit.dart';
import 'package:todo/presentation/screens/add_task.dart';
import 'package:todo/presentation/style/colors.dart';
import 'package:todo/presentation/widget/app_button.dart';


import '../../core/util/app/states.dart';
import '../widget/components.dart';
import '../widget/task_widget.dart';

class BoardScreen extends StatelessWidget {
  const BoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);

        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Expanded(
                    child: RefreshIndicator(
                      color: AppColors.green,
                      onRefresh: ()async{
                        cubit.getTasks();
                      },
                      child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) =>  TaskWidget(
                            task: cubit.allTasks[index],
                          ),
                          separatorBuilder: (context, index) => const SizedBox(
                                height: 25,
                              ),
                          itemCount:cubit.allTasks.length ),
                    )),
                AppButton(
                  text: 'Add a task',
                  onClick: () {
                    navigateTo(context, const AddTask());
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
