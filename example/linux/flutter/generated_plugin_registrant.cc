//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <base_v2/base_v2_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) base_v2_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "BaseV2Plugin");
  base_v2_plugin_register_with_registrar(base_v2_registrar);
}
