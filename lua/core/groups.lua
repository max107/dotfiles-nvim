vim.cmd([[
  augroup default
    au!
    " Make sure Kubernetes yaml files end up being set as helm files.
    au BufNewFile,BufRead *.{yaml,yml} if getline(1) =~ '^apiVersion:' || getline(2) =~ '^apiVersion:' | setlocal filetype=helm | endif
    autocmd BufNewFile,BufRead werf.yaml set syntax=helm

    autocmd BufNewFile,BufRead *.html.twig set syntax=html

    autocmd BufNewFile,BufRead composer.lock set syntax=json
    autocmd BufNewFile,BufRead *.babelrc set syntax=json

    autocmd BufNewFile,BufRead Dockerfile.* set syntax=dockerfile
    autocmd BufNewFile,BufRead *.dockerfile set syntax=dockerfile

    autocmd BufNewFile,BufRead *.tpl set syntax=php
    autocmd BufNewFile,BufRead *.ini set filetype=dosini

    autocmd BufNewFile,BufRead default set filetype=nginx

    autocmd FileType vue,xml,html,xhtml,css,scss,javascript,lua,yaml setlocal shiftwidth=2 tabstop=2

    autocmd FileType terraform setlocal commentstring=#\ %s
  augroup END
]])

vim.cmd([[silent! autocmd! filetypedetect BufRead,BufNewFile *.tf]])
vim.cmd([[autocmd BufRead,BufNewFile *.hcl set filetype=hcl]])
vim.cmd([[autocmd BufRead,BufNewFile .terraformrc,terraform.rc set filetype=hcl]])
vim.cmd([[autocmd BufRead,BufNewFile *.tf,*.tfvars set filetype=terraform]])
vim.cmd([[autocmd BufRead,BufNewFile *.tfstate,*.tfstate.backup set filetype=json]])
