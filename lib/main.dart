import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tentwenty_test/helpers/app_colors.dart';
import 'package:tentwenty_test/providers/movie_provider.dart';
import 'package:tentwenty_test/providers/search_provider.dart';
import 'package:tentwenty_test/views/dashboard/home_screen.dart';
import 'package:tentwenty_test/views/dashboard/seat%20selection/movie_booking_screen.dart';
import 'package:tentwenty_test/views/dashboard/watch%20section/components/watch%20details%20/watch_details_screen.dart';
import 'package:tentwenty_test/views/dashboard/watch section/watch_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MovieProvider>(create: (_) => MovieProvider()),
        ChangeNotifierProvider<SearchProvider>(create: (_) => SearchProvider()),
      ],
      child: ResponsiveSizer(builder: (context, orientation, screenType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'TenTwenty Test',
          theme: ThemeData(
            textTheme: GoogleFonts.poppinsTextTheme(),
            colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
            useMaterial3: true,
          ),
          home: const HomeScreen(),
        );
      }),
    );
  }
}
