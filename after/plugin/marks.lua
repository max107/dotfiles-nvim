local ok, _ = pcall(require, "marks")
if not ok then
  return
end

require("marks").setup({})
