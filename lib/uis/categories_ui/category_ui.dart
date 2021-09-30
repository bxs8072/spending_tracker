import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uchiha_saving/models/category.dart';
import 'package:uchiha_saving/models/person.dart';
import 'package:uchiha_saving/uis/categories_ui/components/add_categories_bottom_sheet.dart';
import 'package:uchiha_saving/uis/categories_ui/components/edit_categories_bottom_sheet.dart';

class CategoriesUI extends StatelessWidget {
  final Person person;
  const CategoriesUI({Key? key, required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories"),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    content: Text(
                        "Swipe right to left to delete!\nSwipe left to right to edit!"),
                  ),
                );
              },
              icon: Icon(Icons.info))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (ctx) {
                return AddCategoriesBottomSheet(
                  person: person,
                  key: key,
                );
              });
        },
        backgroundColor: Colors.black,
        child: Icon(Icons.add, color: Colors.white),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Categories")
            .doc(person.id)
            .collection("Categories")
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text("No categories found!!!"),
            );
          } else {
            List<Category> _items = snapshot.data!.docs
                .map((e) => Category.fromDynamic(e))
                .toList();
            return ListView.builder(
                itemCount: _items.length,
                itemBuilder: (ctx, i) {
                  Category _item = _items[i];
                  return Dismissible(
                    key: ValueKey(_item),
                    secondaryBackground: Card(
                      color: Colors.red,
                      child: ListTile(
                        trailing: Icon(Icons.delete),
                      ),
                    ),
                    background: Card(
                      color: Colors.blue,
                      child: ListTile(
                        leading: Icon(Icons.edit),
                      ),
                    ),
                    onDismissed: (dir) {
                      if (dir == DismissDirection.startToEnd) {
                        showModalBottomSheet(
                          context: context,
                          builder: (ctx) => EditCategoriesBottomSheet(
                            person: person,
                            key: key,
                            category: _item,
                          ),
                        );
                      } else {
                        FirebaseFirestore.instance
                            .collection("Categories")
                            .doc(person.id)
                            .collection("Categories")
                            .doc(_item.title)
                            .delete();
                      }
                    },
                    confirmDismiss: (dir) {
                      if (dir == DismissDirection.startToEnd) {
                        return showModalBottomSheet(
                          context: context,
                          builder: (ctx) => EditCategoriesBottomSheet(
                            person: person,
                            key: key,
                            category: _item,
                          ),
                        );
                      }
                      return showDialog(
                          context: context,
                          builder: (ctx) {
                            return AlertDialog(
                              title: Text(
                                  "Are you sure want to remove ${_item.title}?"),
                              content: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(true);
                                    },
                                    icon: Icon(Icons.check),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(false);
                                    },
                                    icon: Icon(Icons.clear),
                                  ),
                                ],
                              ),
                            );
                          });
                    },
                    child: Card(
                      child: ListTile(
                        leading: Icon(_item.iconData),
                        title: Text(_item.title),
                      ),
                    ),
                  );
                });
          }
        },
      ),
    );
  }
}
