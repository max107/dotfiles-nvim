local ok, _ = pcall(require, "navigator")
if not ok then
	return
end

require("navigator").setup()
