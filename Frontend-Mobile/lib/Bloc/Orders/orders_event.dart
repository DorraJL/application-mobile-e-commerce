part of 'orders_bloc.dart';

@immutable
abstract class OrdersEvent {}

class OnAddNewOrdersEvent extends OrdersEvent {
  final int uidAddress;
  final double total;
  final List<ProductCart> product;

  OnAddNewOrdersEvent(
      this.uidAddress, this.total, this.product);
}

class OnUpdateStatusOrderToDispatchedEvent extends OrdersEvent {
  final String idOrder;
  final String idDelivery;
  final String notificationTokenDelivery;

  OnUpdateStatusOrderToDispatchedEvent(
      this.idOrder, this.idDelivery, this.notificationTokenDelivery);
}

class OnUpdateStatusOrderOnWayEvent extends OrdersEvent {
  final String idOrder;
  final LatLng locationDelivery;

  OnUpdateStatusOrderOnWayEvent(this.idOrder, this.locationDelivery);
}

class OnUpdateStatusOrderDeliveredEvent extends OrdersEvent {
  final String idOrder;

  OnUpdateStatusOrderDeliveredEvent(this.idOrder);
}
