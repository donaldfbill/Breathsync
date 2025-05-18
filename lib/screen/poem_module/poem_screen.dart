import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rhytham/screen/poem_module/poem_controller.dart';

class PoemScreen extends GetView<PoemController> {
  const PoemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0),
        leading: IconButton(
          tooltip: 'Go back',
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios_outlined),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                  child: const Text(
                    'In Tantric yoga, done with a lover, the first thing to do is match the breath and breathe together. This makes an intimite connection, a feeling of one-ness, unity and the beginnings of love. These feelings are magnified in a group with common intention. But timing is everything, and this app is tuned to the world-wide GPS timing signal. Instead of random breathing, Breathsync allows coherentcy and the the experience of Universal, Unconditional Love with everyone who is turned on and tuned in to this completely free app, anytime day or night anywhere on Earth.\nThe AI, chatGPT was asked: "what would happen if everyone breathed together?" It answered:',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700, color: Color(0XFF3A304E), letterSpacing: 1.0),
                  ),
                ),
                Column(
                  children: controller.poem
                      .map((e) => Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
                            child: Text(
                              e,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w700,
                                color: Color(0XFF3A304E),
                                letterSpacing: 1.0,
                              ),
                            ),
                          ))
                      .toList(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
                  child: const Text(
                    "Do not use this app while driving or operating heavy equipment.Try using it lying down. can be used as a sleep aid. Virus free. You will not be tracked nor survailed.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w700,
                      color: Color(0XFF3A304E),
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: const Text(
                "Copyright Don Bill 2024",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w700,
                  color: Color(0XFF3A304E),
                  letterSpacing: 1.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
