import 'package:e_commers/Bloc/product/product_bloc.dart';
import 'package:e_commers/Helpers/helpers.dart';
import 'package:e_commers/ui/Views/Categories/categories_page.dart';
import 'package:e_commers/ui/themes/colors_tech4iot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commers/Bloc/General/general_bloc.dart';
import 'package:e_commers/ui/Views/Home/widgets/carousel_home.dart';
import 'package:e_commers/ui/Views/Home/widgets/header_home.dart';
import 'package:e_commers/ui/Views/Home/widgets/list_categories_home.dart';
import 'package:e_commers/ui/Views/Home/widgets/list_products_home.dart';
import '../../widgets/widgets.dart';
import 'package:kommunicate_flutter/kommunicate_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocListener<ProductBloc, ProductState>(
      listener: (context, state) {
        if (state is LoadingProductState) {
          modalLoadingShort(context);
        } else if (state is FailureProductState) {
          Navigator.pop(context);
          errorMessageSnack(context, state.error);
        } else if (state is SuccessProductState) {
          Navigator.pop(context);
          setState(() {});
        }
      },
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 90.0),
          child: FloatingActionButton(
            child: Image.asset('assets/robot.png'),
            backgroundColor: ColorsFrave.primaryColorFrave,
            tooltip: 'connect To Assistant',
            onPressed: () {
              dynamic conversationObject = {
                'appId':
                    '146caf2c960155a3928261f24480788b0', // The APP_ID obtained from kommunicate dashboard.
              };
              KommunicateFlutterPlugin.buildConversation(conversationObject)
                  .then((clientConversationId) {
                print("Conversation builder success : " +
                    clientConversationId.toString());
              }).catchError((error) {
                print("Conversation builder error : " + error.toString());
              });
            },
          ),
        ),
        backgroundColor: Color(0xfff5f5f5),
        body: Stack(
          children: [
            ListHome(),
            Positioned(
              bottom: 20,
              child: Container(
                width: size.width,
                child: Align(
                    alignment: Alignment.center,
                    child: BottomNavigationFrave(index: 1)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ListHome extends StatefulWidget {
  @override
  _ListHomeState createState() => _ListHomeState();
}

class _ListHomeState extends State<ListHome> {
  late ScrollController _scrollControllerHome;
  double scrollPrevious = 0;

  @override
  void initState() {
    _scrollControllerHome = ScrollController();
    _scrollControllerHome.addListener(addListenerMenu);
    super.initState();
  }

  void addListenerMenu() {
    if (_scrollControllerHome.offset > scrollPrevious) {
      BlocProvider.of<GeneralBloc>(context)
          .add(OnShowOrHideMenuEvent(showMenu: false));
    } else {
      BlocProvider.of<GeneralBloc>(context)
          .add(OnShowOrHideMenuEvent(showMenu: true));
    }

    scrollPrevious = _scrollControllerHome.offset;
  }

  @override
  void dispose() {
    _scrollControllerHome.removeListener(addListenerMenu);
    _scrollControllerHome.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
        controller: _scrollControllerHome,
        children: [
          const HeaderHome(),
          const SizedBox(height: 10.0),
          const CardCarousel(),
          const SizedBox(height: 15.0),
          Container(
            padding: const EdgeInsets.all(3.0),
            height: 35.0,
            //  color: Color.fromARGB(255, 160, 194, 241),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const TextFrave(
                  text: 'Nos Top Catégories',
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context)
                      .push(routeSlide(page: CategoriesPage())),
                  child: Row(
                    children: const [
                      TextFrave(
                          text: 'VOIR TOUT', fontSize: 15, color: Colors.black),
                      SizedBox(width: 5.0),
                      Icon(Icons.arrow_forward_ios_rounded,
                          size: 18, color: Colors.black)
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15.0),
          const ListCategoriesHome(),
          const SizedBox(height: 15.0),
          Container(
            padding: const EdgeInsets.all(3.0),
            height: 35.0,
            //  color: Color.fromARGB(255, 235, 224, 154),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const TextFrave(
                  text: 'Nos Populaire Produits',
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                Row(
                  children: const [
                    TextFrave(
                        text: 'VOIR TOUT', fontSize: 15, color: Colors.black),
                    SizedBox(width: 5.0),
                    Icon(Icons.arrow_forward_ios_rounded,
                        size: 18, color: Colors.black)
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 15.0),
          ListProductsForHome()
        ],
      ),
    );
  }
}
