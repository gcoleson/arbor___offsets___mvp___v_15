import 'package:http/http.dart';

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
  String productlineOrder;

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
      this.productlineOrder = "0"});

  @override
  String toString() {
    return "\n\nheader: " +
        header +
        "\ndescription: " +
        description +
        "\nimage text: " +
        imageText +
        "\nimage icon: " +
        imageIcon +
        "\ndocument id: " +
        documentID +
        "\nprice: " +
        price.toString() +
        "\ncoin count: " +
        coinCount.toString() +
        "\ntree count: " +
        treeCount.toString() +
        "\nbox selected: " +
        boxSelected.toString() +
        "\nproductline order: " +
        productlineOrder;
  }
}
