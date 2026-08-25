import 'package:injectable/injectable.dart';

import '../../../../core/utils/household_local_data_source.dart';

@injectable
class GetCachedHouseholdIdUseCase {
  final HouseholdLocalDataSource repository;

  GetCachedHouseholdIdUseCase(this.repository);

  String? call() {
    return repository.getHouseholdId();
  }
}