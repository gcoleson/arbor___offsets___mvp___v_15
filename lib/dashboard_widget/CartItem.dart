class CartItem {
  String header;
  String description;
  String imageText;
  String imageIcon;
  String documentID;
  double price;
  double coinCount;
  double treeCount;
  bool boxSelected;
  int productlineOrder;

  CartItem(
      {this.header = '',
      this.description = '',
      this.imageText = '',
      this.imageIcon = '',
      this.documentID = '',
      this.price = 0,
      this.coinCount = 0,
      this.treeCount = 0,
      this.boxSelected = false,
      this.productlineOrder = 0});
}
