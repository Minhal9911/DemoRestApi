import 'package:flutter/material.dart';
import 'package:mock_user_app/services/helper.dart';
import 'package:mock_user_app/model/user_req.dart';

class AddUser extends StatefulWidget {
  const AddUser(
      {Key? key,
      required this.name,
      required this.age,
      required this.email,
      required this.pass,
      required this.isAdd,
      required this.id})
      : super(key: key);
  final String name;
  final String age;
  final String email;
  final String pass;
  final bool isAdd;
  final String id;

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.name;
    ageController.text = widget.age;
    emailController.text = widget.email;
    passController.text = widget.pass;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(widget.isAdd ? 'Add New User' : 'Edit User'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              nameTextField(),
              const SizedBox(height: 10),
              ageTextField(),
              const SizedBox(height: 10),
              emailTextField(),
              const SizedBox(height: 20),
              passTextField(),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  widget.isAdd
                      ? addUser()
                          .then((value) => Navigator.pop(context, true))
                          .then((value) => buildSnackBar())
                      : editUser()
                          .then((value) => Navigator.pop(context, true));
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(150, 40),
                    textStyle: const TextStyle(fontSize: 22),
                    elevation: 5.0,
                    shadowColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    )),
                child: Text(widget.isAdd ? 'Add' : 'Edit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextField nameTextField() {
    return TextField(
      controller: nameController,
      enableSuggestions: true,
      autocorrect: true,
      autofocus: false,
      cursorColor: Colors.blue,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.person_outline,
          color: Colors.blue,
        ),
        labelText: "Name",
        labelStyle: TextStyle(color: Colors.blue.withOpacity(0.9)),
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: Colors.white.withOpacity(0.3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.solid),
        ),
      ),
      keyboardType: TextInputType.name,
    );
  }

  TextField ageTextField() {
    return TextField(
      controller: ageController,
      enableSuggestions: true,
      autocorrect: true,
      autofocus: false,
      cursorColor: Colors.blue,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.person_outline,
          color: Colors.blue,
        ),
        labelText: "Age",
        labelStyle: TextStyle(color: Colors.blue.withOpacity(0.9)),
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: Colors.white.withOpacity(0.3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.solid),
        ),
      ),
      keyboardType: TextInputType.number,
    );
  }

  TextField emailTextField() {
    return TextField(
      controller: emailController,
      enableSuggestions: true,
      autocorrect: true,
      autofocus: false,
      cursorColor: Colors.blue,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.person_outline,
          color: Colors.blue,
        ),
        labelText: "Email Address",
        labelStyle: TextStyle(color: Colors.blue.withOpacity(0.9)),
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: Colors.white.withOpacity(0.3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.solid),
        ),
      ),
      keyboardType: TextInputType.name,
    );
  }

  TextField passTextField() {
    return TextField(
      controller: passController,
      enableSuggestions: true,
      autocorrect: true,
      obscureText: true,
      obscuringCharacter: '*',
      autofocus: false,
      cursorColor: Colors.blue,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.person_outline,
          color: Colors.blue,
        ),
        labelText: "Password",
        labelStyle: TextStyle(color: Colors.blue.withOpacity(0.9)),
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: Colors.white.withOpacity(0.3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.solid),
        ),
      ),
      keyboardType: TextInputType.visiblePassword,
    );
  }

  void buildSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'Success',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
        duration: const Duration(seconds: 2),
        elevation: 5,
        width: 150.0,
        backgroundColor: Colors.purple,
        behavior: SnackBarBehavior.floating,
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: const BorderSide(
              style: BorderStyle.solid, width: 1.0, color: Colors.black),
        ),
      ),
    );
  }

  Future<void> addUser() async {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String pass = passController.text.trim();
    String ageString = ageController.text.trim();

    int age = int.parse(ageString);
    UserRequest userReq = UserRequest(
        name: name,
        email: email,
        password: pass,
        age: age,
        url:
            "https://www.citypng.com/public/uploads/small/11640168385jtmh7kpmvna5ddyynoxsjy5leb1nmpvqooaavkrjmt9zs7vtvuqi4lcwofkzsaejalxn7ggpim4hkg0wbwtzsrp1ldijzbdbsj5z.png");
    await Helper.addUser(userReq.toJson());
    setState(() {});
  }

  Future<void> editUser() async {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String pass = passController.text.trim();
    String ageString = ageController.text.trim();

    int age = int.parse(ageString);
    UserRequest userReq = UserRequest(
        name: name,
        email: email,
        password: pass,
        age: age,
        url:
            "https://www.citypng.com/public/uploads/small/11640168385jtmh7kpmvna5ddyynoxsjy5leb1nmpvqooaavkrjmt9zs7vtvuqi4lcwofkzsaejalxn7ggpim4hkg0wbwtzsrp1ldijzbdbsj5z.png");
    await Helper.updateUser(userReq.toJson(), widget.id);
    setState(() {});
  }
}
