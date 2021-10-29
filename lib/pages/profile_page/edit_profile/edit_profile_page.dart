import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uchiha_saving/models/name.dart';
import 'package:uchiha_saving/models/person.dart';

class EditProfilePage extends StatefulWidget {
  final Person person;
  const EditProfilePage({Key? key, required this.person}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController _firstNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
      ),
      body: Form(
        child: ListView(
          padding: EdgeInsets.all(12.0),
          children: [
            TextFormField(
              controller: _firstNameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "First Name",
                hintText: "Eg. John Cena",
              ),
              onChanged: (val) {
                setState(() {});
              },
            ),
            TextFormField(),
            TextFormField(),
            TextFormField(),
            TextFormField(),
            TextFormField(),
            TextFormField(),
            TextFormField(),
            TextFormField(),
            TextButton(
              onPressed: () async {
                Name name = Name(
                    firstName: _firstNameController.text,
                    middleName: _firstNameController.text,
                    lastName: _firstNameController.text);

                await FirebaseFirestore.instance
                    .collection("Users")
                    .doc(widget.person.id)
                    .update({
                  "name": name.toMap,
                  "phone": "",
                  "address": {
                    "street": "street",
                    "roomNumber": "roomNumber",
                    "city": "city",
                    "state": "state",
                    "zipCode": 75050,
                  }
                });

                Navigator.pop(context);
              },
              child: Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}
