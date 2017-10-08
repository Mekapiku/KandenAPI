# KandenAPI
## これは何？
関西電力のサービスである「はぴeみる電」から請求額などのデータを取得し、JSON形式で出力します。

## 使い方
### Command
```
touch config.rb
echo '$user_id = "your_kanden_id" >> config.rb'
echo '$password = "your_kanden_password" >> config.rb'

bundle exec ruby app.rb ./out.json
```

### Result
```
{
    "kanden": {
        "this_month": "9,712円",
        "diff_last_month": "-1,109円",
        "diff_last_year": "-"
    }
}
```

## その他
[json-server](https://github.com/typicode/json-server)との併用が便利です。
