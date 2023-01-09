local ok, _ = pcall(require, "go")
if not ok then
	return
end

require("go").setup()
