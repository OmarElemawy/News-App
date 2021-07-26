import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:news_app/shared/components/component.dart';
import 'package:news_app/shared/cubit/news_cubit.dart';
import 'package:news_app/shared/cubit/news_state.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
      listener: (cubit, state) {},
      builder: (cubit, state) {
        var list = NewsCubit
            .get(context)
            .search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyText1,
                  decoration: InputDecoration(
                      labelStyle: Theme
                          .of(context)
                          .textTheme
                          .subtitle1,
                      prefixIcon: const Icon(Icons.search, color: Colors.grey,),
                      labelText: "Search",
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      )
                  ),
                  validator: (value) {
                    if (value
                        .toString()
                        .isEmpty) {
                      return 'Search Must not by empty';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  onChanged: (value){
                    NewsCubit.get(context).getSearch(value);
                  },
                ),
              ),
              Expanded(
                child: Conditional.single(
                  context: context,
                  conditionBuilder: (BuildContext context) => list.isNotEmpty,
                  widgetBuilder: (BuildContext context) =>
                      ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) =>
                              buildItemList(list[index], context),
                          separatorBuilder: (context, index) => divideListView(),
                          itemCount: list.length),
                  fallbackBuilder: (BuildContext context) => const Center(
                      child: CircularProgressIndicator(
                        color: Colors.deepOrange,)),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
