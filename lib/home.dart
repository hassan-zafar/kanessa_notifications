import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kanessa_notifications/notificationHandler.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset("assets/logo.png"),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Text("Title :"),
          TextFormField(
            controller: _titleController,
          ),
          Text("Description :"),
          TextFormField(
            controller: _descriptionController,
          ),
          ElevatedButton.icon(
            onPressed: () {
              sendAndRetrieveMessage(message: _descriptionController.text, context: context, title: _titleController.text).then((value) => Fluttertoast());
            },
            icon: Icon(Icons.send),
            label: Text("Send Notification"),
          ),
        ],
      )),
    );
  }
}
