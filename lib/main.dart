import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_layout/news.dart';
import 'package:news_app/shared/cubit/news_cubit.dart';
import 'package:news_app/shared/cubit/news_state.dart';
import 'package:news_app/shared/netWork/local/cache_helper.dart';
import 'package:news_app/shared/netWork/remot/dio_helper.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer= BlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getBool(key: "isDark");
  runApp( MyApp(isDark));
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  MyApp(this.isDark);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
          providers: [
        BlocProvider(
        create: (BuildContext context) =>
        NewsCubit()..getBusiness()..changeModeApp(
        fromShard: isDark
          ),
        )
        ],
          child: BlocConsumer<NewsCubit, NewsState>(
              listener: (context, state) {},
              builder: (context, state) {
                var cubit = NewsCubit.get(context);
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData(
                    iconTheme: const IconThemeData(
                      color: Colors.black
                  ),
                    scaffoldBackgroundColor: Colors.white,
                    appBarTheme: const AppBarTheme(
                        backwardsCompatibility: false,
                        systemOverlayStyle: SystemUiOverlayStyle(
                          statusBarColor: Colors.white,
                          statusBarIconBrightness: Brightness.dark,
                        ),
                        iconTheme:  IconThemeData(
                            color: Colors.black
                        ),
                        color: Colors.white,
                        elevation: 0.0,
                        titleTextStyle: TextStyle(color: Colors.black87,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)
                    ),
                    textTheme: const TextTheme(
                    bodyText1: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                      fontWeight: FontWeight.bold
                     ),
                      bodyText2: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                      subtitle1: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),bottomNavigationBarTheme:  const BottomNavigationBarThemeData(
                      type:BottomNavigationBarType.fixed,
                      selectedItemColor: Colors.deepOrange,
                      elevation: 20,
                      backgroundColor: Colors.white,
                      unselectedItemColor: Colors.grey
                  ),
                  ),
                  darkTheme:  ThemeData(
                    primaryColor: Colors.white,
                    scaffoldBackgroundColor: Colors.grey.withOpacity(.1),
                    appBarTheme:   AppBarTheme(
                        backwardsCompatibility: false,
                        systemOverlayStyle: const SystemUiOverlayStyle(
                          statusBarColor: Colors.black54,
                          statusBarIconBrightness: Brightness.light,
                        ),
                        color: Colors.grey.withOpacity(.1),
                        elevation: 0.0,
                        iconTheme: const IconThemeData(
                          color: Colors.white
                        ),
                        titleTextStyle: const TextStyle(color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)
                    ),
                    bottomNavigationBarTheme:
                    BottomNavigationBarThemeData(
                      type:BottomNavigationBarType.fixed,
                      selectedItemColor: Colors.deepOrange,
                      elevation: 20,
                      backgroundColor: Colors.grey.withOpacity(.1),
                      unselectedItemColor: Colors.grey
                    ),
                    textTheme: const TextTheme(
                      bodyText1: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      bodyText2: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                      subtitle1: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                      iconTheme: const
                      IconThemeData(
                      color: Colors.white,opacity: 1
                  )
                  ),
                  themeMode:NewsCubit.get(context).isDark ? ThemeMode.dark:ThemeMode.light,
                  home: const NewsLayout(),
                );
              }
          )
    );
  }
}

