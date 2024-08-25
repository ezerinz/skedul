import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:skedul/shared/provider/siakad_unsulbar/siakad_model.dart';
import 'package:skedul/shared/provider/siakad_unsulbar/siakad_services.dart';

part 'captcha_provider.g.dart';

@riverpod
Future<CaptchaModel?> captcha(CaptchaRef ref) async {
  final services = ref.watch(siakadServicesProvider);
  return await services.getCaptcha();
}
