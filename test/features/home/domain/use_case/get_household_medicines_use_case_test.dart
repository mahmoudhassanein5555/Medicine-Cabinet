import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medicine_cabinet/core/failure/failure.dart';
import 'package:medicine_cabinet/features/home/domain/entity/medicine_entity.dart';
import 'package:medicine_cabinet/features/home/domain/entity/member_entity.dart';
import 'package:medicine_cabinet/features/home/domain/entity/user_entity.dart';
import 'package:medicine_cabinet/features/home/domain/repository/home_repository.dart';
import 'package:medicine_cabinet/features/home/domain/use_case/get_household_medicines_use_case.dart';

class MockHomeRepository implements HomeRepository {
  List<MedicineEntity> medicinesToReturn = [];
  Failure? failureToReturn;

  @override
  Future<Either<Failure, List<MedicineEntity>>> getHouseholdMedicines(
    String householdId,
  ) async {
    if (failureToReturn != null) {
      return Left(failureToReturn!);
    }
    return Right(medicinesToReturn);
  }

  @override
  Future<Either<Failure, List<MemberEntity>>> getHouseholdMembers(
    String householdId,
  ) async {
    return const Right([]);
  }

  @override
  Future<Either<Failure, UserEntity>> getUserDetails(String userId) async {
    return Right(
      UserEntity(
        email: 'test@mail.com',
        householdId: 'h1',
        name: 'Ahmed',
        photoUrl: '',
        createdAt: DateTime.now(),
      ),
    );
  }
}

void main() {
  late MockHomeRepository mockRepository;
  late GetHouseholdMedicinesUseCase useCase;

  setUp(() {
    mockRepository = MockHomeRepository();
    useCase = GetHouseholdMedicinesUseCase(mockRepository);
  });

  test(
    'should filter out expired medicines, sort by nearest expiry date, and group low stock',
    () async {
      final now = DateTime.now();

      final expiredMedicine = MedicineEntity(
        id: '1',
        addedBy: 'Ahmed',
        category: 'Painkiller',
        createdAt: now.subtract(const Duration(days: 10)),
        expiryDate: now.subtract(const Duration(days: 2)), // Expired
        imageUrl: '',
        name: 'Old Aspirin',
        ownerId: 'u1',
        quantity: 10,
        storageLocation: 'Bathroom Cabinet',
        type: 'Tablets',
        updatedAt: now,
      );

      final expiringLater = MedicineEntity(
        id: '2',
        addedBy: 'Ahmed',
        category: 'Antibiotic',
        createdAt: now.subtract(const Duration(days: 1)),
        expiryDate: now.add(const Duration(days: 90)), // 90 days from now
        imageUrl: '',
        name: 'Amoxicillin',
        ownerId: 'u1',
        quantity: 20,
        storageLocation: 'Kitchen',
        type: 'Capsules',
        updatedAt: now,
      );

      final expiringSoonLowStock = MedicineEntity(
        id: '3',
        addedBy: 'Mom',
        category: 'Vitamins',
        createdAt: now.subtract(const Duration(days: 1)),
        expiryDate: now.add(const Duration(days: 12)), // 12 days from now
        imageUrl: '',
        name: 'Panadol',
        ownerId: 'u2',
        quantity: 2, // Low stock <= 3
        storageLocation: 'First Aid Box',
        type: 'Tablets',
        updatedAt: now,
      );

      mockRepository.medicinesToReturn = [
        expiredMedicine,
        expiringLater,
        expiringSoonLowStock,
      ];

      final result = await useCase('h1');

      expect(result.isRight(), true);
      result.fold((failure) => fail('Should not fail'), (summary) {
        // 1. Expired medicine should be filtered out
        expect(summary.activeMedicines.length, 2);
        expect(summary.totalCount, 2);
        expect(summary.activeMedicines.any((m) => m.id == '1'), false);

        // 2. Sorted by nearest expiry date first
        expect(summary.activeMedicines.first.name, 'Panadol');
        expect(summary.activeMedicines.last.name, 'Amoxicillin');

        // 3. Low stock count and list
        expect(summary.lowStockCount, 1);
        expect(summary.lowStockMedicines.first.name, 'Panadol');

        // 4. Expiring soon count
        expect(summary.expiringSoonCount, 1);
        expect(summary.expiringSoonMedicines.first.name, 'Panadol');
      });
    },
  );
}
