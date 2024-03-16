import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FormWidget {
  List<Widget> formWidget(TextEditingController controller) {
    List<Widget> form = [
      TextFormField(
        controller: controller,
        decoration: const InputDecoration(
            labelText: "Entrer votre dns",
            hintText: "exemple.com",
            hintStyle: TextStyle(fontSize: 8)),
        validator: (value) {
          if (value!.isEmpty ||
              !RegExp(r'^[\w-\.]+(\.)+[\w]{2,4}').hasMatch(value)) {
            return "Dns invalide";
          } else {
            return null;
          }
        },
      ),
      TextFormField(
        controller: controller,
        decoration: const InputDecoration(
          labelText: "Nom du pays",
          hintText: "exemple:canada",
          hintStyle: TextStyle(fontSize: 8),
        ),
        validator: (value) {
          if (value!.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
            return "Nom du pays invalide";
          } else {
            return null;
          }
        },
      ),
      TextFormField(
        controller: controller,
        decoration: const InputDecoration(
            labelText: "Entrer votre numero de telephone",
            hintText: "exemple:+25765765636",
            hintStyle: TextStyle(fontSize: 8)),
        validator: (value) {
          if (value!.isEmpty ||
              !RegExp(r'^[+][0-9]{1,4}[-\s\./0-9]+$').hasMatch(value)) {
            return "Entrer un numero valider";
          } else {
            return null;
          }
        },
      ),
    ];

    return form;
  }
}

Widget dateExemple(BuildContext context, TextEditingController controller) {
  DateTime selectedDate = DateTime.now();
  showDate() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2021),
            lastDate: DateTime(2025))
        .then((value) {
      selectedDate = value!;
      controller.text =
          DateFormat("yyyy-MM-dd").format(selectedDate).toString();
    });
  }

  return TextFormField(
    controller: controller,
    readOnly: true,
    decoration: InputDecoration(
        labelText: "Selectionner la date",
        suffixIcon: GestureDetector(
            onTap: () {
              showDate();
            },
            child: const Icon(Icons.calendar_month)),
        hintStyle: TextStyle(fontSize: 8)),
    validator: (value) {
      if (value!.isEmpty) {
        return "saisissez la data";
      } else {
        return null;
      }
    },
  );
}
