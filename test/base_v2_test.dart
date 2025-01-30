import 'package:flutter_test/flutter_test.dart';
import 'package:base_v2/base_v2.dart';
import 'package:base_v2/base_v2_platform_interface.dart';
import 'package:base_v2/base_v2_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockBaseV2Platform
    with MockPlatformInterfaceMixin
    implements BaseV2Platform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final BaseV2Platform initialPlatform = BaseV2Platform.instance;

  test('$MethodChannelBaseV2 is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelBaseV2>());
  });

  test('getPlatformVersion', () async {
    BaseV2 baseV2Plugin = BaseV2();
    MockBaseV2Platform fakePlatform = MockBaseV2Platform();
    BaseV2Platform.instance = fakePlatform;

    expect(await baseV2Plugin.getPlatformVersion(), '42');
  });
}
