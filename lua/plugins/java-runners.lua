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
				
				-- Compile all .java files in current directory
				local compile_cmd = string.format("cd %s && javac *.java", vim.fn.shellescape(current_dir))
				local run_cmd = string.format("cd %s && java %s", vim.fn.shellescape(current_dir), main_class)
				
				vim.cmd("split")
				vim.cmd(string.format("term %s && %s", compile_cmd, run_cmd))
			end, { desc = "Run Java (compiles all files)" })

			-- JDBC Java runner (includes MySQL connector in classpath)
			vim.keymap.set("n", "<leader>rjd", function()
				local jdbc_jar = vim.fn.expand("$HOME/lib/mysql-connector-j-8.2.0.jar")
				local current_dir = vim.fn.expand("%:p:h")
				local main_class = vim.fn.expand("%:r")
				
				if vim.fn.filereadable(jdbc_jar) == 0 then
					print("❌ JDBC driver not found at: " .. jdbc_jar)
					print("💡 Run: jdbc-project <name> to download it")
					return
				end
				
				-- Compile all .java files with JDBC in classpath
				local compile_cmd = string.format("cd %s && javac -cp '%s' *.java", 
					vim.fn.shellescape(current_dir), jdbc_jar)
				local run_cmd = string.format("cd %s && java -cp '.:%s' %s", 
					vim.fn.shellescape(current_dir), jdbc_jar, main_class)
				
				vim.cmd("split")
				vim.cmd(string.format("term %s && %s", compile_cmd, run_cmd))
			end, { desc = "Run Java with JDBC (compiles all files)" })

			-- Compile only (useful for checking errors)
			vim.keymap.set("n", "<leader>jc", function()
				local current_dir = vim.fn.expand("%:p:h")
				vim.cmd(string.format("!cd %s && javac *.java", vim.fn.shellescape(current_dir)))
			end, { desc = "Compile all Java files" })

			-- Compile with JDBC
			vim.keymap.set("n", "<leader>jcd", function()
				local jdbc_jar = vim.fn.expand("$HOME/lib/mysql-connector-j-8.2.0.jar")
				local current_dir = vim.fn.expand("%:p:h")
				vim.cmd(string.format("!cd %s && javac -cp '%s' *.java", 
					vim.fn.shellescape(current_dir), jdbc_jar))
			end, { desc = "Compile all Java files with JDBC" })

			-- Run specific main class (prompts for class name)
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
