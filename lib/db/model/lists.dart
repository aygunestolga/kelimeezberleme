import 'package:flutter/cupertino.dart';

final String tableNameLists = "Lists";

class listsTableFields
{
  static final List<String> values = [
    id,name
  ];
   static final String id = 'id';
   static final String name = 'name';
}


class Lists
{
  final int ? id;
  final String ? name;

  Lists({this.id, this.name});

  Lists copy({ int ? id, String ? name})
  {
   return Lists(
       id: id ?? this.id,
       name: name ?? this.name
   );
  }

  // veri tabanına sorguyu JSON gönderebilmek için
  Map<String,dynamic> toJson() => {
    listsTableFields.id : id,
    listsTableFields.name : name
  };

  // JSON dan Liste türüne dönüştürme
  static Lists fromJSon(Map<String,dynamic> json) => Lists(
      id: json[listsTableFields.id] as int?,
      name: json[listsTableFields.name] as String?
  );

}