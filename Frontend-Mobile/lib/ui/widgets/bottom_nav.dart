part of 'widgets.dart';

class BottomNavigationFrave extends StatelessWidget {
  final int index;

  BottomNavigationFrave({required this.index});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GeneralBloc, GeneralState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) => AnimatedOpacity(
              duration: Duration(milliseconds: 250),
              opacity: (state.showMenuHome) ? 1 : 0,
              child: Container(
                height: 60,
                width: 320,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black38,
                          blurRadius: 10,
                          spreadRadius: -5)
                    ]),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _ItemButtom(
                        i: 1,
                        index: index,
                        child: Image.asset('assets/icon/home.png'),
                        iconString: 'assets/icon/home.png',
                        onPressed: () => Navigator.pushAndRemoveUntil(context,
                            routeSlide(page: HomePage()), (_) => false),
                      ),
                      _ItemButtom(
                        i: 2,
                        index: index,
                        child: Image.asset('assets/icon/heart.png'),
                        iconString: 'assets/icon/heart.png',
                        onPressed: () => Navigator.pushAndRemoveUntil(context,
                            routeSlide(page: FavoritePage()), (_) => false),
                      ),
                      CenterIcon(
                        index: 3,
                        iconString: 'assets/panier.PNG',
                        onPressed: () => Navigator.pushAndRemoveUntil(context,
                            routeSlide(page: CartPage()), (_) => false),
                      ),
                      _ItemButtom(
                        i: 4,
                        index: index,
                        child: Image.asset('assets/icon/search.png'),
                        iconString: 'assets/icon/search.png',
                        onPressed: () => Navigator.pushAndRemoveUntil(context,
                            routeSlide(page: SearchClientPage()), (_) => false),
                      ),
                      _ItemButtom(
                        i: 5,
                        index: index,
                        child: Image.asset('assets/icon/user.png'),
                        iconString: 'assets/icon/user.png',
                        onPressed: () => Navigator.pushAndRemoveUntil(context,
                            routeSlide(page: ProfilePage()), (_) => false),
                      ),
                    ],
                  ),
                ]),
              ),
            ));
  }
}


class CenterIcon extends StatelessWidget {
  final int index;
  final String iconString;
  final Function() onPressed;

  const CenterIcon(
      {Key? key,
      required this.index,
      required this.iconString,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: CircleAvatar(
        backgroundColor: ColorsFrave.primaryColorFrave,
        radius: 26,
        child: Image.asset(
          iconString,
          height: 26,
        ),
      ),
    );
  }
}

class _ItemButtom extends StatelessWidget {
  final int i;
  final int index;
  final String iconString;
  final Function() onPressed;

  const _ItemButtom(
      {Key? key,
      required this.i,
      required this.index,
      required this.onPressed,
      required this.iconString,
      required Image child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
          child: Image.asset(iconString,
              height: 25,
              color: (i == index)
                  ? ColorsFrave.primaryColorFrave
                  : Colors.black87)),
    );
  }
}
