package = "pkg"
version = "0.1-0"

source = {
  url = "git://github.com/spacebeam/package",
  tag = "0.1.0",
}

description = {
  summary = "Capuchino HPC package command line toolkit.",
  detailed = "Spawn multi-dimensional nodes of daemons — all operations run using the pkg command.",
  homepage = "https://nonsense.ws",
  license = "AGPL 3"
}

dependencies = {
  "lua == 5.1",
  "argparse",
  "luasocket",
  "uuid"
}

build = {
  type = 'builtin',
  modules = {
    ['pkg.version'] = "src/version.lua"
  },
  install = {
    bin = {
      ['pkg'] = "src/pkg.lua"
    }
  }
}
