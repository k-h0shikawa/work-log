class Messages {
  static const String failureUpdate = 'データの更新に失敗しました';
  static const String failureFetch = 'データの取得に失敗しました';
  static String successConvertProductToInProgress(String productName) {
    return '$productName のステータスを進行中に変更しました';
  }

  static String successConvertProductToComplete(String productName) {
    return '$productName のステータスを完了に変更しました';
  }

  static String successRegisterProduct(String productName) {
    return '$productName の登録に成功しました';
  }

  static const String successRegisterWork = '業務の登録に成功しました';

  // 商品名のバリデーションメッセージ
  static const String failureDuplicatedProduct = 'すでに登録されている商品名です';
  static const String failureProductNameLength = '商品名は20文字以内で入力してください';
  static const String failureProductNameEmpty = '商品名を入力してください';

  // PDFフォームのバリデーションメッセージ
  static const String failureClientNameLength = 'クライアント名は20文字以内で入力してください';
  static const String failureClientPersonNameLength =
      'クライアント担当者名は10文字以内で入力してください';
  static const String failureSupplierNameLength = 'サプライヤー名は20文字以内で入力してください';
  static const String failureSupplierPersonNameLength =
      'サプライヤー担当者名は10文字以内で入力してください';
}
