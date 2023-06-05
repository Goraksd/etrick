import 'dart:convert';

class ShoppingItem {
  final String itemId;
  final String userId;
  final String name;
  final bool isPurchased;
  
  ShoppingItem({
    required this.itemId,
    required this.userId,
    required this.name,
    required this.isPurchased,
  });

  ShoppingItem copyWith({
    String? itemId,
    String? userId,
    String? name,
    bool? isPurchased,
  }) {
    return ShoppingItem(
      itemId: itemId ?? this.itemId,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      isPurchased: isPurchased ?? this.isPurchased,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'itemId': itemId,
      'userId': userId,
      'name': name,
      'isPurchased': isPurchased,
    };
  }

  factory ShoppingItem.fromMap(Map<String, dynamic> map) {
    return ShoppingItem(
      itemId: map['itemId'] ?? '',
      userId: map['userId'] ?? '',
      name: map['name'] ?? '',
      isPurchased: map['isPurchased'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory ShoppingItem.fromJson(String source) =>
      ShoppingItem.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ShoppingItem(itemId: $itemId, userId: $userId, name: $name, isPurchased: $isPurchased)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ShoppingItem &&
        other.itemId == itemId &&
        other.userId == userId &&
        other.name == name &&
        other.isPurchased == isPurchased;
  }

  @override
  int get hashCode {
    return itemId.hashCode ^
        userId.hashCode ^
        name.hashCode ^
        isPurchased.hashCode;
  }
}