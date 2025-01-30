import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'base_v2_platform_interface.dart';

/// An implementation of [BaseV2Platform] that uses method channels.
class MethodChannelBaseV2 extends BaseV2Platform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('base_v2');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
