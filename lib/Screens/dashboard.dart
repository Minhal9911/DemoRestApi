import 'package:flutter/material.dart';
import 'package:mock_user_app/Screens/detail_user.dart';
import 'package:mock_user_app/services/helper.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../model/user_res.dart';
import 'add_user.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<UserRes> users = [];
  bool isLoading = true;

  Future<void> loadUser() async {
    users = await Helper.getAllUser();
    isLoading = false;
    debugPrint('userSize ${users.length}');
    setState(() {});
  }

  @override
  void initState() {
    loadUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users List'),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : users.isEmpty
              ? const Center(
                  child: Text(
                  'No Data Found',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: Colors.red),
                ))
              : ListView.builder(
                  // shrinkWrap: true,
                  itemCount: users.length,
                  itemBuilder: (BuildContext context, int index) {
                    final user = users[index];
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DetailUser(
                                  id: user.id.toString(),
                                )));
                      },
                      child: Card(
                        margin:
                            const EdgeInsets.only(top: 20, left: 10, right: 10),
                        child: ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(60.0),
                            child: CachedNetworkImage(
                              imageUrl: user.url!,
                              height: 50,
                              width: 50,
                              fit: BoxFit.fill,
                            ),
                          ),
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user.name!,
                                style: const TextStyle(fontSize: 22),
                              ),
                              const SizedBox(width: 10),
                              Text("Age:- ${user.age.toString()}"),
                            ],
                          ),
                          subtitle: Text(user.email!),
                          trailing: buildTrailingButtons(user, context),
                        ),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddUser(
                        name: '',
                        age: '',
                        email: '',
                        pass: '',
                        isAdd: true,
                        id: '',
                      ))).then((value) {
            if (value == true) {
              loadUser();
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildTrailingButtons(UserRes user, BuildContext context) {
    return PopupMenuButton(
        icon: const Icon(
          Icons.more_vert,
          color: Colors.purple,
          size: 28,
        ),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        position: PopupMenuPosition.under,
        constraints: const BoxConstraints(
          minWidth: 80.0,
          minHeight: 140.0,
          maxWidth: 145.0,
          maxHeight: 200.0,
        ),
        itemBuilder: (BuildContext context) {
          return [
            PopupMenuItem(
              child: TextButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.of(context)
                      .push(MaterialPageRoute(
                          builder: (context) => AddUser(
                              name: user.name!,
                              age: user.age!.toString(),
                              email: user.email!,
                              pass: user.password!,
                              isAdd: false,
                              id: user.id!)))
                      .then((value) {
                    if (value == true) {
                      loadUser();
                    }
                  });
                },
                icon: const Icon(
                  Icons.edit,
                  size: 28,
                ),
                label: const Text(
                  "Edit",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            PopupMenuItem(
              child: TextButton.icon(
                onPressed: () {
                  Helper.deleteUser(user.id!).then((value) {
                    if (value) {
                      Navigator.pop(context);
                      loadUser();
                    }
                  });
                },
                icon: const Icon(Icons.delete, size: 28),
                label: const Text(
                  "Delete",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ];
        });
  }
}
