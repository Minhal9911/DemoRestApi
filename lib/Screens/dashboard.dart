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
  TextEditingController searchController = TextEditingController();
  List<UserRes> users = [];
  List<UserRes> showList = [];
  bool isLoading = true;
  bool isSearching = false;

  Future<void> loadUser() async {
    users = await Helper.getAllUser();
    // debugPrint('userSize ${users.length}');
    showList.clear();
    showList.addAll(users);
    isLoading = false;
    // debugPrint("list is available");

    setState(() {});
  }

  @override
  void initState() {
    loadUser();
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isSearching ? searchTextField() : const Text('Users List'),
        // title: const Text('Users List'),
        centerTitle: true,

        actions: isSearching
            ? [
          IconButton(
            onPressed: () {
              isSearching = false;
              searchController.clear();
              showList.clear();
              showList.addAll(users);
              setState(() {});
            },
            icon: const Icon(Icons.clear),
          ),
        ]
            : [
          IconButton(
            onPressed: () {
              isSearching = true;
              setState(() {});
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: WillPopScope(
        onWillPop: _onWillPop,
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : showList.isEmpty
            ? const Center(
            child: Text(
              'No Data Found',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Colors.red),
            ))
            : Padding(
          padding: const EdgeInsets.only(top: 15),
          child: ListView.builder(
            // shrinkWrap: true,
            itemCount: showList.length,
            itemBuilder: (BuildContext context, int index) {
              final user = showList[index];
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          DetailUser(
                            id: user.id.toString(),
                          ),
                    ),
                  );
                  showList.clear();
                  showList.addAll(users);
                },
                child: Card(
                  color: Colors.white60.withOpacity(0.8),
                  shadowColor: Colors.purple,
                  elevation: 3,
                  margin: const EdgeInsets.only(
                      top: 20, left: 15, right: 15),
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
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
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
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                  const AddUser(
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

  Future<bool> _onWillPop() async {
    if (isSearching == true) {
      setState(() {
        isSearching = false;
      });
      return false;
    } else {
      bool result = await showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              title: const Text("Confirm ?"),
              content: const Text("Do you want to exit the app?"),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text("No"),
                ),
                TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: const Text("Yes"))
              ],
            ),
      );
      // return Future.value(result);
      return result;
    }
  }

  Widget searchTextField() {
    return SizedBox(
      height: 40,
      width: 300,
      child: TextField(
        controller: searchController,
        cursorColor: Colors.purple,
        autofocus: true,
        cursorHeight: 22,
        decoration: InputDecoration(
          hintText: "Search...",
          hintStyle: const TextStyle(color: Colors.purple),
          filled: true,
          fillColor: Colors.white54,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Colors.black, width: 0.8),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Colors.black, width: 0.8),
          ),
        ),
        onChanged: (value) {
          showList = users
              .where((items) =>
          (items.name!.toLowerCase().contains(value.toLowerCase())))
              .toList();
          setState(() {});
        },
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
                      builder: (context) =>
                          AddUser(
                              name: user.name!,
                              age: user.age!.toString(),
                              email: user.email!,
                              pass: user.password!,
                              isAdd: false,
                              id: user.id!)))
                      .then((value) {
                    if (value == true) {
                      isSearching = false;
                      searchController.clear();
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