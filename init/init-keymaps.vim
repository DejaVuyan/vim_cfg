"======================================================================
"
" init-keymaps.vim - 按键设置，按你喜欢更改
"
"   - 快速移动
"   - 标签切换
"   - 窗口切换
"   - 终端支持
"   - 编译运行
"   - 符号搜索
"
" Created by skywind on 2018/05/30
" Last Modified: 2018/05/30 17:59:31
"
"======================================================================
" vim: set ts=4 sw=4 tw=78 noet :

 " 在Insert模式下映射键位(原有键位不会丢失)
imap jj <Esc>
" 在普通模式下映射键位(原有键位不会丢失)
nmap <space> : 

"----------------------------------------------------------------------
" 命令模式的快速移动
"----------------------------------------------------------------------
"cnoremap <c-h> <left>
"cnoremap <c-j> <down>
"cnoremap <c-k> <up>
"cnoremap <c-l> <right>
"cnoremap <c-a> <home>
"cnoremap <c-e> <end>
"cnoremap <c-f> <c-d>
"cnoremap <c-b> <left>
"cnoremap <c-d> <del>
"cnoremap <c-_> <c-k>


"----------------------------------------------------------------------
" <leader>+数字键 切换tab
"----------------------------------------------------------------------
noremap <silent><leader>1 1gt<cr>
noremap <silent><leader>2 2gt<cr>
noremap <silent><leader>3 3gt<cr>
noremap <silent><leader>4 4gt<cr>
noremap <silent><leader>5 5gt<cr>
noremap <silent><leader>6 6gt<cr>
noremap <silent><leader>7 7gt<cr>
noremap <silent><leader>8 8gt<cr>
noremap <silent><leader>9 9gt<cr>
noremap <silent><leader>0 10gt<cr>

"----------------------------------------------------------------------
" 缓存：插件 unimpaired 中定义了 [b, ]b 来切换缓存
"----------------------------------------------------------------------
"noremap <silent> <leader>bn :bn<cr>
"noremap <silent> <leader>bp :bp<cr>


"----------------------------------------------------------------------
" 编译运行 C/C++ 项目
" 详细见：http://www.skywind.me/blog/archives/2084
"----------------------------------------------------------------------

"" 自动打开 quickfix window ，高度为 6
"let g:asyncrun_open = 6
"
"" 任务结束时候响铃提醒
"let g:asyncrun_bell = 1
"
"" 设置 F10 打开/关闭 Quickfix 窗口
"nnoremap <F10> :call asyncrun#quickfix_toggle(6)<cr>
"
"" F9 编译 C/C++ 文件
"nnoremap <silent> <F9> :AsyncRun gcc -Wall -O2 "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>
"
"" F5 运行文件
"nnoremap <silent> <F5> :call ExecuteFile()<cr>
"
"" F7 编译项目
"nnoremap <silent> <F7> :AsyncRun -cwd=<root> make <cr>
"
"" F8 运行项目
"nnoremap <silent> <F8> :AsyncRun -cwd=<root> -raw make run <cr>
"
"" F6 测试项目
"nnoremap <silent> <F6> :AsyncRun -cwd=<root> -raw make test <cr>
"
"" 更新 cmake
"nnoremap <silent> <F4> :AsyncRun -cwd=<root> cmake . <cr>
"
"" Windows 下支持直接打开新 cmd 窗口运行
"if has('win32') || has('win64')
"	nnoremap <silent> <F8> :AsyncRun -cwd=<root> -mode=4 make run <cr>
"endif
"
"
""----------------------------------------------------------------------
"" F5 运行当前文件：根据文件类型判断方法，并且输出到 quickfix 窗口
""----------------------------------------------------------------------
"function! ExecuteFile()
"	let cmd = ''
"	if index(['c', 'cpp', 'rs', 'go'], &ft) >= 0
"		" native 语言，把当前文件名去掉扩展名后作为可执行运行
"		" 写全路径名是因为后面 -cwd=? 会改变运行时的当前路径，所以写全路径
"		" 加双引号是为了避免路径中包含空格
"		let cmd = '"$(VIM_FILEDIR)/$(VIM_FILENOEXT)"'
"	elseif &ft == 'python'
"		let $PYTHONUNBUFFERED=1 " 关闭 python 缓存，实时看到输出
"		let cmd = 'python "$(VIM_FILEPATH)"'
"	elseif &ft == 'javascript'
"		let cmd = 'node "$(VIM_FILEPATH)"'
"	elseif &ft == 'perl'
"		let cmd = 'perl "$(VIM_FILEPATH)"'
"	elseif &ft == 'ruby'
"		let cmd = 'ruby "$(VIM_FILEPATH)"'
"	elseif &ft == 'php'
"		let cmd = 'php "$(VIM_FILEPATH)"'
"	elseif &ft == 'lua'
"		let cmd = 'lua "$(VIM_FILEPATH)"'
"	elseif &ft == 'zsh'
"		let cmd = 'zsh "$(VIM_FILEPATH)"'
"	elseif &ft == 'ps1'
"		let cmd = 'powershell -file "$(VIM_FILEPATH)"'
"	elseif &ft == 'vbs'
"		let cmd = 'cscript -nologo "$(VIM_FILEPATH)"'
"	elseif &ft == 'sh'
"		let cmd = 'bash "$(VIM_FILEPATH)"'
"	else
"		return
"	endif
"	" Windows 下打开新的窗口 (-mode=4) 运行程序，其他系统在 quickfix 运行
"	" -raw: 输出内容直接显示到 quickfix window 不匹配 errorformat
"	" -save=2: 保存所有改动过的文件
"	" -cwd=$(VIM_FILEDIR): 运行初始化目录为文件所在目录
"	if has('win32') || has('win64')
"		exec 'AsyncRun -cwd=$(VIM_FILEDIR) -raw -save=2 -mode=4 '. cmd
"	else
"		exec 'AsyncRun -cwd=$(VIM_FILEDIR) -raw -save=2 -mode=0 '. cmd
"	endif
"endfunc
"
"
"
""----------------------------------------------------------------------
"" F2 在项目目录下 Grep 光标下单词，默认 C/C++/Py/Js ，扩展名自己扩充
"" 支持 rg/grep/findstr ，其他类型可以自己扩充
"" 不是在当前目录 grep，而是会去到当前文件所属的项目目录 project root
"" 下面进行 grep，这样能方便的对相关项目进行搜索
""----------------------------------------------------------------------
"if executable('rg')
"	noremap <silent><F2> :AsyncRun! -cwd=<root> rg -n --no-heading 
"				\ --color never -g *.h -g *.c* -g *.py -g *.js -g *.vim 
"				\ <C-R><C-W> "<root>" <cr>
"elseif has('win32') || has('win64')
"	noremap <silent><F2> :AsyncRun! -cwd=<root> findstr /n /s /C:"<C-R><C-W>" 
"				\ "\%CD\%\*.h" "\%CD\%\*.c*" "\%CD\%\*.py" "\%CD\%\*.js"
"				\ "\%CD\%\*.vim"
"				\ <cr>
"else
"	noremap <silent><F2> :AsyncRun! -cwd=<root> grep -n -s -R <C-R><C-W> 
"				\ --include='*.h' --include='*.c*' --include='*.py' 
"				\ --include='*.js' --include='*.vim'
"				\ '<root>' <cr>
"endif


