package = "kong-plugin-argonath-kenny-loggins"
version = "0.0.4-1"
source = {
   url = "git://github.com/cloud-elements/argonath-kenny-loggins.git",
   tag = "v0.0.4"
}
description = {
   summary = "A Kong plugin to handle Cloud Elements audit logging"
}
dependencies = {
   "lua >= 5.1"
}
build = {
   type = "builtin",
   modules = {
      ["kong.plugins.argonath-kenny-loggins.handler"] = "src/handler.lua",
      ["kong.plugins.argonath-kenny-loggins.schema"] = "src/schema.lua",
      ["kong.plugins.argonath-kenny-loggins.serializer"] = "src/serializer.lua"
   }
}
