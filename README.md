# minecraft_server_template
## 準備
`/your/pulled/this/project/path`の部分を自身のサーバ上のファイルパスに書き換えてください(計3箇所)
* `./systems/mc-server@.service`
* `./systems/mc-server-backup@.service`

下記シンボリックリンクを貼ってください。
* `./systems/mc-server@.service` → `/etc/systemd/system/mc-server@.service`
* `./systems/mc-server-backup@.service` → `/etc/systemd/system/mc-server-backup@.service`
* `./systems/mc-server-backup@.timer` → `/etc/systemd/system/mc-server-backup@.timer`

例)
```
ln -snf $(pwd)/systems/mc-server@.service /etc/systemd/system/mc-server@.service 
ln -snf $(pwd)/systems/mc-server-backup@.service /etc/systemd/system/mc-server-backup@.service 
ln -snf $(pwd)/systems/mc-server-backup@.timer /etc/systemd/system/mc-server-backup@.timer  
```

## 登録方法
### servers配下にディレクトリを作成
例) 
```
mkdir servers/test-server
```
`servers/test-server`配下にマイクラのjarファイルを設置、初回は手動で起動して`eula.txt`や`server.properties`などの処理をしておく

### envs配下に設定ファイルを作成
例)
```
cp envs/example envs/test-server
vim envs/test-server
```
`envs/test-server`
```
SERVER_DIR=test-server
SERVER_FILE=minecraft-1.16.5.jar
```
### systemctlに登録する
例)
```
systemctl enable mc-server@test-server
systemctl start mc-server@test-server

systemctl enable mc-server-backup@test-server.timer
systemctl start mc-server-backup@test-server.timer
```
