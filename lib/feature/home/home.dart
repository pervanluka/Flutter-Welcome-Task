import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("home".tr()),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "hello".tr(),
                style:
                    GoogleFonts.lato(fontSize: 16, fontStyle: FontStyle.italic),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "intro".tr(),
                style:
                    GoogleFonts.lato(fontSize: 16, fontStyle: FontStyle.italic),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                thickness: 2,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "apiData".tr(),
                style:
                    GoogleFonts.lato(fontSize: 16, fontStyle: FontStyle.italic),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                thickness: 2,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "aboutSorting".tr(),
                style:
                    GoogleFonts.lato(fontSize: 16, fontStyle: FontStyle.italic),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
