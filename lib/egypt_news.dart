import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'home.dart';

class PageTwo extends StatefulWidget {
  const PageTwo({super.key});

  @override
  State<PageTwo> createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {
  var data = [];

  getNews() async {
    final url = Uri.parse(
        "https://newsdata.io/api/1/news?apikey=pub_2675978753e354aa8cb8d9f2ab9f3d5496f28&q=egypt&country=eg&language=ar");
    final response = await http.get(url);
    final body = jsonDecode(response.body);
    setState(() {
      data.add(body);
    });
  }

  @override
  void initState() {
    super.initState();
    getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: data.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                Container(
                  height: 100.0,
                  decoration: BoxDecoration(
                    gradient: gradient,
                    boxShadow: const [BoxShadow(blurRadius: 5.0)],
                    borderRadius: BorderRadius.vertical(
                        bottom: Radius.elliptical(
                            MediaQuery.of(context).size.width, 100.0)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Center(
                        child: Text(
                          "News Around the World",
                          style: TextStyle(
                            fontSize: 26,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text("Total Results: ${data[0]["totalResults"]}")
                    ],
                  ),
                ),
                for (var x = 0; x <= 1; x++)
                  Card(
                    child: ListTile(
                      title: Column(
                        children: [
                          AutoSizeText(
                            "${data[0]["results"][x]["title"]}",
                            style: const TextStyle(
                                fontSize: 20,
                                color: Colors.pinkAccent,
                                fontWeight: FontWeight.bold),
                            maxLines: 2,
                          ),
                          AutoSizeText(
                            "${data[0]["results"][x]["description"]}",
                            style: const TextStyle(
                                fontSize: 16, color: Colors.white),
                          ),
                          AutoSizeText(
                            "${data[0]["results"][x]["content"]}",
                            style: const TextStyle(
                                fontSize: 14, color: Colors.white70),
                          ),
                        ],
                      ),
                      subtitle: Column(
                        children: [
                          Image.network(
                              "${data[0]["results"][x]["image_url"]}"),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AutoSizeText("${x + 1}"),
                                const SizedBox(
                                  width: 50,
                                ),
                                // AutoSizeText(
                                //     "Author: ${data[0]["results"][x]["author"]}",
                                //     style: const TextStyle(fontSize: 1),
                                //     maxLines: 2),
                                // const SizedBox(
                                //   width: 50,
                                // ),
                                AutoSizeText(
                                    "Date:${data[0]["results"][x]["pubDate"]}",
                                    style: const TextStyle(fontSize: 1),
                                    maxLines: 2),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
              ],
            ),
    );
  }
}
