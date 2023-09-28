import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:music_player/Colors/colors.dart' as AppColors;

import '../Home-Battom-Tabs/my_tabs.dart';
import 'detail_audio_page.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {

  late List mahabharat = [];
  late List popularBooks = [];
  late List books = [];
  late ScrollController _scrollController;
  late TabController _tabController;

  ReadData() async {
    await DefaultAssetBundle.of(context).loadString("json/popularBooks.json").then((s){
      setState(() {
        popularBooks = json.decode(s);
      });
    });

    await DefaultAssetBundle.of(context).loadString("json/books.json").then((s){
      setState(() {
        books = json.decode(s);
      });
    });

    await DefaultAssetBundle.of(context).loadString("json/mahabharta.json").then((s){
      setState(() {
        mahabharat = json.decode(s);
      });
    });
  }


  @override
  void initState(){
    super.initState();
    _tabController =TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
    ReadData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.orangeAccent.withOpacity(0.2),
          body: Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ImageIcon(
                      AssetImage('assets/menu.png'),
                      size: 24,
                      color: Colors.orangeAccent,
                    ),
                    Row(

                      children: [
                        Icon(Icons.search , color: Colors.orangeAccent,),
                        SizedBox(width: 15,),
                        Icon(Icons.notifications_active, color: Colors.orangeAccent)
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20,),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only( left: 20),
                    child: const Text("EpicSaga Audio Books",
                      style: TextStyle(
                        fontSize: 30,
                          color: Colors.orangeAccent,
                        fontWeight: FontWeight.bold,
                        )
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20,),
              SizedBox(
                height: 180,
                child: Stack(
                  children: [
                    Positioned(
                        top: 0,
                        left: -20,
                        right: 0,
                        child: SizedBox(
                          height: 180,
                          child: PageView.builder(
                              controller: PageController(viewportFraction: 0.8),
                              itemCount: popularBooks.length,
                              itemBuilder: (_, i){
                                return Container(
                                  height: 180,
                                  width: MediaQuery.of(context).size.width,
                                  margin: const EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      image: DecorationImage(
                                          image: AssetImage(
                                              popularBooks[i]['img']
                                          ),
                                          fit: BoxFit.fill
                                      )
                                  ),
                                );
                              }
                          ),
                        )
                    )
                  ],
                  )
                ),
              Expanded(child: NestedScrollView(
               controller: _scrollController,
                headerSliverBuilder: (
                    BuildContext context, bool innerBoxIsScrolled) {
                       return [
                         SliverAppBar(
                           backgroundColor: Colors.orangeAccent.withOpacity(0.1),
                           pinned: false,
                           bottom: PreferredSize(
                             preferredSize: const Size.fromHeight(50),
                             child: Container(
                               margin: const EdgeInsets.only(bottom: 20, left: 10),
                               child: TabBar(
                                 indicatorPadding: const EdgeInsets.all(0),
                                 indicatorSize: TabBarIndicatorSize.label,
                                 tabs: [
                                   AppTabs(color: AppColors.menu1Color, text: 'Ramayan',),
                                   AppTabs(color: AppColors.menu2Color, text: 'Mahabharat',),
                                   AppTabs(color: AppColors.menu3Color, text: 'Krishna lila',),
                                 ],
                                 labelPadding: const EdgeInsets.only(right: 8),
                                 controller: _tabController,
                                 isScrollable: true,
                                 indicator: BoxDecoration(
                                   borderRadius: BorderRadius.circular(10),
                                   boxShadow: [
                                     BoxShadow(
                                       color: Colors.orangeAccent.withOpacity(0.5),
                                       blurRadius: 80,
                                       offset: const Offset(1, 1)
                                     )
                                   ]
                                 ),
                               ),
                             ),
                           ),
                         )
                       ];
                },
                body: TabBarView(
                  controller: _tabController,
                  children: [
                    ListView.builder(

                        itemCount: books.length,
                        itemBuilder: (_,i){
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(context,
                            MaterialPageRoute(builder: (context)=> DetailAudioPage(booksData: books, index:i))
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 20,right: 20, top: 10, bottom: 10),
                          child: Container(
                            decoration: BoxDecoration(

                                borderRadius: BorderRadius.circular(10),
                                color: Colors.orangeAccent.withOpacity(0.2),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      blurRadius: 2,
                                      offset: const Offset(0,0)
                                  )
                                ]
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                children: [
                                  Container(
                                    width: 90,
                                    height: 120,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                            image: AssetImage(books[i]["img"])
                                        )
                                    ),
                                  ),
                                  const SizedBox(width: 10,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.star, color: AppColors.starColor, size: 24,),
                                          const SizedBox(width: 5,),
                                          Text(books[i]["rating"],
                                            style: TextStyle(
                                                color: AppColors.menu2Color
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 5,),
                                      Text(books[i]["title"],
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontFamily: "Avenir",
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      const SizedBox(height: 5,),
                                      Text(books[i]["text"],
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: "Avenir",
                                            color: AppColors.subTitleText
                                        ),
                                      ),
                                      const SizedBox(height: 5,),
                                      Container(
                                        width: 65,
                                        height: 15,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(3),
                                          color: AppColors.loveColor,
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(books[i]["type"],
                                          style: const TextStyle(
                                            fontSize: 10,
                                            fontFamily: "Avenir",
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                    ListView.builder(
                        itemCount: books.length,
                        itemBuilder: (_,i){
                          return Container(
                            margin: const EdgeInsets.only(left: 20,right: 20, top: 10, bottom: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.orangeAccent.withOpacity(0.2),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        blurRadius: 2,
                                        offset: const Offset(0,0)
                                    )
                                  ]
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 90,
                                      height: 120,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          image: DecorationImage(
                                              image: AssetImage(mahabharat[i]["img"])
                                          )
                                      ),
                                    ),
                                    const SizedBox(width: 10,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.star, color: AppColors.starColor, size: 24,),
                                            const SizedBox(width: 5,),
                                            Text(mahabharat[i]["rating"],
                                              style: TextStyle(
                                                  color: AppColors.menu2Color
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(height: 5,),
                                        Text(mahabharat[i]["title"],
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontFamily: "Avenir",
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        const SizedBox(height: 5,),
                                        Text(mahabharat[i]["text"],
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: "Avenir",
                                              color: AppColors.subTitleText
                                          ),
                                        ),
                                        const SizedBox(height: 5,),
                                        Container(
                                          width: 65,
                                          height: 15,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(3),
                                            color: AppColors.loveColor,
                                          ),
                                          alignment: Alignment.center,
                                          child: Text(mahabharat[i]["type"],
                                            style: const TextStyle(
                                              fontSize: 10,
                                              fontFamily: "Avenir",
                                              color: Colors.white,
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                    ListView.builder(
                        itemCount: books.length,
                        itemBuilder: (_,i){
                          return Container(
                            margin: const EdgeInsets.only(left: 20,right: 20, top: 10, bottom: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.tabVarViewColor,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        blurRadius: 2,
                                        offset: const Offset(0,0)
                                    )
                                  ]
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 90,
                                      height: 120,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          image: DecorationImage(
                                              image: AssetImage(books[i]["img"])
                                          )
                                      ),
                                    ),
                                    const SizedBox(width: 10,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.star, color: AppColors.starColor, size: 24,),
                                            const SizedBox(width: 5,),
                                            Text(books[i]["rating"],
                                              style: TextStyle(
                                                  color: AppColors.menu2Color
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(height: 5,),
                                        Text(books[i]["title"],
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontFamily: "Avenir",
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        const SizedBox(height: 5,),
                                        Text(books[i]["text"],
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: "Avenir",
                                              color: AppColors.subTitleText
                                          ),
                                        ),
                                        const SizedBox(height: 5,),
                                        Container(
                                          width: 65,
                                          height: 15,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(3),
                                            color: AppColors.loveColor,
                                          ),
                                          alignment: Alignment.center,
                                          child: Text(books[i]["type"],
                                            style: const TextStyle(
                                              fontSize: 10,
                                              fontFamily: "Avenir",
                                              color: Colors.white,
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ],
                ),

              )
              )
            ],
          ),
        ),
      ),
    );
  }
}
