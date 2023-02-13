import 'package:flutter/material.dart';
import 'package:on_boarding_screen/ui/on_boarding/login_screen/login_screen.dart';

import '../../database/database_helper.dart';
import '../../model/user_model.dart';

class UpdateScreen extends StatelessWidget {
  const UpdateScreen({Key? key, this.user}) : super(key: key);
  final User? user;

  @override
  Widget build(BuildContext context) {
    final userController = TextEditingController();
    final passwordController = TextEditingController();
    if (user != null) {
      userController.text = user!.username;
      passwordController.text = user!.password;
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Username',
                style: TextStyle(fontSize: 20),
              ),
              TextFormField(
                controller: userController,
                onChanged: (value) {},
                decoration: InputDecoration(
                  hintText: 'Username',
                ),
              ),
              Text(
                'Password',
                style: TextStyle(fontSize: 20),
              ),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(hintText: 'Password,'),
              ),
              ElevatedButton(
                onPressed: () async {
                  final userN = userController.text;
                  final passN = passwordController.value.text;

                  if (userN.isEmpty || passN.isEmpty) {
                    return;
                  }

                  final User model =
                      User(username: userN, password: passN, id: user!.id);
                  await DatabaseHelper.instance.update(model);

                  Navigator.pop(context);
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
