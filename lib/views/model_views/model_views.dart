import 'package:ninja_api/models/telephone.dart';

import 'package:ninja_api/repository/telephone_repository.dart';

class ModelView {
  final telephoneRepository = TelephoneRepository();
  Future<Telephone> fetchTelephoneData(String phoneNumber) async {
    final response =
        await telephoneRepository.fetchTelephoneValidator(phoneNumber);
    return response;
  }
}
