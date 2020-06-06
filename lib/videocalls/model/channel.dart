

import 'package:emerge/videocalls/pages/call.dart';

class Channel {

  String id;
  String name;
  String description;
  String adminId;
  List<CallPage> peoples = new List();


  Channel(this.name, this.description, this.adminId);

  Channel.fromMap(Map snapshot)
      :
        id = snapshot['id'] ?? '',
        name = snapshot['name'] ?? '',
        description = snapshot['description'] ?? '',
        adminId = snapshot['adminId'] ?? '';

  toJson() {
    return {
      "name": name,
      "description": description,
      "adminId": adminId,
    };
  }

  @override
  String toString() {
    return 'Channel{name: $name, description: $description, adminId: $adminId}';
  }


}