import 'package:flutter/material.dart';
import 'package:welcome_task/model/donut_model.dart';

class DetailPage extends StatelessWidget {
  final DonutItem item;
  final String imgPath;
  const DetailPage({super.key, required this.item, required this.imgPath});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          item.name,
          style: const TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Column(children: [
          SizedBox(
            height: size.height * 0.3,
            child: Hero(
              tag: item.id,
                child: Image.network(
              imgPath,
              width: double.infinity,
              fit: BoxFit.fill,
            )),
          ),
          const SizedBox(
            height: 20,
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7),
            child: Row(
              children: [
                const Text('Batters: ',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Flexible(
                    child:
                        Text(item.batters.batter.map((e) => e.type).join(", ")))
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Topping: ',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Flexible(
                    child: Text(item.topping.map((e) => e.type).join(", ")))
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
