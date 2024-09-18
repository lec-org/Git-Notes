
在**Windows系统**中，你会发现使用命令行clone和push等命令的网速要明显低于Linux，设置代理也无济于事，在经过了查找之后，发现了一种可能的解决方案

请打开`powershell`或者`cmd`，输入这两行命令
```bash
netsh interface tcp set global autotuninglevel=normal 
netsh interface tcp set heuristics disabled
```

他们的作用是：

 `netsh interface tcp set global autotuninglevel=normal`
- **自适应调优（Auto-Tuning）**：这是一个 Windows 网络堆栈中的功能，用于动态调整 TCP 接收窗口大小，以最大限度地提高网络吞吐量。在默认情况下，Windows 会自动调整这个窗口的大小，以适应网络状况。
- **命令含义**：将 `autotuninglevel` 设置为 `normal`，表示启用标准的接收窗口自动调优。这个设置有助于在不同的网络条件下，动态优化数据传输速度。

`netsh interface tcp set heuristics disabled`
- **TCP 启发式调优（TCP Heuristics）**：这是 Windows 中的一项功能，用于根据网络连接的历史行为来调整网络设置，如自适应调优等。它有时会限制自适应调优功能，以减少数据传输的波动。
- **命令含义**：将 `heuristics` 设置为 `disabled`，表示禁用这种启发式调整。这可以确保自适应调优功能完全发挥作用，不受历史连接行为的影响，从而提高传输效率。

> 这两行命令的组合可以帮助优化 Windows 系统下的 TCP 网络性能，特别是在处理大文件或高带宽应用时可能会显著改善数据传输速度。

*若是想调回默认设置，请设置：*
```bash
netsh interface tcp set global autotuninglevel=disabled # 这个默认好像就是normal
netsh interface tcp set heuristics enabled
```

参考：
https://superuser.com/questions/1508188/extremely-slow-git-clone-on-windows
https://stackoverflow.com/questions/45768893/git-clone-in-windows-much-slower-than-in-linux