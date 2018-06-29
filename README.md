# githubioStart
利用github.io和github钩子展示前端repository项目
###  首先你得有一台部署服务器（liunx）
服务器的租赁此处不展开讨论

服务器上要有git客户端、node.js或其他后台语言，此处将以nodejs举例

安装教程自行搜索
### 利用ssh绑定服务器git与github

1. 生成 SSH key
    
    `ssh-keygen -t rsa`
    
    随后不停回车下去就行了
    
    `cd .ssh`
    
    里面有两个文件，分别名叫id_rsa、id_rsa.pub，这就是密钥和公钥
2. 添加 SSH key
    登录你的github
    进入`https://github.com/settings/keys`，选择右上方 `New SSH key`

        title可以随意填写
        key则将生成的公钥内容复制进去，即id_rsa.pub文件内容

    选择 `Add SSH key`保存
3. github webhook

    进入`https://github.com/leij1ang/${前端项目仓库}/settings/hooks/new`

    选择`New webhook`
    
    Payload URL填写服务器ip和准备打开的端口+'/deploy'，如http://110.110.110.110:6666/deploy

    Content type选择application/json

    选择`Just the push event`来监听push事件

    选择`Add webhook`保存
4.  创建github.io仓库

    新建一个仓库，名称为`${用户名}.github.io`

    进入`https://github.com/${用户名}.github.io/settings`，找到`GitHub Pages`

    source选择`master branch`后点击保存
5.  将此项目拷贝至服务器上

    执行以下几个步骤

    1. `sh init.sh`根据提示输入你的前端仓库地址，webhook端口号
    2. 根据需求打开deploy.sh修改脚本，此项目以[vue-element-admin](https://github.com/PanJiaChen/vue-element-admin)部署流程为例为例
    3. `node deploy.js > deploy.log 2>deployErr.log &`监听hook
