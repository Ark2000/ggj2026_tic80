#!/bin/bash
# TIC-80 可执行文件路径
TIC80_BIN="./tic80/build/bin/tic80"
# 启动 TIC-80，使用 --cmd 加载 main.tic，然后导入 code.lua 并运行
"$TIC80_BIN" --fs . --skip --cmd="load src/main.tic & import code src/code.lua & run"
