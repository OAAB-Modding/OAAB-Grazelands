local function onInitialized()
    local ssqn = include("SSQN.interop")
    if not ssqn then
        return
    end

    local registeredIcons = require("SSQN.iconlist")
    local telvanni = "\\Icons\\SSQN\\HT.dds"
    local ashlander = "\\Icons\\SSQN\\ash.dds"
    local icons = {
        MV_OutcastAshlandersGuar = ashlander,
        OAAB_TVos_AshlanderEbony = telvanni,
        OAAB_TVos_BenBandits = telvanni,
        OAAB_TVos_ConservatoryWater = telvanni,
        OAAB_TVos_DwemerMuseum = telvanni,
        OAAB_TVos_GalosIndoranyon = telvanni,
        OAAB_TVos_GalosLesson = telvanni,
        OAAB_TVos_GalosLetter = telvanni,
        OAAB_TVos_GalosMouth = telvanni,
        OAAB_TVos_GalosTallow = telvanni,
        OAAB_TVos_HauntedLantern = ashlander,
        OAAB_TVos_Molaguradan = telvanni,
        OAAB_TVos_MolaguradanMonarch = telvanni,
        OAAB_TVos_MoraTrader = telvanni,
        OAAB_TVos_RootOfTheProblem = telvanni,
        OAAB_TVos_SmokeskinWillpower = telvanni,
        OAAB_TVos_VaroRats = telvanni,
        OAAB_TVos_VenduThief = telvanni,
    }

    for id, icon in pairs(icons) do
        if not registeredIcons[id] then
            ssqn.registerQIcon(id, icon)
        end
    end
end

-- Let SSQN icon packs register their icons first.
event.register("initialized", onInitialized, { priority = -10 })
