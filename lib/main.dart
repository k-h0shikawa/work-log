/*
import 'package:flutter/material.dart';

import 'presentation/router/app.dart';

void main() {
  runApp(MyApp());
}
*/
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final pdf = pw.Document();

  final font = await rootBundle.load("assets/OpenSans-Regular.ttf");
  final ttf = pw.Font.ttf(font);

  pdf.addPage(pw.Page(
    build: (pw.Context context) {
      return pw.Center(
        child: pw.Text('Dart is awesome',
            style: pw.TextStyle(font: ttf, fontSize: 40)),
      );
    },
  ));

  // PDFをバイトデータとして保存
  final bytes = await pdf.save();

  // ローカルのドキュメントディレクトリを取得
  final dir = await getApplicationDocumentsDirectory();
  print(dir);
  final file = File('${dir.path}/example.pdf');

  // ファイルにバイトデータを書き込み
  await file.writeAsBytes(bytes);
}
