class Telephone {
  bool? isValid;
  bool? isFormattedProperly;
  String? country;
  String? location;
  List<String>? timezones;
  String? formatNational;
  String? formatInternational;
  String? formatE164;
  int? countryCode;

  Telephone(
      {this.isValid,
      this.isFormattedProperly,
      this.country,
      this.location,
      this.timezones,
      this.formatNational,
      this.formatInternational,
      this.formatE164,
      this.countryCode});

  Telephone.fromJson(Map<String, dynamic> json) {
    isValid = json['is_valid'];
    isFormattedProperly = json['is_formatted_properly'];
    country = json['country'];
    location = json['location'];
    timezones = json['timezones'].cast<String>();
    formatNational = json['format_national'];
    formatInternational = json['format_international'];
    formatE164 = json['format_e164'];
    countryCode = json['country_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_valid'] = this.isValid;
    data['is_formatted_properly'] = this.isFormattedProperly;
    data['country'] = this.country;
    data['location'] = this.location;
    data['timezones'] = this.timezones;
    data['format_national'] = this.formatNational;
    data['format_international'] = this.formatInternational;
    data['format_e164'] = this.formatE164;
    data['country_code'] = this.countryCode;
    return data;
  }
}
