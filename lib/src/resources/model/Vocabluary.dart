class Vocabluary {
  final String phonetic;
  final String translate;
  final String image;
  final String text;

  Vocabluary({this.phonetic, this.translate, this.image, this.text});

  factory Vocabluary.fromJson(Map<dynamic, dynamic> json) =>
      _$VocabluaryFromJson(json);

  Map<String, dynamic> toJson() => _$VocabluaryToJson(this);
}

Vocabluary _$VocabluaryFromJson(Map<dynamic, dynamic> json) {
  return Vocabluary(
    phonetic: json['country']['VietNam']['phonetic'] as String,
    translate: json['country']['VietNam']['translate'] as String,
    image: json['country']['VietNam']['image'] as String,
    text: json['country']['VietNam']['text'] as String,
  );
}

Map<dynamic, dynamic> _$VocabluaryToJson(Vocabluary instance) =>
    <dynamic, dynamic>{
      'phonetic': instance.phonetic,
      'translate': instance.translate,
      'image': instance.image,
      'text': instance.text
    };
