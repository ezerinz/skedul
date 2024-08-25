import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:realm/realm.dart';
import 'package:skedul/features/jadwal/data/jadwal_repository.dart';
import 'package:skedul/features/siakad_integration/presentation/controller/captcha_provider.dart';
import 'package:skedul/shared/provider/realm/model.dart';
import 'package:skedul/shared/provider/settings/settings_provider.dart';
import 'package:skedul/shared/provider/siakad_unsulbar/siakad_model.dart';
import 'package:skedul/shared/provider/siakad_unsulbar/siakad_services.dart';
import 'package:skedul/shared/theme/theme.dart';
import 'package:skedul/shared/utils/utils.dart';
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
    final isDark = ref.watch(isDarkModeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Integrasi SIAKAD"),
        titleTextStyle: AppTheme.kTextSemiBold18.copyWith(
            color: isDark ? AppTheme.kColorDarkForeground : Colors.black,
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
                          style: AppTheme.kTextSemiBold24,
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
                              surfaceTintColor: AppTheme.kColorPrimary,
                              foregroundColor: AppTheme.kColorPrimary,
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
                            style: AppTheme.kTextSemiBold24,
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
                                      surfaceTintColor: AppTheme.kColorPrimary,
                                      foregroundColor: AppTheme.kColorPrimary,
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
                                      color: AppTheme.kColorPrimary
                                          .withOpacity(0.5),
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
                      style: AppTheme.kTextMedium16
                          .copyWith(fontWeight: FontWeight.w400),
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
                                  color:
                                      AppTheme.kColorPrimary.withOpacity(0.5),
                                ),
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
                                    final jamSplit = m.jam.split(":");
                                    repository.insertMakul(
                                      Makul(
                                        ObjectId(),
                                        m.hari,
                                        m.nama,
                                        m.ruangan,
                                        m.sks,
                                        m.kelas,
                                        jam: Waktu(
                                          int.parse(jamSplit[0]),
                                          int.parse(jamSplit[1]),
                                        ),
                                      ),
                                    );
                                    await Future.delayed(
                                      const Duration(seconds: 1),
                                    );
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
                          surfaceTintColor: AppTheme.kColorPrimary,
                          foregroundColor: AppTheme.kColorPrimary,
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
                                    color:
                                        AppTheme.kColorPrimary.withOpacity(0.5),
                                  ),
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
}
