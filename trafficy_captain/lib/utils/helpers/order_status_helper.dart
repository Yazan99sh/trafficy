import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trafficy_captain/consts/order_status.dart';
import 'package:trafficy_captain/generated/l10n.dart';

class StatusHelper {
  static OrderStatus getStatusEnum(String? status) {
    if (status == 'pending') {
      return OrderStatus.WAITING;
    } else if (status == 'on way to pick order') {
      return OrderStatus.GOT_CAPTAIN;
    } else if (status == 'in store') {
      return OrderStatus.IN_STORE;
    } else if (status == 'ongoing') {
      return OrderStatus.DELIVERING;
    } else if (status == 'delivered') {
      return OrderStatus.FINISHED;
    } else if (status == 'cancelled') {
      return OrderStatus.CANCELLED;
    }
    return OrderStatus.WAITING;
  }

  static String getStatusString(OrderStatus? status) {
    switch (status) {
      case OrderStatus.WAITING:
        return 'pending';
      case OrderStatus.IN_STORE:
        return 'in store';
      case OrderStatus.DELIVERING:
        return 'ongoing';
      case OrderStatus.GOT_CAPTAIN:
        return 'on way to pick order';
      case OrderStatus.FINISHED:
        return 'delivered';
      case OrderStatus.CANCELLED:
        return 'cancelled';
      default:
        return 'pending';
    }
  }

  static String getOrderStatusMessages(OrderStatus? orderStatus) {
    switch (orderStatus) {
      case OrderStatus.WAITING:
        return S.current.waiting;
      case OrderStatus.IN_STORE:
        return S.current.captainInStore;
      case OrderStatus.DELIVERING:
        return S.current.captainIsDelivering;
      case OrderStatus.GOT_CAPTAIN:
        return S.current.captainAcceptedOrder;
      case OrderStatus.FINISHED:
        return S.current.iFinishedDelivering;
      case OrderStatus.CANCELLED:
        return S.current.cancelled;
      default:
        return S.current.waiting;
    }
  }

  static String getOrderStatusDescriptionMessages(OrderStatus orderStatus) {
    switch (orderStatus) {
      case OrderStatus.WAITING:
        return S.current.waitingDescription;
      case OrderStatus.IN_STORE:
        return S.current.captainInStoreDescription;
      case OrderStatus.DELIVERING:
        return S.current.deliveringDescription;
      case OrderStatus.GOT_CAPTAIN:
        return S.current.captainAcceptOrderDescription;
      case OrderStatus.FINISHED:
        return S.current.orderDeliveredDescription;
      case OrderStatus.CANCELLED:
        return S.current.cancelledHint;
      default:
        return S.current.waitingDescription;
    }
  }

  static IconData getOrderStatusIcon(OrderStatus status) {
    switch (status) {
      case OrderStatus.WAITING:
        return Icons.timer_rounded;
      case OrderStatus.IN_STORE:
        return Icons.store_rounded;
      case OrderStatus.DELIVERING:
        return Icons.pedal_bike_rounded;
      case OrderStatus.GOT_CAPTAIN:
        return Icons.account_circle_rounded;
      case OrderStatus.FINISHED:
        return Icons.check_circle_rounded;
      default:
        return Icons.cancel_rounded;
    }
  }

  static Color getOrderStatusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.WAITING:
        return Colors.amber;
      case OrderStatus.IN_STORE:
        return Colors.blue;
      case OrderStatus.DELIVERING:
        return Colors.orange;
      case OrderStatus.GOT_CAPTAIN:
        return Colors.yellow;
      case OrderStatus.FINISHED:
        return Colors.green;
      default:
        return Colors.red;
    }
  }

  static int getOrderStatusIndex(OrderStatus status) {
    switch (status) {
      case OrderStatus.WAITING:
        return 0;
      case OrderStatus.IN_STORE:
        return 2;
      case OrderStatus.DELIVERING:
        return 3;
      case OrderStatus.GOT_CAPTAIN:
        return 1;
      case OrderStatus.FINISHED:
        return 4;
      default:
        return 5;
    }
  }
}
