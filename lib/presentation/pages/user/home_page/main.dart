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


  void _getAllDataBiologi(String username) async {
    final String Url =
        "https://script.google.com/macros/s/AKfycbzXOh6i9GWvY0DflXhgsLPQ92mGNLnHd0tRcvFyeo3r4zZakE0JdchS2PcSqkUt9er3HQ/exec";
    try {
      setState(() {
        _isLoading = true;
      });

      if(_isLoading == true){
        showDialog(
            barrierDismissible: false,
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
