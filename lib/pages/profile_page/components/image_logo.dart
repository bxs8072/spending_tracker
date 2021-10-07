import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:uchiha_saving/models/person.dart';

class ImageLogo extends StatelessWidget {
  final Person person;
  const ImageLogo({Key? key, required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Stack(
      children: [
        ClipOval(
          child: Material(
            color: Colors.transparent,
            child: Ink.image(
              image: NetworkImage(person.photoURL),
              fit: BoxFit.cover,
              width: 128,
              height: 128,
              child: InkWell(
                onTap: () {},
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 4,
          child: ClipOval(
            child: InkWell(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.all(8.0),
                color:
                    ThemeProvider.controllerOf(context).currentThemeId == "dark"
                        ? Colors.white
                        : Colors.black,
                child: Icon(
                  Icons.add_a_photo,
                  color: ThemeProvider.controllerOf(context).currentThemeId ==
                          "dark"
                      ? Colors.black
                      : Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
