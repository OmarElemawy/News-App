
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:news_app/shared/components/component.dart';
import 'package:news_app/shared/cubit/news_cubit.dart';
import 'package:news_app/shared/cubit/news_state.dart';

class HealthScreen extends StatelessWidget {
  const HealthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<NewsCubit,NewsState>(
        listener:(context,state){} ,
        builder:(context,state) {
          var list =NewsCubit.get(context).health;
          return Conditional.single(
            context: context,
            conditionBuilder: (BuildContext context) => list.isNotEmpty,
            widgetBuilder: (BuildContext context) => ListView.separated(
                physics:  const BouncingScrollPhysics(),
                itemBuilder: (context,index)=>buildItemList(list[index],context),
                separatorBuilder: (context,index)=>divideListView(), itemCount: list.length),
            fallbackBuilder: (BuildContext context) => const Center(child:  CircularProgressIndicator(color: Colors.deepOrange,)),
          );
        }
    );
  }
}
