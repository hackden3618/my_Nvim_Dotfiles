return {
	{
		"nvim-treesitter/nvim-treesitter",
		ft = "java",
		config = function()
			-- Simple Java runner (compiles all .java files in directory)
			vim.keymap.set("n", "<leader>rj", function()
				local current_file = vim.fn.expand("%")
				local main_class = vim.fn.expand("%:r")
				local current_dir = vim.fn.expand("%:p:h")
				
				local compile_cmd = string.format("cd %s && javac *.java", vim.fn.shellescape(current_dir))
				local run_cmd = string.format("cd %s && java %s", vim.fn.shellescape(current_dir), main_class)
				
				vim.cmd("split")
				vim.cmd(string.format("term %s && %s", compile_cmd, run_cmd))
			end, { desc = "Run Java (compiles all files)" })

			-- JDBC Java runner (smart JAR detection)
			vim.keymap.set("n", "<leader>rjd", function()
				local current_dir = vim.fn.expand("%:p:h")
				local main_class = vim.fn.expand("%:r")
				
				-- Find project root (look for build.xml, pom.xml, or lib/)
				local function find_project_root()
					local search_dir = current_dir
					while search_dir ~= "/" do
						-- Check for Netbeans project
						if vim.fn.filereadable(search_dir .. "/build.xml") == 1 then
							return search_dir
						end
						-- Check for Maven project
						if vim.fn.filereadable(search_dir .. "/pom.xml") == 1 then
							return search_dir
						end
						-- Check for lib directory
						if vim.fn.isdirectory(search_dir .. "/lib") == 1 then
							return search_dir
						end
						search_dir = vim.fn.fnamemodify(search_dir, ":h")
					end
					return nil
				end
				
				local project_root = find_project_root()
				local jdbc_jar = ""
				
				-- Try to find JDBC JAR
				if project_root then
					-- Check project lib/ directory first (Netbeans style)
					local lib_dir = project_root .. "/lib"
					if vim.fn.isdirectory(lib_dir) == 1 then
						-- Find MySQL connector JAR
						local jar_pattern = lib_dir .. "/mysql-connector*.jar"
						local found_jar = vim.fn.glob(jar_pattern)
						if found_jar ~= "" then
							jdbc_jar = found_jar
							print("✅ Found JDBC driver: " .. jdbc_jar)
						end
					end
				end
				
				-- Fallback to ~/lib if not found in project
				if jdbc_jar == "" then
					local home_jar = vim.fn.expand("$HOME/lib/mysql-connector-j-8.2.0.jar")
					if vim.fn.filereadable(home_jar) == 1 then
						jdbc_jar = home_jar
						print("✅ Using JDBC driver from: " .. jdbc_jar)
					else
						print("❌ JDBC driver not found!")
						print("💡 Place mysql-connector.jar in project lib/ or run: jdbc-project <name>")
						return
					end
				end
				
				-- Compile and run with JDBC in classpath
				local compile_cmd = string.format("cd %s && javac -cp '%s' *.java", 
					vim.fn.shellescape(current_dir), jdbc_jar)
				local run_cmd = string.format("cd %s && java -cp '.:%s' %s", 
					vim.fn.shellescape(current_dir), jdbc_jar, main_class)
				
				vim.cmd("split")
				vim.cmd(string.format("term %s && %s", compile_cmd, run_cmd))
			end, { desc = "Run Java with JDBC (auto-detects JAR)" })

			-- Compile only
			vim.keymap.set("n", "<leader>jc", function()
				local current_dir = vim.fn.expand("%:p:h")
				vim.cmd(string.format("!cd %s && javac *.java", vim.fn.shellescape(current_dir)))
			end, { desc = "Compile all Java files" })

			-- Run specific main class
			vim.keymap.set("n", "<leader>rjm", function()
				local current_dir = vim.fn.expand("%:p:h")
				local main_class = vim.fn.input("Main class name: ", vim.fn.expand("%:r"))
				
				if main_class == "" then
					print("Cancelled")
					return
				end
				
				local compile_cmd = string.format("cd %s && javac *.java", vim.fn.shellescape(current_dir))
				local run_cmd = string.format("cd %s && java %s", vim.fn.shellescape(current_dir), main_class)
				
				vim.cmd("split")
				vim.cmd(string.format("term %s && %s", compile_cmd, run_cmd))
			end, { desc = "Run specific Java main class" })
		end,
	},
}
