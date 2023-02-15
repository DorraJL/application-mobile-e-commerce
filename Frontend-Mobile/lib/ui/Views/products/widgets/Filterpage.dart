import 'package:e_commers/ui/Views/products/widgets/productspage.dart';
import 'package:e_commers/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Bloc/product/product_bloc.dart';
import '../../../../Helpers/helpers.dart';


class DynamicRangeSliderDemo extends StatefulWidget {
  const DynamicRangeSliderDemo({Key? key}) : super(key: key);

  @override
  _DynamicRangeSliderDemoState createState() => _DynamicRangeSliderDemoState();
}

List mycolors = <Color>[
  Colors.red,
  Colors.blue,
  Colors.green,
  Colors.purple,
  Colors.orange,
  Colors.indigo,
];
Color primaryColor = mycolors[0];

class _DynamicRangeSliderDemoState extends State<DynamicRangeSliderDemo> {
  double min = 10, max = 1000;
  int divisions = 18;
  int difference = 100;
  RangeValues rangeValues = const RangeValues(10, 1000);
  TextStyle kTextStyle = const TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
  );

  Widget buildColorIcons() => Positioned(
        bottom: 35,
        right: 10,
        child: Row(
          children: [for (var i = 0; i < 6; i++) buildIconBtn(mycolors[i])],
        ),
      );

  Widget buildIconBtn(Color myColor) => Container(
        child: Stack(
          children: [
            Positioned(
              top: 12.5,
              left: 12.5,
              child: Icon(
                Icons.check,
                size: 20,
                color: primaryColor == myColor ? myColor : Colors.transparent,
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.circle,
                color: myColor.withOpacity(0.65),
                size: 30,
              ),
              onPressed: () {
                setState(() {
                  primaryColor = myColor;
                });
              },
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
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
          appBar: AppBar(
              backgroundColor: Colors.white,
              title: const TextFrave(
                  text: 'Filtre', fontSize: 20, fontWeight: FontWeight.bold),
              elevation: 0,
              centerTitle: true,
              leading: IconButton(
                splashRadius: 20,
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios_new_rounded,
                    color: Colors.black87),
              )),
          body: ListView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              children: [
                const SizedBox(height: 15.0),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Prix(TND)',
                          style: kTextStyle,
                        ),
                        Text(
                          '${rangeValues.start.round().toString()} - ${rangeValues.end.round().toString()}',
                          style: kTextStyle,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    DynamicRangeSlider(
                      currentRangeValues: rangeValues,
                      min: min,
                      max: max,
                      onChanged: (RangeValues values) {
                        setState(() {
                          rangeValues = values;
                        });
                      },
                      onChangeEnd: (RangeValues values) {
                        if (values.end == max) {
                          setState(() {
                            max = max + 1000;
                            // divisions = (max - min) ~/ difference;
                          });
                        } /*else if (max > 1000 && values.end < max - 1000) {
                          setState(() {
                            max = max - 1000;
                            divisions = (max - min) ~/ difference;
                          });
                        }*/
                      },
                      // divisions: divisions,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('min: $min', style: kTextStyle),
                        Text('max: $max', style: kTextStyle),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Divider(
                  color: Colors.grey[300],
                  thickness: 2,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Couleur',
                        style: kTextStyle,
                      ),
                      buildColorIcons(),
                    ]),
                const SizedBox(
                  height: 300,
                ),
                BtnFrave(
                    text: 'Enregistrer',
                    width: 10,
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          routeSlide(
                              page: ProductsPage(
                            max: rangeValues.end.round(),
                            min: rangeValues.start.round(),
                          )),
                          (_) => false);
                    }),
              ]),
        ));
  }
}

class DynamicRangeSlider extends StatelessWidget {
  final RangeValues currentRangeValues;
  final double min, max;
  final onChanged;
  final onChangeEnd;
  //final int divisions;

  const DynamicRangeSlider({
    Key? key,
    required this.currentRangeValues,
    required this.min,
    required this.max,
    required this.onChanged,
    this.onChangeEnd,
    // required this.divisions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RangeSlider(
      values: currentRangeValues,
      min: min,
      max: max,
      // divisions: divisions,
      labels: RangeLabels(
        currentRangeValues.start.round().toString(),
        currentRangeValues.end.round().toString(),
      ),
      onChanged: onChanged, // callback when the range values change
      onChangeEnd: onChangeEnd ??
          null, // callback when the user is done selecting new values
    );
  }
}
