import 'package:kelimeezberleme/db/model/lists.dart';
import 'package:kelimeezberleme/pages/home.dart';

final String tableNameWords = "Words";

class wordTableFields
{
  static final List<String> values = [
    id,list_id,status,word_eng,word_tr
  ];

  static final String id = "id";
  static final String list_id = "list_id";
  static final String word_eng = "word_eng";
  static final String word_tr = "word_tr";
  static final String status = "status";
}


class Word
{
  final int ? id;
  final int ? list_id;
  final String ? word_eng;
  final String ? word_tr;
  final bool ? status;

  const Word({this.id,this.list_id,this.word_eng,this.word_tr,this.status});

  Word copy(
      {
        int ? id,
        int ? list_id,
        String ? word_eng,
        String ? word_tr,
        bool ? status}
      )
  {
    return Word(
      id: id ?? this.id,
      list_id: list_id ?? this.list_id,
      word_eng: word_eng ?? this.word_eng,
      word_tr: word_tr ?? this.word_tr,
      status: status ?? this.status
    );
  }

  // veri tabanına sorguyu JSON gönderebilmek için
  Map<String,dynamic> toJson() => {
    wordTableFields.id: id,
    wordTableFields.list_id: list_id,
    wordTableFields.word_eng: word_eng,
    wordTableFields.word_tr: word_tr,
    wordTableFields.status: status == true ? 1 : 0,
  };

  // JSON dan Liste türüne dönüştürme
  static  Word fromJson(Map<String,dynamic> json) => Word(
      id: json[wordTableFields.id] as int?,
      list_id: json[wordTableFields.list_id] as int?,
      word_tr: json[wordTableFields.word_tr] as String?,
      word_eng: json[wordTableFields.word_eng] as String,
      status: json[wordTableFields.status] ==1,
      );


}