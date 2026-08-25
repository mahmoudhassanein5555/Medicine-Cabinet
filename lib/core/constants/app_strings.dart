abstract final class AppStrings {
  AppStrings._();

  // Firestore collections
  static const usersCollection = 'users';
  static const householdsCollection = 'households';
  static const medicinesCollection = 'medicines';

  // Firestore fields
  static const nameField = 'name';
  static const typeField = 'type';
  static const quantityField = 'quantity';
  static const expiryDateField = 'expiryDate';
  static const imageUrlField = 'imageUrl';
  static const ownerIdField = 'ownerId';
  static const addedByField = 'addedBy';
  static const createdAtField = 'createdAt';
  static const updatedAtField = 'updatedAt';

  // Dummy / Skeleton values
  static const String dummyMedicineId = 'loading';
  static const String dummyMedicineName = 'Panadol Medicine';
  static const String dummyMedicineType = 'Tablets';
  static const String dummyMedicineExpiry = 'Aug 2026';
  static const String dummyMedicineAddedBy = 'User';
  static const String dummyMedicineStatus = 'Healthy';
  static const String dummyMedicineImageUrl = '';
  static const String dummyMedicineOwnerId = 'Owner';
  static const String dummyMedicineStorageLocation = 'Kitchen cabinet';
  static const String dummyMedicineCategory = 'Pain relief';
  static const int dummyMedicineQuantity = 20;
}
