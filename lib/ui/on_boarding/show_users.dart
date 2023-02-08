import 'package:flutter/material.dart';

import '../../database/database_helper.dart';
import '../../model/user_model.dart';

class ShowUser extends StatefulWidget {
  const ShowUser({Key? key}) : super(key: key);

  @override
  State<ShowUser> createState() => _ShowUserState();
}

class _ShowUserState extends State<ShowUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
        body: FutureBuilder<List<User>>(
            future: DatabaseHelper.instance.getUsers(),
            builder:
                (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: Text('Loading...'),
                );
              }
              return snapshot.data!.isEmpty ? Center(child: Text('No List'),) :
              ListView(
                children: snapshot.data!.map((user) {
                  return Center(
                    child: Card(
                      color: Colors.red,
                      child: ListTile(

                        title: Text(user.username),
                        onLongPress: () {
                          setState(() {
                            DatabaseHelper.instance.remove(user.id!.toInt());
                          });
                        },
                      ),
                    ),
                  );
                }).toList(),
              );
            }),
    );
  }
}
