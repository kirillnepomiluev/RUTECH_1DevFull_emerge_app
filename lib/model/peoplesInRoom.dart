

import 'package:date_format/date_format.dart';

class PeoplesInRoom {
  String id;
  String name;


  PeoplesInRoom(this.id, this.name);

  PeoplesInRoom.fromMap(Map snapshot)
      :
        id = snapshot['id'] ?? '',
        name = snapshot['name'] ?? '';

  toJson() {
    return {
      "id": id,
      "name": name,
    };
  }

  @override
  String toString() {
    return 'PeoplesInRoom{id: $id, name: $name}';
  }


}