# SoftEtherVPN Docker

## 运行
##### 使用随机帐号密码的方法

```bash
docker run -d --name softethervpn --privileged --net host benyoo/softethervpn
docker logs softethervpn
```
##### 使用指定帐号密码的方法

```bash
docker run -d --name softethervpn --privileged --net host -e PSK=dtops -e USERNAME=dtopsvpn -e PASSWORD=dtopsvpn benyoo/softethervpn
```

##### 使用docker-compose启动

```bash
curl -LksO github.com/xiaoyawl/docker-softethervpn/raw/master/docker-compose.yml
docker-compose up -d
```

##### 如果`docker-compose`没有被安装，可以用下面的方法进行安装

```bahs
curl -Lk onekey.sh/docker-compose|bash
```



## 可用变量说明

| 变量名      | 默认值        | 描述        |
| -------- | ---------- | --------- |
| PSK      | notasecret | 预共享密钥     |
| USERNAME | 随机生成       | 登录VPN的用户名 |
| PASSWORD | 随机生成       | 登陆VPN的密码  |