class RegisterResponseModel {
  final String message;
  final Map<String, dynamic>? data;
  final int? statusCode;

  RegisterResponseModel({
    required this.message,
    this.data,
    this.statusCode,
  });

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json, {int? statusCode}) {
    String parsedMessage;
    if (json["message"] is List) {
      parsedMessage = (json["message"] as List).join(", ");
    } else if (json["message"] is String) {
      parsedMessage = json["message"];
    } else {
      parsedMessage = "";
    }

    return RegisterResponseModel(
      message: parsedMessage,
      data: json["data"] is Map ? Map<String, dynamic>.from(json["data"]) : null,
      statusCode: statusCode,
    );
  }
}
