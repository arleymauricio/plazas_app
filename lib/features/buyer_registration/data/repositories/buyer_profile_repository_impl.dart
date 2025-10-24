import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/features/buyer_registration/data/datasources/buyer_profile_remote_data_source.dart';
import 'package:myapp/features/buyer_registration/data/datasources/buyer_profile_remote_data_source_impl.dart';
import 'package:myapp/features/buyer_registration/domain/entities/buyer_profile_entity.dart';
import 'package:myapp/features/buyer_registration/domain/repositories/buyer_profile_repository.dart';

import '../models/buyer_profile_model.dart';

final buyerProfileRepositoryProvider = Provider<BuyerProfileRepository>(
  (ref) => BuyerProfileRepositoryImpl(
    remoteDataSource: ref.watch(buyerProfileRemoteDataSourceProvider),
  ),
);

class BuyerProfileRepositoryImpl implements BuyerProfileRepository {
  final BuyerProfileRemoteDataSource remoteDataSource;

  BuyerProfileRepositoryImpl({required this.remoteDataSource});

  @override
  Future<BuyerProfileEntity?> getBuyerProfile(String email) async {
    final buyerProfileModel = await remoteDataSource.getBuyerProfile(email);
    return buyerProfileModel?.toEntity();
  }

  @override
  Future<void> saveBuyerProfile(BuyerProfileEntity buyerProfile) async {
    final buyerProfileModel = BuyerProfileModel(
      email: buyerProfile.email,
      role: buyerProfile.role,
      address: buyerProfile.address,
      phone: buyerProfile.phone,
      gender: buyerProfile.gender,
      birthDate: buyerProfile.birthDate,
    );
    await remoteDataSource.saveBuyerProfile(buyerProfileModel);
  }
}
