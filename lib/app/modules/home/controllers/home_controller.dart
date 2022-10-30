import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

import '../../../../utils/notification.dart';

class HomeController extends GetxController {
  List<String> topics = ["Damso", "Fior_de_bior", "JR", "didi_b", "JD"];
  final topicSubscribe = [].obs;
  LocalNotification? localNotification = LocalNotification();
  @override
  void onInit() {
    print("INITTTTTTTTTTTTTT");
    super.onInit();
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print("tttttttttttttttttttttttttttttttttttttttttttt");

      // localNotification!.show(
      //   event.notification!.title!,
      //   event.notification!.body!,
      // );
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('Message clicked!');
    });
  }

  addToList(String newV) {
    topicSubscribe.add(newV);
  }
}
