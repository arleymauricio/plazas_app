
import 'package:flutter/material.dart';
import 'package:myapp/features/buyer_registration/domain/entities/buyer_profile_entity.dart';
import 'package:myapp/features/buyer_registration/domain/usecases/save_buyer_profile_use_case.dart';

enum BuyerProfileState {
  initial,
  loading,
  success,
  error,
}

class BuyerProfileProvider extends ChangeNotifier {
  final SaveBuyerProfileUseCase saveBuyerProfileUseCase;

  BuyerProfileProvider({required this.saveBuyerProfileUseCase});

  BuyerProfileState _state = BuyerProfileState.initial;
  BuyerProfileState get state => _state;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> saveBuyerProfile(BuyerProfileEntity buyerProfile) async {
    _state = BuyerProfileState.loading;
    notifyListeners();

    try {
      await saveBuyerProfileUseCase(buyerProfile);
      _state = BuyerProfileState.success;
    } catch (e) {
      _state = BuyerProfileState.error;
      _errorMessage = e.toString();
    }

    notifyListeners();
  }
}
