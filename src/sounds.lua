-- made by Uziskull

sounds = {
    inv = {
        button_click               = { Sound.load("button_click",               "sound/inv/button_click"               ), },
        inventory_close            = { Sound.load("inventory_close",            "sound/inv/inventory_close"            ), },
        inventory_open             = { Sound.load("inventory_open",             "sound/inv/inventory_open"             ), },
        item_move_denied           = { Sound.load("item_move_denied",           "sound/inv/item_move_denied"           ), },
        item_move_over_new_slot    = { Sound.load("item_move_over_new_slot_01", "sound/inv/item_move_over_new_slot_01" ),
                                       Sound.load("item_move_over_new_slot_02", "sound/inv/item_move_over_new_slot_02" ),
                                       Sound.load("item_move_over_new_slot_03", "sound/inv/item_move_over_new_slot_03" ),
                                       Sound.load("item_move_over_new_slot_04", "sound/inv/item_move_over_new_slot_04" ),
                                       Sound.load("item_move_over_new_slot_05", "sound/inv/item_move_over_new_slot_05" ), },
        item_move_success          = { Sound.load("item_move_success",          "sound/inv/item_move_success"          ), },
        item_remove                = { Sound.load("item_remove",                "sound/inv/item_remove"                ), },
        item_switch_places         = { Sound.load("item_switch_places",         "sound/inv/item_switch_places"         ), },
    },
    player = {
        pickup = {
            generic         = { Sound.load("pick_item_generic_01",  "sound/player/pickup/pick_item_generic_01" ), 
                                Sound.load("pick_item_generic_02",  "sound/player/pickup/pick_item_generic_02" ), 
                                Sound.load("pick_item_generic_03",  "sound/player/pickup/pick_item_generic_03" ), },
            perk            = { Sound.load("perk_misc",             "sound/player/pickup/perk_misc"            ), },
            wand            = { Sound.load("pickup_wand_1",         "sound/player/pickup/pickup_wand_1"        ),
                                Sound.load("pickup_wand_2",         "sound/player/pickup/pickup_wand_2"        ), },
            heart_refresh   = { Sound.load("pickup_heart_1",        "sound/player/pickup/pickup_heart_1"       ),
                                Sound.load("pickup_heart_3",        "sound/player/pickup/pickup_heart_3"       ), },
            spell_refresh   = { Sound.load("spell_refresh_01",      "sound/player/pickup/spell_refresh_01"     ), },
        },
        shop                = { Sound.load("shop_item",             "sound/player/shop_item"    ), },
        death               = { Sound.load("player_death",          "sound/player/player_death" ), },
    },
    wand = {
        mana_fully_recharged          = { Sound.load("mana_fully_recharged",          "sound/wand/mana_fully_recharged"          ), },
        not_enough_mana_for_action    = { Sound.load("not_enough_mana_for_action_01", "sound/wand/not_enough_mana_for_action_01" ),
                                          Sound.load("not_enough_mana_for_action_02", "sound/wand/not_enough_mana_for_action_02" ),
                                          Sound.load("not_enough_mana_for_action_03", "sound/wand/not_enough_mana_for_action_03" ), },
        recharging                    = { Sound.load("recharging_01",                 "sound/wand/recharging_01"                 ),
                                          Sound.load("recharging_02",                 "sound/wand/recharging_02"                 ),
                                          Sound.load("recharging_03",                 "sound/wand/recharging_03"                 ), },
        shooting_empty_wand           = { Sound.load("shooting_empty_wand_01",        "sound/wand/shooting_empty_wand_01"        ),
                                          Sound.load("shooting_empty_wand_02",        "sound/wand/shooting_empty_wand_02"        ),
                                          Sound.load("shooting_empty_wand_03",        "sound/wand/shooting_empty_wand_03"        ),
                                          Sound.load("shooting_empty_wand_04",        "sound/wand/shooting_empty_wand_04"        ),
                                          Sound.load("shooting_empty_wand_05",        "sound/wand/shooting_empty_wand_05"        ),
                                          Sound.load("shooting_empty_wand_06",        "sound/wand/shooting_empty_wand_06"        ),
                                          Sound.load("shooting_empty_wand_07",        "sound/wand/shooting_empty_wand_07"        ), },
    },
    spells = {
        arrow = {
            bullet = { Sound.load("bullet_arrow_01", "sound/spells/arrow/bullet_arrow_01"),
                       Sound.load("bullet_arrow_02", "sound/spells/arrow/bullet_arrow_02"),
                       Sound.load("bullet_arrow_03", "sound/spells/arrow/bullet_arrow_03"), },
        },
        common = {
            ricochet = { Sound.load("spell_ricochet_general1", "sound/spells/common/spell_ricochet_general1" ),
                         Sound.load("spell_ricochet_general2", "sound/spells/common/spell_ricochet_general2" ),
                         Sound.load("spell_ricochet_general3", "sound/spells/common/spell_ricochet_general3" ), },
            shoot =    { Sound.load("spell_shoot_ver3_1",      "sound/spells/common/spell_shoot_ver3_1"      ),
                         Sound.load("spell_shoot_ver3_2",      "sound/spells/common/spell_shoot_ver3_2"      ),
                         Sound.load("spell_shoot_ver3_3",      "sound/spells/common/spell_shoot_ver3_3"      ), },
            throw =    { Sound.load("spell_throw_ver1",        "sound/spells/common/spell_throw_ver1"        ),
                         Sound.load("spell_throw_ver2",        "sound/spells/common/spell_throw_ver2"        ), },
        },
        electric = {
            spark = { Sound.load("electric_spark_01", "sound/spells/electric/electric_spark_01"),
                      Sound.load("electric_spark_02", "sound/spells/electric/electric_spark_02"),
                      Sound.load("electric_spark_03", "sound/spells/electric/electric_spark_03"),
                      Sound.load("electric_spark_04", "sound/spells/electric/electric_spark_04"), },
        },
        explosive = {
            explosion = { Sound.load("explosion_medium_00", "sound/spells/common/explosion_medium_00"),
                          Sound.load("explosion_medium_01", "sound/spells/common/explosion_medium_01"),
                          Sound.load("explosion_medium_02", "sound/spells/common/explosion_medium_02"), },
            fuse =      { Sound.load("fuse_burn",           "sound/spells/common/fuse_burn"          ), },
            bomb =      { Sound.load("bomb_01",             "sound/spells/explosive/bomb_01"         ),
                          Sound.load("bomb_02",             "sound/spells/explosive/bomb_02"         ),
                          Sound.load("bomb_03",             "sound/spells/explosive/bomb_03"         ), },
            tnt =       { Sound.load("tnt_explode",         "sound/spells/explosive/tnt_explode"     ), },
        },
        fire = {
            bullet_heavy = { Sound.load("bullet_fire_heavy_01", "sound/spells/fire/bullet_fire_heavy_01" ),
                             Sound.load("bullet_fire_heavy_02", "sound/spells/fire/bullet_fire_heavy_02" ),
                             Sound.load("bullet_fire_heavy_03", "sound/spells/fire/bullet_fire_heavy_03" ), },
            bullet_small = { Sound.load("bullet_fire_small_01", "sound/spells/fire/bullet_fire_small_01" ),
                             Sound.load("bullet_fire_small_02", "sound/spells/fire/bullet_fire_small_02" ),
                             Sound.load("bullet_fire_small_03", "sound/spells/fire/bullet_fire_small_03" ), },
            flamethrower = { Sound.load("flamethrower_01",      "sound/spells/fire/flamethrower_01"      ),
                             Sound.load("flamethrower_02",      "sound/spells/fire/flamethrower_02"      ),
                             Sound.load("flamethrower_03",      "sound/spells/fire/flamethrower_03"      ),
                             Sound.load("flamethrower_04",      "sound/spells/fire/flamethrower_04"      ), },
        },
        laser = {
            bullet = { Sound.load("bullet_laser_01", "sound/spells/laser/bullet_laser_01"),
                       Sound.load("bullet_laser_02", "sound/spells/laser/bullet_laser_02"),
                       Sound.load("bullet_laser_03", "sound/spells/laser/bullet_laser_03"), },
        },
        slime = {
            acid =   { Sound.load("acid_slime_01",   "sound/spells/slime/acid_slime_01"  ),
                       Sound.load("acid_slime_02",   "sound/spells/slime/acid_slime_02"  ),
                       Sound.load("acid_slime_03",   "sound/spells/slime/acid_slime_03"  ), },
            bullet = { Sound.load("bullet_slime_01", "sound/spells/slime/bullet_slime_01"),
                       Sound.load("bullet_slime_02", "sound/spells/slime/bullet_slime_02"),
                       Sound.load("bullet_slime_03", "sound/spells/slime/bullet_slime_03"),
                       Sound.load("bullet_slime_04", "sound/spells/slime/bullet_slime_04"), },
        },
        digger = {
            loop = { Sound.load("digger_loop", "sound/spells/digger/digger_loop"), }
        }
    }
}

function getSound(...)
    local args, argc = {...}, 1
    local st = sounds
    while args[argc] ~= nil do
        st = st[args[argc]]
        argc = argc + 1
    end
    return st[math.random(#st)]
end

--==== sound loop managers ====--
sfxLoopCounter = {
    digger = -1
}

registercallback("preStep", function()
    for soundName, _ in pairs(sfxLoopCounter) do
        if sfxLoopCounter[soundName] > -1 then
            sfxLoopCounter[soundName] = sfxLoopCounter[soundName] - 1
            if sfxLoopCounter[soundName] == -1 then
                local sound = nil
                if soundName == "digger" then
                    sound = getSound("spells", "digger", "loop")
                end
                if sound:isPlaying() then
                    sound:stop()
                end
            end
        end
    end
end)