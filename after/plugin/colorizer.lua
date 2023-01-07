local ok, _ = pcall(require, "colorizer")
if not ok then
	return
end

require("colorizer").setup()
