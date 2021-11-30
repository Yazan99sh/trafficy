class ChatModel {
  String? sender;
  var sentDate;
  String? msg;
  
  ChatModel({this.sentDate, this.sender, this.msg});

  ChatModel.fromJson(Map<String, dynamic> jsonData) {
    sender = jsonData['sender'];
    try {
      msg = jsonData['msg']['message'];
    } catch (e) {
      msg = jsonData['msg'].toString();
    }
    if (jsonData['sentDate'] is String) {
      try {
        sentDate = DateTime.parse(jsonData['sentDate']);
      } catch (e) {
        sentDate = DateTime.fromMillisecondsSinceEpoch(int.tryParse(jsonData['sentDate'])! * 1000);
      }
    }
    if (jsonData['sentDate'] is int) {
      DateTime.fromMillisecondsSinceEpoch(jsonData['sentDate'] * 1000);
    }
    if (jsonData['sentDate'] is DateTime) {
      sentDate = jsonData['sentDate'];
    }
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> jsonData = {
      'sender': sender,
      'msg': msg,
      'sentDate': sentDate
    };

    return jsonData;
  }
}
