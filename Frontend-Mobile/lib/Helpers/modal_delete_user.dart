part of 'helpers.dart';

void modalDeleteUser(BuildContext context, String name, String uid) {
  final userBloc = BlocProvider.of<UserBloc>(context);

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
            TextFrave(text: 'voulez vous vraiment supprimer?'),
            SizedBox(height: 20.0),
            Row(
              children: [
                Container(
                  height: 40,
                  width: 40,
                ),
                SizedBox(width: 10.0),
                TextFrave(
                  text: name,
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Btn_Frave(
              height: 45,
              color: Colors.red,
              text: 'Effacer',
              fontWeight: FontWeight.bold,
              onPressed: () {
                userBloc.add(OnDeleteUserEvent(uid));
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    ),
  );
}
