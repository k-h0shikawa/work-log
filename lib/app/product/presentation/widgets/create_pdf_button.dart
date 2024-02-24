import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:work_log/app/domain/entities/daily_work_for_pdf.dart';
import 'package:work_log/app/product/application/in_progress_product_list_usecase.dart';

class CreatePDFButton extends StatelessWidget {
  final int productId;

  const CreatePDFButton({required this.productId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    return ElevatedButton(
      onPressed: () async {
        // ボタン押下時にダイアログで入力を求める
        final result = await showDialog<Map<String, String>>(
          context: context,
          builder: (BuildContext context) {
            TextEditingController clientController = TextEditingController();
            TextEditingController clientPersonController =
                TextEditingController();
            TextEditingController supplierController = TextEditingController();
            TextEditingController supplierPersonController =
                TextEditingController();
            return AlertDialog(
              title: const Text('PDFの記載内容を入力してください'),
              content: Column(
                children: <Widget>[
                  TextField(
                    controller: clientController,
                    decoration: const InputDecoration(hintText: "クライアント名"),
                  ),
                  TextField(
                    controller: clientPersonController,
                    decoration: const InputDecoration(hintText: "クライアント担当者名"),
                  ),
                  TextField(
                    controller: supplierController,
                    decoration: const InputDecoration(hintText: "自社名"),
                  ),
                  TextField(
                    controller: supplierPersonController,
                    decoration: const InputDecoration(hintText: "自社担当者名"),
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('PDF作成'),
                  onPressed: () {
                    Navigator.of(context).pop({
                      'client': clientController.text,
                      'clientPerson': clientPersonController.text,
                      'supplier': supplierController.text,
                      'supplierPerson': supplierPersonController.text,
                    });
                  },
                ),
              ],
            );
          },
        );

        if (result != null) {
          final dailyWorkForPDF = await GetIt.I<InProgressProductListUsecase>()
              .fetchDailyWorkForPDF(productId);
          if (dailyWorkForPDF.isEmpty) {
            scaffoldMessenger.showSnackBar(
              const SnackBar(
                backgroundColor: Colors.red,
                content: Text('作業内容が存在しないので、PDFを作成できませんでした'),
              ),
            );
            return;
          }

          await createPDF(
              dailyWorkForPDF,
              result['client'] ?? '',
              result['clientPerson'] ?? '',
              result['supplier'] ?? '',
              result['supplierPerson'] ?? '');
        }

        scaffoldMessenger.showSnackBar(
          const SnackBar(
            backgroundColor: Colors.green,
            content: Text('PDFを作成しました'),
          ),
        );
      },
      child: const Text('PDF出力'),
    );
  }

  Future<void> createPDF(
      List<List<DailyWorkForPDF>> dailyWorkForPDF,
      String client,
      String clientPerson,
      String supplier,
      String supplierPerson) async {
    WidgetsFlutterBinding.ensureInitialized();
    final pdf = pw.Document();

    // 日本語対応フォント
    final font = await rootBundle.load("assets/NotoSansJP-Regular.ttf");
    final ttf = pw.Font.ttf(font);

    // 表の行数と列数を定義
    const int maxRowCount = 22;

    final productName = dailyWorkForPDF.first.first.productName;

    for (final dailyWork in dailyWorkForPDF) {
      // PDFドキュメントに表を追加
      pdf.addPage(createPage(dailyWork, productName, ttf, maxRowCount, client,
          clientPerson, supplier, supplierPerson));
    }

    // PDFをバイトデータとして保存
    final bytes = await pdf.save();

    // ローカルのドキュメントディレクトリを取得
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/product.pdf');

    // ファイルにバイトデータを書き込み
    await file.writeAsBytes(bytes);
  }

  pw.Page createPage(
      List<DailyWorkForPDF> dailyWork,
      String productName,
      pw.Font ttf,
      int maxRowCount,
      String client,
      String clientPerson,
      String supplier,
      String supplierPerson) {
    // 表のヘッダーを作成
    const headers = ['日付', '作業内容', '作業時間合計'];

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
      final formatter = DateFormat('MM/dd');
      final workDate = index < dailyWork.length
          ? formatter.format(dailyWork[index].workDate)
          : ''; // 日付を取得
      final workDetail = index < dailyWork.length
          ? dailyWork[index].workDetail
          : ''; // 作業内容を取得
      final workTime = index < dailyWork.length
          ? '${(dailyWork[index].workTimeByWorkDetail / 10).toStringAsFixed(1)}h'
          : ''; // 作業時間を取得

      return pw.TableRow(children: [
        pw.Container(
          width: 50, // セルの幅を指定
          height: 20, // 最小の高さを指定
          child: pw.Padding(
            padding: const pw.EdgeInsets.only(left: 5.0),
            child: pw.Text(workDate, style: pw.TextStyle(font: ttf)),
          ),
        ),
        pw.Container(
          width: 200, // セルの幅を指定
          height: 20, // 最小の高さを指定
          child: pw.Padding(
            padding: const pw.EdgeInsets.only(left: 5.0),
            child: pw.Text(workDetail, style: pw.TextStyle(font: ttf)),
          ),
        ),
        pw.Container(
          width: 50, // セルの幅を指定
          height: 20, // 最小の高さを指定

          child: pw.Padding(
            padding: const pw.EdgeInsets.only(left: 5.0),
            child: pw.Text(workTime, style: pw.TextStyle(font: ttf)),
          ),
        ),
      ]);
    });

    // 表を作成
    final table =
        pw.Table(border: pw.TableBorder.all(), children: [headerRow, ...body]);
    // workTimeByWorkDetailの合計を計算
    final workTimeSum = (dailyWork.map((e) => e.workTimeByWorkDetail).fold(0,
                (previousWorkTime, workTime) => previousWorkTime + workTime) /
            10)
        .toStringAsFixed(1);

    return pw.Page(
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
                    pw.Text('商品名 : $productName',
                        style:
                            pw.TextStyle(font: ttf, fontSize: 10)), // 長方形内のテキスト
                    pw.Text(
                        'クライアント（$client） 担当者（$clientPerson 様） $supplier 担当者（$supplierPerson）',
                        style:
                            pw.TextStyle(font: ttf, fontSize: 10)), // 長方形内のテキスト
                  ]),
            ),
          ),
          pw.SizedBox(height: 10), // スペースを作成
          table,
          pw.SizedBox(height: 10), // スペースを作成

          // 外注点他の経費詳細
          pw.Text("外注点他の経費詳細", style: pw.TextStyle(font: ttf)),
          pw.Row(children: [
            pw.Container(
                // 長方形を作成
                width: context.page.pageFormat.availableWidth *
                    2 /
                    3, // 長方形の幅を最大の2/3に設定
                height: 150.0, // 長方形の高さを3倍に設定
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(width: 1.0), // 長方形の枠線
                )),
            pw.SizedBox(width: 10), // スペースを作成

            pw.Column(children: [
              // 合計作業時間
              pw.Container(
                  // 長方形を作成
                  width: context.page.pageFormat.availableWidth *
                      1 /
                      3, // 長方形の幅を最大の1/3に設定
                  height: 20.0,
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(width: 1.0), // 長方形の枠線
                  ),
                  child: pw.Padding(
                      padding: const pw.EdgeInsets.only(left: 5.0),
                      child: pw.Text('合計作業時間 : $workTimeSum h',
                          style: pw.TextStyle(font: ttf)))),
              pw.SizedBox(height: 10), // スペースを作成

              // 備考
              pw.Container(
                // 長方形を作成
                width: context.page.pageFormat.availableWidth *
                    1 /
                    3, // 長方形の幅を最大の1/3に設定
                height: 120.0,
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
    );
  }
}
