import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mock_user_app/services/dio_service.dart';
import 'package:mock_user_app/services/helper.dart';

import '../model/user_req_id.dart';

class DetailUser extends StatefulWidget {
  const DetailUser({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  State<DetailUser> createState() => _DetailUserState();
}

class _DetailUserState extends State<DetailUser> {
  UserReqIdModel? user;

  Future<void> getUser() async {
    user = await ApiServices.getUserById(widget.id);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
        centerTitle: true,
      ),
      body: user == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 60,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(40.0),
                        child: CachedNetworkImage(
                          imageUrl: user!.url!,
                          height: 100,
                          width: 100,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    "Name:- ${user!.name}",
                    style: const TextStyle(color: Colors.black, fontSize: 30),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    "Age:- ${user!.age}",
                    style: const TextStyle(color: Colors.black, fontSize: 25),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    "Email:- ${user!.email}",
                    style: const TextStyle(color: Colors.black, fontSize: 24),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "Description",
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 250,
                    width: 400,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(width: 0.6, color: Colors.black)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "My name is ${user!.name} and I am ${user!.age} year old."
                        "I did my graduation in B.Tech in Mechanical Engineering but my passion is always as a software developer."
                        "For the past 1 year, I have bee working as a Flutter Developer",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
