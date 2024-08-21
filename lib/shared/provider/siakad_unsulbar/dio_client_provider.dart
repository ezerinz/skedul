import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:skedul/shared/provider/siakad_unsulbar/dio_client.dart';

part 'dio_client_provider.g.dart';

@riverpod
DioClient dioClient(DioClientRef ref) {
  return DioClient(Dio());
}
