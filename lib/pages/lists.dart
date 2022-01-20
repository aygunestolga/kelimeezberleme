import 'package:flutter/material.dart';
import 'package:kelimeezberleme/global_widget/app_bar.dart';
import 'package:kelimeezberleme/hazir.dart';
import 'package:kelimeezberleme/pages/create_list.dart';

class ListsPage extends StatefulWidget {

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        context,
        left: Icon(Icons.arrow_back_ios,color: Colors.black87,),
        center:Image.asset("assets/images/listeler.png"),
        leftWidgetOnClick: () => Navigator.pop(context)
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => CreateList()));
        },
        child: const Icon(Icons.add,),
        backgroundColor: Colors.purple.withOpacity(1),
        splashColor: Colors.white,
      ),

      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: Container(
                width: double.infinity,
                child: Card(
                  color: Color(HazirMethod.HexaColorConverter("#DCD2FF")),
                  //gölge
                  elevation: 8,
                  // ovallik
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  margin: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 5,left: 15),
                          child: Text("Liste Adı", style: TextStyle(color: Colors.black87, fontSize: 16, fontFamily: "Roboto Medium"),)
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 30),
                          child: Text("305 Terim", style: TextStyle(color: Colors.black87, fontSize: 14, fontFamily: "Roboto Regular"),)
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 30),
                          child: Text("300 öğrenildi", style: TextStyle(color: Colors.black87, fontSize: 14, fontFamily: "Roboto Regular"),)
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 30),
                          child: Text("5 öğrenilmedi", style: TextStyle(color: Colors.black87, fontSize: 14, fontFamily: "Roboto Regular"),)
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
