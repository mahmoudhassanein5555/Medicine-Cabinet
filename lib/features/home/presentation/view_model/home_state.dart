import 'package:medicine_cabinet/core/failure/failure.dart';
import 'package:medicine_cabinet/features/home/domain/entity/cabinet_summary_entity.dart';
import 'package:medicine_cabinet/features/home/domain/entity/member_entity.dart';
import 'package:medicine_cabinet/features/home/domain/entity/user_entity.dart';

sealed class HomeState {
  const HomeState();
}

class HomeInitial extends HomeState {
  const HomeInitial();

  @override
  String toString() => 'HomeInitial()';
}

class HomeLoading extends HomeState {
  const HomeLoading();

  @override
  String toString() => 'HomeLoading()';
}

class HomeSuccess extends HomeState {
  final UserEntity user;
  final CabinetSummaryEntity summary;
  final List<MemberEntity> members;

  const HomeSuccess({
    required this.user,
    required this.summary,
    required this.members,
  });

  HomeSuccess copyWith({
    UserEntity? user,
    CabinetSummaryEntity? summary,
    List<MemberEntity>? members,
  }) {
    return HomeSuccess(
      user: user ?? this.user,
      summary: summary ?? this.summary,
      members: members ?? this.members,
    );
  }

  @override
  String toString() =>
      'HomeSuccess(user: ${user.name}, activeMedicines: ${summary.activeMedicines.length}, members: ${members.length})';
}

class HomeError extends HomeState {
  final Failure failure;

  const HomeError(this.failure);

  @override
  String toString() => 'HomeError(failure: $failure)';
}
