class ErrorMessages {
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
}
