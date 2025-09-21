--- a/rotation.lua
+++ b/rotation.lua
@@
--- This shit fires all the time... wtf blizz, don't be stupid.
-ProbablyEngine.listener.register("PLAYER_SPECIALIZATION_CHANGED", function(...)
-  local unitID = ...
-  if unitID == "player" then
-    if GetSpecialization() then
-      local id, name, description, icon, background, role = GetSpecializationInfo(GetSpecialization())
-      if id ~= ProbablyEngine.module.player.specId then
-        ProbablyEngine.buttons.icon('MasterToggle', icon)
-        ProbablyEngine.module.player.specId = id
-        ProbablyEngine.module.player.specName = name
-        ProbablyEngine.rotation.activeRotation = ProbablyEngine.rotation.rotations[ProbablyEngine.module.player.specId]
-        if ProbablyEngine.rotation.oocrotations[ProbablyEngine.module.player.specId] then
-          ProbablyEngine.rotation.activeOOCRotation = ProbablyEngine.rotation.oocrotations[ProbablyEngine.module.player.specId]
-        else
-          ProbablyEngine.rotation.activeOOCRotation = false
-        end
-        ProbablyEngine.print(ProbablyEngine.rotation.specId[id] .. " rotation loaded!")
-      end
-    else
-      ProbablyEngine.module.player.specId = false
-    end
-  end
-end)
+-- 3.3.5a replacement: detect spec from talents instead of specialization API
+ProbablyEngine.listener.register("PLAYER_TALENT_UPDATE", function(...)
+  local unitID = ...
+  if unitID == "player" or not unitID then
+    local id = GetPlayerSpecId()
+    if id and id ~= ProbablyEngine.module.player.specId then
+      ProbablyEngine.module.player.specId = id
+      ProbablyEngine.module.player.specName = ProbablyEngine.rotation.specId[id]
+      ProbablyEngine.rotation.activeRotation = ProbablyEngine.rotation.rotations[id]
+      if ProbablyEngine.rotation.oocrotations[id] then
+        ProbablyEngine.rotation.activeOOCRotation = ProbablyEngine.rotation.oocrotations[id]
+      else
+        ProbablyEngine.rotation.activeOOCRotation = false
+      end
+      ProbablyEngine.print(ProbablyEngine.rotation.specId[id] .. " rotation loaded!")
+    elseif not id then
+      ProbablyEngine.module.player.specId = false
+    end
+  end
+end)
