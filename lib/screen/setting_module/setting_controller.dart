import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rhytham/screen/home_module/home_controller.dart';
import 'package:rhytham/services/user_preseance/user_preasence.dart';
import 'package:rhytham/utils/assets.dart';

class SettingController extends GetxController {
  var selectedSound = TextEditingController();
  var listSound = [
    {"name": "sound 1", "path": Play.backGroundMusic1},
    {"name": "sound 2", "path": Play.backGroundMusic2},
    {"name": "sound 3", "path": Play.backGroundMusic3},
  ];
  var totalTimeSpent = "00:00:00".obs;

  @override
  void onInit() {
    super.onInit();
    onChangeSound();
  }

  updateTime() async {
    int data = await Get.find<UserPresenceService>().updateTimeSpent();
    totalTimeSpent.value = formatSecondsToHHMMSS(data);
  }

  onChangeSound() {
    selectedSound.text = listSound
            .where(
              (element) => element["path"] == Get.find<HomeController>().sound.value,
            )
            .toList()
            .first["name"] ??
        "";
  }

  selectSound() async {
    Get.bottomSheet(Builder(
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          child: ListView(
            shrinkWrap: true,
            children: [
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20),
                child: Text(
                  "Change Sound",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                padding: const EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: listSound.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () async {
                        String? selectSound = listSound[index]["path"];
                        if (selectSound != null) {
                          Get.find<HomeController>().stopSound();
                          Get.find<HomeController>().sound.value = selectSound;
                          Get.find<HomeController>().audioSound();
                          onChangeSound();
                          if (Get.isBottomSheetOpen ?? false) {
                            Get.back();
                          }
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                listSound[index]["name"] ?? "",
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            ),
                            listSound[index]["path"] == Get.find<HomeController>().sound.value
                                ? const Icon(Icons.check)
                                : const SizedBox(),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(
                      height: 0,
                    );
                  },
                ),
              )
            ],
          ),
        );
      },
    ));
  }

  String formatSecondsToHHMMSS(int totalSeconds) {
    int hours = totalSeconds ~/ 3600; // Calculate the number of hours
    int minutes = (totalSeconds % 3600) ~/ 60; // Calculate the remaining minutes
    int seconds = totalSeconds % 60; // Calculate the remaining seconds

    // Format the time as hh:mm:ss
    String formattedTime = [
      hours.toString().padLeft(2, '0'),
      minutes.toString().padLeft(2, '0'),
      seconds.toString().padLeft(2, '0'),
    ].join(':');

    return formattedTime;
  }
}
