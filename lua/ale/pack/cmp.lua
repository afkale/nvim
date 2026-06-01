require("mini.icons").tweak_lsp_kind()

require("mini.completion").setup({
  lsp_completion = {
    source_func = 'omnifunc',
    auto_setup = true
  }
})

local snippets = require("mini.snippets")
snippets.setup({
  snippets = {
    snippets.gen_loader.from_lang()
  },
  expand = {
    insert = function(snippet)
      snippets.default_insert(snippet, { empty_tabstop = "" })
    end
  }
})
snippets.start_lsp_server({ match = false })
