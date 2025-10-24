import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myapp/features/buyer_registration/domain/entities/buyer_profile_entity.dart';
import 'package:myapp/features/buyer_registration/presentation/providers/buyer_profile_provider.dart';

import '../../data/datasources/buyer_profile_remote_data_source_impl.dart';
import '../../data/repositories/buyer_profile_repository_impl.dart';
import '../../domain/usecases/save_buyer_profile_use_case.dart';

class BuyerRegistrationScreen extends StatefulWidget {
  final String email;
  final String role;

  const BuyerRegistrationScreen({
    super.key,
    required this.email,
    required this.role,
  });

  @override
  State<BuyerRegistrationScreen> createState() =>
      _BuyerRegistrationScreenState();
}

class _BuyerRegistrationScreenState extends State<BuyerRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();

  String? _selectedGender;
  String? _selectedYear;
  String? _selectedMonth;
  String? _selectedDay;

  @override
  void initState() {
    super.initState();
    // Fill with dummy data in debug mode
    assert(() {
      _addressController.text = 'Calle Falsa 123';
      _phoneController.text = '3001234567';
      _selectedGender = 'Masculino';
      _selectedYear = '1990';
      _selectedMonth = '1';
      _selectedDay = '1';
      return true;
    }());
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BuyerProfileProvider(
        saveBuyerProfileUseCase: SaveBuyerProfileUseCase(
          repository: BuyerProfileRepositoryImpl(
            remoteDataSource: BuyerProfileRemoteDataSourceImpl(
              firestore: FirebaseFirestore.instance,
            ),
          ),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(title: const Text('Completa tu perfil')),
        body: Consumer<BuyerProfileProvider>(
          builder: (context, provider, child) {
            if (provider.state == BuyerProfileState.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (provider.state == BuyerProfileState.success) {
              // You can navigate to the next screen or show a success message
              return const Center(child: Text('Perfil guardado exitosamente'));
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Necesitamos algunos datos más para continuar.',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _addressController,
                      decoration: const InputDecoration(
                        labelText: 'Dirección',
                        hintText: 'Ej: Calle 100 # 20-30',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Este campo es requerido';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _phoneController,
                      decoration: const InputDecoration(
                        labelText: 'Teléfono de Contacto',
                        hintText: 'Ej: 3001234567',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Este campo es requerido';
                        }
                        if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                          return 'Ingrese un número de teléfono válido';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      initialValue: _selectedGender,
                      hint: const Text('Selecciona tu género'),
                      items: ['Masculino', 'Femenino', 'Otro']
                          .map(
                            (gender) => DropdownMenuItem(
                              value: gender,
                              child: Text(gender),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Este campo es requerido';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Género',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text('Fecha de Nacimiento'),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            initialValue: _selectedYear,
                            hint: const Text('Año'),
                            items: List.generate(100, (index) {
                              final year = DateTime.now().year - index;
                              return DropdownMenuItem(
                                value: year.toString(),
                                child: Text(year.toString()),
                              );
                            }),
                            onChanged: (value) {
                              setState(() {
                                _selectedYear = value;
                              });
                            },
                            validator: (value) {
                              if (value == null) {
                                return 'Requerido';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            initialValue: _selectedMonth,
                            hint: const Text('Mes'),
                            items: List.generate(12, (index) {
                              final month = index + 1;
                              return DropdownMenuItem(
                                value: month.toString(),
                                child: Text(month.toString()),
                              );
                            }),
                            onChanged: (value) {
                              setState(() {
                                _selectedMonth = value;
                              });
                            },
                            validator: (value) {
                              if (value == null) {
                                return 'Requerido';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            initialValue: _selectedDay,
                            hint: const Text('Día'),
                            items: List.generate(31, (index) {
                              final day = index + 1;
                              return DropdownMenuItem(
                                value: day.toString(),
                                child: Text(day.toString()),
                              );
                            }),
                            onChanged: (value) {
                              setState(() {
                                _selectedDay = value;
                              });
                            },
                            validator: (value) {
                              if (value == null) {
                                return 'Requerido';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final birthDate = DateTime(
                              int.parse(_selectedYear!),
                              int.parse(_selectedMonth!),
                              int.parse(_selectedDay!),
                            );

                            final buyerProfile = BuyerProfileEntity(
                              email: widget.email,
                              role: widget.role,
                              address: _addressController.text,
                              phone: _phoneController.text,
                              gender: _selectedGender!,
                              birthDate: birthDate,
                            );

                            context
                                .read<BuyerProfileProvider>()
                                .saveBuyerProfile(buyerProfile);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          textStyle: const TextStyle(fontSize: 16),
                        ),
                        child: const Text('Guardar y Continuar'),
                      ),
                    ),
                    if (provider.state == BuyerProfileState.error)
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Text(
                          provider.errorMessage ?? 'Ocurrió un error',
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
