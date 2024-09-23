vim.opt.termguicolors = true

require("bufferline").setup{
    options = {
      diagnostics = "nvim_lsp",

      offsets = {
        {
            filetype = "NvimTree",
            text = "File Explorer",
            highlight = "Directory",
            text_align = "left"
        },
      },
  }
}

vim.cmd [[
  aug buffer_accessed_time
    au!
    au BufEnter,BufWinEnter * let b:accessedtime = localtime()
  aug END

  function! BufferLineSortByMRU()
    lua require'bufferline'.sort_buffers_by(function(a, b) return (vim.b[a.id].accessedtime or 0) > (vim.b[b.id].accessedtime or 0) end)
  endfunction

  command -nargs=0 BufferLineSortByMRU call BufferLineSortByMRU()
]]

