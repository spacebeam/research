-- First we create a table to represent the class and contain its methods.

local MyClass = {}
MyClass.__index = MyClass

-- In the constructor, we create the instance (an empty table), give it the metatable, fill in fields, and return the new instance.

-- syntax equivalent to "MyClass.new = function..."
function MyClass.new(init)
    local self = setmetatable({}, MyClass)
    self.value = init
    return self
end

function MyClass.set_value(self, newval)
    self.value = newval
end

function MyClass.get_value(self)
    return self.value
end

local i = MyClass.new(5)

-- Magic Syntax Sugar of the Moon
-- table:name(arg) is a shortcut for table.name(table, arg), except  table is evaluated only once.
print(i:get_value())
i:set_value(6)
print(i:get_value())

-- In the methods, we use a "self" parameter to get the instance to operate on.
-- This is so common that Lua offers the : syntax sugar that calls a function entry from a table and inserts the table itself before the first arg.

local MyClass = {}
MyClass.__index = MyClass

setmetatable(MyClass, {
    __call = function (cls, ...)
        return cls.new(...)
    end,
})

function MyClass.new(init)
    local self = setmetatable({}, MyClass)
    self.value = init
    return self
end

-- the magic : sugar syntax here causes a "self" arg to be implicitly added before any other args.
function MyClass:set_value(newval)
    self.value = newval
end

function MyClass:get_value()
    return self.value
end


-- We add a metatable to the class table that has the __call metamethod, 
-- which triggered when a value is called like a function.
--
-- We make it call the class's constructor, so you don't need the .new when creating instances.
-- (Like with Python classes?) 
--
-- Also, to complement the : method call shortcut, Lua lets you use `:` when defining a function
-- in a table, which implicitly adds a `self` argument so you don't have to type it out yourself.
--

local instance = MyClass(5)

print(instance:get_value())

-- It's easy to extend the design of the class in the above example to use inheritance:

local BaseClass = {}
BaseClass.__index = BaseClass

setmetatable(BaseClass, {
    __call = function (cls, ...)
        local self = setmetatable({}, cls)
        self:__init(...)
        return self
    end,
})

function BaseClass:_init(init)
    self.value = init
end

function BaseClass:set_value(newval)
    self.value = newval
end

function BaseClass:get_value()
    return self.value
end

--

local DerivedClass = {}
for k, v in pairs(BaseClass) do
    DerivedClass[k] = v
end
DerivedClass.__index = DerivedClass

setmetatable(DerivedClass, {
    __index = BaseClass, -- this is what makes the inheritance work
    __call = function (cls, ...)
        local self = setmetatable({}, cls)
        self:_init(...)
        return self
    end,
})

function DerivedClass:_init(init1, init2)
    BaseClass._init(self, init1) -- call the base class constructor
    self.value2 = init2
end

function DerivedClass:get_value()
    return self.value + self.value2
end

--

local i = DerivedClass(1, 2)
print(i:get_value())
i:set_value(3)
print(i:get_value())


-- It's also possible to make objets using closures.
--
-- Instances are slower to create and use more memory, but there are also some advantages
-- like faster instance field acces, and it's an interesting example of how closures can be used.
--

local function MyClass(init)
    -- the new instance
    local self = {
        -- public fields go in the instance table
        public_field = 0
    }

    -- private fields are implemented using locals
    -- they are faster tan table access, and are truly private
    -- so the code that uses your class can't get them.
    local private_field = init

    function self.foo()
        return self.public_field + private_field
    end

    function self.bar()
        private_field = private_field + 1
    end

    -- return the instance
    return self
end

local i = MyClass(5)
print(i.foo())
i.public_field = 3
i.bar()
print(i.foo())

-- Note that the .syntax was used to call methods, not :.
--
-- This is because the self variable is already stored in the methods as an upvalue,
-- so it doesn't need to be passed in by the code calling it.
--
-- Inheritance is also possible this way:
--

local function BaseClass(init)
    local self = {}

    local private_field = init

    function self.foo()
        return private_field
    end

    function self.bar()
        private_field = private_field + 1
    end

    -- return the instance
    return self
end

local function DerivedClass(init, init2)
    local self = BaseClass(init)

    self.public_field = init2

    -- this is independet from the base class's private field that has the same name
    local private_field = init2

    -- save the base version of foo for use in the derived version
    local base_foo = self.foo
    function self.foo()
        return private_field + self.public_field + base_foo()
    end
    
    -- return the instance
    return self
end

local i = DerivedClass(1, 2)
print(i.foo())
i.bar()
print(i.foo())

-- Table vs Closure-based classes

-- Advantages of table-based:

-- Creating instances of table-based classes is faster.
-- Table-based instances use less memory, since the methods are not duplicated for each instance.
-- It's possible to get a method directly from the class (for example MyClass.method(instance, args)).
-- Many Lua and C++ developers might find : for method calls more consistent with the vast majority of object-oriented Lua code.

-- Advantages of closure-based:

-- Closure-based instances can have truly private fields, so that the users of your class cannot accidentally or intentionally get to them.
-- Access to private fields is faster with closure-based classes, since they're upvalues, not table lookups.
-- Method calls are faster, since they don't have to go through an __index metamethod.
-- Many developers from other languages may find the . method call syntax more familiar.
