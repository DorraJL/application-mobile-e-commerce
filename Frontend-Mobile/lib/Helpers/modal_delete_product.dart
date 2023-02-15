part of 'helpers.dart';

void modalDeleteProduct(
    BuildContext context, String name, String image, String uid) {
  final productBloc = BlocProvider.of<ProductBloc>(context);

  showDialog(
    context: context,
    barrierColor: Colors.white54,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      content: Container(
        height: 196,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    TextFrave(
                        text: 'Tech4iot',
                        color: Colors.red,
                        fontWeight: FontWeight.w500),
                    TextFrave(text: 'Store', fontWeight: FontWeight.w500),
                  ],
                ),
                InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.close))
              ],
            ),
            Divider(),
            SizedBox(height: 10.0),
            TextFrave(text: 'voulez vous vraiment supprimer'),
            TextFrave(text: ' ce produit?'),
            SizedBox(height: 10.0),
            Row(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          scale: 7, image: NetworkImage(URLS.baseUrl + image))),
                ),
                SizedBox(width: 10.0),
                TextFrave(
                  text: name,
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Btn_Frave(
              height: 40,
              color: Colors.red,
              text: 'Effacer',
              fontWeight: FontWeight.bold,
              onPressed: () {
                productBloc.add(OnDeleteProductEvent(uid));
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    ),
  );
}
