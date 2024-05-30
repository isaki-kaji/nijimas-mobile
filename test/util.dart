import 'dart:math';

String randomString(int n) {
  const chars =
      "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
  final rnd = Random();
  final result = List.generate(n, (index) => chars[rnd.nextInt(chars.length)]);
  return result.join();
}

String randomUid() {
  return randomString(28);
}

String randomCountryCode() {
  const countryCodes = [
    "JP",
    "US",
    "GB",
    "CA",
    "FR",
    "DE",
    "IT",
    "ES",
    "AU",
    "BR",
    "RU",
    "KR",
    "CN",
    "IN",
    "ID",
    "MX",
    "NL",
    "SA",
    "SE",
    "TR"
  ];

  final rnd = Random();
  return countryCodes[rnd.nextInt(countryCodes.length)];
}
