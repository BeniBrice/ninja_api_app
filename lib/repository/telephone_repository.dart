import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ninja_api/models/telephone.dart';

class TelephoneRepository {
  Future<Telephone> fetchTelephoneValidator(String phoneNumber) async {
    String number = phoneNumber;
    final response = await http.get(
      Uri.parse('https://api.api-ninjas.com/v1/validatephone?number=$number'),
      headers: {'X-Api-Key': 'Qn8MyOnWPV041NejReU1tg==75jFbJD0SPKpXFjY'},
    );

    // ignore: prefer_typing_uninitialized_variablesaaa
    var body;
    if (response.statusCode == 200) {
      body = jsonDecode(response.body);
    }
    // covidList.add(Covid.fromJson(body));
    return Telephone.fromJson(body);
  }
}
