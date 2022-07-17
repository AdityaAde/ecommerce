import 'package:cloud_firestore/cloud_firestore.dart';

import 'base_product_repository.dart';
import '../../models/models.dart';

class ProductReposiotry extends BaseProductRepository {
  final FirebaseFirestore _firebaseFirestore;
  ProductReposiotry({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;
  @override
  Stream<List<Product>> getAllProduct() {
    return _firebaseFirestore.collection('products').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Product.fromSnapshot(doc)).toList();
    });
  }
}
