return {
  -- 1. BASE16 INTEGRATION (The Engine)
  {
    "RRethy/nvim-base16",
    lazy = false,
    priority = 1000,
    config = function()
      -- This loads the file Matugen creates
      local ok, matugen = pcall(require, "config.matugen_colors")
      if ok and matugen.base_16 then
        require("base16-colorscheme").setup(matugen.base_16)
      end
    end,
  },

  -- 2. LAZYVIM SETTINGS (The Theme)
  {
    "LazyVim/LazyVim",
    opts = {
      -- This function prevents the "Could not load colorscheme" error
      colorscheme = function()
        local ok, _ = pcall(require, "config.matugen_colors")
        return ok and "base16" or "tokyonight"
      end,
    },
  },

  -- 3. MASON FIX (Removes the Warning Box)
  {
    "mason-org/mason.nvim",
    -- We only provide the name and the tools we want
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
      },
    },
  },

  -- 4. UI ENHANCEMENTS (Soft MacOS Style)
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.options.theme = "base16"
      -- Rounded separators for that "soft" look
      opts.options.section_separators = { left = "", right = "" }
      opts.options.component_separators = { left = " ", right = " " }
    end,
  },
}
