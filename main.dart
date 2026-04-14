import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:giaydep_app/utils/common_func.dart';
import 'package:giaydep_app/utils/notification_controller.dart';
import 'package:giaydep_app/view/splash_screen/splash_screen.dart';
import 'package:giaydep_app/viewmodel/auth_viewmodel.dart';
import 'package:giaydep_app/viewmodel/order_viewmodel.dart';
import 'package:giaydep_app/viewmodel/post_viewmodel.dart';
import 'package:giaydep_app/viewmodel/product_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

// 🔥 THÊM DÒNG NÀY ĐỂ DÙNG THEME TỐI
import 'package:giaydep_app/theme/app_theme.dart';

GlobalKey<NavigatorState> navigationKey = GlobalKey();

final formatCurrency = NumberFormat.currency(
  locale: 'vi',
  decimalDigits: 0,
  symbol: 'đ',
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationController.initializeLocalNotifications(debug: true);
  await NotificationController.initializeRemoteNotifications(debug: true);

  // Thanh status bar + navigation bar hơi tối, icon sáng cho hợp theme
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Color(0xFF1C1C1E),
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: Color(0xFF1C1C1E),
    systemNavigationBarIconBrightness: Brightness.light,
  ));

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => ProductViewModel()),
        ChangeNotifierProvider(create: (_) => PostViewModel()),
        ChangeNotifierProvider(create: (_) => OrderViewModel()),
      ],
      child: const MyApp(),
    ),
  );

  CommonFunc.configLoading();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigationKey,
      debugShowCheckedModeBanner: false,

      // 🎨 DÙNG THEME TỐI CHO TOÀN APP
      theme: AppTheme.darkMenTheme,

      home: SplashScreen(),
      builder: EasyLoading.init(),
    );
  }
}
