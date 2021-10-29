import 'package:flutter/material.dart';
import 'package:uchiha_saving/learn/detail_page.dart';
import 'package:uchiha_saving/learn/model/super_hero.dart';
import 'package:uchiha_saving/learn/model/super_hero_detail_model.dart';

class BasicPage extends StatefulWidget {
  BasicPage({Key? key}) : super(key: key);

  @override
  State<BasicPage> createState() => _BasicPageState();
}

class _BasicPageState extends State<BasicPage> {
  List<SuperHero> _list = [
    SuperHero(
        id: 1,
        name: "Spiderman",
        image:
            "https://static.wikia.nocookie.net/spiderman-films/images/0/05/Spider-Man_%28Toby_Maguire%29.png/revision/latest?cb=20210601234511"),
    SuperHero(
        id: 2,
        name: "Batman",
        image:
            "https://cdn.mos.cms.futurecdn.net/eRugth5FK6fMPiGhxVEgFh-1200-80.jpg"),
    SuperHero(
        id: 3,
        name: "Superman",
        image:
            "https://upload.wikimedia.org/wikipedia/en/3/35/Supermanflying.png"),
    SuperHero(
        id: 4,
        name: "Wolverine",
        image:
            "https://upload.wikimedia.org/wikipedia/en/5/5d/Wolverine_%28James_%27Logan%27_Howlett%29.png"),
    SuperHero(
        id: 5,
        name: "Hulk",
        image:
            "https://upload.wikimedia.org/wikipedia/en/a/aa/Hulk_%28circa_2019%29.png"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SuperHero"),
      ),
      body: ListView.builder(
          itemCount: _list.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                    return DetailPage(
                      superHero: _list[index],
                    );
                  }));
                },
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(_list[index].image),
                  radius: 30,
                ),
                title: Text(_list[index].name),
              ),
            );
          }),
    );
  }
}
