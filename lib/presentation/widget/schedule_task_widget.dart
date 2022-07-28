import 'package:flutter/material.dart';
import 'package:todo/core/util/app/cubit.dart';

import '../style/colors.dart';

class ScheduleTaskWidget extends StatefulWidget {
  final Map task;
  const ScheduleTaskWidget({required this.task, Key? key}) : super(key: key);

  @override
  State<ScheduleTaskWidget> createState() => _ScheduleTaskWidgetState();
}

class _ScheduleTaskWidgetState extends State<ScheduleTaskWidget> {
  bool isCheck= false ;
  bool isComplete= true ;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8, top: 8),
      height: 80,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppCubit.get(context).colors[widget.task['colorNumber']],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.task['startTime'],
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                widget.task['title'],
                style: const TextStyle(color: Colors.white),
              ),
              const Spacer(),
              Checkbox(
                checkColor: AppCubit.get(context).colors[widget.task['colorNumber']],
                activeColor: Colors.white,
                value: widget.task['status'] == 'complete' ? isComplete:isCheck,
                side: const BorderSide(
                  color: Colors.white,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)
                ),
                onChanged: (bool? value) {
                  setState(() {
                    isCheck = value!;
                    AppCubit.get(context).updateTask(status: 'complete', id: widget.task['id']);
                  });
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
