import 'package:myclub/services/http_service.dart';
import 'package:get/get.dart';

class MissionController extends GetxController {
  var isLoading = true.obs;
  var missionList = [].obs;

  @override
  void onInit() {
    fetchData();
    print("lol");
    super.onInit();
  }

  void fetchData() async {
    try {
      isLoading(true);
      var missions = await HttpService.fetchMissions();
      if (missions != null) {
        // print(missions.length);

        missionList.value = missions;
        // print(missionList.value);

      }
    } finally {
      isLoading(false);
    }
  }
}
