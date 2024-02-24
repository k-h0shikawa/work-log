import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:work_log/app/product/application/in_progress_product_list_usecase.dart';

// TODO: ページを複数枚作成できるようにする
class CreatePDFButton extends StatelessWidget {
  final int productId;
  const CreatePDFButton({required this.productId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        await createPDF();
      },
      child: const Text('PDF出力'),
    );
  }

  Future<void> createPDF() async {
    WidgetsFlutterBinding.ensureInitialized();
    final pdf = pw.Document();

    // 日本語対応フォント
    final font = await rootBundle.load("assets/NotoSansJP-Regular.ttf");
    final ttf = pw.Font.ttf(font);

    // 表の行数と列数を定義
    const int maxRowCount = 22;

    // 表のヘッダーを作成
    final headers = ['日付', '作業内容', '作業日時・他', '作業時間合計'];

    final headerRow = pw.TableRow(
        children: headers
            .map(
              (header) => pw.Padding(
                  padding: const pw.EdgeInsets.only(left: 5.0),
                  child: pw.Text(header,
                      style: pw.TextStyle(
                          font: ttf, fontWeight: pw.FontWeight.bold))),
            )
            .toList());

    // 表のボディを作成
    final body = List.generate(maxRowCount, (int index) {
      return pw.TableRow(children: [
        pw.Container(
          width: 50, // セルの幅を指定
          child: pw.Padding(
            padding: const pw.EdgeInsets.only(left: 5.0),
            child: pw.Text('1/1', style: pw.TextStyle(font: ttf)),
          ),
        ),
        pw.Container(
          width: 100, // セルの幅を指定
          child: pw.Padding(
            padding: const pw.EdgeInsets.only(left: 5.0),
            child: pw.Text('草むしり', style: pw.TextStyle(font: ttf)),
          ),
        ),
        pw.Container(
          width: 100, // セルの幅を指定
          child: pw.Padding(
            padding: const pw.EdgeInsets.only(left: 5.0),
            child: pw.Text('夜勤', style: pw.TextStyle(font: ttf)),
          ),
        ),
        pw.Container(
          width: 50, // セルの幅を指定
          child: pw.Padding(
            padding: const pw.EdgeInsets.only(left: 5.0),
            child: pw.Text('8h', style: pw.TextStyle(font: ttf)),
          ),
        ),
      ]);
    });

    // 表を作成
    final table =
        pw.Table(border: pw.TableBorder.all(), children: [headerRow, ...body]);

    final dailyWorkForPDF = await GetIt.I<InProgressProductListUsecase>()
        .fetchDailyWorkForPDF(productId);

    for (final dailyWork in dailyWorkForPDF) {
      print(dailyWork);
    }

    // PDFドキュメントに表を追加
    pdf.addPage(pw.Page(
      build: (pw.Context context) {
        return pw
            .Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
          pw.Container(
            // 長方形を作成
            width: context.page.pageFormat.availableWidth, // 長方形の幅を最大の2/3に設定
            height: 40.0, // 長方形の高さを3倍に設定
            decoration: pw.BoxDecoration(
              border: pw.Border.all(width: 1.0), // 長方形の枠線
            ),
            child: pw.Padding(
              padding: const pw.EdgeInsets.all(5), // 長方形内のパディング
              child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text('商品名 ぽしぇっと',
                        style:
                            pw.TextStyle(font: ttf, fontSize: 10)), // 長方形内のテキスト
                    pw.Text('クライアント（むちゃうま株式会社） 担当者名（うさぎ様） 担当者名（星川）',
                        style:
                            pw.TextStyle(font: ttf, fontSize: 10)), // 長方形内のテキスト
                  ]),
            ),
          ),
          pw.SizedBox(height: 10), // スペースを作成
          table,
          pw.SizedBox(height: 10), // スペースを作成
          pw.Text("外注点他の経費詳細", style: pw.TextStyle(font: ttf)),
          pw.Row(children: [
            pw.Container(
                // 長方形を作成
                width: context.page.pageFormat.availableWidth *
                    2 /
                    3, // 長方形の幅を最大の2/3に設定
                height: 220.0, // 長方形の高さを3倍に設定
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(width: 1.0), // 長方形の枠線
                )),
            pw.SizedBox(width: 10), // スペースを作成
            pw.Column(children: [
              pw.Container(
                  // 長方形を作成
                  width: context.page.pageFormat.availableWidth *
                      1 /
                      3, // 長方形の幅を最大の2/3に設定
                  height: 20.0, // 長方形の高さを3倍に設定
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(width: 1.0), // 長方形の枠線
                  ),
                  child: pw.Padding(
                      padding: const pw.EdgeInsets.only(left: 5.0),
                      child: pw.Text('合計作業時間 : 176h',
                          style: pw.TextStyle(font: ttf)))),
              pw.SizedBox(height: 10), // スペースを作成
              pw.Container(
                // 長方形を作成
                width: context.page.pageFormat.availableWidth *
                    1 /
                    3, // 長方形の幅を最大の2/3に設定
                height: 190.0, // 長方形の高さを3倍に設定
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(width: 1.0), // 長方形の枠線
                ),
                child: pw.Padding(
                  padding: const pw.EdgeInsets.all(5), // 長方形内のパディング
                  child: pw.Text('備考',
                      style: pw.TextStyle(font: ttf)), // 長方形内のテキスト
                ),
              )
            ])
          ])
        ]);
      },
    ));

    // PDFをバイトデータとして保存
    final bytes = await pdf.save();

    // ローカルのドキュメントディレクトリを取得
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/product.pdf');

    // ファイルにバイトデータを書き込み
    await file.writeAsBytes(bytes);
  }
}
