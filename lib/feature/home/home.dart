import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hello! My name is Rolls. Let me introduce you ME!",
                style: GoogleFonts.lato(fontSize: 16, fontStyle: FontStyle.italic),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "I am a mobile application with three pages. I was made using the Riverpod provider and initState (on the Home page). My job is to show you everything that Luka coded inside me. On the first page, there is a description with three lines: the first is what you are reading now, the second is what is on the second page and how it was made, and the third is what sorting algorithms are and what is the most efficient way of sorting. What is not on this list is that the application constantly checks for wifi connection and if there is none, it will redirect you to the ErrorPage.",
                style: GoogleFonts.lato(fontSize: 16, fontStyle: FontStyle.italic),
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
                "An API (Application Programming Interface) is a set of rules and protocols for accessing a web-based software application or web tool. In Flutter, APIs are used to fetch data from a server or to send data to a server for processing and storage. Flutter provides built-in support for making HTTP requests to a server and parsing the JSON data returned by the server. Additionally, there are third-party libraries available for Flutter, such as the popular HTTP or Dio package, that can simplify the process of making API requests in Flutter. In my case I am using Dio packag to make a GET request to an API of donuts.",
                style: GoogleFonts.lato(fontSize: 16, fontStyle: FontStyle.italic),
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
                "A sorting algorithm is a method of arranging a collection of data in a specific order, either ascending or descending. Sorting algorithms are implemented using various techniques such as comparison-based, non-comparison based, and hybrid methods. Common comparison-based algorithms include Bubble Sort, Insertion Sort, Selection Sort, Quick Sort, and Merge Sort. Non-comparison based algorithms include Counting Sort and Radix Sort. Hybrid methods like Tim Sort and Intro Sort use both comparison-based and non-comparison based techniques. The choice of sorting algorithm depends on the size of the data, the type of data being sorted, and the desired performance characteristics. So on Sort Page I will show you an example of how you could sort the collection of 25 million random integers with the Quick Sort algorithm, which has an average time complexity of O(n log n).",
                style: GoogleFonts.lato(fontSize: 16, fontStyle: FontStyle.italic),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
