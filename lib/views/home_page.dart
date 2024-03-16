import 'package:flutter/material.dart';
import 'package:ninja_api/views/covid_page.dart';
import 'package:ninja_api/views/customWidget/color.dart';
import 'package:ninja_api/views/customWidget/form.dart';
import 'package:ninja_api/views/dns_page.dart';
import 'package:ninja_api/views/telephone_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController controller = TextEditingController();
  TextEditingController dateController = TextEditingController();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  final form = FormWidget();
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  int index = 0;
  final appColor = AppColor();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    String labelText = index == 0
        ? "Verifier votre Dns"
        : index == 1
            ? "Verifier l'evolution du covid"
            : "Verifier votre numero de telephone";

    Icon bottomIcon(
        {required IconData? iconName,
        double size = 20,
        required Color? color}) {
      Icon icon;

      icon = Icon(
        iconName,
        size: size,
        color: color,
      );

      return icon;
    }

    Text label(String labelText) {
      Text text;
      text = Text(
        labelText,
        style: const TextStyle(fontSize: 20, color: Colors.white),
      );
      return text;
    }

    // for making our design responsive

    return Scaffold(
      appBar: AppBar(
      //   actions: [
      //     GestureDetector(
      //       onTap: () {},
      //       child: const Icon(Icons.light_mode),
      //     ),
      //   ],
    ),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          iconTheme: MaterialStateProperty.all(
            const IconThemeData(
              color: Colors.white,
            ),
          ),
          indicatorColor: Colors.blue.shade100,
          labelTextStyle: MaterialStateProperty.all(const TextStyle(
              fontSize: 15, fontWeight: FontWeight.w500, color: Colors.white)),
        ),
        child: NavigationBar(
          onDestinationSelected: (value) => setState(() {
            index = value;
          }),
          animationDuration: const Duration(seconds: 2),
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          backgroundColor: Colors.black,
          selectedIndex: index,
          destinations: const [
            NavigationDestination(
              label: "dns",
              icon: Icon(Icons.dns),
            ),
            NavigationDestination(
              label: "covid",
              icon: Icon(Icons.coronavirus),
            ),
            NavigationDestination(
              label: "telephone",
              icon: Icon(Icons.phone),
            ),
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 40, right: 40),
        child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: height * 0.04,
                ),
                Text(
                  "Ninja api",
                  style: TextStyle(
                    fontSize: 30,
                    color: appColor.textColor,
                  ),
                ),
                Text(
                  labelText,
                  style: TextStyle(
                    fontSize: 30,
                    color: appColor.textColor,
                  ),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                form.formWidget(controller)[index],
                index == 1 ? dateExemple(context, dateController) : Container(),
                SizedBox(
                  height: height * 0.05,
                ),
                Row(
                  children: [
                    ElevatedButton(
                        style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                Color.fromARGB(157, 83, 31, 180))),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => index == 0
                                  ? DnsPage(
                                      domain: controller.text.toString().trim())
                                  : index == 1
                                      ? CovidPage(
                                          country:
                                              controller.text.toString().trim(),
                                          date: dateController.text
                                              .toString()
                                              .trim(),
                                        )
                                      : TelephonePage(
                                          telephone: controller.text.trim(),
                                        ),
                            ));
                          }
                        },
                        child: const Text(
                          "Valider",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ))
                  ],
                )
              ],
            )),
      ),
    );
  }
}
