
import 'base_v2_platform_interface.dart';

class BaseV2 {
  Future<String?> getPlatformVersion() {
    return BaseV2Platform.instance.getPlatformVersion();
  }
}
