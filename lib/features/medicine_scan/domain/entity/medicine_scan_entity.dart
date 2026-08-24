class MedicineScanEntity {
  final String name;
  final String? category;
  final String type;
  final DateTime? expiryDate;
  final String? description;
  final String? imageUrl;
  MedicineScanEntity({
    this.name = "",
    this.category,
    this.type = "",
    this.expiryDate,
    this.description,
    this.imageUrl,
  });
}
