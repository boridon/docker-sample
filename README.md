# Docker勉強

- nginx 1.8
- app (php-fpm 7.2)
- mysql 5.7
- redis 4.0
- fluentd (latest)
- elasticserch 5
- kibana 5
- phpmyadmin (latest)

elasticsearchがメモリを結構消費するので4Gぐらいは必要そうです。

## nginx (1.13.x)

公式イメージに、ホスト側に用意した
- /etc/nginx/nginx.conf
- /etc/nginx/cond.d/
をマウントして(上書き)実行します

## app (php-fpm)

CentOS7 に epel, remi リポジトリを追加して php-fpm 7.2, phalcon3 の構築をします

その他のphpモジュールなどはbuild/app/Dockerfile参照

ホストのprojectディレクトリを/home/docker/projectでマウントしています。

nginxのfastcgiのパスもこれに合わせて設定しておきます。

## admin

CentOS7 に epel, remi リポジトリを追加して php-cli 7.2, phalcon3 の構築をします

app 環境とほぼ同じで、phalcon devtoolsのセットアップも行われます

コマンドラインでのバッチ処理などを行うコンテナです

起動には admin.sh を使います。(sudo が必要な場合は sudo ./admin.sh など)

ログアウトするとコンテナが消える設定にしていますので、
VOLUME指定してる /home/docker/project 以外は元に戻ります

## mysql (5.7.x)

最初はCentOS7 に mysql-community-server をyumインストールしていましたが、イメージサイズが思ったより大きく(1.2G)
docker stop でちゃんと停止しない、など問題が多かったので公式イメージをつかっています。

特定ディレクトリをマウントさせれば、my.confのカスタマイズ、初期化sqlの実行などできるので便利ですね

データベースのディレクトリをホストのVOLUMEでマウントすればコンテナの破棄をおこなってもデータを保持することができます

## redis (4.0.x)

CentOS7 + 4.0ソースで構築してましたが、公式イメージに変更しました。
特にconfなどは変更していないので起動しているだけです。

## fluentd (latest)

ビルド済みイメージ使ってます(fluent/fluentd)

elasticsearchのプラグインを入れたりするので、そこからさらにビルドをおこなっています。

nginxコンテナのログディレクトリをホストのディレクトリでマウントしておき、
それをfluentdのコンテナにも共有してtailさせてます

送信先は elasticearch コンテナに送ってます

## elasticsearch (5.x)

公式イメージ

特に設定なし

APIはkibanaからしかアクセスしないのでポートフォワードなども設定してません

## kibana (5.x)

公式イメージ

特に設定なし

5601 でポートフォワードしています

## phpmyadmin (latest)

ビルド済みイメージ(phpmyadmin/phpmyadmin)

8080 -> 80 にポートフォワードしてます
