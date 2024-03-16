import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:ninja_api/views/customWidget/custom_row.dart';

class CovidPage extends StatefulWidget {
  const CovidPage({super.key, required this.country, required this.date});
  final String country;
  final String date;

  @override
  // ignore: library_private_types_in_public_api
  _CovidPageState createState() => _CovidPageState();
}

class _CovidPageState extends State<CovidPage> {
  Future<List<dynamic>> fetchCategorieNewsApi() async {
    String country = widget.country;
    final response = await http.get(
      Uri.parse('https://api.api-ninjas.com/v1/covid19?country=$country'),
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
    String date = widget.date;
    String country = widget.country;
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
                        "https://images.unsplash.com/photo-1584036561566-baf8f5f1b144?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8Y292aWR8ZW58MHx8MHx8fDA%3D",
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
                        "Les donnees du covid",
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
                    date,
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
                    country.toUpperCase(),
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
              future: fetchCategorieNewsApi(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: SpinKitCircle(
                      color: Color.fromARGB(255, 121, 3, 13),
                      size: 50,
                    ),
                  );
                } else if (snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text("Aucun donnees trouves"),
                  );
                }
                if (snapshot.data![0]['cases'][widget.date] != null) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final data = snapshot.data![index];
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: const LinearGradient(colors: [
                            Color.fromARGB(255, 26, 29, 29),
                            Color.fromARGB(255, 78, 33, 48)
                            // Color(0xFFf85187)
                          ]),
                          color: Colors.white,
                        ),
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(bottom: 4, top: 4),
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Column(
                            children: [
                              row.textWidget("country",
                                  data["country"].toString(), Colors.white),
                              row.textWidget("Region",
                                  data["region"].toString(), Colors.white),
                              row.textWidget(
                                  "Total",
                                  data["cases"][widget.date]['total']
                                      .toString(),
                                  Colors.white),
                              row.textWidget(
                                  "Nouveau cas",
                                  data["cases"][widget.date]['new'].toString(),
                                  Colors.white),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Center(
                    child: Text("Aucun donnes trouves"),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
