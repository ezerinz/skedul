import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:skedul/features/auth/data/semester_repository.dart';
import 'package:skedul/features/home/presentation/controller/tugas_provider.dart';
import 'package:skedul/features/home/presentation/widgets/profile_button.dart';
import 'package:skedul/features/home/presentation/widgets/statistic_card.dart';
import 'package:skedul/features/jadwal/presentation/controller/jadwal_provider.dart';
import 'package:skedul/shared/provider/settings/settings_provider.dart';
import 'package:skedul/shared/provider/settings/user_data.dart';
import 'package:path_provider/path_provider.dart';
import 'package:skedul/shared/theme/theme.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jadwal = ref.watch(jadwalProvider(0));
    final tugas = ref.watch(tugasProvider);
    final isDark = ref.watch(isDarkModeProvider);
    final profilePicPath = ref.watch(profilePathProvider);
    final jurusan = ref.watch(jurusanProvider);
    final semester = ref.watch(semesterRepositoryProvider).getSemesterById(
          ref.watch(currentSemesterProvider),
        );

    Future<void> chooseImage() async {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(type: FileType.image);

      if (result != null) {
        if (profilePicPath.isNotEmpty) {
          File oldPic = File(profilePicPath);
          await oldPic.delete();
        }
        File file = File(result.files.single.path!);
        final String appDocuments =
            (await getApplicationDocumentsDirectory()).path;
        String copyPath = "$appDocuments/${file.path.split("/").last}";
        await file.copy(copyPath);
        await file.delete();
        await ref.read(profilePathProvider.notifier).update(copyPath);
      }
    }

    Permission getPermission(AndroidDeviceInfo androidInfo) {
      if (androidInfo.version.sdkInt <= 32) {
        return Permission.storage;
      } else {
        return Permission.photos;
      }
    }

    Future<PermissionStatus> getPermissionStatus(
        AndroidDeviceInfo androidInfo) async {
      if (androidInfo.version.sdkInt <= 32) {
        return await Permission.storage.status;
      } else {
        return await Permission.photos.status;
      }
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 150,
                  width: 150,
                  child: Container(
                    margin: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isDark
                          ? Colors.grey.shade100.withOpacity(0.1)
                          : Colors.grey.shade100,
                      image: profilePicPath.isEmpty
                          ? null
                          : DecorationImage(
                              fit: BoxFit.cover,
                              image: FileImage(
                                File(profilePicPath),
                              ),
                            ),
                    ),
                    child: profilePicPath.isEmpty
                        ? const Icon(
                            Icons.person_outlined,
                            size: 50,
                          )
                        : null,
                  ),
                ),
                Positioned(
                    right: -10,
                    bottom: 0,
                    child: RawMaterialButton(
                      onPressed: () async {
                        final androidInfo =
                            await DeviceInfoPlugin().androidInfo;
                        PermissionStatus status =
                            await getPermissionStatus(androidInfo);
                        Permission permission = getPermission(androidInfo);

                        if (status.isGranted) {
                          await chooseImage();
                        } else {
                          if (status == PermissionStatus.permanentlyDenied) {
                            if (context.mounted) {
                              context.pushNamed("confirm-dialog", extra: [
                                const Text(
                                  "Tidak ada izin",
                                  style: AppTheme.kTextSemiBold24,
                                ),
                                Text(
                                  "Izin untuk penyimpanan dibatasi, buka pengaturan dan beri izin penyimpanan untuk memilih foto",
                                  textAlign: TextAlign.center,
                                  style: AppTheme.kTextMedium16
                                      .copyWith(fontSize: 14),
                                ),
                                [
                                  ElevatedButton(
                                    onPressed: () {
                                      context.pop();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      surfaceTintColor: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                      foregroundColor: AppTheme.kColorSecondary,
                                      backgroundColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                    child: const Text("Batal"),
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      await openAppSettings();
                                      final status = await getPermissionStatus(
                                          androidInfo);
                                      if (context.mounted) {
                                        context.pop();
                                        if (status.isGranted) {
                                          chooseImage();
                                        }
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      surfaceTintColor: Colors.transparent,
                                      backgroundColor: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                      foregroundColor: AppTheme.kColorPrimary,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                    child: const Text("Buka Pengaturan"),
                                  ),
                                ]
                              ]);
                            }
                          } else {
                            final status = await permission.request();
                            if (status.isGranted) {
                              chooseImage();
                            }
                          }
                        }
                      },
                      shape: const CircleBorder(),
                      fillColor: isDark ? Colors.black : Colors.white,
                      child: const Icon(
                        Icons.camera_alt_outlined,
                        size: 20,
                      ),
                    ))
              ],
            ),
            Text(
              ref.watch(nameProvider),
              style: AppTheme.kTextSemiBold24,
            ),
            Text(
              "$jurusan | ${semester?.name}",
              style: AppTheme.kTextMedium18,
            ),
            const SizedBox(
              height: 10.0,
            ),
            switch (jadwal) {
              AsyncData(:final value) => StatisticCard(
                  number: value.length.toString(),
                  text:
                      "Mata Kuliah (${value.map((e) => e.sks).fold(0, (a, b) => a + b)} SKS)",
                  backgroundColor: AppTheme.kColorPrimary,
                  foregroundColor: AppTheme.kColorPrimaryDeep,
                ),
              AsyncError() => const Text("Terjadi Masalah"),
              _ => const StatisticCard(
                  leading: SizedBox(
                    width: 40,
                    height: 40,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  number: "0",
                  text: "Mata Kuliah",
                  backgroundColor: AppTheme.kColorPrimary,
                  foregroundColor: AppTheme.kColorPrimaryDeep,
                )
            },
            const SizedBox(
              height: 10.0,
            ),
            switch (tugas) {
              AsyncData(:final value) => StatisticCard(
                  number: value.length.toString(),
                  text: "Tugas",
                  backgroundColor: AppTheme.kColorSecondary,
                  foregroundColor: AppTheme.kColorSecondaryDeep,
                ),
              AsyncError() => const Text("Terjadi Masalah"),
              _ => const StatisticCard(
                  leading: SizedBox(
                    width: 40,
                    height: 40,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  number: "20",
                  text: "Tugas",
                  backgroundColor: AppTheme.kColorSecondary,
                  foregroundColor: AppTheme.kColorSecondaryDeep,
                )
            },
            const SizedBox(
              height: 20.0,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.grey.shade100.withOpacity(0.1)
                      : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: [
                    ProfileButton(
                      text: "Edit Profil",
                      onPressed: () {
                        context.goNamed("edit-profile");
                      },
                    ),
                    Divider(
                      thickness: 1.0,
                      height: 1.0,
                      color: isDark
                          ? AppTheme.kColorDarkForeground
                          : AppTheme.kColorDark,
                    ),
                    ProfileButton(
                      text: "Pengaturan",
                      onPressed: () {
                        context.goNamed("pengaturan");
                      },
                    ),
                    Divider(
                      thickness: 1.0,
                      height: 1.0,
                      color: isDark
                          ? AppTheme.kColorDarkForeground
                          : AppTheme.kColorDark,
                    ),
                    ProfileButton(
                      text: "Integrasi SIAKAD",
                      onPressed: () {
                        context.goNamed("siakad");
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
