---

## Rule 1

One plugin.

One file.

---

## Rule 2

One responsibility.

One file.

---

## Rule 3

Every plugin owns its own keymaps.

Never define Telescope mappings elsewhere.

Never define Comment mappings elsewhere.

---

## Rule 4

No plugin talks to another plugin.

Example

Bad

```text
Comment
↓

calls Telescope
```

Good

```text
Comment

independent
```

---

## Rule 5

Everything lazy-loads whenever possible.

---

## Rule 6

No duplicated configuration.

Ever.

---

## Rule 7

Documentation is mandatory.

Every file explains

* why it exists

* what it configures

* what it exports

---

## Rule 8

Every file should fit on one screen whenever reasonably possible.

Instead of

```text
lsp.lua

900 lines
```

we prefer

```text
mason.lua

80 lines

lsp.lua

150 lines

diagnostics.lua

60 lines
```

---

# Coding Style

We'll also standardize Lua.

Example

Instead of

```lua
require("telescope").setup({
```

we'll always do

```lua
local telescope = require("telescope")

telescope.setup({
```

Much easier to debug.

---

Instead of

```lua
vim.keymap.set(...)
```

fifty times,

we'll eventually introduce

```lua
local map = vim.keymap.set
```

inside every file.

Cleaner.

---

Instead of

```lua
local opts = {
```

everywhere,

we'll use

```lua
local keymap_opts = {
```

that allows for future changes without breaking everything.

---

# Documentation Standard

Every file starts with

```lua
--------------------------------------------------------------------------------
-- Neovim IDE
--------------------------------------------------------------------------------
-- File:
--
-- Purpose:
--
-- Responsibilities:
--
-- Dependencies:
--
-- Notes:
--------------------------------------------------------------------------------
```

Then sections

```lua
--------------------------------------------------------------------------------
-- Constants
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Local Functions
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Public API
--------------------------------------------------------------------------------
```

This will make the entire codebase feel consistent.

---
