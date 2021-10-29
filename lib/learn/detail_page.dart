import 'package:flutter/material.dart';
import 'package:uchiha_saving/learn/model/super_hero.dart';
import 'package:uchiha_saving/learn/model/super_hero_detail_model.dart';

class DetailPage extends StatelessWidget {
  final SuperHero superHero;
  DetailPage({Key? key, required this.superHero}) : super(key: key);

  List<SuperHeroDetail> _detailList = [
    SuperHeroDetail(
        id: 1,
        age: 30,
        powerLevel: 600,
        winList: ["W", "L", "W", "W", "L", "L"]),
    SuperHeroDetail(
        id: 2,
        age: 30,
        powerLevel: 700,
        winList: ["W", "L", "W", "W", "W", "L"]),
    SuperHeroDetail(
        id: 3,
        age: 30,
        powerLevel: 1100,
        winList: ["W", "L", "L", "W", "L", "L"]),
    SuperHeroDetail(
        id: 4,
        age: 30,
        powerLevel: 120,
        winList: ["L", "L", "W", "L", "L", "L"]),
    SuperHeroDetail(
        id: 5,
        age: 30,
        powerLevel: 1200,
        winList: ["W", "W", "W", "W", "W", "L"]),
  ];

  SuperHeroDetail superHeroDetail() {
    return _detailList.firstWhere((element) => element.id == superHero.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(superHero.name),
      ),
      body: Column(
        children: [
          Image.network(superHero.image),
          Text(
            "POWER LEVEL:" + superHeroDetail().powerLevel.toString(),
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
