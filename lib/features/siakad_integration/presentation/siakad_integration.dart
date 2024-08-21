import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:skedul/features/jadwal/data/jadwal_repository_provider.dart';
import 'package:skedul/features/siakad_integration/presentation/controller/captcha_provider.dart';
import 'package:skedul/shared/provider/drift/database.dart';
import 'package:skedul/shared/provider/settings/system_theme_provider.dart';
import 'package:skedul/shared/provider/siakad_unsulbar/siakad_model.dart';
import 'package:skedul/shared/provider/siakad_unsulbar/siakad_services_provider.dart';
import 'package:skedul/shared/theme/colors.dart';
import 'package:skedul/shared/theme/text.dart';
import 'package:skedul/shared/widgets/rounded_textfield.dart';

class SiakadIntegration extends ConsumerStatefulWidget {
  const SiakadIntegration({super.key});

  @override
  ConsumerState<SiakadIntegration> createState() => _SiakadIntegrationState();
}

class _SiakadIntegrationState extends ConsumerState<SiakadIntegration> {
  TextEditingController nimCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController captchaCtrl = TextEditingController();
  String captchaKey = "";
  String makulInIntegration = "";
  bool passwordVisibility = false;
  bool isLoading = false;
  bool loginSuccess = false;
  bool integrasiFailed = false;
  bool integrasiSucced = false;

  @override
  Widget build(BuildContext context) {
    final captcha = ref.watch(captchaProvider);
    final isDark = ref.watch(themeChoosenProvider);

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: const Text("Integrasi Siakad"),
        titleTextStyle: kTextSemiBold18.copyWith(
            color: isDark ? kColorDarkForeground : Colors.black,
            fontFamily: "KumbhSans"),
      ),
      body: SafeArea(
        child: loginSuccess
            ? integrasiSucced
                ? Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Integrasi Sukses",
                          style: kTextSemiBold24,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              context.pop();
                            },
                            style: ElevatedButton.styleFrom(
                              surfaceTintColor: kColorPrimary,
                              foregroundColor: kColorPrimary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: const Text("Kembali"),
                          ),
                        )
                      ],
                    ),
                  )
                : Center(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            integrasiFailed
                                ? "Integrasi gagal"
                                : "Login Berhasil",
                            style: kTextSemiBold24,
                          ),
                          Text(integrasiFailed
                              ? "Ingin masuk ulang?"
                              : "Sedang sinkronisasi, mohon tunggu..."),
                          const SizedBox(
                            height: 10.0,
                          ),
                          integrasiFailed
                              ? SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        loginSuccess = false;
                                        integrasiFailed = false;
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      surfaceTintColor: kColorPrimary,
                                      foregroundColor: kColorPrimary,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                    child: const Text("Ya"),
                                  ),
                                )
                              : SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: kColorPrimary.withOpacity(0.5),
                                    ),
                                  ),
                                ),
                          Text(
                            makulInIntegration,
                            style: const TextStyle(
                              fontSize: 10.0,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
            : SingleChildScrollView(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Login ke SIAKAD UNSULBAR dan sinkronisasi jadwal kuliahmu",
                      style:
                          kTextMedium16.copyWith(fontWeight: FontWeight.w400),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    RoundedTextField(
                      hintText: "Nama Pengguna / NIM",
                      controller: nimCtrl,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    StatefulBuilder(builder: (context, stateSet) {
                      return RoundedTextField(
                        obscure: !passwordVisibility,
                        suffix: IconButton(
                          onPressed: () {
                            stateSet(() {
                              passwordVisibility = !passwordVisibility;
                            });
                          },
                          icon: Icon(passwordVisibility
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                        hintText: "Kata Sandi",
                        controller: passwordCtrl,
                      );
                    }),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: captcha.when(
                            data: (data) {
                              setState(() {
                                captchaKey = data?.key ?? "";
                              });
                              return data == null
                                  ? const Text("Gagal memuat captcha")
                                  : Image.network(data.image);
                            },
                            error: (error, stackTrace) =>
                                const Text("Gagal memuat captcha"),
                            loading: () => SizedBox(
                              height: 58,
                              child: Center(
                                child: CircularProgressIndicator(
                                    color: kColorPrimary.withOpacity(0.5)),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8.0,
                        ),
                        IconButton(
                          onPressed: () {
                            ref.invalidate(captchaProvider);
                          },
                          icon: const Icon(Icons.refresh_outlined),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    RoundedTextField(
                        hintText: "Captcha", controller: captchaCtrl),
                    const SizedBox(
                      height: 25.0,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (nimCtrl.text.trim().isEmpty ||
                              passwordCtrl.text.trim().isEmpty ||
                              captchaCtrl.text.trim().isEmpty) {
                            String message = "Isi semua kolom yang tersedia";
                            final snackbar = snackBarCustom(isDark, message);
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackbar);
                          } else {
                            final services = ref.watch(siakadServicesProvider);
                            try {
                              setState(() {
                                isLoading = true;
                              });
                              bool login = await services.login(
                                  nimCtrl.text,
                                  passwordCtrl.text,
                                  captchaKey,
                                  captchaCtrl.text);
                              setState(() {
                                isLoading = false;
                              });
                              if (login) {
                                setState(() {
                                  loginSuccess = true;
                                });

                                try {
                                  List<MakulResponse> makul =
                                      await services.getMakul();
                                  final repository =
                                      ref.watch(jadwalRepositoryProvider);
                                  for (MakulResponse m in makul) {
                                    setState(() {
                                      makulInIntegration = m.nama;
                                    });
                                    final data = MataKuliahCompanion.insert(
                                        hari: m.hari,
                                        nama: m.nama,
                                        ruangan: m.ruangan,
                                        kelas: m.kelas,
                                        sks: m.sks,
                                        jam: m.jam);
                                    await repository.insertMakul(data);
                                    await Future.delayed(
                                        const Duration(seconds: 1));
                                  }

                                  setState(() {
                                    makulInIntegration = "";
                                    integrasiSucced = true;
                                  });
                                } catch (e) {
                                  setState(() {
                                    integrasiFailed = true;
                                  });
                                }
                              }
                            } on DioException catch (e) {
                              setState(() {
                                isLoading = false;
                              });
                              String message = e.message ?? "";
                              final snackbar = snackBarCustom(isDark, message);
                              if (context.mounted) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackbar);
                              }
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          surfaceTintColor: kColorPrimary,
                          foregroundColor: kColorPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: isLoading
                            ? Center(
                                child: SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                      color: kColorPrimary.withOpacity(0.5)),
                                ),
                              )
                            : const Text("Masuk"),
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }

  SnackBar snackBarCustom(bool isDark, String message) {
    return SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: isDark ? kColorDark : Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
      content: Text(
        message,
        style: TextStyle(color: isDark ? kColorDarkForeground : kColorDark),
      ),
    );
  }
}
