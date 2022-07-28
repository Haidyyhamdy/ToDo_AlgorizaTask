import 'package:flutter/material.dart';
import 'package:todo/core/util/app/cubit.dart';
import 'package:todo/presentation/widget/components.dart';

import '../style/colors.dart';

class TaskWidget extends StatefulWidget {
  final Map task;

  const TaskWidget({Key? key, required this.task}) : super(key: key);

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  bool isCheck = false;
  bool isComplete = true;

  @override
  Widget build(BuildContext context) {
    Color colors = AppCubit.get(context).colors[widget.task['colorNumber']];
    return Row(
      children: [
        Checkbox(
          activeColor: AppCubit.get(context).colors[widget.task['colorNumber']],
          value: widget.task['status'] == 'complete' ? isComplete : isCheck,
          side: BorderSide(
            color: AppCubit.get(context).colors[widget.task['colorNumber']],
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          onChanged: (bool? value) {
            setState(() {
              isCheck = value!;
              AppCubit.get(context)
                  .updateTask(status: 'complete', id: widget.task['id']);
              showToast(text: 'Task is Completed', color: colors);
            });
          },
        ),
        const SizedBox(
          width: 15,
        ),
        Text(
          '${widget.task['title']}',
          style: const TextStyle(fontSize: 18),
        ),
        const Spacer(),
        GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        alignment: AlignmentDirectional.centerEnd,
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextButton(
                                onPressed: () {
                                  AppCubit.get(context).updateTask(
                                      status: 'favorite',
                                      id: widget.task['id']);
                                  Navigator.pop(context);
                                  showToast(text: 'Task Added To Favorite', color: colors);
                                },
                                child:  Text(
                                  'Favorite',
                                  style: TextStyle(color: colors,fontSize: 20),
                                )),
                            TextButton(
                                onPressed: () {
                                  AppCubit.get(context).deleteTask(
                                      id: widget.task['id']);
                                  Navigator.pop(context);
                                  showToast(text: 'Task Removed', color: colors);
                                },
                                child:  Text(
                                  'Remove',
                                  style: TextStyle(color: colors,fontSize: 20),
                                )),
                          ],
                        ),
                      ));
            },
            child: const Icon(Icons.more_horiz)),
      ],
    );
  }
}
