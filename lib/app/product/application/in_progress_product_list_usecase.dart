import 'package:logger/logger.dart';
import 'package:work_log/app/domain/config/product_config.dart';
import 'package:work_log/app/domain/config/product_pdf_config.dart';
import 'package:work_log/app/domain/entities/daily_work_for_pdf.dart';
import 'package:work_log/app/domain/entities/in_progress_product.dart';
import 'package:work_log/app/domain/log/messages.dart';
import 'package:work_log/setup/database/entities/product_entity.dart';
import 'package:work_log/app/product/infrastructure/in_progress_product_list_repository.dart';

class InProgressProductListUsecase {
  final _logger = Logger();
  final InProgressProductListRepository _repository;

  InProgressProductListUsecase(this._repository);

  Future<List<InProgressProduct>> fetchInProgressProductList() async {
    try {
      final inProgressProductEntities =
          await _repository.fetchInProgressProductList();

      return inProgressProductEntities
          .map((entity) => InProgressProduct(
              id: entity.id,
              productName: entity.productName,
              isCompleted: entity.isCompleted,
              createdOn: entity.createdOn != null
                  ? DateTime.parse(entity.createdOn!)
                  : null,
              createdBy: entity.createdBy))
          .toList();
    } catch (e) {
      _logger.e(e);
      rethrow;
    }
  }

  Future<List<InProgressProduct>> finishProduct(int? id) async {
    if (id == null) {
      _logger.e('id is null');
      throw ArgumentError.notNull('id');
    }
    try {
      await _repository.finishProduct(id: id);
      return fetchInProgressProductList();
    } catch (e) {
      _logger.e(e);
      rethrow;
    }
  }

  Future<List<InProgressProduct>> insertProduct(
      InProgressProduct product) async {
    try {
      await _repository.insertProduct(ProductEntity(
          id: product.id,
          productName: product.productName,
          isCompleted: product.isCompleted,
          createdOn: product.createdOn.toString(),
          createdBy: product.createdBy));

      return fetchInProgressProductList();
    } catch (e) {
      _logger.e(e);
      rethrow;
    }
  }

  Future<List<List<DailyWorkForPDF>>> fetchDailyWorkForPDF(
      int productId) async {
    try {
      final dailyWorkForPDF = await _repository.fetchDailyWorkForPDF(productId);

      // dailyWorkForPDFがnullの場合は空のリストを返す
      if (dailyWorkForPDF.isEmpty) {
        return [];
      }

      const int maxSizePerPdfPage =
          ProductPdfConfig.maxWorkRow; // 1つのPDFページに収まる要素数。

      // dailyWOrkForDPFを1ページあたりの要素数で分割する
      final dividedDailyWorkForPDF = <List<DailyWorkForPDF>>[];
      for (var i = 0; i < dailyWorkForPDF.length; i += maxSizePerPdfPage) {
        dividedDailyWorkForPDF.add(dailyWorkForPDF.sublist(
            i,
            i + maxSizePerPdfPage > dailyWorkForPDF.length
                ? dailyWorkForPDF.length
                : i + maxSizePerPdfPage));
      }

      return dividedDailyWorkForPDF;
    } catch (e) {
      _logger.e(e);
      rethrow;
    }
  }

  Future<bool> isDuplicated(String productName) async {
    try {
      return _repository.isDuplicated(productName);
    } catch (e) {
      _logger.e(e);
      rethrow;
    }
  }

  Future<String> validateProductName(String productName) async {
    try {
      if (productName.isEmpty) {
        return Messages.failureProductNameEmpty;
      }
      if (productName.length >= ProductConfig.nameLength) {
        return Messages.failureProductNameLength;
      }
      if (await _repository.isDuplicated(productName)) {
        return Messages.failureDuplicatedProduct;
      }
      return '';
    } catch (e) {
      _logger.e(e);
      rethrow;
    }
  }

  String validatePDFForm(String client, String clientPerson, String supplier,
      String supplierPerson) {
    if (client.length > 20) {
      return Messages.failureClientNameLength;
    }
    if (clientPerson.length > 20) {
      return Messages.failureClientPersonNameLength;
    }
    if (supplier.length > 20) {
      return Messages.failureSupplierNameLength;
    }
    if (supplierPerson.length > 20) {
      return Messages.failureSupplierPersonNameLength;
    }
    return '';
  }
}
