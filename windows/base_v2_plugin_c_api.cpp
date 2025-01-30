#include "include/base_v2/base_v2_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "base_v2_plugin.h"

void BaseV2PluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  base_v2::BaseV2Plugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
