#ifndef FLUTTER_PLUGIN_BASE_V2_PLUGIN_H_
#define FLUTTER_PLUGIN_BASE_V2_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace base_v2 {

class BaseV2Plugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  BaseV2Plugin();

  virtual ~BaseV2Plugin();

  // Disallow copy and assign.
  BaseV2Plugin(const BaseV2Plugin&) = delete;
  BaseV2Plugin& operator=(const BaseV2Plugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace base_v2

#endif  // FLUTTER_PLUGIN_BASE_V2_PLUGIN_H_
