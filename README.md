# KandenAPI
## これは何？
関西電力のサービスである「はぴeみる電」から請求額などのデータを取得し、JSON形式で出力します。

## 使い方
### Command
```
touch config.rb
echo '$user_id = "your_kanden_id"' >> config.rb
echo '$password = "your_kanden_password"' >> config.rb

bundle exec ruby app.rb ./out.json
```

### Result
```
{
    "kanden": {
        "date":"2018-06-01"
        "this_month": 8966,
        "diff_last_month": -1109,
        "diff_last_year": 110
    }
}
```

## その他
[json-server](https://github.com/typicode/json-server)との併用が便利です。
