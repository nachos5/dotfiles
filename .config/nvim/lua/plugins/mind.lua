local nnoremap = require("keymap").nnoremap

require("mind").setup({
  persistence = {
    state_path = "~/mind/mind.json",
    data_dir = "~/mind/data",
  },
})

local default_opts = { noremap = true, silent = true }

nnoremap("<leader>mm", "<cmd>MindOpenMain<CR>", default_opts)
nnoremap("<leader>mp", "<cmd>MindOpenSmartProject<CR>", default_opts)
nnoremap("<leader>mc", "<cmd>MindClose<CR>", default_opts)

local function _mind_create_smart_node()
  require("mind").wrap_smart_project_tree_fn(function(args)
    require("mind.commands").create_node_index(
      args.get_tree(),
      require("mind.node").MoveDir.INSIDE_END,
      args.save_tree,
      args.opts
    )
  end)
end
nnoremap("<leader>mn", _mind_create_smart_node, default_opts)

local function _mind_create_main_node()
  require("mind").wrap_main_tree_fn(function(args)
    require("mind.commands").create_node_index(
      args.get_tree(),
      require("mind.node").MoveDir.INSIDE_END,
      args.save_tree,
      args.opts
    )
  end)
end
nnoremap("<leader>mN", _mind_create_main_node, default_opts)

local function _mind_search_smart_tree()
  require("mind").wrap_smart_project_tree_fn(function(args)
    require("mind.commands").open_data_index(args.get_tree(), args.data_dir, args.save_tree, args.opts)
  end)
end
nnoremap("<leader>ms", _mind_search_smart_tree, default_opts)

local function _mind_search_main_tree()
  require("mind").wrap_main_tree_fn(function(args)
    require("mind.commands").open_data_index(args.get_tree(), args.data_dir, args.save_tree, args.opts)
  end)
end
nnoremap("<leader>mS", _mind_search_main_tree, default_opts)

nnoremap("<leader>mg", "<cmd>Telescope live_grep cwd=" .. vim.g.OS_HOME .. "/mind/data<CR>", default_opts)
