-- made by Uziskull

------------------================== SPELLS ==================------------------
allSpells = {
    sparkBolt = function()
        local sprite = Sprite.find("caster_spells_sparkBolt", modloader.getActiveNamespace())
        if sprite == nil then
            sprite = Sprite.load("caster_spells_sparkBolt", "spr/spells/proj/sparkBolt/icon", 1, 0, 0)
        end
        return {
            internalName = "sparkBolt",
            name = "Spark Bolt",
            type = spellType.PROJECTILE,
            desc = "A weak sparkling projectile",
            maxCount = -1,
            count = -1,
            damage = getRoRifiedDamage(3),
            explosion = nil,
            manaCost = 5,
            castDelay = 0.05,
            rechargeTime = 0,
            speed = getRoRifiedSpeed(800),
            degree = 0,
            weight = 0,
            sprites = {
                icon = sprite,
                proj = {
                    spr = spellIconToProj(sprite, 0.5),
                    speed = 1
                },
                hit = Sprite.find("BugChunk", "vanilla") --Sprite.load("caster_spells_magicMissile_hit", "spr/spells/magicMissile_hit", 4, 10, 8)
            },
            fireSound = getSound("spells", "common", "shoot"),
            properties = {},
            callback = {
                step = function(self)
                    if misc.getOption("video.quality") == 3 then
                        local projData = self:getData()
                        local angle = math.deg(math.atan2(-projData.vector[2], projData.vector[1]))
                        projParticles.blur(angle):burst("above", self.x, self.y, math.random(2), Color.PURPLE)
                    end
                end,
                draw = nil,
                hitEnemy = commonFuncs.projEnemyHit,
                hitWall = function(self, hitAngle)
                    -- TODO: display hit sprite
                    self:destroy()
                    return
                end,
                destroy = nil
            }
        }
    end,
    bomb = function()
        local sprite = Sprite.find("caster_spells_bomb", modloader.getActiveNamespace())
        local spriteProj = Sprite.find("caster_spells_bomb_proj", modloader.getActiveNamespace())
        if sprite == nil then
            sprite = Sprite.load("caster_spells_bomb", "spr/spells/proj/bomb/icon", 1, 0, 0)
        end
        if spriteProj == nil then
            spriteProj = Sprite.load("caster_spells_bomb_proj", "spr/spells/proj/bomb/proj", 1, 6, 6)
        end
        return {
            internalName = "bomb",
            name = "Bomb",
            type = spellType.PROJECTILE,
            desc = "Summon a bomb",
            maxCount = 3,
            count = 3,
            damage = getRoRifiedDamage(500),
            explosion = {30, 30},
            manaCost = 25,
            castDelay = 1.67,
            rechargeTime = 0,
            speed = getRoRifiedSpeed(10),
            degree = 0,
            weight = 7,
            sprites = {
                icon = sprite,
                proj = {
                    spr = spriteProj,
                    speed = 1
                },
                hit = Sprite.find("EfBombExplode", "vanilla") --Sprite.load("caster_spells_bomb_hit", "spr/spells/bomb_hit", 4, 10, 8)
            },
            fireSound = getSound("spells", "explosive", "bomb"),
            properties = {
                solid = true
            },
            callback = {
                step = function(self)
                    projData = self:getData()
                    local player = projData.player
                    local spell = projData.spell
                    
                    -- rotate bomb based on current speed
                    self.angle = (self.angle - projData.currentVector[1] / 5) % 360
                    
                    -- fuse sound
                    local fuseSound = getSound("spells", "explosive", "fuse")
                    if not fuseSound:isPlaying() then
                        fuseSound:play(1, 0.25)
                    end
                    
                    -- if fuse runs out, kaboom
                    if projData.life == 1.5 * 60 then
                        local damager = player:fireExplosion(
                            self.x, self.y,
                            spell.explosion[1] / 19, spell.explosion[2] / 4,
                            spell.damage,
                            spell.sprites.hit
                        )
                        
                        local damagerData = damager:getData()
                        if spell.callback ~= nil and spell.callback.destroy ~= nil then
                            damagerData.spellFunc = spell.callback.destroy
                        end
                        if projData.modifier ~= nil and projData.modifier.destroy ~= nil then
                            damagerData.modFunc = projData.modifier.destroy
                        end
        
                        if fuseSound:isPlaying() then
                            fuseSound:stop()
                        end
                        getSound("spells", "explosive", "explosion"):play()
                        
                        if misc.getOption("video.quality") == 3 then
                            ParticleType.find("Spark"):burst("above", self.x, self.y, 10)
                        end
                        
                        self:destroy()
                    end
                    return
                end,
                draw = nil,
                hitWall = nil,
                hitEnemy = nil,
                destroy = nil
            }
        }
    end,
    tnt = function()
        local sprite = Sprite.find("caster_spells_tnt", modloader.getActiveNamespace())
        local spriteProj = Sprite.find("caster_spells_tnt_proj", modloader.getActiveNamespace())
        if sprite == nil then
            sprite = Sprite.load("caster_spells_tnt", "spr/spells/proj/tnt/icon", 1, 0, 0)
        end
        if spriteProj == nil then
            spriteProj = Sprite.load("caster_spells_tnt_proj", "spr/spells/proj/tnt/proj", 1, 3, 4)
        end
        return {
            internalName = "tnt",
            name = "TNT",
            type = spellType.PROJECTILE,
            desc = "Summon an explosive",
            maxCount = 16,
            count = 16,
            damage = getRoRifiedDamage(250),
            explosion = {15, 15},
            manaCost = 50,
            castDelay = 0.83,
            rechargeTime = 0,
            speed = getRoRifiedSpeed(800),
            degree = 6,
            weight = 7,
            sprites = {
                icon = sprite,
                proj = {
                    spr = spriteProj,
                    speed = 1
                },
                hit = Sprite.find("EfSmoke", "vanilla") --Sprite.load("caster_spells_bomb_hit", "spr/spells/bomb_hit", 4, 10, 8)
            },
            fireSound = getSound("spells", "explosive", "bomb"),
            properties = {
                solid = true
            },
            callback = {
                step = function(self)
                    projData = self:getData()
                    local player = projData.player
                    local spell = projData.spell
                    
                    -- rotate tnt based on current speed
                    self.angle = (self.angle - projData.currentVector[1] / 5) % 360
                    
                    -- fuse sound
                    local fuseSound = getSound("spells", "explosive", "fuse")
                    if not fuseSound:isPlaying() then
                        fuseSound:play(1, 0.25)
                    end
                    
                    -- if fuse runs out, kaboom
                    if projData.life == 1.5 * 60 then
                        local damager = player:fireExplosion(
                            self.x, self.y,
                            spell.explosion[1] / 19, spell.explosion[2] / 4,
                            spell.damage,
                            spell.sprites.hit
                        )
                        
                        local damagerData = damager:getData()
                        if spell.callback ~= nil and spell.callback.destroy ~= nil then
                            damagerData.spellFunc = spell.callback.destroy
                        end
                        if projData.modifier ~= nil and projData.modifier.destroy ~= nil then
                            damagerData.modFunc = projData.modifier.destroy
                        end
                        
                        if fuseSound:isPlaying() then
                            fuseSound:stop()
                        end
                        getSound("spells", "explosive", "tnt"):play()
                        
                        if misc.getOption("video.quality") == 3 then
                            ParticleType.find("Spark"):burst("above", self.x, self.y, 5)
                        end
                        
                        self:destroy()
                    end
                    return
                end,
                draw = nil,
                hitWall = nil,
                hitEnemy = nil,
                destroy = nil
            }
        }
    end,
    bouncingBurst = function()
        local sprite = Sprite.find("caster_spells_bouncingBurst", modloader.getActiveNamespace())
        local spriteProj = Sprite.find("caster_spells_bouncingBurst_proj", modloader.getActiveNamespace())
        if sprite == nil then
            sprite = Sprite.load("caster_spells_bouncingBurst", "spr/spells/proj/bouncingBurst/icon", 1, 0, 0)
        end
        if spriteProj == nil then
            spriteProj = Sprite.load("caster_spells_bouncingBurst_proj", "spr/spells/proj/bouncingBurst/proj", 4, 3, 3)
        end
        return {
            internalName = "bouncingBurst",
            name = "Bouncing Burst",
            type = spellType.PROJECTILE,
            desc = "A very bouncy projectile",
            maxCount = -1,
            count = -1,
            damage = getRoRifiedDamage(3),
            explosion = nil,
            manaCost = 5,
            castDelay = -0.03,
            rechargeTime = 0,
            speed = getRoRifiedSpeed(700),
            degree = 0,
            weight = 2,
            sprites = {
                icon = sprite,
                proj = {
                    spr = spriteProj,
                    speed = 1
                },
                hit = Sprite.find("BugChunk", "vanilla") --Sprite.load("caster_spells_bouncingBurst_hit", "spr/spells/bouncingBurst_hit", 4, 10, 8)
            },
            fireSound = getSound("spells", "common", "shoot"),
            properties = {
                bounce = CONST_BOUNCE_FALLBACK
            },
            callback = {
                step = function(self)
                    if misc.getOption("video.quality") == 3 then
                        local projData = self:getData()
                        local angle = math.deg(math.atan2(-projData.vector[2], projData.vector[1]))
                        projParticles.blur(angle):burst("above", self.x, self.y, math.random(2), Color.LIME)
                    end
                end,
                draw = nil,
                hitEnemy = commonFuncs.projEnemyHit,
                hitWall = nil,
                destroy = nil
            }
        }
    end,
    summonArrow = function()
        local sprite = Sprite.find("caster_spells_summonArrow", modloader.getActiveNamespace())
        local spriteProj = Sprite.find("caster_spells_summonArrow_proj", modloader.getActiveNamespace())
        if sprite == nil then
            sprite = Sprite.load("caster_spells_summonArrow", "spr/spells/proj/summonArrow/icon", 1, 0, 0)
        end
        if spriteProj == nil then
            spriteProj = Sprite.load("caster_spells_summonArrow_proj", "spr/spells/proj/summonArrow/proj", 1, 2, 2)
        end
        return {
            internalName = "summonArrow",
            name = "Summon Arrow",
            type = spellType.PROJECTILE,
            desc = "Summons an arrow",
            maxCount = -1,
            count = -1,
            damage = getRoRifiedDamage(5),
            explosion = nil,
            manaCost = 15,
            castDelay = 0.17,
            rechargeTime = 0,
            speed = getRoRifiedSpeed(600),
            degree = 0.6,
            weight = 5,
            sprites = {
                icon = sprite,
                proj = {
                    spr = spriteProj,
                    speed = 1
                },
                hit = Sprite.find("BugChunk", "vanilla") --Sprite.load("caster_spells_bouncingBullet_hit", "spr/spells/bouncingBullet_hit", 4, 10, 8)
            },
            fireSound = getSound("spells", "arrow", "bullet"),
            properties = {},
            callback = {
                step = nil,
                draw = nil,
                hitEnemy = commonFuncs.projEnemyHit,
                hitWall = nil,
                destroy = nil
            }
        }
    end,
    firebolt = function()
        local sprite = Sprite.find("caster_spells_firebolt", modloader.getActiveNamespace())
        local spriteProj = Sprite.find("caster_spells_firebolt_proj", modloader.getActiveNamespace())
        if sprite == nil then
            sprite = Sprite.load("caster_spells_firebolt", "spr/spells/proj/firebolt/icon", 1, 0, 0)
        end
        if spriteProj == nil then
            spriteProj = Sprite.load("caster_spells_firebolt_proj", "spr/spells/proj/firebolt/proj", 4, 3, 3)
        end
        return {
            internalName = "firebolt",
            name = "Firebolt",
            type = spellType.PROJECTILE,
            desc = "A bouncy, explosive bolt",
            maxCount = 25,
            count = 25,
            damage = getRoRifiedDamage(45),
            explosion = {5, 5},
            manaCost = 50,
            castDelay = 0.50,
            rechargeTime = 0,
            speed = getRoRifiedSpeed(265),
            degree = 2.9,
            weight = 5,
            sprites = {
                icon = sprite,
                proj = {
                    spr = spriteProj,
                    speed = 0.5
                },
                hit = Sprite.find("BugChunk", "vanilla") --Sprite.load("caster_spells_bouncingBullet_hit", "spr/spells/bouncingBullet_hit", 4, 10, 8)
            },
            fireSound = getSound("spells", "fire", "bullet_heavy"),
            properties = {
                bounce = CONST_BOUNCE_FALLBACK
            },
            callback = {
                step = function(self)
                    if misc.getOption("video.quality") == 3 then
                        local flame = ParticleType.find("Dust1", "vanilla")
                        flame:color(Color.ROR_YELLOW, Color.WHITE)
                        flame:life(30, 30)
                        flame:size(0.025, 0.075, -0.00033, 0)
                        flame:alpha(1, 0)
                        flame:burst("above", self.x, self.y, math.random(2,3))
                        return
                    end
                end,
                draw = nil,
                hitEnemy = commonFuncs.projEnemyHit,
                hitWall = nil,
                destroy = function(enemy, _, _, _)
                    if enemy ~= nil then
                        if enemy:hasBuff(buffs.burning.buff) then
                            enemy:removeBuff(buffs.burning.buff)
                        end
                        enemy:applyBuff(buffs.burning.buff, 60 * 2)
                    end
                end
            }
        }
    end,
    magicArrow = function()
        local sprite = Sprite.find("caster_spells_magicArrow", modloader.getActiveNamespace())
        local spriteProj = Sprite.find("caster_spells_magicArrow_proj", modloader.getActiveNamespace())
        if sprite == nil then
            sprite = Sprite.load("caster_spells_magicArrow", "spr/spells/proj/magicArrow/icon", 1, 0, 0)
        end
        if spriteProj == nil then
            spriteProj = Sprite.load("caster_spells_magicArrow_proj", "spr/spells/proj/magicArrow/proj", 1, 1, 2)
        end
        return {
            internalName = "magicArrow",
            name = "Magic Arrow",
            type = spellType.PROJECTILE,
            desc = "A handy magical arrow",
            maxCount = -1,
            count = -1,
            damage = getRoRifiedDamage(10),
            explosion = nil,
            manaCost = 20,
            castDelay = 0.07,
            rechargeTime = 0,
            speed = getRoRifiedSpeed(625),
            degree = 1,
            weight = 0,
            sprites = {
                icon = sprite,
                proj = {
                    spr = spriteProj,
                    speed = 1
                },
                hit = Sprite.find("BugChunk", "vanilla") --Sprite.load("caster_spells_bouncingBullet_hit", "spr/spells/bouncingBullet_hit", 4, 10, 8)
            },
            fireSound = getSound("spells", "common", "throw"),
            properties = {},
            callback = {
                step = nil,
                draw = nil,
                hitEnemy = commonFuncs.projEnemyHit,
                hitWall = nil,
                destroy = nil
            }
        }
    end,
    magicBolt = function()
        local sprite = Sprite.find("caster_spells_magicBolt", modloader.getActiveNamespace())
        local spriteProj = Sprite.find("caster_spells_magicBolt_proj", modloader.getActiveNamespace())
        if sprite == nil then
            sprite = Sprite.load("caster_spells_magicBolt", "spr/spells/proj/magicBolt/icon", 1, 0, 0)
        end
        if spriteProj == nil then
            spriteProj = Sprite.load("caster_spells_magicBolt_proj", "spr/spells/proj/magicBolt/proj", 4, 7, 8)
        end
        return {
            internalName = "magicBolt",
            name = "Magic Bolt",
            type = spellType.PROJECTILE,
            desc = "A powerful magical projectile",
            maxCount = -1,
            count = -1,
            damage = getRoRifiedDamage(12.75),
            explosion = nil,
            manaCost = 30,
            castDelay = 0.12,
            rechargeTime = 0,
            speed = getRoRifiedSpeed(675),
            degree = 2.5,
            weight = 0,
            sprites = {
                icon = sprite,
                proj = {
                    spr = spriteProj,
                    speed = 0.5
                },
                hit = Sprite.find("BugChunk", "vanilla") --Sprite.load("caster_spells_bouncingBullet_hit", "spr/spells/bouncingBullet_hit", 4, 10, 8)
            },
            fireSound = getSound("spells", "common", "throw"),
            properties = {},
            callback = {
                step = function(self)
                    if misc.getOption("video.quality") == 3 then
                        local projData = self:getData()
                        local angle = math.deg(math.atan2(-projData.vector[2], projData.vector[1]))
                        projParticles.blur(angle):burst("above", self.x, self.y, math.random(2), Color.LIME)
                    end
                end,
                draw = nil,
                hitEnemy = commonFuncs.projEnemyHit,
                hitWall = function(self, hitAngle)
                    -- TODO: display hit sprite
                    self:destroy()
                    return
                end,
                destroy = nil
            }
        }
    end,
    acidBall = function()
        local sprite = Sprite.find("caster_spells_acidBall", modloader.getActiveNamespace())
        local spriteProj = Sprite.find("caster_spells_acidBall_proj", modloader.getActiveNamespace())
        if sprite == nil then
            sprite = Sprite.load("caster_spells_acidBall", "spr/spells/proj/acidBall/icon", 1, 0, 0)
        end
        if spriteProj == nil then
            spriteProj = Sprite.load("caster_spells_acidBall_proj", "spr/spells/proj/acidBall/proj", 4, 11, 11)
        end
        return {
            internalName = "acidBall",
            name = "Acid Ball",
            type = spellType.PROJECTILE,
            desc = "A terrifying acidic projectile",
            maxCount = 20,
            count = 20,
            damage = getRoRifiedDamage(6),
            explosion = nil,
            manaCost = 20,
            castDelay = 0.17,
            rechargeTime = 0,
            speed = getRoRifiedSpeed(90),
            degree = 0,
            weight = 0,
            sprites = {
                icon = sprite,
                proj = {
                    spr = spriteProj,
                    speed = 0.25
                },
                hit = Sprite.find("BugChunk", "vanilla") --Sprite.load("caster_spells_bouncingBullet_hit", "spr/spells/bouncingBullet_hit", 4, 10, 8)
            },
            fireSound = getSound("spells", "slime", "bullet"),
            properties = {},
            callback = {
                step = function(self)
                    local projData = self:getData()
                    if projData.life == 60 then
                        self:destroy()
                    end
                end,
                draw = nil,
                hitEnemy = commonFuncs.projEnemyHit,
                hitWall = nil,
                destroy = function(enemy, _, _, _)
                    if enemy ~= nil then
                        if enemy:hasBuff(buffs.poison.buff) then
                            enemy:removeBuff(buffs.poison.buff)
                        end
                        enemy:applyBuff(buffs.poison.buff, 60)
                    end
                end
            }
        }
    end,
    chainsaw = function()
        local sprite = Sprite.find("caster_spells_chainsaw", modloader.getActiveNamespace())
        local spriteProj = Sprite.find("caster_spells_chainsaw_proj", modloader.getActiveNamespace())
        if sprite == nil then
            sprite = Sprite.load("caster_spells_chainsaw", "spr/spells/proj/chainsaw/icon", 1, 0, 0)
        end
        if spriteProj == nil then
            spriteProj = Sprite.load("caster_spells_chainsaw_proj", "spr/spells/proj/chainsaw/proj", 1, 0, 0)
        end
        return {
            internalName = "chainsaw",
            name = "Chainsaw",
            type = spellType.PROJECTILE,
            desc = "Good for digging meat",
            maxCount = -1,
            count = -1,
            damage = getRoRifiedDamage(1),
            explosion = {5, 5},
            manaCost = 0,
            castDelay = nil, -- sets entire delay to 0
            rechargeTime = -0.17,
            speed = getRoRifiedSpeed(0),
            degree = 0,
            weight = 0,
            sprites = {
                icon = sprite,
                proj = {
                    spr = spellIconToProj(spriteProj, 0.5),
                    speed = 1
                },
                hit = nil --Sprite.load("caster_spells_bouncingBullet_hit", "spr/spells/bouncingBullet_hit", 4, 10, 8)
            },
            fireSound = nil,
            properties = {},
            callback = {
                step = function(self)
                    local projData = self:getData()
                    local player = projData.player
                    local spell = projData.spell
                    
                    local sound = getSound("spells", "digger", "loop")
                    if not sound:isPlaying() then
                        sound:play()
                    end
                    sfxLoopCounter.digger = 1
                    
                    if misc.getOption("video.quality") == 3 then
                        local particle = ParticleType.find("Spark")
                        for i = 1, 3 do
                            particle:burst(
                                "above",
                                self.x + (math.random(1,5) - 3),
                                self.y + (math.random(1,3) - 2),
                                math.random(2) == 1 and math.random(1,2) or 0
                            )
                        end
                    end
                    
                    -- immediately blow up
                    local damager = player:fireExplosion(
                        self.x, self.y,
                        spell.explosion[1] / 19, spell.explosion[2] / 4,
                        0 --spell.damage
                    )
                    
                    local damagerData = damager:getData()
                    damagerData.spellFunc = function(enemy, x, y)
                        if enemy ~= nil then
                            enemyData = enemy:getData()
                            local currTime = os.clock()
                            if enemyData["chainsaw_hit"] == nil or enemyData["chainsaw_hit"] + 1/4 <= currTime then
                                enemyData["chainsaw_hit"] = currTime
                                local damager = player:fireBullet(
                                    enemy.x - 10, enemy.y,
                                    0,
                                    20,
                                    spell.damage
                                )
                                damager:set("specific_target", enemy.id)
                            end
                        end
                    end
                    -- if spell.callback ~= nil and spell.callback.destroy ~= nil then
                        -- damagerData.spellFunc = spell.callback.destroy
                    -- end
                    if projData.modifier ~= nil and projData.modifier.destroy ~= nil then
                        damagerData.modFunc = projData.modifier.destroy
                    end
                    
                    self:destroy()
                end,
                draw = nil,
                hitEnemy = nil,
                hitWall = nil,
                destroy = nil
            }
        }
    end,
    concentratedLight = function()
        local sprite = Sprite.find("caster_spells_concentratedLight", modloader.getActiveNamespace())
        if sprite == nil then
            sprite = Sprite.load("caster_spells_concentratedLight", "spr/spells/proj/concentratedLight/icon", 1, 0, 0)
        end
        return {
            internalName = "concentratedLight",
            name = "Concentrated Light",
            type = spellType.PROJECTILE,
            desc = "A pinpointed beam of light",
            maxCount = -1,
            count = -1,
            damage = getRoRifiedDamage(22),
            explosion = {10, 10},
            manaCost = 30,
            castDelay = -0.37,
            rechargeTime = 0,
            speed = getRoRifiedSpeed(150),
            degree = 0,
            weight = 0,
            sprites = {
                icon = sprite,
                proj = {
                    spr = emptySprite,
                    speed = 1
                },
                hit = Sprite.find("BugChunk", "vanilla") --Sprite.load("caster_spells_bouncingBurst_hit", "spr/spells/bouncingBurst_hit", 4, 10, 8)
            },
            fireSound = getSound("spells", "laser", "bullet"),
            properties = {
                bounce = -1 -- laser loses no momentum
            },
            callback = {
                step = function(self)
                    local projData = self:getData()
                    if projData.life >= 5*60 then
                        self:destroy()
                    else
                    --if misc.getOption("video.quality") == 3 then
                        local angle = math.deg(math.atan2(-projData.vector[2], projData.vector[1]))
                        local particle = projParticles.blur(angle)
                        particle:life(45, 45)
                        particle:color(Color.LIME)
                        particle:burst("above", self.x, self.y, 1)
                    --end
                    end
                end,
                draw = nil,
                hitEnemy = commonFuncs.projEnemyExplode,
                hitWall = nil,
                destroy = nil
            }
        }
    end,
    spitterBolt = function()
        local sprite = Sprite.find("caster_spells_spitterBolt", modloader.getActiveNamespace())
        local spriteProj = Sprite.find("caster_spells_spitterBolt_proj", modloader.getActiveNamespace())
        if sprite == nil then
            sprite = Sprite.load("caster_spells_spitterBolt", "spr/spells/proj/spitterBolt/icon", 1, 0, 0)
        end
        if spriteProj == nil then
            spriteProj = Sprite.load("caster_spells_spitterBolt_proj", "spr/spells/proj/spitterBolt/proj", 7, 5, 5)
        end
        return {
            internalName = "spitterBolt",
            name = "Spitter Bolt",
            type = spellType.PROJECTILE,
            desc = "A short-lived magical bolt",
            maxCount = -1,
            count = -1,
            damage = getRoRifiedDamage(7.5),
            explosion = nil,
            manaCost = 5,
            castDelay = -0.02,
            rechargeTime = 0,
            speed = getRoRifiedSpeed(500),
            degree = 0,
            weight = 0,
            sprites = {
                icon = sprite,
                proj = {
                    spr = spriteProj,
                    speed = 1
                },
                hit = emptySprite
            },
            fireSound = getSound("spells", "slime", "bullet"),
            properties = {},
            callback = {
                step = function(self)
                    local projData = self:getData()
                    if projData.life >= 1/5 * 60 then
                        self:destroy()
                    end
                end,
                draw = nil,
                hitEnemy = commonFuncs.projEnemyHit,
                hitWall = nil,
                destroy = nil
            }
        }
    end,
    unstableCrystal = function()
        local sprite = Sprite.find("caster_spells_unstableCrystal", modloader.getActiveNamespace())
        if sprite == nil then
            sprite = Sprite.load("caster_spells_unstableCrystal", "spr/spells/proj/unstableCrystal/icon", 1, 0, 0)
        end
        return {
            internalName = "unstableCrystal",
            name = "Unstable Crystal",
            type = spellType.PROJECTILE,
            desc = "A crystal that explodes when someone comes nearby",
            maxCount = 15,
            count = 15,
            damage = getRoRifiedDamage(400),
            explosion = {15, 15},
            manaCost = 20,
            castDelay = 0.50,
            rechargeTime = 0,
            speed = getRoRifiedSpeed(500),
            degree = 2.9,
            weight = 7,
            sprites = {
                icon = sprite,
                proj = {
                    spr = spellIconToProj(sprite, 0.5),
                    speed = 1
                },
                hit = Sprite.find("EfBombExplode", "vanilla")
            },
            fireSound = getSound("spells", "explosive", "bomb"),
            properties = {},
            callback = {
                step = function(self)
                    local projData = self:getData()
                    local spell = projData.spell
                    
                    -- no rotato
                    self.angle = 0
                    
                    if projData.triggered == nil then
                        if projData.life >= 3/4 * 60 then
                            -- can now explode
                            local nearby, triggered = nil, false
                            for i = 1, 2 do
                                nearby = i == 1 and (projObj:findNearest(self.x, self.y))
                                  or (ParentObject.find(projData.player:get("team") == "player" and "enemies" or "actors", "vanilla"):findNearest(self.x, self.y))
                                if nearby ~= nil and math.abs(nearby.x - self.x) <= spell.explosion[1] and math.abs(nearby.y - self.y) <= spell.explosion[2] then
                                    triggered = true
                                    break
                                end
                            end
                            if triggered then
                                projData.triggered = 1/3 * 60
                            end
                        end
                    elseif projData.triggered <= 0 then
                        local damager = player:fireExplosion(
                            self.x, self.y,
                            spell.explosion[1] / 19, spell.explosion[2] / 4,
                            spell.damage,
                            spell.sprites.hit
                        )
                        
                        local damagerData = damager:getData()
                        if spell.callback ~= nil and spell.callback.destroy ~= nil then
                            damagerData.spellFunc = spell.callback.destroy
                        end
                        if projData.modifier ~= nil and projData.modifier.destroy ~= nil then
                            damagerData.modFunc = projData.modifier.destroy
                        end
        
                        getSound("spells", "explosive", "explosion"):play()
                        
                        self:destroy()
                    else
                        projData.triggered = projData.triggered - 1
                    end
                end,
                draw = function(self)
                    local projData = self:getData()
                    if projData.triggered ~= nil and projData.triggered % 3 == 0 then
                        graphics.color(Color.WHITE)
                        graphics.alpha(0.15)
                        for i = 1, 5 do
                            graphics.circle(
                                self.x, self.y,
                                projData.spell.explosion[1] / 2 * i/5
                            )
                        end
                        graphics.alpha(1)
                    end
                end,
                hitEnemy = nil,
                hitWall = function(self, hitAngle)
                    local projData = self:getData()
                    if hitAngle == 90 or hitAngle == 270 then
                        projData.vector[1] = 0
                    end
                    if projData.bounce == nil or projData.bounce <= CONST_BOUNCE_MAX then
                        projData.bounce = projData.bounce == nil and 1 or (projData.bounce + 1)
                        if projData.bounce <= CONST_BOUNCE_MAX then
                            projData.vector[1] = projData.vector[1] * CONST_BOUNCE_FALLBACK
                            projData.vector[2] = projData.vector[2] * CONST_BOUNCE_FALLBACK
                        else
                            projData.vector[1] = 0
                            projData.vector[2] = 0
                        end
                    end
                end,
                destroy = nil
            }
        }
    end,
}

------------------================ MODIFIERS ================------------------
allModifiers = {
    doubleSpell = function()
        local sprite = Sprite.find("caster_spells_modifier_doubleSpell", modloader.getActiveNamespace())
        if sprite == nil then
            sprite = Sprite.load("caster_spells_modifier_doubleSpell", "spr/spells/modifiers/doubleSpell", 1, 0, 0)
        end
        return {
            internalName = "doubleSpell",
            name = "Double Spell",
            type = spellType.MODIFIER,
            desc = "Simultaneously cast 2 spells",
            spellsAffected = 2,
            manaCost = 2,
            castDelay = 0,
            sprites = {
                icon = sprite
            },
            properties = {},
            modification = {
                init = nil,
                step = nil,
                destroy = nil
            }
        }
    end,
    bifurcated = function()
        local sprite = Sprite.find("caster_spells_modifier_bifurcated", modloader.getActiveNamespace())
        if sprite == nil then
            sprite = Sprite.load("caster_spells_modifier_bifurcated", "spr/spells/modifiers/bifurcated", 1, 0, 0)
        end
        return {
            internalName = "bifurcated",
            name = "Formation: Bifurcated",
            type = spellType.MODIFIER,
            desc = "Cast 2 spells in a bifurcated pattern",
            spellsAffected = 2,
            manaCost = 2,
            castDelay = 0,
            sprites = {
                icon = sprite
            },
            properties = {},
            modification = {
                init = {
                    function (angle)
                        return angle + 15
                    end,
                    function (angle)
                        return angle - 15
                    end
                },
                step = nil,
                destroy = nil
            }
        }
    end,
    burningShot = function()
        local sprite = Sprite.find("caster_spells_modifier_burningTrail", modloader.getActiveNamespace())
        if sprite == nil then
            sprite = Sprite.load("caster_spells_modifier_burningTrail", "spr/spells/modifiers/burningTrail", 1, 0, 0)
        end
        return {
            internalName = "burningShot",
            name = "Modifier: Burning Trail",
            type = spellType.MODIFIER,
            desc = "A tail of fire follows the projectile",
            spellsAffected = 1,
            manaCost = 5,
            castDelay = 0,
            sprites = {
                icon = sprite
            },
            properties = {},
            modification = {
                init = nil,
                step = function(self)
                    if misc.getOption("video.quality") == 3 then
                        local flame = ParticleType.find("Dust1", "vanilla")
                        flame:color(Color.ROR_YELLOW, Color.WHITE)
                        flame:life(30, 30)
                        flame:size(0.05, 0.15, -0.0033, 0)
                        flame:alpha(1, 0)
                        flame:burst("above", self.x, self.y, math.random(2,3))
                        return
                    end
                end,
                destroy = function(enemy, _, _, _)
                    if enemy ~= nil then
                        if enemy:hasBuff(buffs.burning.buff) then
                            enemy:removeBuff(buffs.burning.buff)
                        end
                        enemy:applyBuff(buffs.burning.buff, 60 * 2)
                    end
                end
            }
        }
    end,
    bounce = function()
        local sprite = Sprite.find("caster_spells_modifier_bounce", modloader.getActiveNamespace())
        if sprite == nil then
            sprite = Sprite.load("caster_spells_modifier_bounce", "spr/spells/modifiers/bounce", 1, 0, 0)
        end
        return {
            internalName = "bounce",
            name = "Modifier: Bounce",
            type = spellType.MODIFIER,
            desc = "Causes projectiles to bounce on impact",
            spellsAffected = 1,
            manaCost = 0,
            castDelay = 0,
            sprites = {
                icon = sprite
            },
            properties = {
                bounce = CONST_BOUNCE_FALLBACK
            },
            modification = {
                init = nil,
                step = nil,
                destroy = nil
            }
        }
    end,
    horizontalPath = function()
        local sprite = Sprite.find("caster_spells_modifier_horizontalPath", modloader.getActiveNamespace())
        if sprite == nil then
            sprite = Sprite.load("caster_spells_modifier_horizontalPath", "spr/spells/modifiers/horizontalPath", 1, 0, 0)
        end
        return {
            internalName = "horizontalPath",
            name = "Horizontal Path",
            type = spellType.MODIFIER,
            desc = "Forces the projectile to fly horizontally but increases its damage",
            spellsAffected = 1,
            manaCost = 0,
            castDelay = -0.07,
            sprites = {
                icon = sprite
            },
            properties = {},
            modification = {
                init = nil,
                step = function(self)
                    local projData = self:getData()
                    projData.vector = {projData.vector[1]/math.abs(projData.vector[1]), 0}
                    projData.currentVector = {projData.currentVector[1], 0}
                end,
                destroy = function(_, _, _, damager)
                    damager:set("damage", damager:get("damage") + 5)
                        :set("damage_fake", damager:get("damage_fake") + 5)
                end
            }
        }
    end,
    homing = function()
        local sprite = Sprite.find("caster_spells_modifier_homing", modloader.getActiveNamespace())
        if sprite == nil then
            sprite = Sprite.load("caster_spells_modifier_homing", "spr/spells/modifiers/homing", 1, 0, 0)
        end
        return {
            internalName = "homing",
            name = "Homing",
            type = spellType.MODIFIER,
            desc = "Causes the projectile to fly towards your foes",
            spellsAffected = 1,
            manaCost = 50,
            castDelay = 0,
            sprites = {
                icon = sprite
            },
            properties = {},
            modification = {
                init = nil,
                step = function(self)
                    local projData = self:getData()
                    local nearestTarget = ParentObject.find(projData.player:get("team") == "player" and "enemies" or "actors", "vanilla"):findNearest(self.x, self.y)
                    if nearestTarget ~= nil then
                        local targetAngle = math.atan2(nearestTarget.y - self.y, nearestTarget.x - self.x)
                        local targetVector = {math.cos(targetAngle), math.sin(targetAngle)}
                        for i = 1, 2 do
                            local targetCompensation = targetVector[i] - projData.vector[i]
                            if targetCompensation < 0.01 then
                                projData.vector[i] = targetVector[i]
                            else
                                projData.vector[i] = projData.vector[i] + targetCompensation * 1/5
                            end
                        end
                    end
                end,
                destroy = nil
            }
        }
    end,
}