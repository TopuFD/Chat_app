class MsgModel {
  MsgModel({
    required this.toId,
    required this.read,
    required this.message,
    required this.type,
    required this.send,
    required this.fromId,
  });
  late final String toId;
  late final String read;
  late final String message;
  late final Type type;
  late final String send;
  late final String fromId;

  MsgModel.fromJson(Map<String, dynamic> json) {
    toId = json['toId'].toString();
    read = json['read'].toString();
    message = json['message'].toString();
    type = json['type'] == Type.image.name ? Type.image : Type.text;
    send = json['send'].toString();
    fromId = json['fromId'].toString();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['toId'] = toId;
    _data['read'] = read;
    _data['message'] = message;
    _data['type'] = type.name;
    _data['send'] = send;
    _data['fromId'] = fromId;
    return _data;
  }
}

enum Type { text, image }
