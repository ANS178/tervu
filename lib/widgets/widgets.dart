import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget appBar(BuildContext context){
  return Text(
    'Tervu',
    style: GoogleFonts.dosis(textStyle: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500, fontSize: 50),)

  );
//  return RichText(
//    text: TextSpan(
//      style: TextStyle(fontSize: 22),
//      children: <TextSpan>[
//        TextSpan(
//          style: TextStyle(fontSize: 22,),
//          children:<TextSpan> [
//            TextSpan(text: "TERVU", style: TextStyle(fontWeight: FontWeight.w700, color : Colors.blue,))
//          ]
//        ),
//      ],
//    ),
//  );
}

Widget blueButton({BuildContext context, String label, buttonWidth}){
  return Container(
    padding: EdgeInsets.symmetric(vertical: 18),
    decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(30)
    ),
    alignment: Alignment.center,
    width: buttonWidth != null ? buttonWidth : MediaQuery.of(context).size.width-48,
    child: Text(label, style: TextStyle(color: Colors.white, fontSize: 16)),
  );


}