import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/sign_up.dart';
import '../providers/database_helper.dart';

class RegistereUsersScreen extends StatefulWidget {
  const RegistereUsersScreen({Key? key}) : super(key: key);

  @override
  State<RegistereUsersScreen> createState() => _RegistereUsersScreenState();
}

class _RegistereUsersScreenState extends State<RegistereUsersScreen> {
  void _deleteAll(int? index) async {
    DatabaseHelper.instance.delete('signup', index);
    setState(() {});
  }

  Widget _registeredUsers() {
    return SingleChildScrollView(
      reverse: true,
      scrollDirection: Axis.vertical,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30.0,
            ),
            const Text(
              'Registered users',
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.lightBlue,
                  fontSize: 20.0),
            ),
            Center(
              child: FutureBuilder<List<SignUp>>(
                future: DatabaseHelper.instance.getRegisteredUsers(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<SignUp>> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: Text("Loading..."),
                    );
                  }
                  return snapshot.data!.isEmpty
                      ? Container(
                          height: MediaQuery.of(context).size.height * 0.75,
                          child: const Center(
                              child: Text(
                            "No User has registered in this app",
                            style: TextStyle(fontSize: 19, color: Colors.blue),
                          )),
                        )
                      : SizedBox(
                          height: 600,
                          child: ListView(
                              children: snapshot.data!.map((user) {
                                return Center(
                                  child: ListTile(
                                      title: Text(user.id.toString() +
                                          "  " +
                                          user.firstName.toString() +
                                          " " +
                                          user.lastName.toString()),
                                      leading: const Icon(Icons.edit,
                                          color: Colors.blue),
                                      hoverColor: Colors.blue,
                                      textColor: Colors.black87,
                                      trailing: const Icon(Icons.delete,
                                          color: Colors.red),
                                      onTap: () {
                                        setState(() {
                                          _deleteAll(user.id);
                                        });
                                      }),
                                );
                              }).toList(),
                              shrinkWrap: true),
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _registeredUsers(),
    );
  }
}
