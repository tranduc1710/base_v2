import 'base_v2_platform_interface.dart';

export 'config/style.dart';
export 'extends/extensions.dart';
export 'extends/inherited.dart';

class BaseV2 {
  Future<String?> getPlatformVersion() {
    return BaseV2Platform.instance.getPlatformVersion();
  }
}
