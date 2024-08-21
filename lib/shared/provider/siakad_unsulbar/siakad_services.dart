import 'package:dio/dio.dart';
import 'package:skedul/shared/provider/siakad_unsulbar/dio_client.dart';
import 'package:skedul/shared/provider/siakad_unsulbar/functions.dart';
import 'package:skedul/shared/provider/siakad_unsulbar/siakad_model.dart';
import 'package:html/parser.dart' as html_parser;

class SiakadServices {
  final DioClient dio;

  SiakadServices(this.dio);

  Future<CaptchaModel?> getCaptcha() async {
    try {
      final request = await dio.get('/login');

      var document = html_parser.parse(request.data);
      String? key = document
          .querySelector('input[name="_chaptchaKey"]')
          ?.attributes["value"];
      String? img =
          document.querySelector('img[id="Imageid"]')?.attributes["src"];

      if (img != null && key != null) {
        return CaptchaModel(img, key);
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  // true = login berhasil
  // false = login gagal
  Future<bool> login(String username, String password, String captchaKey,
      String captcha) async {
    try {
      final getLogin = await dio.get('/login');

      var document = html_parser.parse(getLogin.data);
      String? csrf = document
          .querySelector('input[name="csrf_test_name"]')
          ?.attributes["value"];

      final request = await dio.post(
        '/login/act',
        data: FormData.fromMap({
          "csrf_test_name": csrf,
          "from": "mahasiswa",
          "user": username,
          "pwd": password,
          "_chaptchaKey": captchaKey,
          "captcha": captcha,
        }),
      );
      if (request.statusCode == 200) {
        var document = html_parser.parse(request.data);

        String message = "Terjadi kesalahan";

        var labelElement = document
            .querySelector('div.alert.alert-danger.alert-dismissible label');
        if (labelElement != null) {
          message = labelElement.text.contains("Capthca")
              ? "Captcha salah"
              : "Kata sandi atau nama pengguna salah";
        }
        throw DioException(requestOptions: RequestOptions(), message: message);
      } else if (request.statusCode == 303 || request.statusCode == 302) {
        return true;
      } else {
        throw DioException(
            requestOptions: RequestOptions(),
            message: "Terjadi kesalahan, login gagal");
      }
    } on DioException {
      rethrow;
      // throw DioException(requestOptions: RequestOptions(), message: e.message);
    }
  }

  Future<List<MakulResponse>> getMakul() async {
    try {
      final request = await dio.get("/mahasiswa/jadwal");
      return parseMakul(request.data);
    } catch (e) {
      rethrow;
    }
  }
}
