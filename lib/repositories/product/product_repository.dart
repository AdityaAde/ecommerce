import 'package:cloud_firestore/cloud_firestore.dart';

import 'base_product_repository.dart';
import '../../models/models.dart';

class ProductRepositotry extends BaseProductRepository {
  final FirebaseFirestore _firebaseFirestore;
  ProductRepositotry({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;
  @override
  Stream<List<Product>> getAllProduct() {
    return _firebaseFirestore.collection('products').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Product.fromSnapshot(doc)).toList();
    });
  }
}
