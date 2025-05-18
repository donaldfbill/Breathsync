import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rhytham/screen/setting_module/setting_controller.dart';
import 'package:rhytham/services/user_preseance/user_preasence.dart';
import 'package:rhytham/utils/assets.dart';

class SettingScreen extends GetView<SettingController> {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0),
        title: Text(
          "Settings",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        leading: IconButton(
          tooltip: 'Go back',
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios_outlined),
        ),
        centerTitle: true,
      ),
      body: Stack(children: [
        Container(height: double.infinity,width: double.infinity,child:
          Image.asset(Assets.background, fit: BoxFit.fill,),),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Change Sounds",
                style: Theme.of(context).textTheme.titleMedium?.apply(fontWeightDelta: 1),
              ),
              InkWell(
                onTap: () {
                  controller.selectSound();
                },
                child: TextField(
                  controller: controller.selectedSound,
                  textInputAction: TextInputAction.done,
                  style: Theme.of(context).textTheme.titleMedium,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.keyboard_arrow_down),
                      hintText: "No Sound Selected",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(width: 3, color: Colors.black)),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(width: 2, color: Colors.grey)),
                      enabled: false,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 10)),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Spent time",
                style: Theme.of(context).textTheme.titleMedium?.apply(fontWeightDelta: 1),
              ),
              StreamBuilder<int>(
                stream: Get.find<UserPresenceService>().getActiveUser(),
                builder: (context, snapshot) {
                  return Text(
                    controller.formatSecondsToHHMMSS(snapshot.data ?? 0),
                    style: Theme.of(context).textTheme.titleSmall,
                  );
                },
              ),
              // Obx(
              //   () => Text(
              //     controller.totalTimeSpent.value,
              //     style: Theme.of(context).textTheme.titleMedium,
              //   ),
              // )
            ],
          ),
        ),
      ]),
    );
  }
}
