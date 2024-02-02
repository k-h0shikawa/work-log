import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:work_log/product/presentation/pages/complete_product_list.dart';
import 'package:work_log/product/presentation/pages/in_progress_product_list.dart';
import 'package:work_log/work/presentation/pages/work_list.dart';

final goRouter = GoRouter(
  // アプリが起動した時
  initialLocation: '/work',

  routes: [
    // 作業入力画面
    GoRoute(
      path: '/work',
      name: 'work',
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: const WorkList(),
        );
      },
    ),
    // 商品一覧画面
    GoRoute(
      path: '/product',
      name: 'product',
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: const InProgressProductList(),
        );
      },
    ),
    // 完了済み商品一覧画面
    GoRoute(
      path: '/product/complete',
      name: 'product-complete',
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: const CompleteProductList(),
        );
      },
    ),
  ],

  errorPageBuilder: (context, state) => MaterialPage(
    key: state.pageKey,
    child: Scaffold(
      body: Center(
        child: Text(state.error.toString()),
      ),
    ),
  ),
);
