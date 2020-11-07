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
