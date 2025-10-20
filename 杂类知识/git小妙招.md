
# 删库或清空所有提交

先随便创建一个孤儿分支，假设名字是aa
```bash
git checkout --orphan aa
```

把所有文件提交到这个分支上
```bash
git add .
git commit -m 'clean'
```

强制删除主分支
```bash
git branch -D master
```

重命名当前分支
```bash
git branch -m master
```

强制推送到远程
```bash
git push -f -u origin master
```

可以部署成自动化脚本
你会发现远程只有一个commit记录了

删库是一样的道理

# 使用Git自动同步Obsidian配置及仓库

`Obsidian`没有全局配置，所有的配置和插件都是跟着仓库走的。

[用 git submodule（子模块）同步多个 obsidian 库的配置文件](https://forum-zh.obsidian.md/t/topic/334)

本仓库所使用的Git插件即是为了自动同步所用。


---
# 使用Git推送大文件
参见此网站[glf](https://git-lfs.com/)

[[Git如何push大文件]]


# 删除所有commit中都存在的一个文件

如果在所有（或部分）commit中都存在着同一个文件，有一种一键删除的方法：

使用`git filter-repo`，这是一个python包，需要提前安装
```bash
pip install git-filter-repo
```

执行清理命令：
```bash
git filter-repo --path path/to/your/large/file.zip --invert-paths
```

如果本地仓库记录不干净，即不是直接clone下来的干净仓库，那么命令会报错，可以`--force`或`-f`强制执行
```bash
git filter-repo --path path/to/your/large/file.zip --invert-paths -f
```

**注意**：路径要用正斜杠而不是反斜杠，并且根目录路径前不用加斜杠

