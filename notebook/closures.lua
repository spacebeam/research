marine = {}

-- global private variables:

local idcounter = 0
local defaultmaxhp = 200
local defaultshield = 10

-- global private methods
local function printhi()
    print('hi')
end

-- access to global private variables
function marine.setdefaultmaxhp(value)
    defaultmaxhp = value
end

-- global public variables:
marine.defaultarmorclass = 0

function marine.new()
    local self = {}

    -- private variables:
    local maxhp = defaultmaxhp
    local hp = maxhp
    local armor
    local armorclass = marine.defaultarmorclass
    local shield = defaultshield

    -- public variables
    self.id = idcounter
    idcounter = idcounter + 1

    -- private methods:
    local function updatearmor()
        armor = armorclass*5 + shield*13
    end

    -- public methods:
    function self.heal(deltahp)
        hp = math.min(maxhp, hp + deltahp)
    end
    function self.sethp(newhp)
        hp = math.min(maxhp, newhp)
    end
    function self.gethp()
        return hp
    end
    function self.setarmorclass(value)
        armorclass = value
        updatearmor()
    end
    function self.dumpstate()
        return string.format("maxhp = %d\nhp = %d\narmor = %d\narmorclass = %d\nshield = %d\n",
                             maxhp, hp, armor, armorclass, shield)
    end

    -- Apply some private methods
    updatearmor()

    return self
end



--
-- infested_terran module:
--

-- Polymorphism sample
infested_terran = {}

function infested_terran.consume(self)
    -- No need for local self = self stuff (:
    
    -- new private variables:
    local explosion_damage = 500

    -- new methods:
    function self.set_explosion_damage(value)
        explosion_damage = value
    end
    function self.explode()
        print("EXPLODE for "..explosion_damage.." damage!!\n")
    end

    -- Some inheritance:
    local marine_dumpstate = self.dumpstate -- Save parent function (not polluting global 'self' space)
    function self.dumpstate()
        return marine_dumpstate()..string.format("explosion_damage = %d\n", explosion_damage)
    end

    return self
end

function infested_terran.new()
    return infested_terran.consume(marine.new())
end

--
-- Application
--

local function printstate(m)
    print("Marine [ID: "..m.id.."']:")
    print(m.dumpstate())
end

local m1 = marine.new()
local m2 = marine.new()

m1.sethp(100)
m1.heal(13)
m2.sethp(90)
m2.heal(5)

printstate(m1)
printstate(m2)

print("UPGRADES!!\n")
marine.setdefaultmaxhp(400) -- We've got some upgrades here
local m3 = marine.new()

printstate(m3)

local im1 = infested_terran.new()
local im2 = infested_terran.consume(m1)

printstate(im1)
printstate(im2)

im2.explode()

-- It's al quite self-explained.
--
-- We've got all the common OOP tricks in pretty clean and fast manner.
