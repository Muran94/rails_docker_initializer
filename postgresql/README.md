### 手順
1. このレポジトリをダウンロードし、任意のディレクトリに配置する。
1. `cp`コマンドを使い、必要なフォルダをコピーし、リネームする。PostgreSQLを使用する場合は、`cp -r rails_docker_initializer/postgresql <app_name>`、MySQLを使用する場合は、`cp -r rails_docker_initializer/mysql <app_name>`。なお、フォルダ名には、スネークケースを用いてください。
1. `./initializer.sh`コマンドを実行。

### Instructions
1. Download this repositry.
2. Use `./initializer.sh` command to start initializing your rails app.

### 環境詳細
- Alpineイメージを用いたRailsの環境構築を行います。
- マルチステージビルドを用い、イメージサイズの軽量化を実現しています。
- また、マルチステージビルドを用いる事で、開発環境用のイメージ、本番環境用のイメージの両方を用意できます。

### Environment you get
- This uses an Alpine image to create your rails app.
- It uses a function called `multi-stage builds` from Docker to size down your image.
- It will provide you an image for development (including test environment) and production.
