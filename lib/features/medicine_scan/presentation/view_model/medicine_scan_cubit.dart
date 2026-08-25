import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:medicine_cabinet/core/di/service_locator.dart';
import 'package:medicine_cabinet/core/failure/failure.dart';
import 'package:medicine_cabinet/core/utils/household_local_data_source.dart';
import 'package:medicine_cabinet/features/medicine_scan/domain/entity/medicine_entity.dart';
import 'package:medicine_cabinet/features/medicine_scan/domain/entity/medicine_scan_entity.dart';
import 'package:medicine_cabinet/features/medicine_scan/domain/entity/member_entity.dart';
import 'package:medicine_cabinet/features/medicine_scan/domain/use_case/add_medicine_use_case.dart';
import 'package:medicine_cabinet/features/medicine_scan/domain/use_case/analyze_medicine_image_use_case.dart';
import 'package:medicine_cabinet/features/medicine_scan/domain/use_case/get_house_holds_members_use_case.dart';
import 'package:medicine_cabinet/features/medicine_scan/presentation/view_model/medicine_scan_states.dart';

@injectable
class MedicineScanCubit extends Cubit<MedicineScanStates> {
  MedicineScanCubit({
    required this.addMedicineUseCase,
    required this.analyzeMedicineImageUseCase,
    required this.getHouseHoldsMembersUseCase,
  }) : super(MedicineScanInitialState());

  static MedicineScanCubit get(BuildContext context) =>
      BlocProvider.of<MedicineScanCubit>(context);

  final AddMedicineUseCase addMedicineUseCase;
  final AnalyzeMedicineImageUseCase analyzeMedicineImageUseCase;
  final GetHouseHoldsMembersUseCase getHouseHoldsMembersUseCase;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController strengthController = TextEditingController();
  final TextEditingController storageLocationController =
      TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();

  DateTime? selectedExpiryDate;
  int quantity = 1;
  String selectedMember = '';
  String? scannedImageUrl;
  String currentHouseId = '';
  List<MemberEntity> householdMembers = [];
  bool isLoadingMembers = false;
  Failure? membersFailure;
  String? getMembersErrorMessage(BuildContext context) =>
      membersFailure?.getMessage(context);

  void initConfirmationData(
    MedicineScanEntity? entity, {
    String? houseId,
  }) {
    currentHouseId = (houseId != null && houseId.isNotEmpty)
        ? houseId
        : (getIt<HouseholdLocalDataSource>().getHouseholdId() ?? '');
    scannedImageUrl = entity?.imageUrl;
    selectedExpiryDate =
        entity?.expiryDate ?? DateTime.now().add(const Duration(days: 365));

    nameController.text = entity?.name ?? '';
    categoryController.text = entity?.category ?? '';
    typeController.text = (entity?.type.isNotEmpty == true)
        ? entity!.type
        : 'Tablets';
    strengthController.text = '';
    storageLocationController.text = 'Medicine Cabinet';
    descriptionController.text = entity?.description ?? '';
    expiryDateController.text = selectedExpiryDate != null
        ? DateFormat('yyyy-MM-dd').format(selectedExpiryDate!)
        : '';

    quantity = 1;
    selectedMember = '';

    getHouseholdMembers(currentHouseId);
  }

  void updateExpiryDate(DateTime date) {
    selectedExpiryDate = date;
    expiryDateController.text = DateFormat('yyyy-MM-dd').format(date);
    emit(
      MedicineScanFormDataUpdatedState(
        quantity: quantity,
        selectedMember: selectedMember,
        selectedExpiryDate: selectedExpiryDate,
      ),
    );
  }

  void selectMember(String memberName) {
    selectedMember = memberName;
    emit(
      MedicineScanFormDataUpdatedState(
        quantity: quantity,
        selectedMember: selectedMember,
        selectedExpiryDate: selectedExpiryDate,
      ),
    );
  }

  void incrementQuantity() {
    quantity++;
    emit(
      MedicineScanFormDataUpdatedState(
        quantity: quantity,
        selectedMember: selectedMember,
        selectedExpiryDate: selectedExpiryDate,
      ),
    );
  }

  void decrementQuantity() {
    if (quantity > 1) {
      quantity--;
      emit(
        MedicineScanFormDataUpdatedState(
          quantity: quantity,
          selectedMember: selectedMember,
          selectedExpiryDate: selectedExpiryDate,
        ),
      );
    }
  }

  Future<void> analyzeMedicine(File image) async {
    emit(MedicineScanLoadingState());

    final result = await analyzeMedicineImageUseCase.invoke(image);

    result.fold(
      (failure) {
        emit(MedicineScanErrorState(failure));
      },
      (scannedData) {
        initConfirmationData(scannedData);
        emit(MedicineScanSuccessState(scannedData));
      },
    );
  }

  Future<void> getHouseholdMembers(String houseHoldId) async {
    currentHouseId = houseHoldId;
    isLoadingMembers = true;
    membersFailure = null;
    emit(MedicineScanGetMembersLoadingState());

    final result = await getHouseHoldsMembersUseCase.invoke(houseHoldId);

    result.fold(
      (failure) {
        isLoadingMembers = false;
        membersFailure = failure;
        emit(MedicineScanGetMembersErrorState(failure));
      },
      (membersList) {
        isLoadingMembers = false;
        householdMembers = membersList;
        if (membersList.isNotEmpty && selectedMember.isEmpty) {
          selectedMember = membersList.first.name;
        }
        emit(MedicineScanGetMembersSuccessState(membersList));
      },
    );
  }

  Future<void> saveMedicine() async {
    if (formKey.currentState != null && !formKey.currentState!.validate()) {
      return;
    }

    emit(AddMedicineLoadingState());

    final effectiveHouseId = currentHouseId.isNotEmpty
        ? currentHouseId
        : (getIt<HouseholdLocalDataSource>().getHouseholdId() ?? '');

    final currentUserName = FirebaseAuth.instance.currentUser?.displayName ??
        FirebaseAuth.instance.currentUser?.email ??
        'User';

    final medicineEntity = MedicineEntity(
      id: '',
      name: nameController.text.trim(),
      category: categoryController.text.trim(),
      type: typeController.text.trim(),
      quantity: quantity,
      storageLocation: storageLocationController.text.trim(),
      imageUrl: scannedImageUrl ?? '',
      expiryDate:
          selectedExpiryDate ?? DateTime.now().add(const Duration(days: 365)),
      addedBy: currentUserName,
      ownerId: selectedMember,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      description: descriptionController.text.trim(),
    );

    final result = await addMedicineUseCase.invoke(
      medicineEntity,
      effectiveHouseId,
    );

    result.fold(
      (failure) {
        emit(AddMedicineErrorState(failure));
      },
      (_) {
        emit(AddMedicineSuccessState());
      },
    );
  }

  Future<void> addMedicine(
    MedicineEntity medicineEntity,
    String houseId,
  ) async {
    emit(AddMedicineLoadingState());

    final result = await addMedicineUseCase.invoke(medicineEntity, houseId);

    result.fold(
      (failure) {
        emit(AddMedicineErrorState(failure));
      },
      (_) {
        emit(AddMedicineSuccessState());
      },
    );
  }

  @override
  Future<void> close() {
    nameController.dispose();
    categoryController.dispose();
    typeController.dispose();
    strengthController.dispose();
    storageLocationController.dispose();
    descriptionController.dispose();
    expiryDateController.dispose();
    return super.close();
  }
}
