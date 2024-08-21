import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:skedul/shared/provider/siakad_unsulbar/dio_client_provider.dart';
import 'package:skedul/shared/provider/siakad_unsulbar/siakad_services.dart';

part 'siakad_services_provider.g.dart';

@riverpod
SiakadServices siakadServices(SiakadServicesRef ref) {
  final dio = ref.watch(dioClientProvider);
  return SiakadServices(dio);
}
