import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'home.dart';

class PageOne extends StatefulWidget {
  const PageOne({super.key});

  @override
  State<PageOne> createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  var data = [];

  getNews() async {
    final url = Uri.parse(
        "https://newsapi.org/v2/everything?domains=wsj.com&apiKey=085ae7e218d14c8090ab20ae3d83fb04");
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
                for (var x = 0; x <= data[0]["totalResults"] - 1; x++)
                  Card(
                    child: ListTile(
                      title: Column(
                        children: [
                          AutoSizeText(
                            "${data[0]["articles"][x]["title"]}",
                            style: const TextStyle(
                                fontSize: 20,
                                color: Colors.pinkAccent,
                                fontWeight: FontWeight.bold),
                            maxLines: 2,
                          ),
                          AutoSizeText(
                            "${data[0]["articles"][x]["description"]}",
                            style: const TextStyle(
                                fontSize: 16, color: Colors.white),
                          ),
                          AutoSizeText(
                            "${data[0]["articles"][x]["content"]}",
                            style: const TextStyle(
                                fontSize: 14, color: Colors.white70),
                          ),
                        ],
                      ),
                      subtitle: Column(
                        children: [
                          Image.network(
                              "${data[0]["articles"][x]["urlToImage"]}"),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AutoSizeText("${x + 1}"),
                                const SizedBox(
                                  width: 50,
                                ),
                                AutoSizeText(
                                    "Author: ${data[0]["articles"][x]["author"]}",
                                    style: const TextStyle(fontSize: 1),
                                    maxLines: 2),
                                const SizedBox(
                                  width: 50,
                                ),
                                AutoSizeText(
                                    "Date:${data[0]["articles"][x]["publishedAt"]}",
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
