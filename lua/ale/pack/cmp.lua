require("mini.completion").setup({
  lsp_completion = {
    source_func = "omnifunc",
    process_items = function(items, base)
      local kind_priority = {
        Snippet = 10,
        Text = -1,
        Function = 50,
        Variable = 50,
        Class = 50,
        Interface = 50,
        Module = 50,
        Property = 50,
        KeyWord = 50,
      }

      -- Use the default processing but with our custom priorities
      return MiniCompletion.default_process_items(items, base, {
        filtersort = 'fuzzy',
        kind_priority = kind_priority
      })
    end
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
