import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_layout/news.dart';
import 'package:news_app/shared/cubit/news_cubit.dart';
import 'package:news_app/shared/cubit/news_state.dart';
import 'package:news_app/shared/netWork/local/cache_helper.dart';
import 'package:news_app/shared/netWork/remot/dio_helper.dart';
import 'package:news_app/shared/styles/thems.dart';

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
                  theme: themeLight(),
                  darkTheme:themeDark(),
                  themeMode:NewsCubit.get(context).isDark ? ThemeMode.dark:ThemeMode.light,
                  home: const NewsLayout(),
                );
              }
          )
    );
  }
}

