import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:ninja_api/views/customWidget/custom_row.dart';

class DnsPage extends StatefulWidget {
  const DnsPage({super.key, required this.domain});
  final String domain;

  @override
  // ignore: library_private_types_in_public_api
  _DnsPageState createState() => _DnsPageState();
}

class _DnsPageState extends State<DnsPage> {
  int bigIndex = 0;
  @override
  void initState() {
    super.initState();
    fetchCategorieNewsApi("country").then((value) {
      final bigData = value.reduce((a, b) => a.length > b.length ? a : b);
      final indexPlusGrand = value.indexOf(bigData);
      bigIndex = indexPlusGrand;
      print('Le json le plus grand : $bigIndex');
    });
  }

  Future<List<dynamic>> fetchCategorieNewsApi(String country) async {
    var domain = widget.domain;
    final response = await http.get(
      Uri.parse(
        'https://api.api-ninjas.com/v1/dnslookup?domain=$domain',
      ),
      headers: {'X-Api-Key': 'Qn8MyOnWPV041NejReU1tg==75jFbJD0SPKpXFjY'},
    );

    // ignore: prefer_typing_uninitialized_variables
    var body;
    if (response.statusCode == 200) {
      body = jsonDecode(response.body);
    }
    // covidList.add(Covid.fromJson(body));
    return body;
  }

  @override
  Widget build(BuildContext context) {
    CustomRow row = CustomRow();
    String dns = widget.domain;
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              Container(
                height: 200,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xFF3ac3cb), Color(0xFFf85187)]),
                  image: DecorationImage(
                    image: NetworkImage(
                      "https://images.unsplash.com/photo-1633167606207-d840b5070fc2?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OXx8ZG5zfGVufDB8fDB8fHww",
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
                margin: EdgeInsets.only(bottom: 5, top: 0),
              ),
              Positioned(
                top: 20,
                left: 10,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Les informations",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 10,
                top: 80,
                child: Text(
                  "concernant",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Positioned(
                left: 10,
                bottom: 29,
                child: Text(
                  dns.toUpperCase(),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 1.5,
          child: FutureBuilder<List<dynamic>>(
            future: fetchCategorieNewsApi("country"),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: const SpinKitCircle(
                    color: Color.fromARGB(255, 121, 3, 13),
                    size: 50,
                  ),
                );
              }
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  // final donnesPrincipale = snapshot.data![bigIndex];
                  final otherData = snapshot.data![index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: const LinearGradient(colors: [
                        Color.fromARGB(255, 39, 38, 38),
                        Color.fromARGB(207, 17, 4, 4)
                      ]),
                      color: Color.fromARGB(207, 17, 4, 4),
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Column(
                          children: [
                            row.textWidget(
                              "record_type",
                              otherData['record_type'] ?? "",
                              Colors.white,
                            ),
                            row.textWidget(
                              "value",
                              otherData['value'] ?? "",
                              Colors.white,
                            ),
                          ],
                        )),
                  );
                },
              );
            },
          ),
        ),
      ],
    ));
  }
}
