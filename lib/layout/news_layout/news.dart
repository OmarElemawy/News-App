
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/search/search_screen.dart';
import 'package:news_app/shared/cubit/news_cubit.dart';
import 'package:news_app/shared/cubit/news_state.dart';
class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsState>(
         listener: (context,state){},
         builder: (context,state){
           var cubit=NewsCubit.get(context);
           return Scaffold(
             appBar: AppBar(
               title: const Text("News App"),
               actions: [
                 IconButton(onPressed: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>const SearchScreen()));
                 }, icon: const Icon(Icons.search,)),
                 IconButton(onPressed: (){
                   NewsCubit.get(context).changeModeApp();
                 }, icon: const Icon(Icons.brightness_4_outlined,))
               ],
             ),
             bottomNavigationBar: BottomNavigationBar(
               items: cubit.bottomItems,
               currentIndex: cubit.currentIndex,
             onTap: (index){
               cubit.changeBottomNavState(index);
             },),
             body: cubit.bodyScreens[cubit.currentIndex],
            );
            },
    );
  }
}
