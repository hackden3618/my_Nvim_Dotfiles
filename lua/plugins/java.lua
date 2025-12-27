return {
	"mfussenegger/nvim-jdtls",
	ft = "java",
	config = function()
		local jdtls = require("jdtls")
		local home = os.getenv("HOME")
		local mason_path = vim.fn.stdpath("data") .. "/mason"
		
		-- Find jdtls installation
		local jdtls_path = mason_path .. "/packages/jdtls"
		local launcher = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
		local config_path = jdtls_path .. "/config_linux"
		
		-- Workspace setup
		local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
		local workspace_dir = home .. "/.local/share/nvim/jdtls-workspace/" .. project_name

		local config = {
			cmd = {
				"java",
				"-Declipse.application=org.eclipse.jdt.ls.core.id1",
				"-Dosgi.bundles.defaultStartLevel=4",
				"-Declipse.product=org.eclipse.jdt.ls.core.product",
				"-Dlog.protocol=true",
				"-Dlog.level=ALL",
				"-Xmx1g",
				"--add-modules=ALL-SYSTEM",
				"--add-opens", "java.base/java.util=ALL-UNNAMED",
				"--add-opens", "java.base/java.lang=ALL-UNNAMED",
				"-jar", launcher,
				"-configuration", config_path,
				"-data", workspace_dir,
			},
			root_dir = jdtls.setup.find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }),
			settings = {
				java = {
					eclipse = { downloadSources = true },
					maven = { downloadSources = true },
					implementationsCodeLens = { enabled = true },
					referencesCodeLens = { enabled = true },
					references = { includeDecompiledSources = true },
					format = { enabled = true },
				},
			},
			init_options = {
				bundles = {},
			},
			on_attach = function(client, bufnr)
				-- Keymaps
				local opts = { buffer = bufnr, noremap = true, silent = true }
				vim.keymap.set("n", "<leader>jo", jdtls.organize_imports, opts)
				vim.keymap.set("n", "<leader>jv", jdtls.extract_variable, opts)
				vim.keymap.set("v", "<leader>jv", [[<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>]], opts)
				vim.keymap.set("n", "<leader>jc", jdtls.extract_constant, opts)
				vim.keymap.set("v", "<leader>jc", [[<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>]], opts)
				vim.keymap.set("v", "<leader>jm", [[<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>]], opts)
			end,
		}

		-- Start or attach to jdtls
		jdtls.start_or_attach(config)
	end,
}
