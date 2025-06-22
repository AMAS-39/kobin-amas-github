class api {
  final String _domain = "kobin.krd";

  String get domainLink => _domain;
  String get apiPath => "/api";
  String get key => "Anything";

  String get link => "https://$_domain$apiPath";
}

/// Returns the full image URL by prepending the server domain when needed.
String resolveImageUrl(String url) {
  if (url.startsWith('http')) {
    return url;
  }
  final domain = api().domainLink;
  return 'https://$domain$url';
}
