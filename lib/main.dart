import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:veterinary_application/components/routes.dart';
import 'package:veterinary_application/pages/aboutus.dart';
import 'package:veterinary_application/pages/appointment_page.dart';
import 'package:veterinary_application/pages/authpage.dart';
import 'package:veterinary_application/pages/cart_page.dart';
import 'package:veterinary_application/pages/home_page.dart';
import 'package:veterinary_application/pages/payment_provider.dart';
import 'package:veterinary_application/pages/paymentpage.dart';
import 'package:veterinary_application/pages/profile_page.dart';
import 'package:veterinary_application/pages/sellpage.dart';
import 'package:veterinary_application/pages/services.dart';
import 'package:veterinary_application/pages/shop_page.dart';

import 'package:veterinary_application/widgets/themes.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PaymentProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Veterinary App',

        // for theme
        themeMode: ThemeMode.system,
        theme: MyThemes.LightTheme(context),
        darkTheme: MyThemes.DarkTheme(context),

        //for moving from one page to other
        initialRoute: MyRoutes.authroute,
        routes: {
          MyRoutes.authroute: (context) => const AuthPage(),
          MyRoutes.homeroute: (context) =>
              const HomePage(), // default route/page
          MyRoutes.shoproute: (context) => const ShopPage(),
          MyRoutes.cartroute: (context) => const CartPage(),
          MyRoutes.profileroute: (context) => const ProfilePage(),
          MyRoutes.mailroute: (context) => const MailPage(),
          MyRoutes.aboutusroute: (context) => AboutUsPage(),
          MyRoutes.servicesroute: (context) => const ServicesPage(),
          MyRoutes.paymentroute: (context) => const PaymentPage(),
          MyRoutes.sellroute: (context) => const SellPage(),
        },
      ),
    );
  }
}
