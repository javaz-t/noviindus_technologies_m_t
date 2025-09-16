class Treatment {
  final String package;
  final int male;
  final int female;

  Treatment({
    required this.package,
    required this.male,
    required this.female,
  });

  factory Treatment.fromJson(Map<String, dynamic> json) {
    return Treatment(
      package: json['treatment'] as String,
      male: json['male'] as int,
      female: json['female'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'treatment': package,
      'male': male,
      'female': female,
    };
  }
}
