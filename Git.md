# Git备忘录


## 引入

*`Obsidian` > `Typora`*

本文档使用`Obsidian`编写，使用`Obsidian`可获得最佳体验，同时本文档所在仓库包含该软件的配置文件，拉下来后即可体验和我一样的配置、主题和插件。
https://blog.csdn.net/qq_54631992/article/details/139185099

### 介绍

[Git是什么](https://liaoxuefeng.com/books/git/what-is-git/index.html)
这篇文章很好地介绍了git 是什么东西，但是这篇文章有点冗杂了，不用看太多

**需要简单学习一下Git是如何工作的**

### 部署

会用Linux的可能不需要通过我这个教程来学习部署

对于Windows，需要安装git相关工具软件，这样可以执行git命令行

https://git-scm.com/
选择
![[Pasted image 20250124144404.png]]

![[Pasted image 20250124144435.png]]

不想使用便携版可以选择上面的标准版下载

安装的时候其实这两个没必要选择，用powershell更好
![[Pasted image 20250124144830.png]]

下面的所有默认即可

安装完成后在powershell中能使用即可
![[Pasted image 20250124145316.png]]

如果没有的话怎么办？自己配置环境变量去


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

> 配置代理（避免麻烦，不然还得开Tun模式）

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

### git clone

把项目拉下来，~~这是最好用的命令~~
比如
```bash
git clone https://github.com/lec-org/Git-Notes.git
```

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

```bash
git checkout --orphan <branch-name>
```

创建一个孤立的，没有任何commit记录的分支

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

Fast-forward 合并发生在目标分支没有新的提交，而源分支有新的提交时。简单来说，目标分支的历史没有分叉，因此 Git 可以通过简单地将目标分支指针“快进”到源分支的最新提交来完成合并。
- **发生条件**：目标分支和源分支之间没有任何分叉，目标分支指向源分支的祖先提交。
- **操作**：Git 会将目标分支的指针直接“快进”到源分支的最新提交。
- **结果**：合并不会创建新的合并提交，目标分支历史会直接包含源分支的提交。
```bash
git merge feature-branch
```

效果：
![[Pasted image 20250124151913.png]]

但是如果在合并的时候我们想保留来自被合并分支的提交历史，并显式标注出合并发生的位置，那么可以使用`–no-ff`参数进行三路合并
![[Pasted image 20250124153522.png]]

2. **三路合并（Three-Way Merge模式）**:

三路合并发生在目标分支和源分支有不同的提交时，但没有产生冲突。Git 会自动将两个分支的更改合并在一起，创建一个新的合并提交。
- **发生条件**：目标分支和源分支之间有不同的提交，且 Git 能够自动合并这些更改。
- **操作**：Git 会比较两个分支的差异，自动将它们合并。如果没有冲突，Git 会生成一个新的合并提交，表示两个分支的历史合并在一起。
```bash
git merge feature-branch
```
   
效果：
![[Pasted image 20250124173524.png]]

![[Pasted image 20250124174241.png]]


3. **合并冲突（Merge Conflict）**:
   - 当 Git 无法自动将更改合并时，会产生合并冲突。这通常发生在两个分支都修改了同一文件的同一部分。Git 会在冲突的文件中标记冲突部分，并停止合并过程，等待你手动解决冲突。
   - 你需要手动编辑冲突文件，选择要保留的更改，然后通过 `git add` 和 `git commit` 完成合并。

```bash
git merge feature-branch
# 解决冲突后
git add <resolved_files>
git commit
```

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

[[git pull|git pull的使用时机及冲突解决]]

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

- **查看指定历史版本**

```bash
git checkout <commit-hash>
```

此时，你会切换到一个 "detached HEAD" 状态，意味着你不再处于当前的分支，而是查看指定提交的内容。此时的工作目录会变为该提交时的快照，你可以查看、编辑文件，但不会影响当前分支的状态

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


- **将特定文件回滚到特定版本**

用`git log`确定版本后
```bash
git checkout <commit-id> -- <file-path>
```


---

### 其他常用命令

- **查看远程仓库**：

```bash
git remote -v
```

显示所有远程仓库的详细信息。

- **查看文件状态**：

```bash
 git status
```

显示工作目录和暂存区的状态。


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

- **更新所有子模块**：

```bash
git submodule foreach git pull origin master
```

遍历所有子模块并更新到最新提交。

删除子模块和把子模块转换为普通文件夹
[[git把子模块文件夹转化为普通文件夹]]

## 更多小技巧

[[git小妙招]]

---

## 问题解决

### Windows中使用Git速度过慢

在确保像本文档开头“配置”一栏那样设置过可靠的代理后，请继续阅读：
[[git clone或push速度过慢]]

### 出现 detected dubious ownership

```
fatal: detected dubious ownership in repository at 'xxx'
'xx' is owned by:
        Reimu
but the current user is:
        Marisa
To add an exception for this directory, call:

        git config --global --add safe.directory 'xxx'
```

在Windows中，发生过这种问题，在这种情况下，一切对本地仓库的操作都会被阻止。
这是因为仓库文件夹的**所有者**发生了变化。

可以按照提示对相应文件夹进行临时解决，一劳永逸的方法是：
```bash
git config --global --add safe.directory "*"
```

---


## 轶事

曾经Github的主分支名字叫**master**，后来改名叫**main**了，原因为何，可以搜索一下。

## 可视化操作

很多软件都能实现，比如vscode、idea等

这里推荐
https://github.com/gitextensions/gitextensions
可以可视化查看提交历史，还可以实现单个文件的版本比较等操作

不过感觉用熟悉命令行后再用这个软件才感觉到便捷一点，但是最终感觉还是命令行比较方便
# 后记

本文档乃速成之作，为了方便使用git命令行所著，现投递到公共仓库中，各位可以fork之后提交pull request，以此来完善此文。