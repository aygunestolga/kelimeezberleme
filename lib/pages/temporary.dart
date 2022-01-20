import 'package:flutter/material.dart';
import 'package:kelimeezberleme/pages/home.dart';


class TemporaryPage extends StatefulWidget {
  const TemporaryPage({Key? key}) : super(key: key);

  @override
  _TemporaryPagesState createState() => _TemporaryPagesState();
}

class _TemporaryPagesState extends State<TemporaryPage> {

  // Bir class çalıştığında ilk çalışan fonksiyondur
  @override
  void initState() {
    super.initState();

    // 2 saniye bekleyip diğer sayfaya geçmesini sağladım
    Future.delayed(const Duration(seconds: 2), (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        // Safearea kullanmamızın sebebi görseli güvenli alana almak için
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Image.asset("assets/images/logo1.png"),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Word Translate",
                        style: TextStyle(
                            color: Colors.black87,
                            fontFamily: "Carter",
                            fontSize: 40),
                      ),
                    )
                  ],
                ),
                const Padding(
                  padding:  EdgeInsets.all(8.0),
                  child: Text(
                    "WORLD OF WORDS",
                    style: TextStyle(
                        color: Colors.black87,
                        fontFamily: "Luck",
                        fontSize: 25),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
