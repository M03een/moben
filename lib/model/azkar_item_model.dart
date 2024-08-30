class AzkarItem {
  final String category;
  final String count;
  final String description;
  final String reference;
  final String content;

  AzkarItem({
    required this.category,
    required this.count,
    required this.description,
    required this.reference,
    required this.content,
  });

  factory AzkarItem.fromJson(Map<String, dynamic> json) {
    return AzkarItem(
      category: json['category'],
      count: json['count'],
      description: json['description'],
      reference: json['reference'],
      content: json['content'],
    );
  }
}