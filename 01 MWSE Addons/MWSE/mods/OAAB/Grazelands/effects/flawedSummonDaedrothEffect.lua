tes3.claimSpellEffectId("flawedSummonDaedroth", 7800)

event.register("magicEffectsResolved", function()
    tes3.addMagicEffect({
        id = tes3.effect.flawedSummonDaedroth,
        name = "Flawed Summon Daedroth",
        description = "This effect supposedly summons a Daedroth from Oblivion."
            .. " It should appear six feet in front of the caster and attack any entity that attacks the caster until"
            .. " the effect ends or the summoning is killed. At death, or when the effect ends, the summoning"
            .. " disappears, returning to Oblivion. But the enchantment appears to be flawed somehow...",
        school = tes3.magicSchool.conjuration,
        baseCost = 36,
        speed = 1,
        allowEnchanting = true,
        allowSpellmaking = true,
        appliesOnce = true,
        canCastSelf = true,
        canCastTarget = false,
        canCastTouch = false,
        casterLinked = true,
        hasContinuousVFX = false,
        hasNoDuration = false,
        hasNoMagnitude = true,
        illegalDaedra = false,
        isHarmful = false,
        nonRecastable = false,
        targetsAttributes = false,
        targetsSkills = false,
        unreflectable = false,
        usesNegativeLighting = false,
        icon = "OAAB\\e\\smn_daedrothFlawed.dds",
        particleTexture = "vfx_conj_flare02.tga",
        castSound = "conjuration cast",
        castVFX = "VFX_ConjureCast",
        boltSound = "conjuration bolt",
        boltVFX = "VFX_DefaultBolt",
        hitSound = "conjuration hit",
        hitVFX = "VFX_DefaultHit",
        areaSound = "conjuration area",
        areaVFX = "VFX_DefaultArea",
        lighting = { 0.99, 0.95, 0.67 },
        size = 1,
        sizeCap = 50,
        onTick = function(e)
            e:triggerSummon("ABtv_Dae_Daedrat")
        end
    })
end)
