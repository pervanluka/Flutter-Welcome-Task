import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../model/donut_model.dart';
import '../data/detail_page.dart';

class CustomContainer extends StatelessWidget {
  final DonutItem item;
  final String src;
  const CustomContainer({super.key, required this.item, required this.src});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => DetailPage(
            item: item,
            imgPath: src,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Hero(
                tag: item.id,
                child: ClipOval(
                  child: Image.network(
                    src,
                    fit: BoxFit.cover,
                    height: 100,
                    width: 100,
                  ),
                ),
              ),
              Text(
                item.name,
                style: GoogleFonts.lato(fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Batter: ",
                    style: GoogleFonts.lato(fontWeight: FontWeight.bold),
                  ),
                  Flexible(
                    child: Text(
                      item.batters.batter.map((e) => e.type).join(", "),
                      style: GoogleFonts.lato(fontStyle: FontStyle.normal),
                    ),
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Topping: ",
                    style: GoogleFonts.lato(fontWeight: FontWeight.bold),
                  ),
                  Flexible(
                    child: Text(
                      item.topping.map((e) => e.type).join(", "),
                      style: GoogleFonts.lato(fontStyle: FontStyle.italic),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
