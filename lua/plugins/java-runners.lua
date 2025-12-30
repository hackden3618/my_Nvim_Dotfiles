return {
    {
        "nvim-lua/plenary.nvim",
        ft = "java",
        config = function()
            -- Helper function to escape shell arguments properly
            local function shell_escape(str)
                return "'" .. str:gsub("'", "'\\''") .. "'"
            end

            -- ==========================================
            -- 🚀 SIMPLE JAVA RUNNER (Single/Multi-class)
            -- ==========================================
            vim.keymap.set("n", "<leader>rj", function()
                local current_dir = vim.fn.expand("%:p:h")
                local main_class = vim.fn.expand("%:t:r")

                -- Find all Java files in current directory
                local java_files = vim.fn.glob(current_dir .. "/*.java", false, true)

                if #java_files == 0 then
                    print("❌ No Java files found in directory")
                    return
                end

                -- Build compile command
                local compile_cmd = "cd " .. shell_escape(current_dir) .. " && javac *.java"
                local run_cmd = "cd " .. shell_escape(current_dir) .. " && java " .. main_class

                vim.cmd("split")
                vim.cmd("resize 15")
                vim.cmd("term " .. compile_cmd .. " && echo '\\n✅ Compiled successfully\\n' && " .. run_cmd)
                vim.cmd("startinsert")
            end, { desc = "Run Java (multi-class support)" })

            -- ==========================================
            -- 🗄️ JDBC JAVA RUNNER (Smart JAR detection)
            -- ==========================================
            vim.keymap.set("n", "<leader>rjd", function()
                local current_dir = vim.fn.expand("%:p:h")
                local main_class = vim.fn.expand("%:t:r")

                -- Find project root
                local function find_project_root()
                    local search_dir = current_dir
                    while search_dir ~= "/" do
                        if vim.fn.filereadable(search_dir .. "/build.xml") == 1 then
                            return search_dir
                        end
                        if vim.fn.filereadable(search_dir .. "/pom.xml") == 1 then
                            return search_dir
                        end
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
                    local lib_dir = project_root .. "/lib"
                    if vim.fn.isdirectory(lib_dir) == 1 then
                        local jar_pattern = lib_dir .. "/mysql-connector*.jar"
                        local found_jar = vim.fn.glob(jar_pattern)
                        if found_jar ~= "" then
                            jdbc_jar = found_jar
                            print("✅ Found JDBC driver: " .. jdbc_jar)
                        end
                    end
                end

                -- Fallback to ~/lib
                if jdbc_jar == "" then
                    local home_jar = vim.fn.expand("$HOME/lib/mysql-connector-j-8.2.0.jar")
                    if vim.fn.filereadable(home_jar) == 1 then
                        jdbc_jar = home_jar
                        print("✅ Using JDBC driver from: " .. jdbc_jar)
                    else
                        print("❌ JDBC driver not found!")
                        print("💡 Place mysql-connector.jar in project lib/ or ~/lib/")
                        return
                    end
                end

                -- Compile and run with JDBC - using wildcard for simplicity
                local compile_cmd = "cd " .. shell_escape(current_dir) ..
                    " && javac -cp " .. shell_escape(jdbc_jar) .. " *.java"

                local run_cmd = "cd " .. shell_escape(current_dir) ..
                    " && java -cp " .. shell_escape(".:" .. jdbc_jar) .. " " .. main_class

                vim.cmd("split")
                vim.cmd("resize 15")
                vim.cmd("term " .. compile_cmd .. " && echo '\\n✅ Compiled with JDBC\\n' && " .. run_cmd)
                vim.cmd("startinsert")
            end, { desc = "Run Java with JDBC (auto-detects JAR)" })

            -- ==========================================
            -- 🎯 RUN SPECIFIC MAIN CLASS
            -- ==========================================
            vim.keymap.set("n", "<leader>rjm", function()
                local current_dir = vim.fn.expand("%:p:h")
                local main_class = vim.fn.input("Main class name: ", vim.fn.expand("%:t:r"))

                if main_class == "" then
                    print("❌ Cancelled")
                    return
                end

                local compile_cmd = "cd " .. shell_escape(current_dir) .. " && javac *.java"
                local run_cmd = "cd " .. shell_escape(current_dir) .. " && java " .. main_class

                vim.cmd("split")
                vim.cmd("resize 15")
                vim.cmd("term " .. compile_cmd .. " && echo '\\n✅ Compiled\\n' && " .. run_cmd)
                vim.cmd("startinsert")
            end, { desc = "Run specific Java main class" })

            -- ==========================================
            -- 🔨 COMPILE ONLY (No Run)
            -- ==========================================
            vim.keymap.set("n", "<leader>jC", function()
                local current_dir = vim.fn.expand("%:p:h")
                local java_files = vim.fn.glob(current_dir .. "/*.java", false, true)

                if #java_files == 0 then
                    print("❌ No Java files found")
                    return
                end

                local compile_cmd = "cd " .. shell_escape(current_dir) ..
                    " && javac *.java && echo '✅ Compilation successful'"

                vim.cmd("split")
                vim.cmd("resize 10")
                vim.cmd("term " .. compile_cmd)
                vim.cmd("startinsert")
            end, { desc = "Compile all Java files (no run)" })

            -- ==========================================
            -- 🧹 CLEAN .class FILES
            -- ==========================================
            vim.keymap.set("n", "<leader>jX", function()
                local current_dir = vim.fn.expand("%:p:h")
                vim.fn.system("cd " .. shell_escape(current_dir) .. " && rm -f *.class")
                print("🧹 Cleaned .class files in " .. current_dir)
            end, { desc = "Clean .class files" })

            -- ==========================================
            -- 📦 PACKAGE-AWARE RUNNER (for src/ structure)
            -- ==========================================
            vim.keymap.set("n", "<leader>rjp", function()
                -- Detect if we're in a src/ directory structure
                local current_file = vim.fn.expand("%:p")
                local src_index = string.find(current_file, "/src/")

                if not src_index then
                    print("❌ Not in a src/ directory structure")
                    return
                end

                -- Find project root (directory containing src/)
                local project_root = string.sub(current_file, 1, src_index - 1)

                -- Get package name from file
                local package_line = vim.fn.getline(1)
                local package_name = package_line:match("package%s+([%w%.]+)")

                if not package_name then
                    print("❌ No package declaration found")
                    return
                end

                local class_name = vim.fn.expand("%:t:r")
                local fully_qualified_class = package_name .. "." .. class_name

                -- Compile from project root with proper structure
                local compile_cmd = "cd " .. shell_escape(project_root) ..
                    " && find src -name '*.java' -exec javac -d . {} +"

                local run_cmd = "cd " .. shell_escape(project_root) ..
                    " && java " .. fully_qualified_class

                vim.cmd("split")
                vim.cmd("resize 15")
                vim.cmd("term " .. compile_cmd .. " && echo '\\n✅ Compiled with packages\\n' && " .. run_cmd)
                vim.cmd("startinsert")
            end, { desc = "Run Java with package structure" })
        end,
    },
}
