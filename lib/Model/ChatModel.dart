// ignore_for_file: public_member_api_docs, sort_constructors_first
class ChatModel {
  String? id;
  String? message;
  String? senderId;
  String? timestamp;
  String? readStatus;
  String? imageUrl;
  String? videoUrl;
  String? audioUrl;
  String? documentUrl;
  String? replies;
  String? reaction;
  ChatModel(
      {this.id,
      this.message,
      this.senderId,
      this.timestamp,
      this.readStatus,
      this.imageUrl,
      this.videoUrl,
      this.audioUrl,
      this.documentUrl,
      this.replies,
      this.reaction});

  ChatModel.fromJson(Map<Object?, Object?> json) {
    if (json["id"] is String) {
      id = json["id"] as String;
    }
    if (json["message"] is String) {
      message = json["message"] as String;
    }

    if (json["senderId"] is String) {
      senderId = json["senderId"] as String;
    }

    if (json["timestamp"] is String) {
      timestamp = json["timestamp"] as String;
    }
    if (json["readStatus"] is String) {
      readStatus = json["readStatus"] as String;
    }
    if (json["imageUrl"] is String) {
      imageUrl = json["imageUrl"] as String;
    }
    if (json["videoUrl"] is String) {
      videoUrl = json["videoUrl"] as String;
    }
    if (json["audioUrl"] is String) {
      audioUrl = json["audioUrl"] as String;
    }
    if (json["documentUrl"] is String) {
      documentUrl = json["documentUrl"] as String;
    }

    if (json["replies"] is String) {
      replies = json["replies"] as String;
    }
    if (json["reaction"] is String) {
      reaction = json["reaction"] as String;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["message"] = message;
    _data["senderId"] = senderId;
    _data["timestamp"] = timestamp;
    _data["readStatus"] = readStatus;
    _data["imageUrl"] = imageUrl;
    _data["videoUrl"] = videoUrl;
    _data["audioUrl"] = audioUrl;
    _data["documentUrl"] = documentUrl;
    if (replies != null) {
      _data["replies"] = replies;
    }

    _data["reaction"] = reaction ?? "";

    return _data;
  }
}
