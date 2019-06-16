import 'package:firebase_database/firebase_database.dart';

class Vocabulary {
  String name;
  String phonetic;
  String translate;
  String image;
  String text;

  Vocabulary(this.name, this.phonetic, this.translate, this.image, this.text);

  Vocabulary.fromSnapshot(DataSnapshot snapshot)
      : name = snapshot.key,
        phonetic = snapshot.value["phonetic"],
        translate = snapshot.value["translate"],
        image = snapshot.value["image"],
        text = snapshot.value["text"];
  toJson() {
    return {
      "phonetic": phonetic,
      "translate": translate,
      "image": image,
      "text": text,
    };
  }
}