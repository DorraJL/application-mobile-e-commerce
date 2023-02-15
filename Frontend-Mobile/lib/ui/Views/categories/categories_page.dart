
import 'package:e_commers/Helpers/helpers.dart';
import 'package:e_commers/Models/Response/response_categories.dart';
import 'package:e_commers/Models/Response/response_products_home.dart';
import 'package:e_commers/service/ProductController.dart';
import 'package:e_commers/service/urls.dart';
import 'package:e_commers/ui/Views/products/widgets/Filterpage.dart';

import 'package:e_commers/ui/widgets/shimmer_frave.dart';
import 'package:e_commers/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Bloc/product/product_bloc.dart';
import '../../../Models/Response/subcategoriesofcategories.dart';
import '../products/details_product_page.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          splashRadius: 20,
          icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
        title: const TextFrave(
            text: 'Categories',
            color: Colors.black87,
            fontWeight: FontWeight.w500,
            fontSize: 20),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Categorie>>(
        future: productServices.listCategoriesHome(),
        builder: (context, snapshot) {
          return !snapshot.hasData
              ? Column(
                  children: const [
                    ShimmerFrave(),
                    SizedBox(height: 10.0),
                    ShimmerFrave(),
                    SizedBox(height: 10.0),
                    ShimmerFrave(),
                  ],
                )
              : Cat(categories: snapshot.data!);
        },
      ),
    );
  }
}

class Cat extends StatefulWidget {
  final List<Categorie> categories;

  const Cat({Key? key, required this.categories}) : super(key: key);
  @override
  _CatState createState() => _CatState();
}

class _CatState extends State<Cat> {
  int selectedIdx = 0;
  bool extended = false;
  bool isselected = false;

  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              setState(() {
                //extended = !extended;
              });
            },
            child: NavigationRail(
                // extended: extended,
                indicatorColor: Colors.grey.shade300,
                backgroundColor: Colors.yellow[700],
                labelType: NavigationRailLabelType.all,
                unselectedLabelTextStyle:
                    TextStyle(color: Colors.black, fontSize: 16),
                selectedLabelTextStyle:
                    TextStyle(color: Colors.white, fontSize: 16),
                onDestinationSelected: (newIndex) {
                  setState(() {
                    selectedIdx = newIndex;
                    // isselected = true;
                    pageController.animateToPage(
                      newIndex,
                      duration: Duration(microseconds: 250),
                      curve: Curves.ease,
                    );
                  });
                },
                destinations: [
                  for (int i = 0; i < widget.categories.length; i++)
                    NavigationRailDestination(
                        icon: const Icon(null),
                        label: SizedBox(
                            width: 90,
                            height: 60,
                            child: Text(
                              widget.categories[i].category,
                            )))
                ],
                selectedIndex: selectedIdx),
          ),
          VerticalDivider(
            thickness: 10,
            width: 10,
            color: Colors.grey.shade300,
          ),
          Expanded(
              child: PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: pageController,
            scrollDirection: Axis.vertical,
            children: <Widget>[
              for (int i = 0; i < widget.categories.length; i++)
                Container(
                    color: Colors.white70,
                    child: Center(
                        child: RightWidget(
                      category: widget.categories[i].category,
                      idcategory: widget.categories[i].uidCategory,
                      length: widget.categories.length,
                    ))),
            ],
          ))
        ],
      ),
    );
  }
}


class RightWidget extends StatefulWidget {
  final String category;
  final int idcategory;
  final int length;
  const RightWidget(
      {Key? key,
      required this.category,
      required this.idcategory,
      required this.length})
      : super(key: key);
  @override
  _RightWidgetState createState() => _RightWidgetState();
}

class _RightWidgetState extends State<RightWidget>
    with TickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: widget.length);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<List<Categoriess>>(
          future: productServices
              .getsubcategoryForCategories(widget.idcategory.toString()),
          builder: (context, snapshot) {
            print(snapshot.data);

            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Divider(
                  color: Colors.grey.shade300,
                  thickness: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10),
                  child: SizedBox(
                    height: 30,
                    child: TabBar(
                      isScrollable: true,
                      unselectedLabelColor: Colors.black,
                      labelColor: Colors.white,
                      controller: _tabController,
                      indicator: BoxDecoration(
                        color: Colors.yellow[700],
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                        ),
                      ),
                      tabs: <Widget>[
                        for (int i = 0; i < snapshot.data!.length; i++)
                          Tab(
                            text: snapshot.data![i].category,
                          ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: <Widget>[
                      for (int i = 0; i < snapshot.data!.length; i++)
                        RightBody(id: snapshot.data![i].uidCategory),
                    ],
                  ),
                )
              ],
            );
          }),
    );
  }
}

class RightBody extends StatelessWidget {
  final int id;

  const RightBody({Key? key, required this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final productBloc = BlocProvider.of<ProductBloc>(context);
    return Container(
      margin: EdgeInsets.only(
        left: 15,
      ),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              top: 5,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const TextFrave(
                  text: 'Populaire',
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context)
                      .push(routeSlide(page: DynamicRangeSliderDemo())),
                  child: Row(
                    children: const [
                      TextFrave(text: 'VOIR TOUT', fontSize: 13),
                      SizedBox(width: 5.0),
                      Icon(Icons.arrow_forward_ios_rounded,
                          size: 18, color: Color(0xff006CF2))
                    ],
                  ),
                ),
              ],
            ),
          ),
          FutureBuilder<List<ListProducts>>(
              future: productServices.getProductsForCategories(id.toString()),
              builder: (context, snapshot) {
                print(snapshot.data);

                if (snapshot.data == null) {
                  return Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                return Expanded(
                  child: GridView.builder(
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.all(10.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 18,
                        mainAxisSpacing: 18,
                        mainAxisExtent: 180),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, i) => Container(
                        width: 220,
                        margin: EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 5,
                        ),
                        child: Card(
                          shadowColor: Colors.black26,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(20),
                            splashColor: Colors.blue,
                            onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (_) => DetailsProductPage(
                                        product: snapshot.data![i]))),
                            child: Padding(
                              padding: const EdgeInsets.all(9.0),
                              child: Stack(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Hero(
                                            tag: snapshot.data![i].uidProduct
                                                .toString(),
                                            child: Image.network(
                                                URLS.baseUrl +
                                                    snapshot.data![i].picture,
                                                height: 90)),
                                      ),
                                      TextFrave(
                                          text: snapshot.data![i].nameProduct,
                                          fontWeight: FontWeight.w500),
                                      TextFrave(
                                          text: ' ${snapshot.data![i].price}',
                                          fontSize: 16),
                                    ],
                                  ),
                                  Positioned(
                                      right: 0,
                                      child: snapshot.data![i].isFavorite == 1
                                          ? InkWell(
                                              onTap: () => productBloc.add(
                                                  OnAddOrDeleteProductFavoriteEvent(
                                                      uidProduct: snapshot
                                                          .data![i].uidProduct
                                                          .toString())),
                                              child: const Icon(
                                                  Icons.favorite_rounded,
                                                  color: Colors.red),
                                            )
                                          : InkWell(
                                              onTap: () => productBloc.add(
                                                  OnAddOrDeleteProductFavoriteEvent(
                                                      uidProduct: snapshot
                                                          .data![i].uidProduct
                                                          .toString())),
                                              child: Icon(Icons
                                                  .favorite_outline_rounded))),
                                ],
                              ),
                            ),
                          ),
                        )),
                  ),
                );
              }),
        ],
      ),
    );
  }
}
