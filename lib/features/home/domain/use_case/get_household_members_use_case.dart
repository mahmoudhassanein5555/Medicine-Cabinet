import 'package:dartz/dartz.dart';
import 'package:medicine_cabinet/core/failure/failure.dart';
import 'package:medicine_cabinet/features/home/domain/entity/member_entity.dart';
import 'package:medicine_cabinet/features/home/domain/entity/user_entity.dart';
import 'package:medicine_cabinet/features/home/domain/repository/home_repository.dart';

class GetHouseholdMembersUseCase {
  final HomeRepository _homeRepository;

  GetHouseholdMembersUseCase(this._homeRepository);

  Future<Either<Failure, List<MemberEntity>>> call(
    String householdId, {
    UserEntity? fallbackUser,
    String? userId,
  }) async {
    final result = await _homeRepository.getHouseholdMembers(householdId);

    return result.fold(
      (failure) {
        if (fallbackUser != null) {
          return Right([
            MemberEntity(
              id: userId ?? '',
              name: fallbackUser.name,
              role: 'Owner',
              photoUrl: fallbackUser.photoUrl,
              joinedAt: fallbackUser.createdAt,
            ),
          ]);
        }
        return Left(failure);
      },
      (members) {
        if (members.isEmpty && fallbackUser != null) {
          return Right([
            MemberEntity(
              id: userId ?? '',
              name: fallbackUser.name,
              role: 'Owner',
              photoUrl: fallbackUser.photoUrl,
              joinedAt: fallbackUser.createdAt,
            ),
          ]);
        }
        return Right(members);
      },
    );
  }
}
