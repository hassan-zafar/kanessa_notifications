import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:kanessa_notifications/notificationHandler.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset("assets/logo.png"),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                    hintText: "Add title of the notification",
                    labelText: "Title"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                    hintText: "Add description of the notification",
                    labelText: "Description"),
              ),
            ),
            _isLoading
                ? CircularProgressIndicator()
                : Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          _isLoading = true;
                        });
                        sendAndRetrieveMessage(
                                message: _descriptionController.text,
                                context: context,
                                title: _titleController.text)
                            .then((value) {
                          _descriptionController.clear();
                          _titleController.clear();
                          BotToast.showText(text: "Notification Sent");
                        });
                        setState(() {
                          _isLoading = false;
                        });
                      },
                      icon: Icon(Icons.send),
                      label: Text("Send Notification"),
                    ),
                  ),
          ],
        ),
      )),
    );
  }
}
