
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