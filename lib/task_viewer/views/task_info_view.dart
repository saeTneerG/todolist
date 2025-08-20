import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../view_models/app_view_model.dart';

class TaskInfoView extends StatelessWidget {
  const TaskInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppViewModel>(builder: (context, viewModel, child) {
      return Container(
        margin: EdgeInsets.fromLTRB(15, 10, 15, 10),
        child: Row(
          children: [
            // Total Tasks
            Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(color: viewModel.colorLevel2, borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.center,
                      child: FittedBox(
                        child: Text("${viewModel.numTask}",
                        style: TextStyle(fontSize: 28,
                            color: viewModel.colorLevel3,
                            fontWeight: FontWeight.bold),),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: FittedBox(
                          child: Text("Total Tasks",
                            style: TextStyle(
                                color: viewModel.colorLevel4,
                                fontWeight: FontWeight.w600)
                          )),
                    ),
                  )
                ],
              ),
            ),
          ),
            SizedBox(width: 20),

            // Remaining Tasks
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(color: viewModel.colorLevel2, borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Align(
                        alignment: Alignment.center,
                        child: FittedBox(
                          child: Text("${viewModel.numTasksRemaining}",
                            style: TextStyle(fontSize: 28,
                                color: viewModel.colorLevel3,
                                fontWeight: FontWeight.bold),),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: FittedBox(
                            child: Text("Remaining Tasks",
                                style: TextStyle(
                                    color: viewModel.colorLevel4,
                                    fontWeight: FontWeight.w600)
                            )),
                      ),
                    )
                  ],
                ),
              ),
            ),
        ]),
      );
    });
  }
}
