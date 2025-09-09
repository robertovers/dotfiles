local keymap = vim.keymap

vim.g.mapleader = ";"

keymap.set('n', 'x', '"_x')
keymap.set('i', '<C-j>', '<Esc>', { noremap = true })
