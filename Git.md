# Git备忘录

d6d004898587a25b023e83658c803d3e745e0b03c005a36765a78a2f9abf8b5ffdacc72fea1982a1c19f73cab2cd638c552c277fa3aff054a04bc0b09a741ec9

## 引入

*`Obsidian` > `Typora`*

本文档使用`Obsidian`编写，使用`Obsidian`可获得最佳体验，同时本文档所在仓库包含该软件的配置文件，拉下来后即可体验和我一样的配置、主题和插件。
https://blog.csdn.net/qq_54631992/article/details/139185099

### 介绍

[Git是什么](https://liaoxuefeng.com/books/git/what-is-git/index.html)
这篇文章很好地介绍了git 是什么东西。

**需要简单学习一下Git是如何工作的**

### 配置

github是使用git管理的代码托管社区，除了github之外还有gitlab，中国的github之类的的，当然也可以搭建私人的"github"。
最有名的就是github，因此想要学会git，首先得学会配置github。

https://blog.csdn.net/EliasChang/article/details/136561863
这篇文章讲述了如何安装git和如何配置github，这里补充两点：

1. 在本地用命令行时，不必非得使用git的命令行工具gitbash，可以添加环境变量后使用Windows自带的`powershell`
2. 在配置Github时，很多教程都要求设置SSH秘钥，配置SSH连接，这个其实没必要，因为用起来不太方便。~~*愿意也可以设置*~~
    - 用SSH生成公钥与私钥其实相当于用个人电脑生成了一张身份证，之后连接Github只要有这张身份证就不用输入用户名和密码，看起来很方便，但是如果用纯SSH搞一个开源项目，那你赶紧忙着去邀请八方来客吧，不然连clone的权限都没有。
    - SSH生成的秘钥保存在电脑`C:\Users\用户名\.ssh`中，不做特殊保护，容易被他人持有，不安全。用Http连接配置完用户名和邮箱后会弹出登录窗口，登录后令牌保存在Windows凭据管理器中，相对安全。


> 快速配置Config：
```bash
git config --global user.name "github上注册的用户名" # 配置用户名
git config --global user.email "github上注册的邮箱" # 配置用户邮箱
git config --global user.name # 查看配置的用户名
git config --global user.email # 查看配置的用户邮箱
git config -l # 查看所有配置

# 删除配置
git config --global --unset user.name
git config --global --unset user.email

```

> 配置代理（避免麻烦，还得开Tun模式）

设置代理：

```bash
//http || https (换成本机的代理服务地址)
git config --global http.proxy 127.0.0.1:7897
git config --global https.proxy 127.0.0.1:7897

//sock5代理
git config --global http.proxy socks5 127.0.0.1:7891
git config --global https.proxy socks5 127.0.0.1:7891
```

查看代理：

```bash
git config --global --get http.proxy
git config --global --get https.proxy
```

取消代理：

```bash
git config --global --unset http.proxy
git config --global --unset https.proxy
```
---
## Git 分支和远程操作指南

## git clone

把项目拉下来，~~这是最好用的命令~~

---
### 分支相关命令

#### 本地分支操作

- **查看本地分支**：

```bash
    git branch
```

    显示本地所有分支。

- **创建新分支**：

```bash
    git branch <branch-name>
```

    创建一个名为 `<branch-name>` 的新分支。

- **切换分支**：

```bash
    git checkout <branch-name>
```

    切换到名为 `<branch-name>` 的分支。

- **创建并切换到新分支**：

```bash
    git checkout -b <branch-name>
```

    创建一个新分支并立即切换到该分支。

- **删除分支**：

```bash
    git branch -d <branch-name>
```

    删除名为 `<branch-name>` 的分支。

- **强制删除分支**：

```bash
    git branch -D <branch-name>
```

    强制删除名为 `<branch-name>` 的分支，即使该分支有未合并的更改。

- **重命名分支**：

```bash
    git branch -m <new-branch-name>
```

    将当前分支重命名为 `<new-branch-name>`。

- **合并分支**

```bash
git merge <branch_name>
```
该命令会将 `branch_name` 分支合并到你当前的分支。例如，如果你在 `main` 分支上运行 `git merge feature-branch`，则会把 `feature-branch` 的更改合并到 `main` 分支。

`git merge` 可能会产生以下几种结果：

1. **Fast-forward 合并**:
   - 当目标分支的历史直接在线上包含源分支的历史时，Git 会执行“快进”（fast-forward）合并。这样，目标分支的指针会简单地向前移动到源分支的最后一个提交，不会生成新的合并提交。
   - 这种合并只会在源分支的提交在目标分支的历史中顺延的情况下发生。

```bash
git merge feature-branch
```
   结果：
```
Before: A---B---C---D (main)
                \
                E---F (feature-branch)

After:  A---B---C---D---E---F (main, feature-branch)
```

2. **自动合并**:
   - 如果两个分支有分歧，Git 会尝试自动合并两者。此时，Git 会创建一个新的合并提交（merge commit），这个提交包含两个父提交：目标分支和源分支。

```bash
git merge feature-branch
```
   结果：
```
Before: A---B---C (main)
            \ 
             D---E (feature-branch)

After:  A---B---C---M (main)
             \     /
              D---E (feature-branch)
```
   其中，`M` 是合并提交。

3. **合并冲突（Merge Conflict）**:
   - 当 Git 无法自动将更改合并时，会产生合并冲突。这通常发生在两个分支都修改了同一文件的同一部分。Git 会在冲突的文件中标记冲突部分，并停止合并过程，等待你手动解决冲突。
   - 你需要手动编辑冲突文件，选择要保留的更改，然后通过 `git add` 和 `git commit` 完成合并。

```bash
git merge feature-branch
# 解决冲突后
git add <resolved_files>
git commit
```

- **`--no-ff`**: 强制生成一个合并提交，即使可以执行 fast-forward 合并。
  
```bash
  git merge --no-ff feature-branch
```
  结果：
```
  Before: A---B---C---D (main)
                     \
                      E---F (feature-branch)

  After:  A---B---C---D---M (main)
                     \   /
                      E---F (feature-branch)
```
  其中，`M` 是合并提交。

- **`--squash`**: 将源分支的所有提交压缩为一个提交，然后合并到当前分支。这不会自动生成一个合并提交，你需要手动提交。
  
```bash
git merge --squash feature-branch
git commit -m "Squashed merge of feature-branch"
```
  结果：
```
  Before: A---B---C (main)
                \ 
                 D---E (feature-branch)

  After:  A---B---C---S (main)
```
  其中，`S` 是你手动提交的 squashed 合并提交。

- **`--abort`**: 如果在合并过程中发生冲突，并且你决定放弃合并，可以使用 `git merge --abort` 取消合并过程，恢复到合并前的状态。

```bash
  git merge --abort
```


#### 远程分支操作

- **推送本地分支到远程**

如果在本地新建了一个分支，想推送到远端，输入`git push`提示 

```bash
fatal: The current branch test2 has no upstream branch.
To push the current branch and set the remote as upstream, use

    git push --set-upstream origin test2
```
是正常的，这是因为<mark style="background: #ADCCFFA6;">本地分支和远程分支没有产生关联</mark>，因此你需要这样:

```bash
git push origin test2:testqaq
```
这样，你就在远程新建了一个`testqaq`分支并把本地的`tset2`分支推送到了远程的`testqaq`中

其实你可以按照提示的说法输入
```bash
git push --set-upstream origin test2
```
或者直接
```bash
git push -u origin test2
```

- **`-u` 或 `--set-upstream`**：将本地分支与远程分支关联。这样以后你可以直接使用 `git push` 和 `git pull` 而不需要每次都指定远程分支的名称。
- **`origin`**：这是远程仓库的默认名称。如果你的远程仓库名称不同，请替换为相应的名称。
- **`test2`**：这是你要推送的本地分支的名称。


**其他常用参数**

- **`--force` 或 `-f`**：强制推送，会覆盖远程分支的历史记录。使用时需谨慎，因为它会丢失远程分支上的提交记录。

```bash
    git push --force origin <branch-name>
```
使用场景：你想回滚到某次提交，并且这次提交之后的所有提交都不想要了

- **`--all`**：推送所有本地分支到远程仓库。
  
```bash
    git push --all origin
```

- **`--tags`**：推送所有本地标签到远程仓库。
  
```bash
    git push --tags origin
```


- **查看远程分支**：
一定要记得，首先，使用 `git fetch` 命令从远程仓库获取最新的分支信息：

```bash
git fetch
```

`显示所有远程分支`
```bash
git branch -r
```


- **拉取远程分支并创建本地分支**：

如果发现远程新增了分支，那么可以拉取到本地：

```bash
git checkout -b <local-branch-name> <remote-name>/<remote-branch-name>
```

    从远程仓库 `<remote-name>` 的 `<remote-branch-name>` 分支拉取更新，并创建一个名为 `<local-branch-name>` 的本地分支。


如果你想同时查看本地和远程的所有分支，可以使用 `git branch -a` 命令

- **删除远程分支**：

```bash
git push <remote-name> --delete <branch-name>
或者
git push <remote-name> -d <branch-name>
```

    删除远程仓库 `<remote-name>` 中的 `<branch-name>` 分支。

>`git branch -d -r origin/xxx` 和 `git push origin -d xxx`的区别： 
> 
 *`git branch -d -r origin/xxx`*
> - **作用**：删除本地对远程分支的引用。
> - **影响范围**：仅在本地有效，不会影响远程仓库。
> - **使用场景**：当你想在本地清理已经删除或不再需要的远程分支引用时使用。
> 
>
>*`git push origin -d xxx`*
> 
> - **作用**：删除远程仓库中的分支。
> - **影响范围**：会影响远程仓库，删除指定的远程分支。
> - **使用场景**：当你确定某个分支在远程仓库中不再需要，并希望将其删除时使用。

---
### 获取更新

- **从远程仓库获取更新**：

```bash
git fetch
```

    从远程仓库获取最新的更新，但不自动合并。



- **拉取远程仓库的更新并合并到当前分支**：

```bash
    git pull
```

    获取远程仓库的更新并自动合并到当前分支。

`git pull`相当于先`git fetch`后再`git merge`


- **从远程拉取其他分支**：


```bash
git fetch origin <branch-name>:<local-branch-name>
```

    从远程仓库的 `<branch-name>` 分支拉取更新到本地的 `<local-branch-name>` 分支。

>实际上这个和`git checkout -b <local-branch-name> <remote-name>/<remote-branch-name>`的区别就是获取之后是否切换到相应分支。
---
### 提交和推送

- **添加文件到暂存区**：

```bash
git add <file-name>
```

    将 `<file-name>` 文件添加到暂存区。

你可以一次性添加多个文件到暂存区。

```bash
git add file1 file2 file3
```

- **提交更改**：

```bash
    git commit -m "commit message"
```

    提交暂存区的更改，并添加提交信息。

- **修改最近一次提交的信息**：

```bash
    git commit --amend -m "new commit message"
```

    修改最近一次提交的信息。

- **推送到远程仓库**：

```bash
    git push
```

    将本地分支的更改推送到远程仓库。

- **推送到指定的远程仓库和分支**：

```bash
    git push <remote-name> <branch-name>
```

    将本地 `<branch-name>` 分支的更改推送到远程仓库 `<remote-name>`。

- **强制推送到远程仓库**：

```bash
    git push <remote-name> <branch-name> --force
```

    强制将本地 `<branch-name>` 分支的更改推送到远程仓库 `<remote-name>`，覆盖远程分支的内容。

---
### 回滚和撤销

*如果我add或者commit了之后反悔了该怎么办？*

> 随着Git版本迭代，也许现在有更多的方法，不过殊途同归，换汤不换药

- **撤销已经暂存的文件**

[[HEAD|相关链接，HEAD是什么意思]]

如果你已经执行了 `git add`，但想撤销这个操作并让文件回到未暂存状态，可以使用以下命令：
```bash
git reset HEAD <file_name>
```

如果你想撤销所有已暂存的文件，可以使用以下命令：
```bash
git reset HEAD
```

这个操作不会撤回文件的修改，只是把文件从暂存区中剥离出来。
*`git reset .`和上面的命令作用相同*

>滑稽:`git restore`又是啥？


- **回滚到上一个提交**：

```bash
    git reset --hard HEAD^
```

    回滚到上一个提交，丢弃所有更改。

- **回滚到指定提交**：

```bash
    git reset --hard <commit-hash>
```

    回滚到指定的提交 `<commit-hash>`，丢弃所有更改。

*如何查看commit的hash？[[git log和git reflog|试试这个]]*


- **撤销最近一次提交，但保留更改**：

```bash
    git reset --soft HEAD^
```

    撤销最近一次提交，但保留更改在暂存区。

- **撤销最近一次提交并将更改移动到工作目录**：

```bash
    git reset HEAD^
```

    撤销最近一次提交，并将更改移动到工作目录。

- **取消提交但保留更改**：

```bash
    git reset --mixed HEAD^
```

    撤销最近一次提交，但保留更改在工作目录中。


> *相关参数的解释：*
> `--mixed`（默认）: 
>
> - 重置 `HEAD` 到指定的提交，并且**取消暂存区中的更改**，但**保留工作目录中的更改**。这是 `git reset` 的默认行为，即使你不指定 `--mixed`，它也是默认的。
>
> `--soft`:
>
> - 重置 `HEAD` 到指定的提交，但**保留暂存区和工作目录中的更改**。这意味着所有的更改都保持暂存状态，只是当前分支的提交历史被重置了。
>
> `--hard`:
> - 重置 `HEAD` 到指定的提交，并且**将暂存区和工作目录都重置到这个提交的状态**。这意味着==所有未提交的更改都会被丢弃==，包括暂存区和工作目录中的更改。


- **撤销最近一次推送**：

```bash
    git revert <commit-hash>
```

    创建一个新的提交来撤销指定的提交 `<commit-hash>`。


在Git中，回滚操作的结果取决于你使用的具体命令和参数。以下是几种常见的回滚方式及其影响：

1. **`git reset --hard <commit>`**:
   
    - 这种方式会将当前分支的HEAD指针移动到指定的提交，并且会丢弃该提交之后的所有更改。
    - **注意**：这种操作会删除工作目录中的所有未提交的更改和提交记录，无法通过普通方式恢复
2. **`git reset --soft <commit>`**:
   
    - 这种方式会将HEAD指针移动到指定的提交，但不会更改工作目录中的文件。
    - 之前的提交会被取消，但更改仍然存在于暂存区，可以重新提交
3. **`git revert <commit>`**:
   
    - 这种方式不会删除任何提交，而是创建一个新的提交来撤销指定提交的更改。
    - 这种方法保留了提交历史记录，是一种更安全的回滚方式
4. **`git reflog`**:
   
    - 如果你误用了`git reset --hard`，可以使用`git reflog`查看HEAD的历史记录，然后使用`git reset --hard <reflog-id>`恢复到之前的状态

---
### 远程相关命令

- **查看远程仓库**：



```bash
    git remote -v
```

    显示所有远程仓库的详细信息。

- **添加远程仓库**：

```bash
    git remote add <remote-name> <remote-url>
```

    添加一个新的远程仓库，命名为 `<remote-name>`，URL 为 `<remote-url>`。

- **删除远程仓库**：

```bash
    git remote remove <remote-name>
```

    删除名为 `<remote-name>` 的远程仓库。

- **重命名远程仓库**：

```bash
    git remote rename <old-name> <new-name>
```

    将远程仓库从 `<old-name>` 重命名为 `<new-name>`。

- **获取远程仓库的更新**：

```bash
    git fetch <remote-name>
```

    从名为 `<remote-name>` 的远程仓库获取更新。

---
### 其他常用命令

- **查看文件状态**：

```bash
    git status
```

    显示工作目录和暂存区的状态。

- **合并远程分支到本地分支**：

```bash
    git merge <remote-name>/<branch-name>
```

    将远程仓库 `<remote-name>` 的 `<branch-name>` 分支合并到当前本地分支。

- **查看某个提交的详细信息**：

```bash
    git show <commit-hash>
```

    显示指定提交 `<commit-hash>` 的详细信息。

- **比较两个分支的差异**：

```bash
    git diff <branch1> <branch2>
```

    比较 `<branch1>` 和 `<branch2>` 分支的差异。

- **暂存当前更改**：

```bash
    git stash
```

    暂存当前工作目录的更改。

- **应用暂存的更改**：

```bash
    git stash apply
```

    应用最近一次暂存的更改。

- **查看暂存的更改列表**：

```bash
    git stash list
```

    显示所有暂存的更改。

- **丢弃所有暂存的更改**：

```bash
    git stash clear
```

    丢弃所有存储的暂存更改。

[[git stash|更多关于暂存操作的内容，请阅读]]

### 进阶使用

#### 变基操作

- **变基到主分支**：

```bash
    git rebase main
```

    将当前分支的提交变基到 `main` 分支上。

- **交互式变基**：

```bash
    git rebase -i HEAD~<number>
```

    对最近的 `<number>` 次提交进行交互式变基。

关于变基，是一种不同于`merge`的合并方式，请阅读这篇文章：
https://www.cnblogs.com/FraserYu/p/11192840.html

---

### 子模块相关命令

- **添加子模块**：

```bash
    git submodule add <repository-url> <path>
```

    将子模块仓库添加到当前仓库中，路径为 `<path>`。

- **初始化子模块**：

```bash
    git submodule init
```

    初始化子模块，这通常在克隆包含子模块的仓库后进行。

- **更新子模块**：

```bash
    git submodule update
```

    更新子模块到配置文件中记录的最新提交。

- **克隆包含子模块的仓库**：

```bash
    git clone --recurse-submodules <repository-url>
```

    克隆包含子模块的仓库，并同时克隆所有子模块。

- **查看子模块状态**：

```bash
    git submodule status
```

    显示当前子模块的状态，包括子模块的 SHA-1 值和路径。

- **更新子模块到最新提交**：

```bash
    git submodule update --remote
```

    更新子模块到远程仓库的最新提交。

> NOTE:这个命令虽然会更新子模块，但是导致子模块的头指针分离，这一点需要注意

- **删除子模块**：

    1. 从 `.gitmodules` 文件中移除子模块条目。
    
```bash
        git config -f .gitmodules --remove-section submodule.<path>
```

    2. 从 `.git/config` 文件中移除子模块条目。

```bash
        git config -f .git/config --remove-section submodule.<path>
```

    3. 删除子模块目录并移除暂存区的子模块。

```bash
        git rm --cached <path>
        rm -rf <path>
```

    4. 提交更改。

```bash
        git commit -m "Removed submodule <path>"
```

- **更新所有子模块**：

```bash
    git submodule foreach git pull origin master
```

    遍历所有子模块并更新到最新提交。


## 使用Git自动同步Obsidian配置及仓库

`Obsidian`没有全局配置，所有的配置和插件都是跟着仓库走的。

[用 git submodule（子模块）同步多个 obsidian 库的配置文件](https://forum-zh.obsidian.md/t/topic/334)

本仓库所使用的Git插件即是为了自动同步所用。

> 上文我提到，`git submodule update --remote`会导致子模块头指针分离，这样在自动同步的时候push会出问题
> 因此，我使用仓库中的*sync_config.bat*进行配置文件(`.Obsidian仓库`)的同步。


## 轶事

曾经Github的主分支名字叫**master**，后来改名叫**main**了，原因为何，可以搜索一下。

# 后记

本文档乃速成之作，为了方便使用git命令行所著，现投递到公共仓库中，各位可以fork之后提交pull request，以此来完善此文。