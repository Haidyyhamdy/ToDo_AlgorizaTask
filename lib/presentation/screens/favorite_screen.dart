import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/util/app/cubit.dart';
import 'package:todo/core/util/app/states.dart';

import '../style/colors.dart';
import '../widget/task_widget.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit = AppCubit.get(context);
        return Padding(
          padding: const EdgeInsets.all(20.0),
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
                          task: cubit.favoriteTasks[index],
                        ),
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 25,
                        ),
                        itemCount:cubit.favoriteTasks.length ),
                  )),
            ],
          ),
        );
      },
    );
  }
}
