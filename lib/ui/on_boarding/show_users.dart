import 'package:flutter/material.dart';
import 'package:on_boarding_screen/ui/on_boarding/login_screen/login_screen.dart';
import 'package:on_boarding_screen/ui/on_boarding/update_screen.dart';

import '../../database/database_helper.dart';
import '../../model/user_model.dart';

class ShowUser extends StatefulWidget {
  const ShowUser({Key? key}) : super(key: key);

  // String text;

  @override
  State<ShowUser> createState() => _ShowUserState();
}

class _ShowUserState extends State<ShowUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        title: Text("Users List"),
        centerTitle: true,
      ),
      body: FutureBuilder<List<User>>(
        future: DatabaseHelper.instance.getUsers(),
        builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text('Loading...'),
            );
          }
          return snapshot.data!.isEmpty
              ? Center(
                  child: Text('No List'),
                )
              : ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    return Center(
                      child: Card(
                        // color: Colors.red,
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Text(snapshot.data![index].id.toString()),
                          ),
                          title:
                              Text(snapshot.data![index].username.toString()),
                          subtitle:
                              Text(snapshot.data![index].password.toString()),
                          trailing: IconButton(
                            onPressed: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      UpdateScreen(user: snapshot.data![index]),
                                ),
                              );
                              setState(() {});
                            },
                            icon: Icon(Icons.edit),
                          ),
                          onLongPress: () {
                            setState(() {
                              DatabaseHelper.instance
                                  .remove(snapshot.data![index].id!.toInt());
                            });
                          },
                        ),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
