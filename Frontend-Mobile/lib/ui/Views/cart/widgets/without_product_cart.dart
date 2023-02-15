import 'package:e_commers/Bloc/product/product_bloc.dart';
import 'package:e_commers/Helpers/helpers.dart';
import 'package:e_commers/ui/Views/Home/home_page.dart';
import 'package:e_commers/ui/themes/colors_tech4iot.dart';
import 'package:e_commers/ui/widgets/shimmer_frave.dart';
import 'package:e_commers/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WithoutProductsCart extends StatelessWidget {

  const WithoutProductsCart({Key? key}):super(key: key);
  
  @override
  Widget build(BuildContext context) {

    return BlocBuilder<ProductBloc, ProductState>(
      builder: (_, state) 
        => state.products != null
        ? state.products!.length != 0 
          ? SizedBox(
              height: 290,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Icon(Icons.shopping_bag_outlined, size: 90, color: ColorsFrave.primaryColorFrave.withOpacity(.7)),
                const TextFrave(text: 'Actuellement vous n avez pas  ', fontSize: 16),
                const SizedBox(height: 5),
                const TextFrave(text: 'des produits dans votre Panier', fontSize: 16),
                const SizedBox(height: 40),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextButton(
                    style:ButtonStyle(
                      side: MaterialStateProperty.all( BorderSide(color: Colors.blue) ),
                      padding: MaterialStateProperty.all( EdgeInsets.symmetric(horizontal: 40, vertical: 10))
                    ),
                    child: const TextFrave(text: 'faire du shopping', fontSize: 19 ),
                    onPressed: () => Navigator.of(context).pushAndRemoveUntil(routeSlide(page: HomePage()), (_) => false),
                  ),
                )
              ],
            )
          )
          : const SizedBox()
      : const ShimmerFrave()
    );
  }


}
