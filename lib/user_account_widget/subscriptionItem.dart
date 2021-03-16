import 'package:flutter/material.dart';

class SubscriptionItem {
  String projectName;
  String subscriptionId;
  DateTime nextBillingDate;
  bool isSelected;

  SubscriptionItem(String projectName, String subscriptionId,
      DateTime nextBillingDate, bool isSelected) {
    this.projectName = projectName;
    this.subscriptionId = subscriptionId;
    this.nextBillingDate = nextBillingDate;
    this.isSelected = isSelected;
  }
}
