import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'base_v2_method_channel.dart';

abstract class BaseV2Platform extends PlatformInterface {
  /// Constructs a BaseV2Platform.
  BaseV2Platform() : super(token: _token);

  static final Object _token = Object();

  static BaseV2Platform _instance = MethodChannelBaseV2();

  /// The default instance of [BaseV2Platform] to use.
  ///
  /// Defaults to [MethodChannelBaseV2].
  static BaseV2Platform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [BaseV2Platform] when
  /// they register themselves.
  static set instance(BaseV2Platform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
