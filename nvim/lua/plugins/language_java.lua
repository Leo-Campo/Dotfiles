local home_dir = vim.env.HOME
local java_version = "21"

-- taken from https://github.com/mfussenegger/nvim-jdtls/issues/565
-- solves running test error with jdtls

local function get_bundles()
	local mason_reg = require("mason-registry")
	local function get_adapter_bundle()
		local pkg = mason_reg.get_package("java-debug-adapter")
		local pkg_install_path = pkg:get_install_path()
		local pkg_jar_glob = pkg_install_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar"
		local pkg_jar = vim.fn.glob(pkg_jar_glob, 1)
		return pkg_jar
	end
	local function get_vscode_java_test_bundles()
		local pkg = mason_reg.get_package("java-test")
		local pkg_install_path = pkg:get_install_path()
		local pkg_jars_glob = pkg_install_path .. "/extension/server/*.jar"
		local pkg_jars = vim.fn.glob(pkg_jars_glob, 1)
		local pkg_jars_list = vim.split(pkg_jars, "\n")
		return pkg_jars_list
	end
	local bundles = {
		get_adapter_bundle(),
	}
	vim.list_extend(bundles, get_vscode_java_test_bundles())
	-- vim.notify("[JAVA bundles] " .. vim.inspect(bundles))
	return bundles
end

return {
	{
		"mfussenegger/nvim-jdtls",
		opts = function()
			return {
				-- How to find the root dir for a given filename. The default comes from
				-- lspconfig which provides a function specifically for java projects.
				root_dir = require("lspconfig.server_configurations.jdtls").default_config.root_dir,

				-- How to find the project name for a given root dir.
				project_name = function(root_dir)
					return root_dir and vim.fs.basename(root_dir)
				end,

				-- Where are the config and workspace dirs for a project?
				jdtls_config_dir = function(project_name)
					return vim.fn.stdpath("cache") .. "/jdtls/" .. project_name .. "/config"
				end,
				jdtls_workspace_dir = function(project_name)
					return vim.fn.stdpath("cache") .. "/jdtls/" .. project_name .. "/workspace"
				end,

				-- How to run jdtls. This can be overridden to a full java command-line
				-- if the Python wrapper script doesn't suffice.
				cmd = {
					home_dir .. "/.local/share/mise/installs/java/" .. java_version .. "/bin/java",
					"-Declipse.application=org.eclipse.jdt.ls.core.id1",
					"-Dosgi.bundles.defaultStartLevel=4",
					"-Declipse.product=org.eclipse.jdt.ls.core.product",
					"-Dosgi.checkConfiguration=true",
					"-Dosgi.sharedConfiguration.area="
						.. home_dir
						.. "/.local/share/nvim/mason/packages/jdtls/config_linux",
					"-Dosgi.sharedConfiguration.area.readOnly=true",
					"-Dosgi.configuration.cascaded=true",
					"-Xms1G",
					"--add-modules=ALL-SYSTEM",
					"--add-opens",
					"java.base/java.util=ALL-UNNAMED",
					"--add-opens",
					"java.base/java.lang=ALL-UNNAMED",
					"-jar",
					home_dir
						.. "/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.6.600.v20231106-1826.jar",
				},
				full_cmd = function(opts)
					local fname = vim.api.nvim_buf_get_name(0)
					local root_dir = opts.root_dir(fname)
					local project_name = opts.project_name(root_dir)
					local cmd = vim.deepcopy(opts.cmd)
					if project_name then
						vim.list_extend(cmd, {
							"-configuration",
							opts.jdtls_config_dir(project_name),
							"-data",
							opts.jdtls_workspace_dir(project_name),
						})
					end
					return cmd
				end,

				-- These depend on nvim-dap, but can additionally be disabled by setting false here.
				dap = { hotcodereplace = "auto", config_overrides = {} },
				test = true,
			}
		end,
	},
}