import 'package:firebase_database/firebase_database.dart';

class TopicSpeech {
  String topic;
  String name;
  String image;
  String text;
  String color;
  String percent;

  TopicSpeech(
      this.topic, this.name, this.image, this.text, this.color, this.percent);

  TopicSpeech.fromSnapshot(DataSnapshot snapshot)
      : topic = snapshot.key,
        name = snapshot.value["name"],
        image = snapshot.value["image"],
        text = snapshot.value["text"],
        color = snapshot.value["color"],
        percent = snapshot.value["percent"];
  toJson() {
    return {
      "topic": topic,
      "name": name,
      "image": image,
      "text": text,
      "color": color,
      "percent": percent,
    };
  }
}
