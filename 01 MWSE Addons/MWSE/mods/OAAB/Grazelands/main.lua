if not tes3.isModActive("OAAB_Grazelands.ESP") then
    return
end

require("OAAB.Grazelands.effects.flawedSummonDaedrothEffect")
require("OAAB.Grazelands.achievements")
require("OAAB.Grazelands.ssqn")

local function onLoaded(e)
    if tes3.getJournalIndex{id="OAAB_TVos_HauntedLantern"} == 30 then
        e.mobile:equip{item="ABtv_light_AshlLanternGhost"}
    end
end


local function onInitialized()
    local enchantment = tes3.getObject("ABtv_w_Verminous_en")
    if enchantment then
        -- Keep the ESP's enchantment settings and replace its vanilla summon effect.
        enchantment.effects[1].id = tes3.effect.flawedSummonDaedroth
    end
    event.register("loaded", onLoaded)
end
event.register("initialized", onInitialized)
