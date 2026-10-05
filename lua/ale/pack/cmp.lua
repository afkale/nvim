require("mini.completion").setup({
  lsp_completion = {
    source_func = "omnifunc"
  }
})

local snippets = require("mini.snippets")
snippets.setup({
  snippets = {
    snippets.gen_loader.from_lang()
  },
  expand = {
    insert = function(snippet)
      snippets.default_insert(snippet, { empty_tabstop = "", empty_tabstop_final = "" })
    end
  }
})
snippets.start_lsp_server({ match = false })
