import 'package:flutter/material.dart';
import 'package:kelimeezberleme/db/db/db.dart';
import 'package:kelimeezberleme/db/model/lists.dart';
import 'package:kelimeezberleme/db/model/words.dart';
import 'package:kelimeezberleme/hazir.dart';

import '../global_widget/app_bar.dart';
import 'lists.dart';

class CreateList extends StatefulWidget {
  @override
  _CreateListState createState() => _CreateListState();
}

class _CreateListState extends State<CreateList> {
  final _listName = TextEditingController();

  //Bir satırda iki tane textfield olduğu için liste tipi row, Her tektFieldın bir controllerı vardır
  List<Row> wordListField = [];
  List<TextEditingController> wordTextEditingList = [];

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < 5; i++) {
      wordTextEditingList.add(TextEditingController());
      wordTextEditingList.add(TextEditingController());

      // kelime çiftlerini
      for (int j = 0; j < 1; j++) {
        wordListField.add(Row(
          children: [
            Expanded(
                child: textFieldBuilder(
              textEditingController: wordTextEditingList[i * 2],
            )),
            Expanded(
                child: textFieldBuilder(
              textEditingController: wordTextEditingList[i * 2 + 1],
            )),
          ],
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        context,
        left: const Icon(
          Icons.arrow_back_ios,
          color: Colors.black87,
        ),
        center: Image.asset("assets/images/logo_text.png"),
        leftWidgetOnClick: () => Navigator.pop(context),
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              textFieldBuilder(
                  textEditingController: _listName,
                  icon: Icon(Icons.list),
                  hintText: "List Name"),

              Container(
                margin: EdgeInsets.only(top: 20, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    Text(
                      "English",
                      style:
                          TextStyle(fontSize: 18, fontFamily: "Roboto Regular"),
                    ),
                    Text(
                      "Türkçe",
                      style:
                          TextStyle(fontSize: 18, fontFamily: "Roboto Regular"),
                    )
                  ],
                ),
              ),

              // ekrana yayılsın diye expanded ile sarıyoruz
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    // her artıya bastıkça aşağıya doğru textfieldlar artacağı için buraya bir list veriyoruz
                    children: wordListField,
                  ),
                ),
              ),

              // Butonları ekledik burada
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  butonlar(addRow, Icons.add),
                  butonlar(save, Icons.save),
                  butonlar(deleteRow, Icons.remove),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  InkWell butonlar(Function() click, IconData icon) {
    return InkWell(
      onTap: () => click(),
      child: Container(
        width: 40,
        height: 40,
        margin: EdgeInsets.only(bottom: 10, top: 5),
        child: Icon(
          icon,
          size: 28,
        ),
        decoration: BoxDecoration(
          color: Color(HazirMethod.HexaColorConverter("#e8e8e8")),
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  void addRow() {
    wordTextEditingList.add(TextEditingController());
    wordTextEditingList.add(TextEditingController());

    wordListField.add(Row(
      children: [
        Expanded(
            child: textFieldBuilder(
          textEditingController:
              wordTextEditingList[wordTextEditingList.length - 2],
        )),
        Expanded(
            child: textFieldBuilder(
          textEditingController:
              wordTextEditingList[wordTextEditingList.length - 1],
        )),
      ],
    ));
    setState(() => wordListField);
  }

  void save() async {
    //listeye kelimeler ekleyebilmek için şartları yerleştiriyoruz
    int counter = 0;
    bool notEmptyPair = false;

    for (int i = 0; i < wordTextEditingList.length / 2; ++i) {
      String eng = wordTextEditingList[2 * i].text;
      String tr = wordTextEditingList[2 * i + 1].text;

      if (!eng.isEmpty && !tr.isEmpty) {
        counter++;
      } else {
        notEmptyPair = false;
      }
    }

    if (counter >= 1) {
      if (notEmptyPair == false) {
        Lists addedList =
            await DataBaseHelper.instance.insertList(Lists(name: _listName.text));

        for (int i = 0; i < wordTextEditingList.length / 2; ++i) {
          String eng = wordTextEditingList[i * 2].text;
          String tr = wordTextEditingList[i * 2 + 1].text;

          Word word = await DataBaseHelper.instance.insertWord(Word(
              list_id: addedList.id,
              word_eng: eng,
              word_tr: tr,
              status: false));
          debugPrint(word.id.toString() +
              " " +
              word.list_id.toString() +
              " " +
              word.word_eng.toString() +
              " " +
              word.word_tr.toString() +
              " " +
              word.status.toString());
        }

        debugPrint("Toast Message => Liste oluşturuldu");
        _listName.clear();
        wordTextEditingList.forEach((element) {
          element.clear();
        });
      } else {
        debugPrint("çiftlerden bir tanesi boş ");
      }
    } else {
      debugPrint("Toast Message => minimum 4  çift dolu olmalıdır ");
    }
  }

  void deleteRow() {
    if (wordListField.length != 1) {
      wordTextEditingList.removeAt(wordTextEditingList.length - 1);
      wordTextEditingList.removeAt(wordTextEditingList.length - 1);

      wordListField.removeAt(wordListField.length - 1);

      setState(() => wordListField);
    } else {
      debugPrint("Son eleman");
    }
  }

  Container textFieldBuilder({
    @required TextEditingController? textEditingController,
    Icon? icon,
    String? hintText,
  }) {
    return Container(
      height: 40,
      padding: EdgeInsets.only(left: 16, right: 16),
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.25),
          borderRadius: BorderRadius.circular(4)),
      margin: EdgeInsets.only(left: 16, right: 16, bottom: 4, top: 4),
      child: TextField(
        keyboardType: TextInputType.name,
        maxLines: 1,
        // yazımızın soldan başlamasını sağlar
        textAlign: TextAlign.left,
        // bu contoller aracalığıyla texte ne yazdığımızı elde edebiliriz
        controller: textEditingController,
        style: TextStyle(
            color: Colors.black,
            fontFamily: "Roboto Medium",
            decoration: TextDecoration.none,
            fontSize: 18),
        decoration: InputDecoration(
          icon: icon,
          border: InputBorder.none,
          hintText: hintText,
          fillColor: Colors.transparent,
          isDense: true,
        ),
      ),
    );
  }
}
