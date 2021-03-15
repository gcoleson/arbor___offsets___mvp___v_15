class SubscriptionItem {
  String projectName;
  String subscriptionId;
  DateTime nextBillingDate;

  SubscriptionItem(
      String projectName, String subscriptionId, DateTime nextBillingDate) {
    this.projectName = projectName;
    this.subscriptionId = subscriptionId;
    this.nextBillingDate = nextBillingDate;
  }
}
