# src/

## Function `aws`

### Syntax

__aws__ _command_ _subcommand_ &rest _options_


### Arguments and Values

| Name       | Description |
|------------|-------------|
| command    |             |
| subcommand |             |
| options    |             |


#### options

AWS CLI のオプションをキーワード引数で指定する。

`--debug` ならば `:--debug` な感じで。

AWS CLI のオプション以外に、この aws コマンド自体のオプションもあります。

| Name    | Type    | Values               | Description                                              |
|---------|---------|----------------------|----------------------------------------------------------|
| :format | keyword | :json :plist :object | 返すデータのタイプを指定する。                           |
| :test   | boolean | t nil                | t の場合テストモードとしてコマンドは実行されません。     |
| :force  | boolean | t nil                | t の場合サブコマンドがロックされていても実行します。     |
| :help   | なし    | なし                 | AWS、コマンド、サブコマンド のヘルプ的なものを表示する。 |

### Description

指定された AWS Cli のコマンドを実行し、その結果を返す。

## Directories

このディレクトリは以下のような内訳になっています。

| type      | name       | description                                 |
|-----------|------------|---------------------------------------------|
| directory | cli        | aws cli のコマンドを作成するコード          |
| directory | db         | DB 関連のコード                             |
| directory | beach      | AWS Cli の情報をWEB上からDBに取り込むコード |
| directory | subcommand | 各サブコマンド毎のコードを配置する。        |