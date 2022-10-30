import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return Scaffold(
      body: Container(
        child: ListView.builder(
            itemCount: controller.topics.length,
            itemBuilder: (context, i) {
              return ListTile(
                onTap: () {},
                title: Text(controller.topics[i]),
                trailing: ElevatedButton(
                  onPressed: () async {
                    print(await FirebaseMessaging.instance.getToken());

                    if (controller.topicSubscribe
                        .contains(controller.topics[i])) {
                      controller.topicSubscribe.remove(controller.topics[i]);
                      FirebaseMessaging.instance
                          .unsubscribeFromTopic(controller.topics[i]);
                      print("desabonner");
                    } else {
                      controller.topicSubscribe.add(controller.topics[i]);
                      FirebaseMessaging.instance
                          .subscribeToTopic(controller.topics[i]);
                      print("abonner");
                    }
                  },
                  child: Obx(() {
                    return Text(
                      controller.topicSubscribe.value
                              .contains(controller.topics[i])
                          ? "Désabonner"
                          : "abonné",
                    );
                  }),
                ),
              );
            }),
      ),
    );
  }
}
