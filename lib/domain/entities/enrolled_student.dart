class EnrolledStudent {
  final String code;
  final String name;
  final bool hasAccount; // true si ya se registró en la app

  const EnrolledStudent({
    required this.code,
    required this.name,
    required this.hasAccount,
  });
}
