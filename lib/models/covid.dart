import 'dart:convert';

class Covid {
  String country;
  String region;
  Map<String, Case> cases;

  Covid({
    required this.country,
    required this.region,
    required this.cases,
  });

  factory Covid.fromRawJson(String str) => Covid.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Covid.fromJson(Map<String, dynamic> json) => Covid(
        country: json["country"],
        region: json["region"],
        cases: Map.from(json["cases"])
            .map((k, v) => MapEntry<String, Case>(k, Case.fromJson(v))),
      );

  Map<String, dynamic> toJson() => {
        "country": country,
        "region": region,
        "cases": Map.from(cases)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
      };
}

class Case {
  int total;
  int caseNew;

  Case({
    required this.total,
    required this.caseNew,
  });

  factory Case.fromRawJson(String str) => Case.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Case.fromJson(Map<String, dynamic> json) => Case(
        total: json["total"],
        caseNew: json["new"],
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "new": caseNew,
      };
}
