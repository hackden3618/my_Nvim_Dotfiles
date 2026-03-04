-- =============================================================================
-- JAVA-RUNNERS.LUA - Compile and run Java files without Maven/Gradle
-- =============================================================================

return {
    {
        "nvim-lua/plenary.nvim",
        ft = "java",

        config = function()

            -- Safely escape shell arguments
            local function shell_escape(str)
                return "'" .. str:gsub("'", "'\\''") .. "'"
            end

            -- Open a terminal split and run a command
            local function run_in_term(cmd, size)
                vim.cmd("split")
                vim.cmd("resize " .. (size or 15))
                vim.cmd("term " .. cmd)
                vim.cmd("startinsert")
            end

            -- -------------------------------------------------------------------
            -- <leader>rj  Simple runner (multi-class, same directory)
            -- -------------------------------------------------------------------
            vim.keymap.set("n", "<leader>rj", function()
                local dir        = vim.fn.expand("%:p:h")
                local main_class = vim.fn.expand("%:t:r")

                if #vim.fn.glob(dir .. "/*.java", false, true) == 0 then
                    print("❌ No Java files found in directory")
                    return
                end

                local compile = "cd " .. shell_escape(dir) .. " && javac *.java"
                local run     = "cd " .. shell_escape(dir) .. " && java " .. main_class
                run_in_term(compile .. " && echo '\\n✅ Compiled\\n' && " .. run)
            end, { desc = "Run Java (multi-class)" })

            -- -------------------------------------------------------------------
            -- <leader>rjd  Run with JDBC (auto-detects mysql-connector JAR)
            -- -------------------------------------------------------------------
            vim.keymap.set("n", "<leader>rjd", function()
                local dir        = vim.fn.expand("%:p:h")
                local main_class = vim.fn.expand("%:t:r")

                -- Walk up the tree looking for lib/ or known project files
                local function find_project_root()
                    local search = dir
                    while search ~= "/" do
                        if vim.fn.filereadable(search .. "/build.xml") == 1 then return search end
                        if vim.fn.filereadable(search .. "/pom.xml")   == 1 then return search end
                        if vim.fn.isdirectory(search .. "/lib")        == 1 then return search end
                        search = vim.fn.fnamemodify(search, ":h")
                    end
                end

                local jdbc_jar = ""
                local root     = find_project_root()

                if root then
                    local found = vim.fn.glob(root .. "/lib/mysql-connector*.jar")
                    if found ~= "" then
                        jdbc_jar = found
                        print("✅ Found JDBC driver: " .. jdbc_jar)
                    end
                end

                -- Fallback to ~/lib
                if jdbc_jar == "" then
                    local home_jar = vim.fn.expand("$HOME/lib/mysql-connector-j-8.2.0.jar")
                    if vim.fn.filereadable(home_jar) == 1 then
                        jdbc_jar = home_jar
                        print("✅ Using JDBC driver from: " .. jdbc_jar)
                    else
                        print("❌ JDBC driver not found! Place mysql-connector.jar in project lib/ or ~/lib/")
                        return
                    end
                end

                local compile = "cd " .. shell_escape(dir) .. " && javac -cp " .. shell_escape(jdbc_jar) .. " *.java"
                local run     = "cd " .. shell_escape(dir) .. " && java -cp " .. shell_escape(".:" .. jdbc_jar) .. " " .. main_class
                run_in_term(compile .. " && echo '\\n✅ Compiled with JDBC\\n' && " .. run)
            end, { desc = "Run Java with JDBC" })

            -- -------------------------------------------------------------------
            -- <leader>rjm  Run a specific main class (prompted)
            -- -------------------------------------------------------------------
            vim.keymap.set("n", "<leader>rjm", function()
                local dir        = vim.fn.expand("%:p:h")
                local main_class = vim.fn.input("Main class name: ", vim.fn.expand("%:t:r"))

                if main_class == "" then
                    print("❌ Cancelled")
                    return
                end

                local compile = "cd " .. shell_escape(dir) .. " && javac *.java"
                local run     = "cd " .. shell_escape(dir) .. " && java " .. main_class
                run_in_term(compile .. " && echo '\\n✅ Compiled\\n' && " .. run)
            end, { desc = "Run specific Java main class" })

            -- -------------------------------------------------------------------
            -- <leader>jC  Compile only (no run)
            -- -------------------------------------------------------------------
            vim.keymap.set("n", "<leader>jC", function()
                local dir = vim.fn.expand("%:p:h")

                if #vim.fn.glob(dir .. "/*.java", false, true) == 0 then
                    print("❌ No Java files found")
                    return
                end

                run_in_term("cd " .. shell_escape(dir) .. " && javac *.java && echo '✅ Compilation successful'", 10)
            end, { desc = "Compile Java (no run)" })

            -- -------------------------------------------------------------------
            -- <leader>jX  Clean .class files
            -- -------------------------------------------------------------------
            vim.keymap.set("n", "<leader>jX", function()
                local dir = vim.fn.expand("%:p:h")
                vim.fn.system("cd " .. shell_escape(dir) .. " && rm -f *.class")
                print("🧹 Cleaned .class files in " .. dir)
            end, { desc = "Clean .class files" })

            -- -------------------------------------------------------------------
            -- <leader>rjp  Package-aware runner (for src/ project structure)
            -- -------------------------------------------------------------------
            vim.keymap.set("n", "<leader>rjp", function()
                local current_file = vim.fn.expand("%:p")
                local src_index    = string.find(current_file, "/src/")

                if not src_index then
                    print("❌ Not in a src/ directory structure")
                    return
                end

                local project_root = string.sub(current_file, 1, src_index - 1)
                local package_line = vim.fn.getline(1)
                local package_name = package_line:match("package%s+([%w%.]+)")

                if not package_name then
                    print("❌ No package declaration found on line 1")
                    return
                end

                local class_name            = vim.fn.expand("%:t:r")
                local fully_qualified_class = package_name .. "." .. class_name

                local compile = "cd " .. shell_escape(project_root) .. " && find src -name '*.java' -exec javac -d . {} +"
                local run     = "cd " .. shell_escape(project_root) .. " && java " .. fully_qualified_class
                run_in_term(compile .. " && echo '\\n✅ Compiled with packages\\n' && " .. run)
            end, { desc = "Run Java with package structure" })
        end,
    },
}
