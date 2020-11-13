# README

## 課題1
userの新規作成
```
seccamp-2020-b8_development=# INSERT INTO users ("name", "email", "created_at", "updated_at") VALUES ('taro', 'taro@taro.com', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT 0 1

seccamp-2020-b8_development=# SELECT * FROM users;
 id | name |     email     |         created_at         |         updated_at
----+------+---------------+----------------------------+----------------------------
  2 | po   | po@po.com     | 2020-11-07 07:17:00.587211 | 2020-11-07 07:17:00.587211
  3 | taro | taro@taro.com | 2020-11-07 07:30:16.095686 | 2020-11-07 07:30:16.095686
(2 rows)
```

既存ユーザのname/email更新
```
seccamp-2020-b8_development=# UPDATE users SET name = 'yamada taro', email = 'taro_new@taro.com', updated_at = CURRENT_TIMESTAMP WHERE id = 3;
UPDATE 1

seccamp-2020-b8_development=# SELECT * FROM users;
 id |    name     |       email       |         created_at         |         updated_at
----+-------------+-------------------+----------------------------+----------------------------
  2 | po          | po@po.com         | 2020-11-07 07:17:00.587211 | 2020-11-07 07:17:00.587211
  3 | yamada taro | taro_new@taro.com | 2020-11-07 07:30:16.095686 | 2020-11-07 07:35:42.424079
(2 rows)
```

既存ユーザの削除
```
seccamp-2020-b8_development=# DELETE FROM users WHERE id = 3;
DELETE 1

seccamp-2020-b8_development=# SELECT * FROM users;
 id | name |   email   |         created_at         |         updated_at
----+------+-----------+----------------------------+----------------------------
  2 | po   | po@po.com | 2020-11-07 07:17:00.587211 | 2020-11-07 07:17:00.587211
(1 row)
```

## 課題2
どういうkeyの名前にするのが良いかわからなかったので
  - https://future-architect.github.io/articles/20190821/  
を参考にして`microposts:${id}`のようなkeyでcontentをredisに保存させるようにした.  

```ruby
content = cache.fetch("microposts:" + id) do
  @micropost.content
end
```

また,ドキュメントを参照してcacheのexpirationを`1 minutes`として指定した.  
- https://api.rubyonrails.org/classes/ActiveSupport/Cache/Store.html#method-i-fetch  

余裕があったので,cacheから取得するときはDBアクセスしないようにした.
下記のようなメソッドを実装し,
```ruby
def cache_micropost
  cache = ActiveSupport::Cache::RedisCacheStore.new
  @micropost = cache.fetch("microposts:" + params[:id], expires_in: 1.minutes) do
    Micropost.find(params[:id])
  end
end
```
`before_action`として`show`の時に実行させるようにした.
```
before_action :cache_micropost, only: [:show]
...

