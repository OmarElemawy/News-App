

import 'package:flutter/material.dart';
import 'package:news_app/modules/web_view/web_view_screen.dart';

Widget buildItemList(list,context) {
  String url="https://clubspark.lta.org.uk/Library/WadebridgeTennisClub?command=Proxy&lang=en&type=Images&currentFolder=%2F&hash=71a0d2f62c663503401b1a83d5c147cc9cf31101&fileName=Marketplace-Lending-News.jpg";
  if(list["urlToImage"]!=null)
        {
          url= list["urlToImage"];
        }
 return InkWell(
   onTap: (){
     Navigator.push(context, MaterialPageRoute(builder: (context)=>WebViewScreen(list["url"]) ));
   },
   child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 120,height: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image:  DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(url)
                )
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
          ),
          const SizedBox(width: 20,),
          Expanded(
            child: Container(
              height: 120,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: Text('${list["title"]}',
                    style:Theme.of(context).textTheme.bodyText1,maxLines: 3,overflow: TextOverflow.ellipsis,),),
                  Text('${list["publishedAt"]}',style:Theme.of(context).textTheme.bodyText2,)
                ],
              ),
            ),
          )

        ],
      ),
    ),
 );
}
Widget divideListView()=>Container(height: 1,width: double.infinity,color: Colors.grey,);