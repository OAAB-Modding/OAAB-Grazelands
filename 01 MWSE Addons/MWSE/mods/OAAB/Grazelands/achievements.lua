-- Track the MWSE summon even when the achievement framework is absent.
local function observeVerminoth()
    if not tes3.mobilePlayer or tes3.getGlobal("ABtv_Ach_Daedrat") >= 1 then
        return
    end

    for _, effect in pairs(tes3.mobilePlayer.activeMagicEffectList) do
        if effect.effectId == 7800 then
            local instance = effect.instance
            local source = instance and instance.source
            local effectInstance = effect.effectInstance
            local createdData = effectInstance and effectInstance.createdData
            local summoned = createdData and createdData.object
            local creature = summoned and summoned.baseObject
            if instance and instance.caster == tes3.player
                and source and source.id:lower() == "abtv_w_verminous_en"
                and creature and creature.id:lower() == "abtv_dae_daedrat" then
                tes3.setGlobal("ABtv_Ach_Daedrat", 1)
                return
            end
        end
    end
end

local function onInitialized()
    if not tes3.isModActive("OAAB_Grazelands.ESP") then
        return
    end

    -- Keep this callback after completion: an earlier save may still need it.
    event.register("enterFrame", observeVerminoth)
    local achievements = include("sb_achievements.interop")
    if not achievements then
        return
    end

    local category = achievements.registerCategory("OAAB Grazelands")
    local function register(id, title, desc, variable, threshold, icon, progress, hidden)
        local achievement = {
            id = id,
            title = title,
            desc = desc,
            category = category,
            icon = icon,
            colour = achievements.colours.yellow,
        }
        if hidden then
            achievement.configDesc = achievements.configDesc.groupHidden
        end
        if progress then
            achievement.conditionType = achievements.conditionType.progressAmount
            achievement.progress = function() return tes3.getGlobal(variable) end
            achievement.progressMax = function() return threshold end
        else
            achievement.conditionType = achievements.conditionType.instant
            achievement.condition = function() return tes3.getGlobal(variable) >= threshold end
        end
        achievements.registerAchievement(achievement)
    end

    register("oaabgl_passwalls", "Walls Are a Suggestion",
        "Use all four Passwall doors connecting the Tel Vos towers.",
        "ABtv_Ach_Passwalls", 4, "Icons\\OAAB\\v\\achievement_passwall.tga", true)
    register("oaabgl_doomscrolling", "Doom Scrolling",
        "Print all eight unique summon scroll recipes.",
        "ABtv_Ach_PrintCount", 8, "Icons\\OAAB\\v\\achievement_doomscroll.tga", true)
    register("oaabgl_dwemerhead", "Speaking Its Language",
        "Solve the Dwemer talking helm's puzzle.",
        "ABtv_Ach_DwemerHead", 1, "Icons\\OAAB\\v\\achievement_talkinghead.tga")
    register("oaabgl_daedrat", "Oblivious Vermin",
        "Summon a Verminoth with the Verminous Spear.",
        "ABtv_Ach_Daedrat", 1, "Icons\\OAAB\\v\\achievement_vermin.tga", false, true)
    register("oaabgl_moonreiver", "Do You Know Who My Sword Is?",
        "Intimidate the scamp thief using the Moon Reiver.",
        "ABtv_Ach_MoonReiver", 1, "Icons\\OAAB\\v\\achievement_swordscamp.tga", false, true)
    register("oaabgl_ngasta", "Forbidden Reading",
        "Learn Lesser Soulsnare.",
        "ABtv_Ach_Ngasta", 1, "Icons\\OAAB\\v\\achievement_ngasta.tga", false, true)
    register("oaabgl_jailtalk", "An Honest Misunderstanding",
        "Talk Goler Andrethi into releasing you with Speechcraft or Illusion.",
        "ABtv_Ach_JailTalk", 1, "Icons\\OAAB\\v\\achievement_misunderstanding.tga", false, true)
    register("oaabgl_amulet", "Lost Property",
        "Find the missing Fire Barrier Amulet.",
        "ABtv_Ach_Amulet", 1, "Icons\\OAAB\\v\\achievement_fireamulet.tga", false, true)
    register("oaabgl_monarchsoul", "Bottle the Blaze",
        "Capture the Molaguradan Flame Monarch's soul in a soul gem.",
        "ABtv_Ach_MonarchSoul", 1, "Icons\\OAAB\\v\\achievement_bottleblaze.tga", false, true)
    register("oaabgl_wholesale", "Wholesale",
        "Buy five ebony from Ganald in a single transaction.",
        "ABtv_Ach_Wholesale", 1, "Icons\\OAAB\\v\\achievement_wholesale.tga", false, true)
    register("oaabgl_bigcheese", "The Big Cheese",
        "Receive Burcanius Varo's five-scuttle weekly payout.",
        "ABtv_Ach_BigCheese", 1, "Icons\\OAAB\\v\\achievement_cheese.tga", false, true)
    register("oaabgl_museum", "Master Curator",
        "Complete the Dwemer Museum's final tier.",
        "ABtv_DwemerMuseumStage", 4, "Icons\\OAAB\\v\\achievement_dwemuseum.tga")
end

event.register("initialized", onInitialized)
