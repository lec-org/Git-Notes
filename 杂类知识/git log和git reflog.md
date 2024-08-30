# git log
`git log` 是 Git 中的一个命令，用于查看项目的提交历史。它显示了项目的所有提交记录，按照时间倒序排列（最新的提交显示在最上面）。`git log` 是开发者了解代码库变更历史、查找特定提交、了解代码演变过程的一个非常重要的工具。

### `git log` 的基本用法

1. **显示提交历史**
   - 运行 `git log`，你会看到每个提交的详细信息，包括提交的哈希值（SHA-1）、提交者、日期和提交信息。
   - 默认情况下，`git log` 显示的信息如下：
```bash
     commit <commit_hash>
     Author: <author_name> <author_email>
     Date:   <date>

         <commit_message>
```

   例如：
```bash
   commit 1a2b3c4d5e6f7g8h9i0j
   Author: John Doe <john.doe@example.com>
   Date:   Mon Aug 28 12:34:56 2023 +0200

       Fixed bug in authentication module
```

### `git log` 的常用选项

2. **限制输出的提交数**
   - 如果你只想查看最近几次提交，可以使用 `-n` 选项，其中 `n` 是你想要显示的提交记录数。
   - 例如，显示最近 5 次提交：
```bash
     git log -5
```

3. **单行显示每个提交**
   - 使用 `--oneline` 选项可以简化每个提交的显示格式，每个提交只显示其简短的哈希值和提交信息的第一行。
   - 例如：
```bash
     git log --oneline
```
   - 输出示例：
```
     1a2b3c4 Fixed bug in authentication module
     5d6e7f8 Added new feature to improve performance
```

4. **显示提交的差异**
   - 如果你想查看每次提交所作的更改内容，可以使用 `-p` 选项，它会显示每个提交的差异（diff）。
   - 例如：
```bash
     git log -p
```

5. **显示统计信息**
   - 使用 `--stat` 选项可以查看每次提交所更改的文件及其更改的行数统计。
   - 例如：
```bash
     git log --stat
```
   - 输出示例：
```
     commit 1a2b3c4d5e6f7g8h9i0j
     Author: John Doe <john.doe@example.com>
     Date:   Mon Aug 28 12:34:56 2023 +0200

         Fixed bug in authentication module

      auth_module.py | 10 +++++-----
      1 file changed, 5 insertions(+), 5 deletions(-)
```

6. **按时间范围过滤提交**
   - 你可以使用 `--since` 和 `--until` 选项来过滤特定时间范围内的提交。
   - 例如，查看自 2023 年 1 月 1 日以来的所有提交：
```bash
     git log --since="2023-01-01"
```
   - 或者查看 2023 年 8 月的所有提交：
```bash
     git log --since="2023-08-01" --until="2023-08-31"
```

7. **按作者过滤提交**
   - 使用 `--author` 选项可以过滤出特定作者的提交。
   - 例如，查看 John Doe 的所有提交：
```bash
     git log --author="John Doe"
```

8. **按提交信息过滤提交**
   - 使用 `--grep` 选项可以根据提交信息中的关键字进行过滤。
   - 例如，查看提交信息中包含 "bug fix" 的所有提交：
```bash
     git log --grep="bug fix"
```

### 综合示例

结合多个选项，你可以创建复杂的查询。例如：

```bash
git log --oneline --author="John Doe" --since="2023-01-01" --grep="performance"
```

这个命令会显示自 2023 年 1 月 1 日以来，John Doe 提交的所有提交信息中包含 "performance" 的简洁提交记录。

---
# git reflog

`git reflog` 是 Git 中一个非常强大的命令，用于记录和查看 `HEAD` 以及其他引用（如分支、标签等）在本地仓库中的移动历史。与 `git log` 不同，`git reflog` 显示的是所有本地操作的历史，包括那些可能已经无法通过 `git log` 看到的提交（例如通过 `git reset`、`git checkout` 或 `git rebase` 隐藏或移除的提交）。

### `git reflog` 的作用

1. **记录 HEAD 的历史变动**：
   - `git reflog` 记录了每一次 `HEAD` 的变动历史。这包括提交（`commit`）、撤销（`reset`）、变基（`rebase`）、合并（`merge`）、检出（`checkout`）等操作。
   - 这些变动记录会被保存在本地仓库中，且通常不会被推送到远程仓库。

2. **恢复误操作**：
   - 如果你误用了 `git reset --hard`、`git rebase` 或 `git checkout`，导致提交丢失或分支状态变动，你可以通过 `git reflog` 找到这些提交的哈希值，从而恢复它们。
   - 例如，恢复一个被 `reset` 移除的提交，只需要从 `reflog` 中找到该提交的哈希值，然后使用 `git checkout` 或 `git reset` 进行恢复。

### `git reflog` 的基本用法

1. **查看 reflog 历史**：
   - 直接运行 `git reflog` 可以查看 `HEAD` 的变动历史：
```bash
     git reflog
```
   - 输出示例：
```
     d1e8c3b HEAD@{0}: commit: Fixed bug in authentication module
     7f3a1f4 HEAD@{1}: checkout: moving from feature-branch to main
     2c1e8d3 HEAD@{2}: reset: moving to HEAD~1
     6b2c7a9 HEAD@{3}: commit (amend): Updated documentation
     3d4a6e8 HEAD@{4}: commit: Added new feature
```
   - 输出中的 `HEAD@{n}` 表示 `HEAD` 在第 `n` 次操作时的状态。

2. **恢复丢失的提交**：
   - 如果你发现某个提交被 `reset` 或其他操作移除了，但你希望恢复它，你可以从 `reflog` 中找到该提交的哈希值并恢复它：
```bash
     git checkout <commit_hash>
```
   - 或者将 `HEAD` 移动到该提交：
```bash
     git reset --hard <commit_hash>
```

### 详细示例

假设你误用了 `git reset --hard`，并且丢失了一个重要的提交。你可以使用 `git reflog` 来恢复它：

1. **误操作示例**：
```bash
   git reset --hard HEAD~2
```
   这会将 `HEAD` 重置到前两个提交之前，丢弃当前的所有更改。

2. **使用 `git reflog` 查找丢失的提交**：
```bash
   git reflog
```
   输出示例：
   ```
   d1e8c3b HEAD@{0}: reset: moving to HEAD~2
   7f3a1f4 HEAD@{1}: commit: Fixed critical bug
   2c1e8d3 HEAD@{2}: commit: Initial implementation of new feature
   ```

3. **恢复丢失的提交**：
   - 你可以使用提交哈希值 `7f3a1f4` 恢复丢失的提交：
```bash
     git reset --hard 7f3a1f4
```
   - 这会将 `HEAD` 和工作目录恢复到 `7f3a1f4` 提交的状态，找回丢失的更改。

### `git reflog` 的选项

- **`git reflog show`**：
  - 可以指定具体的引用来查看该引用的变动历史，而不仅仅是 `HEAD`。
  - 例如，查看 `main` 分支的变动历史：
```bash
    git reflog show main
```

- **`git reflog expire`**：
  - 用于手动清理 `reflog` 记录，通常用于回收磁盘空间。Git 默认会在一定时间后自动清理旧的 `reflog` 记录。
  - 例如：
```bash
    git reflog expire --expire=now --all
```

- **`git reflog delete`**：
  - 如果需要删除特定的 `reflog` 记录，可以使用该命令。
  - 例如，删除 `HEAD@{1}` 的 `reflog` 记录：
```bash
    git reflog delete HEAD@{1}
```

