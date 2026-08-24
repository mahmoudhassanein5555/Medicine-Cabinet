import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:medicine_cabinet/core/failure/failure.dart';
import 'package:medicine_cabinet/features/home/domain/entity/user_entity.dart';
import 'package:medicine_cabinet/features/home/domain/repository/home_repository.dart';

@injectable
class GetUserDetailsUseCase {
  final HomeRepository _homeRepository;

  GetUserDetailsUseCase(this._homeRepository);

  Future<Either<Failure, UserEntity>> call(String userId) async {
    return await _homeRepository.getUserDetails(userId);
  }
}
