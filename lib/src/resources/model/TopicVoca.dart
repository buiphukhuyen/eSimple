import 'package:firebase_database/firebase_database.dart';

class TopicVoca {
  String topic;
  int index;
  String name;
  String image;
  int length;
  int percent;

  TopicVoca(
      this.topic, this.index, this.name, this.image, this.length, this.percent);

  TopicVoca.fromSnapshot(DataSnapshot snapshot)
      : topic = snapshot.key,
        index = snapshot.value["index"],
        name = snapshot.value["name"],
        image = snapshot.value["image"],
        length = snapshot.value["length"],
        percent = snapshot.value["percent"];
  toJson() {
    return {
      "topic": topic,
      "index": index,
      "name": name,
      "image": image,
      "length": length,
      "percent": percent,
    };
  }
}
