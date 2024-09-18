# push大文件

[glf](https://git-lfs.com/)


当推送超过100MB的文件的时候github会报错，因此需要到上面的网站下载GLF并安装，安装之后即可在原来的git基础上使用。

在add大文件之前，需要先

```bash
git lfs install
```

激活大文件服务
```bash
# 添加特定格式文件到大文件管理中去
git lfs track "*.psd"
# 添加所有格式
git lfs track "*"
```

添加想要推送的大文件后会生成一个`.gitattributes`文件，这是大文件服务管理文件类型的配置文件，要确保这个文件也在git管理中(被git所跟踪)
```bash
git add .gitattributes
```

或者像往常一样添加所有文件进暂存区
```
git add .
```

之后不需要任何特殊操作，正常commit和push即可

> note:glfs能免费管理的文件大小有限，只有1GB，多了要收费

![[Pasted image 20240902214746.png]]

# clone包含大文件的项目

如果使用glfs管理项目，那么当你直接用github主页的下载zip来下载仓库，你会发现所有的文件都是坏的。

其实不是坏的，只不过默认下载的是*大文件的指针*，你需要手动把大文件本体拉下来

```bash
# 进入仓库目录后操作
git lfs pull
```


速度很快(*在解决了速度慢的问题后*)