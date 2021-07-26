local my_telescope = {}

my_telescope.find_files = function()
  require('telescope.builtin').find_files({
    previewer = false
  })
end

return my_telescope
