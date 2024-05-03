// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_inner_shadow/flutter_inner_shadow.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healty_quizz/presentation/cari_quiz_page.dart';
import 'package:healty_quizz/presentation/pages/profil_page.dart';
import 'package:healty_quizz/presentation/pages/quiz/model/question_model.dart';
import 'package:healty_quizz/presentation/pages/quiz/test_page.dart';
import 'package:healty_quizz/presentation/pages/quiz/test_page_quiz_user.dart';
import 'package:healty_quizz/presentation/pages/splashscreen_page.dart';
import 'package:healty_quizz/themes/theme.dart';
import 'package:healty_quizz/widget/quiz_card.dart';
import 'package:http/http.dart' as http;

class HomeMain extends StatefulWidget {
  String id;
  String username;
  String score;
  String email;
  String level;
  String password;

  HomeMain({
    Key? key,
    required this.id,
    required this.username,
    required this.score,
    required this.email,
    required this.level,
    required this.password,
  }) : super(key: key);

  @override
  State<HomeMain> createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {
  late QuestionModel questionModel;
  List ListdataQuiz = [];
  List user = [];
  bool _isLoading = false;
  final TextEditingController _cariquiz = TextEditingController();

  void dispose() {
    super.dispose();
    _cariquiz.dispose();
  }

  Future<void> _registeradmin() async {
    String Url =
        "http://192.168.67.214/belajar/HiTech-hmti2024/frontend/HealtyQuizz-main/healty_quizz/lib/data/register_admin.php";
    final response = await http.post(Uri.parse(Url), body: {
      "username": widget.username,
      "id": widget.id,
    });

    if (response.statusCode == 200) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Selamt anda telah berhasil menjadi Admin"),
              content: Text("Ayo manfaatkan fitur admin dengan sebaik mungkin"),
            );
          });
    }
  }

  void _getAllDataBiologi(String username) async {
    final String Url =
        "https://script.googleusercontent.com/macros/echo?user_content_key=RcjKMKaINZ-dt9TW9nz2vQUxcT5misiR0E9IqXT_qnlXHCTktSglOT_yHTOeDMyBCZw4oDZEHKpXZQdDWUIz61cRvvhccldRm5_BxDlH2jW0nuo2oDemN9CCS2h10ox_1xSncGQajx_ryfhECjZEnK14ioERKJ6foQExf1tpoc--qUW6Y-tC5Y-SpXokcZnoPObxCHdFVsr_KXoE8N0xa7tfMd2IMigE5pMmS0HU2nyQucmmppdS_w&lib=MBhYIpOyECp2ihwhpyqSqK-5ZvmFWs76M";
    try {
      setState(() {
        _isLoading = true;
      });

      if(_isLoading == true){
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Tunggu Sebentar"),
                content: Text("Sedang Memuat Data"),
              );
            });
      }

      var response = await http.get(Uri.parse(Url));

      questionModel = QuestionModel.fromJson(json.decode(response.body));
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return Test(
          questionModel: questionModel,
          username: username,
          score: widget.score,
          id: widget.id,
          level: widget.level,
          email: widget.email,
          password: widget.password,
        );
      }));
    } catch (e) {
      print(e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget CatSection(screenWidth) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.black12, width: 2)),
        width: screenWidth.width * 0.2,
        // height: screenWidth.height * 0.1,
        child: Text(
          "Populer",
          style: GoogleFonts.poppins().copyWith(
              fontSize: 12, fontWeight: FontWeight.w500, color: blackColor),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenWidth = MediaQuery.of(context).size;
    return Center(
      child: ElevatedButton(
        onPressed: (){
          _getAllDataBiologi("...");
        },
        child: Text("mulai kuis")),
    );
  }
}
