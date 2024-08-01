import 'package:dio/dio.dart';
import 'package:final_assignment/features/myappointment/data/data_source/remote/appointment_list_remote_data_source.dart';
import 'package:final_assignment/features/myappointment/data/repository/appointment_list_repository.dart';
import 'package:final_assignment/features/myappointment/domain/usecases/fetch_user_appointment_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


// Create a provider for Dio
final dioProvider = Provider<Dio>((ref) => Dio());

// Create a provider for AppointmentListRemoteDataSource
final appointmentListRemoteDataSourceProvider = Provider<AppointmentListRemoteDataSource>((ref) {
  final dio = ref.watch(dioProvider);
  return AppointmentListRemoteDataSource(dio);
});

// Create a provider for AppointmentListRepositoryImpl
final appointmentListRepositoryProvider = Provider<AppointmentListRepositoryImpl>((ref) {
  final remoteDataSource = ref.watch(appointmentListRemoteDataSourceProvider);
  return AppointmentListRepositoryImpl(remoteDataSource);
});

// Create a provider for FetchUserAppointments
final fetchUserAppointmentsProvider = Provider<FetchUserAppointments>((ref) {
  final repository = ref.watch(appointmentListRepositoryProvider);
  return FetchUserAppointments(repository);
});
