import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kelimeezberleme/global_widget/app_bar.dart';
import 'package:kelimeezberleme/hazir.dart';
import 'package:kelimeezberleme/pages/lists.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:package_info_plus/package_info_plus.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

// kodun okunabilirliğini arttırmak için enum yapısını oluşturuyoruz
enum Lang { eng, tr }

const String _url =
    'https://github.com/sonerkoylu/Tips-Tricks/edit/main/Flutter';

class _HomePageState extends State<HomePage> {
  Lang? _chooseLang = Lang.eng;

  //drawer için
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  PackageInfo? packageInfo;
  String version = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pakageInfoInit();
  }

  // versiyon kontrol için
  void pakageInfoInit() async {
    packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      version = packageInfo!.version;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        drawer: Container(
          width: MediaQuery.of(context).size.width * 0.5,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Image.asset(
                    "assets/images/logo2.png",
                    height: 80,
                  ),
                  const Text(
                    "World Translate",
                    style: TextStyle(fontFamily: "Carter", fontSize: 26),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.35,
                    child: const Divider(
                      color: Colors.black,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 50, right: 8, left: 8),
                    child: const Text(
                      "Yakında Google play de görüşmek üzere, daha güzel projelerle karşınıza çıkacağım daha fazla bilgi için",
                      style:
                          TextStyle(fontFamily: "roboto Medium", fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  InkWell(
                      onTap: () async {
                        if (!await launch(_url)) throw 'Could not launch $_url';
                      },
                      child: Text(
                        "Tıkla",
                        style: TextStyle(
                            fontFamily: "Roboto Light",
                            fontSize: 16,
                            color: Color(
                                HazirMethod.HexaColorConverter("#0A588D"))),
                      )),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "V" + version + "\naygunestolgaa@gmail.com",
                  style: TextStyle(
                    color: Color(
                      HazirMethod.HexaColorConverter("#0A588D"),
                    ),
                    fontFamily: "Roboto Light",
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        appBar: appBar(
          context,
          left: const FaIcon(
            FontAwesomeIcons.bars,
            color: Colors.black87,
          ),
          center: Image.asset("assets/images/logo_text.png"),
          leftWidgetOnClick: () => {_scaffoldKey.currentState!.openDrawer()},
        ),
        body: SafeArea(
          child: Container(
            color: Colors.white,
            child: Center(
              child: Column(
                children: [
                  // Radio butonları konumlandırdık
                  Container(
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.3),
                    child: Column(
                      children: [
                        dilTurkce(),
                        dilEnglish(),
                      ],
                    ),
                  ),

                  // Bu alanda kartlarımızı oluşturup isimlendiriyoruz

                  Listelerim(context),

                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        kelimeKartlari(context),
                        coktanSecmeli(context),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  ListTile dilTurkce() {
    return ListTile(
      title: Text("Türkçe"),
      leading: Radio<Lang>(
        value: Lang.tr,
        groupValue: _chooseLang,
        onChanged: (Lang? value) {
          setState(() {
            _chooseLang = value;
          });
        },
      ),
    );
  }

  ListTile dilEnglish() {
    return ListTile(
      title: Text("English"),
      leading: Radio<Lang>(
        value: Lang.eng,
        groupValue: _chooseLang,
        onChanged: (Lang? value) {
          setState(() {
            _chooseLang = value;
          });
        },
      ),
    );
  }

  InkWell Listelerim(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ListsPage()));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        alignment: Alignment.center,
        height: 55,
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(HazirMethod.HexaColorConverter('#7D20A6')),
                  Color(HazirMethod.HexaColorConverter('#481183')),
                ])),
        child: const Text(
          "Listelerim",
          style: TextStyle(
              fontSize: 28, fontFamily: 'Carter', color: Colors.white),
        ),
      ),
    );
  }

  Container kelimeKartlari(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 200,
      width: MediaQuery.of(context).size.width * 0.35,
      decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(HazirMethod.HexaColorConverter('#1DACC9')),
                Color(HazirMethod.HexaColorConverter('#0C33B2')),
              ])),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          Text(
            "Kelime\nKartları",
            style: TextStyle(
                fontSize: 28, fontFamily: 'Carter', color: Colors.white),
            textAlign: TextAlign.center,
          ),
          Icon(
            Icons.file_copy,
            size: 32,
            color: Colors.white,
          )
        ],
      ),
    );
  }

  Container coktanSecmeli(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 200,
      width: MediaQuery.of(context).size.width * 0.35,
      decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(HazirMethod.HexaColorConverter('#FF3348')),
                Color(HazirMethod.HexaColorConverter('#B029B9')),
              ])),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          Text(
            "Çoktan\nSeçmeli",
            style: TextStyle(
                fontSize: 28, fontFamily: 'Carter', color: Colors.white),
            textAlign: TextAlign.center,
          ),
          Icon(
            Icons.check_circle_outline,
            size: 32,
            color: Colors.white,
          )
        ],
      ),
    );
  }
}
