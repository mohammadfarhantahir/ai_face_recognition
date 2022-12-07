
import 'dart:convert';
import 'dart:math';

import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'mobile.dart' if (dart.library.html) 'web.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:io';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:ai_face/const/globals.dart' as globals;
//Local imports


import 'package:syncfusion_flutter_pdf/pdf.dart';

Random random = new Random();
String holdRanvalue='';




//Draws the grid
void drawGrid(PdfPage page, PdfLayoutResult result) {




}

//Draw the invoice footer data.
void drawFooter(PdfPage page, Size pageSize) {
  final PdfPen linePen =
  PdfPen(PdfColor(142, 170, 219), dashStyle: PdfDashStyle.custom);
  linePen.dashPattern = <double>[3, 3];
  //Draw line
  page.graphics.drawLine(linePen, Offset(0, pageSize.height - 100),
      Offset(pageSize.width, pageSize.height - 100));

  const String footerContent =
  // ignore: leading_newlines_in_multiline_strings
  '''NiGELLA SOFTWARES.\r\n\r\nCorp Office-301, 3rd Floor,
         Royal Square Tedhi Pulia\r\n\r\nAny Questions? support@nigellasoftwares.com''';

  //Added 30 as a margin for the layout
  page.graphics.drawString(
      footerContent, PdfStandardFont(PdfFontFamily.helvetica, 9),
      format: PdfStringFormat(alignment: PdfTextAlignment.right),
      bounds: Rect.fromLTWH(pageSize.width - 30, pageSize.height - 70, 0, 0));
}

Future<void> createPDF() async {
  PdfDocument document = PdfDocument();
  globals.idcardopeningstatus = true;
  final page = document.pages.add();
  final Size pageSize = page.getClientSize();
  page.graphics.drawString('SWIMS-BIO ID CARD SABAH STATE',
      PdfStandardFont(PdfFontFamily.helvetica, 30));

  page.graphics.drawImage(
      PdfBitmap(await _readImageData('card.png')),
      Rect.fromLTWH(0, 100, 550, 550));



  //Draw the header section by creating text element
  final PdfLayoutResult result =await drawHeader(page, pageSize);
  //Draw grid
 // drawGrid(page, result);

  //Add invoice footer
  drawFooter(page, pageSize);

  List<int> bytes =await document.save();


  saveAndLaunchFile(bytes, '$holdRanvalue.pdf');

  document.dispose();
}


Future<Uint8List> _readImageData(String name) async {
  final data = await rootBundle.load('assets/images/$name');
  return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
}


//Draws the invoice header
Future<PdfLayoutResult> drawHeader(PdfPage page, Size pageSize) async {

  //Draw rectangle
  page.graphics.drawRectangle(
      brush: PdfSolidBrush(PdfColor(91, 126, 215)),
      bounds: Rect.fromLTWH(0, 0, pageSize.width - 115, 90));
  //Draw string
  page.graphics.drawString(
      'SWIMS-BIO ID CARD', PdfStandardFont(PdfFontFamily.helvetica, 30),
      brush: PdfBrushes.white,
      bounds: Rect.fromLTWH(25, 0, pageSize.width - 115, 90),
      format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));

 // page.graphics.drawImage(
   //   PdfBitmap(await _readImageData('main.jpg')),
 // Rect.fromLTWH(360, 290, 100, 100));
  page.graphics.drawImage(
      PdfBitmap(await _readImageData('flagg.png')),
      Rect.fromLTWH(35, 220, 180, 100));
  page.graphics.drawImage(
      PdfBitmap(await _readImageData('sign.png')),
      Rect.fromLTWH(375, 420, 50, 50));

  page.graphics.drawImage(
      PdfBitmap(File(globals.filepaths).readAsBytesSync()),
      Rect.fromLTWH(360, 290, 100, 100));


  page.graphics.drawRectangle(
      bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 90),
      brush: PdfSolidBrush(PdfColor(65, 104, 205)));
  int randomNumber = random.nextInt(1000); // from 0 upto 990 included
  holdRanvalue = randomNumber.toString();
  page.graphics.drawString(r'ID Card No: '+holdRanvalue ,
      PdfStandardFont(PdfFontFamily.helvetica, 18),
      bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 100),
      brush: PdfBrushes.white,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.center,
          lineAlignment: PdfVerticalAlignment.middle));

  final PdfFont contentFont = PdfStandardFont(PdfFontFamily.helvetica, 15);
  //Draw string
  page.graphics.drawString(holdRanvalue, contentFont,
      brush: PdfBrushes.white,
      bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 33),
      format: PdfStringFormat(
          alignment: PdfTextAlignment.center,
          lineAlignment: PdfVerticalAlignment.bottom));
  //Create data foramt and convert it to text.
  final DateFormat format = DateFormat.yMMMMd('en_US');
  final String invoiceNumber =
      'Issuing Date: ${format.format(DateTime.now())}';
  final Size contentSize = contentFont.measureString(invoiceNumber);

   final String cardNumber =
    'Card No: ${holdRanvalue}';
    contentFont.measureString(invoiceNumber);
  final String authoritySignature =
      'Authority Signature';
 contentFont.measureString(authoritySignature);
  // ignore: leading_newlines_in_multiline_strings

   String address = '''First Name: '''+globals.scanFirstName+'\n\n\n'
       'Last Name: '+globals.scanLastName+'\n\n\n'+
       'Gender:'+globals.scanGender+'\n\n\n'+
       'Nationality: '+globals.scanNationality;

  PdfTextElement(text: invoiceNumber, font: PdfStandardFont(PdfFontFamily.helvetica, 18)).draw(
      page: page,
      bounds: Rect.fromLTWH(50, 480,
          300, 120));

  PdfTextElement(text: authoritySignature, font: PdfStandardFont(PdfFontFamily.helvetica, 18)).draw(
      page: page,
      bounds: Rect.fromLTWH(350, 480,
          300, 120));
  PdfTextElement(text: cardNumber, font: PdfStandardFont(PdfFontFamily.helvetica, 25)).draw(
      page: page,
      bounds: Rect.fromLTWH(40, 380,
          300, 120));


  return PdfTextElement(text: address, font: contentFont).draw(
      page: page,
      bounds: Rect.fromLTWH(200, 260,
          pageSize.width - (contentSize.width + 30), pageSize.height - 120))!;
}
