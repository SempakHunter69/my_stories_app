import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginRespose {
  final bool error;
  final String message;
  final LoginResult loginResult;

  LoginRespose({
    required this.error,
    required this.message,
    required this.loginResult,
  });

  factory LoginRespose.fromJson(Map<String, dynamic> json) =>
      _$LoginResposeFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResposeToJson(this);
}

@JsonSerializable()
class LoginResult {
  final String userId;
  final String name;
  final String token;

  LoginResult({
    required this.userId,
    required this.name,
    required this.token,
  });

  factory LoginResult.fromJson(Map<String, dynamic> json) =>
      _$LoginResultFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResultToJson(this);
}
