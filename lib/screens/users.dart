import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_management/components/custom_input.dart';
import 'package:flutter_state_management/models/user_model.dart';
import 'package:flutter_state_management/providers/user_provider.dart';
import 'package:provider/provider.dart';

class Users extends StatelessWidget {
  const Users({super.key});

  @override
  Widget build(BuildContext context) {
    //read data from provider
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: _buildAppbar(context),
      body: userProvider.users.length == 0
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("No users available"),
                  SizedBox(
                    height: 20,
                  ),
                  MaterialButton(
                    elevation: 0,
                    color: Colors.black,
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      "Back",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: userProvider.users.length,
              itemBuilder: (context, index) {
                final user = userProvider.users[index];
                return _buildUserTile(context, user, userProvider);
              },
            ),
    );
  }

  ListTile _buildUserTile(
    BuildContext context,
    UserModel user,
    UserProvider userProvider,
  ) {
    return ListTile(
      title: Text(
        "${user.firstName.toUpperCase()} ${user.lastName}",
        style: TextStyle(
            color: Colors.black.withOpacity(.8), fontWeight: FontWeight.bold),
      ),
      subtitle: Text("${user.email.toLowerCase()}"),
      leading: CircleAvatar(
        child: Text(
          "${user.firstName[0].toUpperCase()}${user.lastName[0].toUpperCase()}",
        ),
      ),
      trailing: IconButton(
        onPressed: () => showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Comfirm"),
                content: Text("Are you sure to delete this user?"),
                actions: [
                  MaterialButton(
                    elevation: 0,
                    color: Colors.red.shade600,
                    onPressed: () {
                      Navigator.pop(context);
                      userProvider.removeUser(user);
                    },
                    child: Text(
                      "Yes",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  MaterialButton(
                    elevation: 0,
                    color: Colors.green.shade600,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "No",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              );
            }),
        icon: Icon(CupertinoIcons.trash),
      ),
    );
  }

  AppBar _buildAppbar(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AppBar(
      title: Text("Users"),
      actions: [
        IconButton(
          onPressed: () {
            _buildNewUserDialog(context, size);
          },
          icon: Icon(CupertinoIcons.person_add),
        ),
      ],
    );
  }

  _buildNewUserDialog(BuildContext context, Size size) {
    final firstNameController = TextEditingController();
    final lastNameController = TextEditingController();
    final emailController = TextEditingController();

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: AlertDialog(
            title: Text(
              'Create a new user',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
              textAlign: TextAlign.left,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextInput(
                  controller: firstNameController,
                  hintText: "First name",
                  icon: Icon(CupertinoIcons.person),
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextInput(
                  controller: lastNameController,
                  hintText: "Last name",
                  icon: Icon(CupertinoIcons.person),
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextInput(
                  controller: emailController,
                  hintText: "Email name",
                  icon: Icon(CupertinoIcons.envelope),
                ),
              ],
            ),
            actions: [
              MaterialButton(
                elevation: 0,
                color: Colors.red.shade600,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              MaterialButton(
                elevation: 0,
                color: Colors.green.shade600,
                onPressed: () {
                  Provider.of<UserProvider>(context, listen: false).addUser(
                    UserModel(
                      email: emailController.text,
                      firstName: firstNameController.text,
                      lastName: lastNameController.text,
                    ),
                  );
                  Navigator.pop(context);
                },
                child: Text(
                  "Create",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
