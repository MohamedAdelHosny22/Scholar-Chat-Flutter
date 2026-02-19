import 'package:scholar_chat_app/constants/constants.dart';

class MessageModel{
  final String message;
  final String id;
  MessageModel(this.message, this.id);
  factory MessageModel.fromJson(Map<String, dynamic> json){
    return MessageModel(json[kMessage],json[kId]);
  }
}