import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/business/business_screen.dart';
import 'package:news_app/modules/health/health_screen.dart';
import 'package:news_app/modules/sports/sports_screen.dart';
import 'package:news_app/shared/cubit/news_state.dart';
import 'package:news_app/shared/netWork/local/cache_helper.dart';
import 'package:news_app/shared/netWork/remot/dio_helper.dart';

class NewsCubit extends Cubit<NewsState>{
  NewsCubit() : super(InitialNewsState());
  static NewsCubit get(context)=>BlocProvider.of(context);

  int currentIndex=0;
  List<BottomNavigationBarItem> bottomItems=[
    const BottomNavigationBarItem(icon: Icon(Icons.business),label: "Business"),
    const BottomNavigationBarItem(icon: Icon(Icons.health_and_safety),label: "Health"),
    const BottomNavigationBarItem(icon: Icon(Icons.sports),label: "Sports"),
  ];
  List<Widget> bodyScreens=[
    const BusinessScreen(),
    const HealthScreen(),
    const SportsScreen(),
  ];
  void changeBottomNavState(int index)
  {
    currentIndex=index;
    if(index==1)
      {
        getHealth();
      }
     if(index == 2)
        {
          getSports();
        }
    emit(BottomNevNewsState());
  }
  List<dynamic> business= [];
  void getBusiness ()
  {
    emit(GetDataLoadingNewsState());
    DioHelper.getData(url: "v2/top-headlines", query: {
          "country":"eg",
          "category":"business",
          "apiKey":"a1835b629e5d4d189ead989c673a5acb",
    }).then((value) {
      business =value.data["articles"];
      emit(GetBusinessNewsSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(GetBusinessNewsErrorState(error.toString()));

    });
  }
  List<dynamic> health= [];
  void getHealth ()
  {
    emit(GetHealthLoadingNewsState());
    if(health.isEmpty) {
      DioHelper.getData(url: "v2/top-headlines", query: {
        "country": "eg",
        "category": "health",
        "apiKey": "a1835b629e5d4d189ead989c673a5acb",
      }).then((value) {
        health = value.data["articles"];
        emit(GetHealthNewsSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(GetHealthNewsErrorState(error.toString()));
      });
    }else{
      emit(GetHealthNewsSuccessState());

    }
  }
  List<dynamic> sports= [];
  void getSports ()
  {
    emit(GetSportsLoadingNewsState());
    if(sports.isEmpty) {
      DioHelper.getData(url: "v2/top-headlines", query: {
        "country": "eg",
        "category": "sports",
        "apiKey": "a1835b629e5d4d189ead989c673a5acb",
      }).then((value) {
        sports = value.data["articles"];
        emit(GetSportsNewsSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(GetSportsNewsErrorState(error.toString()));
      });
    }else{
      emit(GetSportsNewsSuccessState());

    }
  }
  bool isDark=false;
  void changeModeApp({bool? fromShard})
  {
    if(fromShard != null) {
      isDark =fromShard;
    } else {
      isDark=!isDark;
    }
    CacheHelper.putBool(key: "isDark", value: isDark).then((value) {
      emit(ChangeModeAppNewsState());
    });
  }
  List<dynamic> search= [];
  void getSearch (value)
  {
    emit(GetSearchLoadingNewsState());

      DioHelper.getData(url: "v2/everything", query: {
        "q": "$value",
        "apiKey": "a1835b629e5d4d189ead989c673a5acb",
      }).then((value) {
        search = value.data["articles"];
        emit(GetSearchNewsSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(GetSearchNewsErrorState(error.toString()));
      });
  }
}