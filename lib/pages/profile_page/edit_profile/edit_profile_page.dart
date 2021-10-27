import 'package:flutter/material.dart';
import 'package:uchiha_saving/models/person.dart';

class EditProfilePage extends StatefulWidget {
  final Person person;
  const EditProfilePage({Key? key, required this.person}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit profile"),
      leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ), onPressed: () {},
        ),
        actions: [
          IconButton(
              icon:Icon(
              Icons.settings,
              color:Colors.white,
              ),
            onPressed: () {}
          )
        ],
      ),
      body: Form(
          child:ListView(
            padding: EdgeInsets.all(12.0),
            children:[
              TextFormField(
                decoration: InputDecoration(
                    labelText: "First Name", hintText: "Eg: kathy Jones"),
              ),
            ],
          )
      ),
    );

    //   appBar: AppBar(
    //     title: Text('This is the edit screen'),
    //     leading: IconButton(
    //       icon: Icon(
    //         Icons.arrow_back,
    //         color: Colors.white,
    //       ), onPressed: () {},
    //     ),
    //     actions: [
    //       IconButton(
    //           icon:Icon(
    //           Icons.settings,
    //           color:Colors.white,
    //           ),
    //         onPressed: () {}
    //       )
    //     ],
    //   ),
    //   body: Container(
    //     padding: EdgeInsets.only(left:15,top:20,right:15),
    //     child:
    //     GestureDetector(
    //       onTap: (){
    //         FocusScope.of(context).unfocus();
    //     },
    //     child: ListView(
    //         children: [
    //           Center(
    //             child:Stack(
    //               children:[
    //                 Container(
    //                   width: 130,
    //                   height: 130,
    //                   decoration: BoxDecoration(
    //                     border: Border.all(width:4, color:Colors.white),
    //                     boxShadow: [
    //                       BoxShadow(
    //                         spreadRadius: 2,
    //                         blurRadius: 10,
    //                         color: Colors.black.withOpacity(0.1)
    //                       )
    //                     ],
    //                     shape: BoxShape.circle,
    //                     image: DecorationImage(
    //                       fit: BoxFit.cover,
    //                       image: NetworkImage('https://images.unsplash.com/photo-1526304640581-d334cdbbf45e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80')
    //
    //                     )
    //                   )
    //                 ),
    //                 Positioned(
    //                   bottom:0,
    //                   right:0,
    //                   child: Container(
    //                     height:40,
    //                     width:40,
    //                     decoration: BoxDecoration(
    //                       shape: BoxShape.circle,
    //                       border: Border.all(
    //                         width: 4,
    //                         color: Colors.white
    //                       ),
    //                         color:Colors.blue
    //                     ),
    //                     child: Icon(
    //                       Icons.edit,
    //                       color:Colors.white
    //                     ),
    //                   ),
    //
    //                 )
    //               ]
    //             )
    //           ),
    //
    //         ]
    //     )
    //     )
    //
    //   ),
    // );
  }

}
