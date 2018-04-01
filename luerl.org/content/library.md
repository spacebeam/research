Title: Library Module
Date: 2017-06-02 16:20
Category: Library

There is also a library module, `luerl_lib`, which contains functions which may be used.

`luerl_lib:first_value(ReturnList) -> Value.`

`luerl_lib:is_true_value(ReturnList) -> true | false.`

### Currently implemented functions in the libraries

- _G
- _VERSION
- assert
- collectgarbage
- dofile
- eprint
- error
- getmetatable
- ipairs
- load
- loadfile
- next
- pairs
- pcall
- print
- rawequal
- rawget
- rawlen
- rawset
- require
- select
- setmetatable
- tonumber
- tostring
- type
- unpack
- io\.flush
- io\.write
- math\.abs
- math\.acos
- math\.asin
- math\.atan
- math\.atan2
- math\.ceil
- math\.cos
- math\.cosh
- math\.deg
- math\.exp
- math\.floor
- math\.fmod
- math\.frexp
- math\.huge
- math\.ldexp
- math\.log
- math\.log10
- math\.max
- math\.min
- math\.modf
- math\.pi
- math\.pow
- math\.rad
- math\.random
- math\.randomseed
- math\.sin
- math\.sinh
- math\.sqrt
- math\.tan
- math\.tanh
- os\.clock
- os\.date
- os\.difftime
- os\.getenv
- os\.time
- package\.config
- package\.loaded
- package\.preload
- package\.path
- package\.searchers
- package\.searchpath
- string\.byte
- string\.char
- string\.find
- string\.format (should handle most things now)
- string\.gmatch
- string\.gsub
- string\.len
- string\.lower
- string\.match
- string\.rep
- string\.reverse
- string\.sub
- string\.upper
- table\.concat
- table\.insert
- table\.pack
- table\.remove
- table\.sort
- table\.unpack
- bit32\.band
- bit32\.bnot
- bit32\.bor
- bit32\.btest
- bit32\.bxor
- bit32\.lshift
- bit32\.rshift
- bit32\.arshift
- bit32\.lrotate
- bit32\.rrotate
- bit32\.extract
- bit32\.replace
- debug\.getmetatable
- debug\.getuservalue
- debug\.setmetatable
- debug\.setuservalue