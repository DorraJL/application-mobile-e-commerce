part of 'helpers.dart';

void modalSelectDelivery(BuildContext context, String idOrder) {
  final orderBloc = BlocProvider.of<OrdersBloc>(context);

  showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.white60,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      content: Container(
        height: 400,
        width: MediaQuery.of(context).size.width,
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
                        color: ColorsFrave.primaryColorFrave,
                        fontWeight: FontWeight.w500),
                    TextFrave(text: 'store', fontWeight: FontWeight.w500),
                  ],
                ),
                InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.close))
              ],
            ),
            Divider(),
            SizedBox(height: 10.0),
            TextFrave(text: 'Selectionner un livreur'),
            SizedBox(height: 10.0),
            Expanded(
              child: FutureBuilder<List<Delivery>?>(
                  future: deliveryController.getAlldelivery(),
                  builder: (context, snapshot) => (!snapshot.hasData)
                      ? Column(
                          children: [
                            ShimmerFrave(),
                            SizedBox(height: 10.0),
                            ShimmerFrave(),
                            SizedBox(height: 10.0),
                            ShimmerFrave(),
                          ],
                        )
                      : _ListDeliveryModal(listDelivery: snapshot.data!)),
            ),
            BlocBuilder<DeliveryBloc, DeliveryState>(
              builder: (context, state) => BtnFrave(
                text: 'Envoyer ordre',
                onPressed: () {
                  if (state.idDelivery != '0') {
                    orderBloc.add(OnUpdateStatusOrderToDispatchedEvent(idOrder,
                        state.idDelivery, state.notificationTokenDelivery));
                    Navigator.pop(context);
                  }
                },
                width: 100,
              ),
            )
          ],
        ),
      ),
    ),
  );
}

class _ListDeliveryModal extends StatelessWidget {
  final List<Delivery> listDelivery;

  const _ListDeliveryModal({required this.listDelivery});

  @override
  Widget build(BuildContext context) {
    final deliveryBloc = BlocProvider.of<DeliveryBloc>(context);

    return ListView.builder(
      itemCount: listDelivery.length,
      itemBuilder: (context, i) => InkWell(
        onTap: () => deliveryBloc.add(OnSelectDeliveryEvent(
            listDelivery[i].personId.toString(),
            listDelivery[i].notificationToken.toString())),
        splashColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(10.0),
          margin: EdgeInsets.only(bottom: 10.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10.0)),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(listDelivery[i].nameDelivery!,
                      maxLines: 1, style: GoogleFonts.getFont('Inter')),
                  SizedBox(height: 5.0),
                  TextFrave(text: listDelivery[i].phone!, color: Colors.grey),
                ],
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.centerRight,
                  child: BlocBuilder<DeliveryBloc, DeliveryState>(
                      builder: (_, state) => (state.idDelivery ==
                              listDelivery[i].personId.toString())
                          ? Icon(Icons.check_outlined,
                              size: 30, color: Colors.green)
                          : Container()),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
