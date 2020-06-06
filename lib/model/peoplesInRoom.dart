

import 'package:date_format/date_format.dart';

class PeoplesInRoom {
  String id;
  String name;
  String stream;


  PeoplesInRoom(this.id, this.name, this.stream);

  PeoplesInRoom.fromMap(Map snapshot)
      :
        id = snapshot['id'] ?? '',
        name = snapshot['date'] ?? '',
        stream = snapshot['stream'] ?? '';

  toJson() {
    return {
      "id": id,
      "name": name,
      "stream": stream,
    };
  }

  @override
  String toString() {
    return 'PeoplesInRoom{id: $id, name: $name, stream: $stream}';
  }


}