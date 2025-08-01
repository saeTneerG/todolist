import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/view_models/app_view_model.dart';

class TaskListView extends StatelessWidget {
  const TaskListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppViewModel>(builder: (context, viewModel, child) {
      return Container(
        decoration: BoxDecoration(
            color: viewModel.colorLevel2,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
            child: ListView.separated(
                separatorBuilder: (context, index) {
                  return SizedBox(height: 15,);
                },
                itemCount: viewModel.numTask,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Checkbox(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      side: BorderSide(width: 2, color: viewModel.colorLevel3),
                      checkColor: viewModel.colorLevel1,
                      activeColor: viewModel.colorLevel3,
                      value: viewModel.getTaskValue(index),
                      onChanged: (value) {
                        viewModel.setTaskValue(index, value!);
                      },
                    ),
                    title: Text(viewModel.getTaskTitle(index), style: TextStyle(
                        color: viewModel.colorLevel4,
                        fontSize: 17,
                        fontWeight: FontWeight.w500)
                    ),
                  );
                },),
      );
    },);
  }
}
