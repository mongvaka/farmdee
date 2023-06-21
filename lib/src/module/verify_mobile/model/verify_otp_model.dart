class VerifyOtpModel  {
  String sid;
  String serviceSid;
  String accountSid;
  String channel;
  String status;
  bool valid;
  DateTime dateCreated;
  DateTime dateUpdated;


  VerifyOtpModel({
    required this.sid,
    required this.serviceSid,
    required this.accountSid,
    required this.channel,
    required this.status,
    required this.valid,
    required this.dateCreated,
    required this.dateUpdated
  });

  factory VerifyOtpModel.fromJson(dynamic json) {
    return VerifyOtpModel(
      sid: json['sid'],
      serviceSid: json['serviceSid'],
      accountSid: json['accountSid'],
      channel: json['channel'],
      status: json['status'],
      valid: json['valid'],
      dateCreated: DateTime.parse(json['dateCreated']) ,
      dateUpdated: DateTime.parse(json['dateUpdated']),
    );
  }
}