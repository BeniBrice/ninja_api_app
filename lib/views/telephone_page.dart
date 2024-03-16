import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ninja_api/models/telephone.dart';
import 'package:ninja_api/views/customWidget/custom_row.dart';
import 'package:ninja_api/views/model_views/model_views.dart';

class TelephonePage extends StatefulWidget {
  const TelephonePage({super.key, required this.telephone});
  final String telephone;

  @override
  // ignore: library_private_types_in_public_api
  _TelephonePageState createState() => _TelephonePageState();
}

class _TelephonePageState extends State<TelephonePage> {
  CustomRow row = CustomRow();
  final modelView = ModelView();
  @override
  Widget build(BuildContext context) {
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
                      "https://images.unsplash.com/photo-1621208586877-be0c9bc8a7c5?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjB8fHBob25lJTIwbnVtYmVyJTIwaW50byUyMGRhcmttb2RlfGVufDB8fDB8fHww",
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
                margin: const EdgeInsets.only(bottom: 5, top: 0),
              ),
              Positioned(
                top: 20,
                left: 10,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Verifier".toUpperCase(),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const Positioned(
                left: 10,
                top: 80,
                child: Text(
                  "votre numero",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 1.5,
          child: FutureBuilder<Telephone>(
            future: modelView.fetchTelephoneData(widget.telephone),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: SpinKitCircle(
                    color: Color.fromARGB(255, 121, 3, 13),
                    size: 50,
                  ),
                );
              }
              return ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  final data = snapshot.data!;
                  return Container(
                    height: 250,
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: const LinearGradient(colors: [
                        Color(0xFF3ac3cb),
                        Color.fromARGB(255, 43, 41, 41)
                      ]),
                      color: Colors.white,
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            row.textWidget(
                              "country",
                              data.country ?? "",
                              Colors.white,
                            ),
                            row.textWidget(
                              "location",
                              data.location ?? "",
                              Colors.white,
                            ),
                            row.textWidget(
                              "format national",
                              data.formatNational ?? "",
                              Colors.white,
                            ),
                            row.textWidget(
                              "format international",
                              data.formatInternational ?? "",
                              Colors.white,
                            ),
                            row.textWidget(
                              "format actuel",
                              data.formatE164 ?? "",
                              Colors.white,
                            ),
                            row.textWidget(
                              "Code du pays",
                              data.countryCode.toString(),
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
