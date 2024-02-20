class ShowProduct {
  String? sId;
  String? admin;
  List<String>? productImage;
  String? productName;
  String? role;
  int? productPrice;
  bool? isDelete;
  int? iV;

  ShowProduct(
      {this.sId,
      this.admin,
      this.productImage,
      this.productName,
      this.role,
      this.productPrice,
      this.isDelete,
      this.iV});

  ShowProduct.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    admin = json['admin'];
    productImage = json['productImage'].cast<String>();
    productName = json['productName'];
    role = json['role'];
    productPrice = json['productPrice'];
    isDelete = json['isDelete'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['admin'] = this.admin;
    data['productImage'] = this.productImage;
    data['productName'] = this.productName;
    data['role'] = this.role;
    data['productPrice'] = this.productPrice;
    data['isDelete'] = this.isDelete;
    data['__v'] = this.iV;
    return data;
  }
}
