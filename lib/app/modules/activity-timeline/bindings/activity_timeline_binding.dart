import 'package:get/get.dart';

import '../controllers/activity_timeline_controller.dart';

class ActivityTimelineBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ActivityTimelineController>(
      () => ActivityTimelineController(),
    );
  }
}
