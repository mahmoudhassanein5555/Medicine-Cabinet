class MedicineScanEntity {
  final String name;
  final String? category;
  final String type;
  final DateTime? expiryDate;

  MedicineScanEntity({
    this.name = "",
    this.category,
    this.type = "",
    this.expiryDate,
  });
}
