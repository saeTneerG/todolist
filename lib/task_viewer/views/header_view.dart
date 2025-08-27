import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:todolist/login_view/login_view.dart';
import '../../view_models/app_view_model.dart';
import '../models/user_model.dart';
import 'bottom_sheets/delete_bottom_sheet_view.dart';

class HeaderView extends StatelessWidget {
  const HeaderView({super.key});

  Future signOut (BuildContext context) async {
    final viewModel = Provider.of<AppViewModel>(context, listen: false);
    User.clearUserData();
    User.setSignIn(false);
    viewModel.deleteAllTasks();
    viewModel.clearUserData();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppViewModel>(
      builder: (context, viewModel, child) {
        return Row(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                margin: EdgeInsets.only(left: 15),
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: FittedBox(
                          fit: BoxFit.fitHeight,
                          child: Text(
                            "Welcome back,",
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w400,
                              color: viewModel.colorLevel4,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: FittedBox(
                          fit: BoxFit.fitHeight,
                          child: Text(
                            viewModel.username,
                            style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: viewModel.colorLevel4,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Trash Icon
            Expanded(
              flex: 1,
              child: InkWell(
                borderRadius: BorderRadius.circular(5),
                onTap: () {
                  viewModel.bottomSheetBuilder(DeleteBottomSheetView(), context);
                },
                child: Icon(
                  Icons.delete,
                  color: viewModel.colorLevel3,
                  size: 40,
                ),
              ),
            ),
            // Logout Icon
            Expanded(
              flex: 1,
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () => signOut(context),
                child: Icon(
                  Icons.logout,
                  color: viewModel.colorLevel3,
                  size: 40,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
