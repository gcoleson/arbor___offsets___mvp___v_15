// @dart=2.9
import 'package:flutter/material.dart';

class SubscriptionItem {
  String projectName;
  String subscriptionId;
  DateTime nextBillingDate;
  bool isSelected;
  double amountDue;

  SubscriptionItem(String projectName, String subscriptionId,
      DateTime nextBillingDate, bool isSelected, double amountDue) {
    this.projectName = projectName;
    this.subscriptionId = subscriptionId;
    this.nextBillingDate = nextBillingDate;
    this.isSelected = isSelected;
    this.amountDue = amountDue;
  }
}
