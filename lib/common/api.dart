class api {
  final String _domain = "kobin.krd";

  String get domainLink => _domain;
  String get apiPath => "/api";
  String get key => "Anything";

  String get link => "https://$_domain$apiPath";
}
