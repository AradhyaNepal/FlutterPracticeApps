import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:video_algorithm/common/class/database.dart';
import 'package:video_algorithm/common/class/go_back_alert_widget.dart';
import 'package:video_algorithm/common/color.dart';
import 'package:video_algorithm/screens/edit_video/add_video.dart';
import 'package:video_algorithm/screens/edit_video/edit_video.dart';
import 'package:video_algorithm/screens/edit_video/play_specific_video.dart';
import 'package:video_algorithm/screens/edit_video/provider/add_video_provider.dart';
import 'package:video_algorithm/screens/edit_video/video_timeframe.dart';
import 'package:video_algorithm/screens/edit_video/videos_list.dart';
import 'package:video_algorithm/screens/home_page/home_page.dart';
import 'package:video_algorithm/screens/home_page/splash_page.dart';
import 'package:video_algorithm/screens/play_video/play_algorithm_video.dart';
import 'package:video_algorithm/screens/play_video/provider/algorithm_video_provider.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: ColorConstant.kSecondaryColor, // navigation bar color
    statusBarColor:  ColorConstant.kSecondaryColor.withOpacity(0.8), // status bar color
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<VideosDatabase>(create: (context)=>VideosDatabase()),
        ChangeNotifierProxyProvider<VideosDatabase,AlgorithmVideoProvider>(//AlgorithmVideoProvider is dependent on VideosDatabase
          create: (context){
            VideosDatabase videosDatabase=Provider.of<VideosDatabase>(context,listen: false);
            return AlgorithmVideoProvider(videosDatabase: videosDatabase);
          },
          update: (context,updatedDatabase,previousVideo){
            return AlgorithmVideoProvider(videosDatabase: updatedDatabase);
          },
        ),
      ],
      child: MaterialApp(
        title: 'Video Algorithm',
        theme: ThemeData(
          colorScheme: const ColorScheme.light().copyWith(primary:ColorConstant.kSecondaryColor,secondary: ColorConstant.kPrimaryColor),
        ),
        initialRoute: SplashPage.route,
        routes: {
          SplashPage.route:(context)=>const SplashPage(),
          HomePage.route:(context)=>const HomePage(),
          VideosList.route:(context)=>const VideosList(),
          AddVideoPage.route:(context)=> AddVideoPage(),
          EditVideo.route:(context)=> const EditVideo(),
          PlaySpecificVideo.route:(context)=> const PlaySpecificVideo(),
          VideoTimeFrameSetting.route:(context)=> VideoTimeFrameSetting(),
          PlayAlgorithmVideo.route:(context)=>const PlayAlgorithmVideo()
        },
      ),
    );
  }
}
