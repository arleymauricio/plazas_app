import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/market_entity.dart';

class MarketModel extends MarketEntity {
  MarketModel({
    required String id,
    required String name,
    required String description,
    required String address,
    required String imageUrl,
  }) : super(
          id: id,
          name: name,
          description: description,
          address: address,
          imageUrl: imageUrl,
        );

  factory MarketModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return MarketModel(
      id: doc.id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      address: data['address'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'description': description,
      'address': address,
      'imageUrl': imageUrl,
    };
  }
}
