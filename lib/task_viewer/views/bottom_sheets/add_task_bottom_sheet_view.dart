import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/view_models/task_service_view_model.dart';
import '../../../view_models/app_view_model.dart';

import '../../models/task_model.dart';

class AddTaskBottomSheetView extends StatefulWidget {
  const AddTaskBottomSheetView({super.key});

  @override
  State<AddTaskBottomSheetView> createState() => _AddTaskBottomSheetViewState();
}

class _AddTaskBottomSheetViewState extends State<AddTaskBottomSheetView> {
  bool isLoading = false;

  Future<void> _addTask(AppViewModel viewModel, String title) async {
    setState(() {
      isLoading = true;
    });
    final result = await TaskService.createTask(
      userId: viewModel.user.userId,
      title: title,
      description: "",
      complete: false,
    );

    Task newTask = Task(
      result['data']['task_id'].toString(),
      result['data']['title'],
      result['data']['description'],
      (result['data']['status'] == 1) ? true : false,
    );

    viewModel.addTask(newTask);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController entryController = TextEditingController();
    return Consumer<AppViewModel>(
      builder: (context, viewModel, child) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            height: 80,
            child: Center(
              child: SizedBox(
                height: 40,
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextField(
                  onSubmitted: (value) {
                    if (entryController.text.isNotEmpty) {
                      _addTask(viewModel, entryController.text);
                      entryController.clear();
                    }
                    Navigator.of(context).pop();
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 5),
                    filled: true,
                    fillColor: viewModel.colorLevel2,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                  ),
                  textAlign: TextAlign.center,
                  textAlignVertical: TextAlignVertical.center,
                  cursorColor: viewModel.colorLevel4,
                  autofocus: true,
                  autocorrect: false,
                  controller: entryController,
                  style: TextStyle(
                    color: viewModel.colorLevel4,
                    fontWeight: FontWeight.w500,
                  ),
                  enabled: !isLoading,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
