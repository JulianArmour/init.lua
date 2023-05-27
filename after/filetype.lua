vim.filetype.add {
  -- extension = {
  --   cdl = {'cpp', {priority = 10000}},
  --   cdlh = 'cpp',
  -- }
  extension = {
    it = {'lua', priority = 1000000},
  },
  pattern = {
    ['.*/binos/infra/.*%.cdl'] = {'cpp', {priority = 1000}},
    ['.*/binos/infra/.*%.cdlh'] = {'cpp', {priority = 1000}},
    ['.*%.it'] = {'lua', priority = 1000000},
  }
}

