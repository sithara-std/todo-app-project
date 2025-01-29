import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Type-Safe Document Conversion
  Future<List<T>> getDocuments<T>({
    required String collection,
    required T Function(Map<String, dynamic> data, String documentId) fromMap,
    Query? query,
  }) async {
    try {
      QuerySnapshot snapshot = query != null 
        ? await query.get() 
        : await _firestore.collection(collection).get();

      return snapshot.docs
        .map((doc) => fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
    } catch (e) {
      debugPrint('Error fetching documents: $e');
      return [];
    }
  }

  // Type-Safe Document Addition
  Future<String?> addDocument<T>({
    required String collection,
    required Map<String, dynamic> data,
  }) async {
    try {
      final docRef = await _firestore.collection(collection).add(data);
      return docRef.id;
    } catch (e) {
      debugPrint('Error adding document: $e');
      return null;
    }
  }

  // Advanced Query Method
  Query buildQuery(
    String collection, {
    List<QueryFilter>? filters,
    String? orderBy,
    bool descending = false,
    int? limit,
  }) {
    Query query = _firestore.collection(collection);

    // Apply Filters
    if (filters != null) {
      for (var filter in filters) {
        query = query.where(
          filter.field, 
          isEqualTo: filter.value
        );
      }
    }

    // Apply Ordering
    if (orderBy != null) {
      query = query.orderBy(orderBy, descending: descending);
    }

    // Apply Limit
    if (limit != null) {
      query = query.limit(limit);
    }

    return query;
  }
}

// Helper Class for Filtering
class QueryFilter {
  final String field;
  final dynamic value;

  QueryFilter(this.field, this.value);
}
