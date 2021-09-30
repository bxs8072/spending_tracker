import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uchiha_saving/models/category.dart';
import 'package:uchiha_saving/models/person.dart';
import 'package:uchiha_saving/uis/categories_ui/components/icon_list.dart';

class AddCategoriesBottomSheet extends StatefulWidget {
  final Person person;
  const AddCategoriesBottomSheet({Key? key, required this.person})
      : super(key: key);

  @override
  _AddCategoriesBottomSheetState createState() =>
      _AddCategoriesBottomSheetState();
}

class _AddCategoriesBottomSheetState extends State<AddCategoriesBottomSheet> {
  TextEditingController _titleController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _titleController.dispose();
    super.dispose();
  }

  IconData? _iconData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Category"),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseFirestore.instance
                  .collection("Categories")
                  .doc(widget.person.id)
                  .collection("Categories")
                  .doc(_titleController.text.trim())
                  .set(Category(
                          iconData: _iconData!,
                          title: _titleController.text.trim())
                      .toMap)
                  .then(
                    (value) => Navigator.pop(context),
                  );
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Card(
        child: ListView(
          padding: const EdgeInsets.all(15.0),
          children: [
            ListTile(
              leading: Card(
                elevation: 20,
                child: DropdownButton<IconData>(
                  value: _iconData,
                  elevation: 5,
                  style: TextStyle(color: Colors.black),
                  items: icon_list
                      .map((e) => DropdownMenuItem<IconData>(
                            value: e,
                            child: Icon(e),
                          ))
                      .toList(),
                  alignment: Alignment.center,
                  onChanged: (IconData? value) {
                    setState(() {
                      _iconData = value;
                    });
                  },
                ),
              ),
              title: TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  label: Text("Title"),
                ),
                onChanged: (val) {
                  setState(() {});
                },
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Please Enter Category Title";
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
