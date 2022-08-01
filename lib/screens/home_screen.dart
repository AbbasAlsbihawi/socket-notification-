import 'package:animate_do/animate_do.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:e_shopping/utils/universal_variables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreens extends StatefulWidget {
  const HomeScreens({Key? key}) : super(key: key);

  @override
  _HomeScreensState createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> {
  PageController _pageController = PageController();
  int _page = 0;
  // UserProvider _userProvider ;
  @override
  void initState() {
    super.initState();

    //  SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
    //    _userProvider=Provider.of<UserProvider>(context,listen: false);
    //    _userProvider.refreshUser();
    //  });
    _pageController = PageController();
  }

  void onPageChanged(int value) {
    setState(() {
      _page = value;
    });
  }

  void navigateTapped(int value) {
    _pageController.jumpToPage(value);
  }

  @override
  Widget build(BuildContext context) {
    var we = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: UniversalVariables.blackColor,
      body: PageView(
        controller: _pageController,
        onPageChanged: onPageChanged,
        children: [
          Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              child: SizedBox(
                width: we,
                height: he,
                child: Column(
                  children: [
                    SizedBox(
                      height: he * 0.03,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: we * 0.38),
                      child: FadeInLeft(
                        delay: const Duration(milliseconds: 550),
                        child: const Text(
                          "Explore new \nrelease movies..",
                          // style: GoogleFonts.lato(
                          //     color: Colors.white, fontSize: 30)
                        ),
                      ),
                    ),
                    SizedBox(
                      height: he * 0.04,
                    ),
                    SizedBox(
                      // width: we * 0.9,
                      height: he * 0.35,
                      child: Stack(
                        children: [
                          Swiper(
                            itemBuilder: (BuildContext context, int index) {
                              return Image.network(
                                "https://via.placeholder.com/350x150",
                                fit: BoxFit.fill,
                              );
                            },
                            itemCount: 3,
                            pagination: const SwiperPagination(),
                            control: const SwiperControl(),
                          ),
                          // Swiper(
                          //     physics: const BouncingScrollPhysics(),
                          //     itemCount: 2,
                          //     scrollDirection: Axis.horizontal,
                          //     viewportFraction: 0.8,
                          //     scale: 0.85,
                          //     layout: SwiperLayout.DEFAULT,
                          //     itemBuilder: (c, i) {
                          //       return BounceInDown(
                          //         child: Card(
                          //           color: const Color(0xff202032),
                          //           shape: RoundedRectangleBorder(
                          //               borderRadius:
                          //                   BorderRadius.circular(32)),
                          //           child: Container(
                          //               decoration: BoxDecoration(
                          //                   borderRadius:
                          //                       BorderRadius.circular(40),
                          //                   image: DecorationImage(
                          //                       fit: BoxFit.cover,
                          //                       image: NetworkImage(
                          //                           movies[i]
                          //                               .fullImageUrl))),
                          //               child: Center(
                          //                 child: Padding(
                          //                   padding: EdgeInsets.only(
                          //                       top: he * 0.133),
                          //                   child: ClipRRect(
                          //                     borderRadius:
                          //                         BorderRadius.circular(32),
                          //                     child: ClipPath(
                          //                       clipper: RPSCustomPainter(),
                          //                       child: BackdropFilter(
                          //                         filter: ImageFilter.blur(
                          //                             sigmaX: 10,
                          //                             sigmaY: 10),
                          //                         child: Container(
                          //                           width: we * 0.8,
                          //                           // alignment: Alignment.center,
                          //                           height: 170,
                          //                           decoration: BoxDecoration(
                          //                               color: Colors.black
                          //                                   .withOpacity(
                          //                                       0.3),
                          //                               borderRadius:
                          //                                   const BorderRadius
                          //                                           .all(
                          //                                       Radius.circular(
                          //                                           20))),
                          //                           child: Stack(
                          //                             children: [
                          //                               Padding(
                          //                                 padding:
                          //                                     const EdgeInsets
                          //                                             .only(
                          //                                         left: 20,
                          //                                         top: 50),
                          //                                 child: Row(
                          //                                   children: [
                          //                                     Expanded(
                          //                                       child: Text(
                          //                                           movies[i]
                          //                                               .title,
                          //                                           style: GoogleFonts.lato(
                          //                                               fontSize: movies[i].title.length >= 21
                          //                                                   ? 13
                          //                                                   : 18,
                          //                                               fontWeight:
                          //                                                   FontWeight.bold,
                          //                                               color: Colors.white)),
                          //                                     ),
                          //                                     Expanded(
                          //                                       child:
                          //                                           SizedBox(
                          //                                         width: we *
                          //                                             0.25,
                          //                                       ),
                          //                                     ),
                          //                                     Text(
                          //                                       movies[i]
                          //                                           .vote_average
                          //                                           .toString(),
                          //                                       style: const TextStyle(
                          //                                           color: Colors
                          //                                               .yellow),
                          //                                     ),
                          //                                     const Icon(
                          //                                       Icons
                          //                                           .star_outline,
                          //                                       color: Colors
                          //                                           .yellow,
                          //                                     ),
                          //                                     SizedBox(
                          //                                         width: we *
                          //                                             0.09)
                          //                                   ],
                          //                                 ),
                          //                               ),
                          //                               SizedBox(
                          //                                 height: he * 0.02,
                          //                               ),
                          //                               Container(
                          //                                   width: 55,
                          //                                   height: 55,
                          //                                   margin: EdgeInsets
                          //                                       .only(
                          //                                           top: he *
                          //                                               0.12,
                          //                                           left: we *
                          //                                               .6),
                          //                                   decoration: const BoxDecoration(
                          //                                       color: Color(
                          //                                           0xFF733FF1),
                          //                                       shape: BoxShape
                          //                                           .circle),
                          //                                   child:
                          //                                       IconButton(
                          //                                     onPressed:
                          //                                         () {
                          //                                       Navigator.push(
                          //                                           context,
                          //                                           PageTransition(
                          //                                               child:
                          //                                                   DetailsPage(movie: movies[i]),
                          //                                               type: PageTransitionType.fade));
                          //                                     },
                          //                                     icon:
                          //                                         const Icon(
                          //                                       Icons
                          //                                           .play_arrow,
                          //                                       color: Colors
                          //                                           .white,
                          //                                       size: 30,
                          //                                     ),
                          //                                   )),
                          //                               const Padding(
                          //                                 padding: EdgeInsets
                          //                                     .only(
                          //                                         top: 120,
                          //                                         left: 20),
                          //                                 child:
                          //                                     CircleAvatar(
                          //                                   radius: 16,
                          //                                   backgroundImage:
                          //                                       NetworkImage(
                          //                                           "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSNOzRGW1KgfkefLAR8TIk5KkXO5wmFOesHQhA49mrGodPT8JwK"),
                          //                                 ),
                          //                               ),
                          //                               const Padding(
                          //                                 padding: EdgeInsets
                          //                                     .only(
                          //                                         top: 120,
                          //                                         left: 40),
                          //                                 child:
                          //                                     CircleAvatar(
                          //                                   backgroundImage:
                          //                                       NetworkImage(
                          //                                     "https://m.media-amazon.com/images/M/MV5BYWViYWU1MjQtZmYwMy00ZjUyLTkyYzgtMmZhMmUwNDU0ZTI4XkEyXkFqcGdeQXVyNDAzNDk0MTQ@._V1_.jpg",
                          //                                   ),
                          //                                   radius: 16,
                          //                                 ),
                          //                               ),
                          //                               const Padding(
                          //                                 padding: EdgeInsets
                          //                                     .only(
                          //                                         top: 120,
                          //                                         left: 60),
                          //                                 child:
                          //                                     CircleAvatar(
                          //                                   backgroundImage:
                          //                                       NetworkImage(
                          //                                           "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4b/Benedict_Cumberbatch_SDCC_2014.jpg/1200px-Benedict_Cumberbatch_SDCC_2014.jpg"),
                          //                                   radius: 16,
                          //                                 ),
                          //                               ),
                          //                               const Padding(
                          //                                 padding: EdgeInsets
                          //                                     .only(
                          //                                         top: 120,
                          //                                         left: 80),
                          //                                 child:
                          //                                     CircleAvatar(
                          //                                   radius: 16,
                          //                                   backgroundImage:
                          //                                       NetworkImage(
                          //                                           "https://upload.wikimedia.org/wikipedia/commons/4/46/Johnny_Depp_%28July_2009%29_2_cropped.jpg?20210809165401"),
                          //                                 ),
                          //                               ),
                          //                               const Padding(
                          //                                   padding: EdgeInsets
                          //                                       .only(
                          //                                           top:
                          //                                               130,
                          //                                           left:
                          //                                               120),
                          //                                   child: Text(
                          //                                     "20 + cast",
                          //                                     style: TextStyle(
                          //                                         color: Colors
                          //                                             .grey),
                          //                                   )),
                          //                             ],
                          //                           ),
                          //                         ),
                          //                       ),
                          //                     ),
                          //                   ),
                          //                 ),
                          //               )),
                          //         ),
                          //       );
                          //     }),
                        ],
                      ),
                    ),
                    // Expanded(
                    //   child: SizedBox(
                    //     height: he * .1,
                    //   ),
                    // ),
                    // Padding(
                    //   padding: EdgeInsets.only(right: we * 0.4),
                    //   child: Text("Continue Watching",
                    //       style: GoogleFonts.lato(
                    //           fontSize: 18,
                    //           color: Colors.white,
                    //           fontWeight: FontWeight.bold)),
                    // ),
                    // SizedBox(
                    //   height: he * 0.02,
                    // ),
                    // SizedBox(
                    //   width: we * 1,
                    //   height: he * 0.12,
                    //   child: ListView.builder(
                    //     physics: const BouncingScrollPhysics(),
                    //     itemBuilder: (c, i) {
                    //       return FadeInRight(
                    //         delay: const Duration(milliseconds: 700),
                    //         child: Container(
                    //           margin: const EdgeInsets.only(left: 30),
                    //           width: we * 0.63,
                    //           height: he * 0.3,
                    //           alignment: Alignment.center,
                    //           decoration: BoxDecoration(
                    //               borderRadius: BorderRadius.circular(20),
                    //               color: const Color(0xff202032)),
                    //           child: Row(
                    //             mainAxisAlignment: MainAxisAlignment.center,
                    //             children: [
                    //               Container(
                    //                 width: 80,
                    //                 height: 80,
                    //                 decoration: BoxDecoration(
                    //                     borderRadius:
                    //                         BorderRadius.circular(20)),
                    //                 child: Image.network(
                    //                     movies[i + 9].fullImageUrl),
                    //               ),
                    //               Column(
                    //                 mainAxisAlignment: MainAxisAlignment.center,
                    //                 crossAxisAlignment:
                    //                     CrossAxisAlignment.start,
                    //                 children: [
                    //                   Text(movies[i + 9].title,
                    //                       style: TextStyle(
                    //                           color: Colors.white,
                    //                           fontSize:
                    //                               movies[i + 6].title.length >=
                    //                                       19
                    //                                   ? 10
                    //                                   : 13)),
                    //                   const SizedBox(
                    //                     height: 12,
                    //                   ),
                    //                   Text(movies[i].original_language,
                    //                       style: const TextStyle(
                    //                           color: Colors.grey)),
                    //                 ],
                    //               ),
                    //               Expanded(
                    //                 child: SizedBox(
                    //                   width: we * 0.06,
                    //                 ),
                    //               ),
                    //               Container(
                    //                 width: 50,
                    //                 height: 50,
                    //                 decoration: const BoxDecoration(
                    //                     color: Color(0xFF733FF1),
                    //                     shape: BoxShape.circle),
                    //                 child: const Icon(
                    //                   Icons.play_arrow,
                    //                   color: Colors.white,
                    //                   size: 30,
                    //                 ),
                    //               ),
                    //               SizedBox(
                    //                 width: we * 0.02,
                    //               )
                    //             ],
                    //           ),
                    //         ),
                    //       );
                    //     },
                    //     scrollDirection: Axis.horizontal,
                    //     itemCount: 5,
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: he * 0.02,
                    // ),
                    // const BottomNa(),
                    // SizedBox(
                    //     height: MediaQuery.of(context).size.height >= 845
                    //         ? he * 0.12
                    //         : he * 0.15)
                  ],
                ),
              ),
            ),
          ),
          const Center(child: Text("Call Logs Screen")),
          const Center(child: Text("Contact Screen")),
          const Center(child: Text("Call Logs Screen")),
          const Center(child: Text("Contact Screen")),
        ],
        // physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: CupertinoTabBar(
            backgroundColor: UniversalVariables.blackColor,
            items: [
              BottomNavigationBarItem(
                tooltip: 'Home',
                activeIcon: ZoomIn(child: const Icon(Icons.home)),
                icon: Icon(
                  Icons.home_outlined,
                  color: _page == 0
                      ? UniversalVariables.lightBlueColor
                      : UniversalVariables.greyColor,
                ),
                label: 'Home',
                backgroundColor: _page == 0
                    ? UniversalVariables.lightBlueColor
                    : UniversalVariables.greyColor,
              ),
              BottomNavigationBarItem(
                icon: _page == 1
                    ? ZoomIn(child: const Icon(Icons.dashboard_rounded))
                    : const Icon(Icons.dashboard_outlined),
                // color: _page == 1
                //         ? UniversalVariables.lightBlueColor
                //         : UniversalVariables.greyColor,
                //   ),

                label: 'Dashboard',
                backgroundColor: _page == 1
                    ? UniversalVariables.lightBlueColor
                    : UniversalVariables.greyColor,
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  _page == 2
                      ? Icons.shopping_cart
                      : Icons.shopping_cart_outlined,
                  color: _page == 2
                      ? UniversalVariables.lightBlueColor
                      : UniversalVariables.greyColor,
                ),
                label: 'Shopping',
                backgroundColor: _page == 2
                    ? UniversalVariables.lightBlueColor
                    : UniversalVariables.greyColor,
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  _page == 3
                      ? Icons.notifications
                      : Icons.notifications_outlined,
                  color: _page == 3
                      ? UniversalVariables.lightBlueColor
                      : UniversalVariables.greyColor,
                ),
                label: 'Notifications',
                backgroundColor: _page == 3
                    ? UniversalVariables.lightBlueColor
                    : UniversalVariables.greyColor,
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  _page == 4
                      ? Icons.account_circle
                      : Icons.account_circle_outlined,
                  color: _page == 4
                      ? UniversalVariables.lightBlueColor
                      : UniversalVariables.greyColor,
                ),
                label: 'Account',
                backgroundColor: _page == 4
                    ? UniversalVariables.lightBlueColor
                    : UniversalVariables.greyColor,
              ),
            ],
            onTap: navigateTapped,
            currentIndex: _page,
          ),
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 7, vsync: this);
    setState(() {
      _tabController.addListener(() {
        setState(() {});
      });
    });
  }

  final int _currentIndex = 0;
  List<Widget> pages = const [
    Text('home'),
    Text('Dashboard'),
    Text('shopping'),
    Text('notification')
  ];
  @override
  Widget build(BuildContext context) {
    return (Scaffold(
        backgroundColor: UniversalVariables.blackColor,
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                backgroundColor: UniversalVariables.blackColor,
                title: const Text('Telegram'),
                actions: [
                  TextButton.icon(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(16.0),
                      primary: Colors.white,
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    onPressed: () => {},
                    icon: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    label: const Text(''),
                  )
                ],
                pinned: true,
                floating: true,
                forceElevated: innerBoxIsScrolled,
                bottom: Tab(
                  height: 60,
                  child: TabBar(  
                    isScrollable: true,
                    indicatorColor: Colors.pinkAccent, 
                    controller: _tabController,
                    tabs: <Widget>[
                      Tab(
                        child: Text('All',
                            style: TextStyle(
                                color: _tabController.index == 0
                                    ? Colors.pinkAccent
                                    : Colors.grey)),
                      ),
                      Tab(
                        child: Text('Person',
                            style: TextStyle(
                                color: _tabController.index == 1
                                    ? Colors.pinkAccent
                                    : Colors.grey)),
                      ),
                      Tab(
                        child: Text('Chat',
                            style: TextStyle(
                                color: _tabController.index == 2
                                    ? Colors.pinkAccent
                                    : Colors.grey)),
                      ),
                      Tab(
                        child: Text('The Work',
                            style: TextStyle(
                                color: _tabController.index == 3
                                    ? Colors.pinkAccent
                                    : Colors.grey)),
                      ),
                      Tab(
                        child: Text('The Work',
                            style: TextStyle(
                                color: _tabController.index == 4
                                    ? Colors.pinkAccent
                                    : Colors.grey)),
                      ),
                      Tab(
                        child: Text('The Work',
                            style: TextStyle(
                                color: _tabController.index == 5
                                    ? Colors.pinkAccent
                                    : Colors.grey)),
                      ),
                      Tab(
                        child: Text('The Work',
                            style: TextStyle(
                                color: _tabController.index == 6
                                    ? Colors.pinkAccent
                                    : Colors.grey)),
                      ),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: const <Widget>[
              Center(
                child: Text("It's cloudy here"),
              ),
              Center(
                child: Text("It's rainy here"),
              ),
              Center(
                child: Text("It's sunny here"),
              ),
              Center(
                child: Text("It's sunny here"),
              ),
              Center(
                child: Text("It's sunny here"),
              ),
              Center(
                child: Text("It's sunny here"),
              ),
              Center(
                child: Text("It's sunny here"),
              ),
            ],
          ),
        )));
  }
}



//       body: Center(

//         child: pages[_currentIndex],
//       ),
//       bottomNavigationBar: NavigationBarTheme(
//         data: NavigationBarThemeData(
//           indicatorColor:Colors.pinkAccent
//           ),
//         child: NavigationBar(
//           backgroundColor: UniversalVariables.blackColor,
//           selectedIndex: _currentIndex,
//           onDestinationSelected: (int newIndex) => {
//             setState((() => {_currentIndex = newIndex}))
//           },
//           elevation: 10,
//           animationDuration: const Duration(seconds: 1),
//           // labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      
//           destinations:   [
//             NavigationDestination(
//               icon: Icon(Icons.home_outlined,
//                color: _currentIndex == 0
//                         ? UniversalVariables.lightBlueColor
//                         : UniversalVariables.greyColor,
//               ),
//               label: 'home',
//               selectedIcon: Icon(Icons.home),
//             ),
//             NavigationDestination(
//               icon: Icon(Icons.dashboard_outlined),
//               label: 'tome',
//               selectedIcon: Icon(Icons.dashboard),
//             ),
//             NavigationDestination(
//               icon: Icon(Icons.home_outlined),
//               label: 'tome',
//               selectedIcon: Icon(Icons.home),
//             ),
//           ],
//         ),
//       ),
//     ));
//   }
// }
