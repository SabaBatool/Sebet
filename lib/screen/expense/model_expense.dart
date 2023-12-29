class ExpenseItem {
  final String category;
  final String subcategoryName;
  final String categoryValue;

  ExpenseItem({
    required this.category,
    required this.subcategoryName,
    required this.categoryValue,
  });

  // Factory method to create an ExpenseItem from a map
  factory ExpenseItem.fromMap(Map<String, dynamic> map) {
    return ExpenseItem(
      category: map['categoryName'] ?? '',
      subcategoryName: map['subcategoryName'] ?? '',
      categoryValue: map['categoryValue'] ?? '',
    );
  }

  // Method to convert ExpenseItem to a map
  Map<String, dynamic> toMap() {
    return {
      'categoryName': category,
      'subcategoryName': subcategoryName,
      'categoryValue': categoryValue,
    };
  }
}
