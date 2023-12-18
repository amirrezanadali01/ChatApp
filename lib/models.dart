class Config {
  static const String domainName = 'http://192.168.1.102:8000';
}

class JwtTokenModel {
  final String? refresh;
  final String access;

  JwtTokenModel({required this.access, this.refresh});

  factory JwtTokenModel.fromJson(Map json) =>
      JwtTokenModel(access: json['access'], refresh: 'refresh');
}
