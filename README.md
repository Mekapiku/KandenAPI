# KandenAPI
## これは何？
関西電力のサービスである「はぴeみる電」から請求額などのデータを取得し、JSON形式で出力します。

## 使い方
### Command
```
bundle install --path vendor/bundle
bundle exec ruby app.rb ./out.json "login_id" "login_pass"
```

### Result
```
{
    "kanden": {
        "date":"2018-06-01"
        "price": 8966,
        "diff_last_month": -1109,
        "diff_last_year": 110
    }
}
```

## その他
[json-server](https://github.com/typicode/json-server)との併用が便利です。
