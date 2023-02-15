part of 'helpers.dart';

void modalDeleteSubCtegory(
    BuildContext context, String uid) {
  final categoryBloc = BlocProvider.of<CategoryBloc>(context);

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
            TextFrave(text: ' sous categorie?'),
          
            SizedBox(height: 20.0),
            Btn_Frave(
              height: 45,
              color: Colors.red,
              text: 'Effacer',
              fontWeight: FontWeight.bold,
              onPressed: () {
               categoryBloc.add(OnDeleteSubCategoryEvent(uid));
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    ),
  );
}
