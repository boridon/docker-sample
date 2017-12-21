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

## nginx

CentOS7 に epelリポジトリを追加して、nginx を yumインストール、confファイルの差し替えをしています

※公式イメージでもコンテナの/etc/nginx/ 以下のconfディレクトリをホストのディレクトリで上書きマウントすれば自分でイメージ作成する必要がないかも？

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

## mysql

最初はCentOS7 に mysql-community-server をyumインストールしていましたが、イメージサイズが思ったより大きく(1.2G)
docker stop でちゃんと停止しない、など問題が多かったので公式イメージをつかっています。

特定ディレクトリをマウントさせれば、my.confのカスタマイズ、初期化sqlの実行などできるので便利ですね

## redis

CentoOS7 + 4.0ソースで構築してます

※公式イメージがあるのでそっちを使ったほうがいいかも

## fluentd

ビルド済みイメージ使ってます(fluent/fluentd)

elasticsearchのプラグインを入れたりするので、そこからさらにビルドをおこなっています。

fluentd.conf も書き換えしています

nginxコンテナのログディレクトリをホストのディレクトリでマウントしておき、
それをfluentdのコンテナにも共有してtailさせてます

送信先は elasticearch コンテナに送ってます

## elasticsearch

公式イメージ

特に設定なし

APIはkibanaからしかアクセスしないのでポートフォワードなども設定してません

## kibana

公式イメージ

特に設定なし

5601 でポートフォワードしています

## phpmyadmin

ビルド済みイメージ(phpmyadmin/phpmyadmin)

8080 -> 80 にポートフォワードしてます
