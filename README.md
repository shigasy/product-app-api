# 商品管理アプリ

### 概要
店舗ごとに商品を管理するためのアプリです。  
検索機能や写真添付機能があります。

## 設計
アプリケーションサーバ: heroku  
データベース: MySQL  
ストレージ: AWS S3  
バックエンド: Ruby on Rails  
フロントエンド: Nuxt.js  
CI/CD: CircleCI  

### DB設計
![image](https://user-images.githubusercontent.com/40525390/63229689-32f21e80-c23e-11e9-81dd-1faaa72a1701.png)

### API仕様書
`GET /api/v1/items`  商品一覧取得

```json
{
  "status": "SUCCESS",
  "message": "loaded the items",
  "data": {
    "items": [
      {
        "id": 12,
        "title": "おにぎり",
        "description": "",
        "price": 100,
        "created_at": "2019-08-18T17:44:27.000Z",
        "updated_at": "2019-08-18T17:44:46.000Z",
        "shop_id": 2,
        "shop": {
          "id": 2,
          "name": "セブンファミリー",
          "created_at": "2019-08-18T17:24:29.000Z",
          "updated_at": "2019-08-18T17:24:29.000Z"
        }
      },
      {
        "id": 22,
        "title": "サンドイッチ",
        "description": "卵とハムとレタス",
        "price": 150,
        "created_at": "2019-08-18T17:47:14.000Z",
        "updated_at": "2019-08-18T17:47:15.000Z",
        "shop_id": 2,
        "image": "https://mask/rails/active_storage/blobs/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBCdz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--aa0c04094dda4465ced33f34039b3f8ffe45b6cc/20190818174714834.jpeg",
        "shop": {
          "id": 2,
          "name": "セブンファミリー",
          "created_at": "2019-08-18T17:24:29.000Z",
          "updated_at": "2019-08-18T17:24:29.000Z"
        }
      }
    ]
  }
}
```

`POST /api/v1/items`  商品の作成

#### 入力

|JSON Key  |型  |サイズ |必須  |値の説明  |
|---|---|---|---|---|
|item[title] |String |100 |◯ |商品タイトル | 
|item[description] |String |500 | |商品の説明 |
|item[price] |Integer | |◯ |値段 |
|item[image] |String | | |Base64 |
|item[shop_id] |String | | |店舗名 |

#### 出力
```json
{
  "status": "SUCCESS",
  "message": "loaded the item",
  "data": {
    "item": {
      "id": 22,
      "title": "サンドイッチ",
      "description": "卵とハムとレタス",
      "price": 150,
      "created_at": "2019-08-18T17:47:14.000Z",
      "updated_at": "2019-08-18T17:47:15.000Z",
      "image": "https://mask/rails/active_storage/blobs/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBCdz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--aa0c04094dda4465ced33f34039b3f8ffe45b6cc/20190818174714834.jpeg",
      "shop": {
        "id": 2,
        "name": "セブンファミリー",
        "created_at": "2019-08-18T17:24:29.000Z",
        "updated_at": "2019-08-18T17:24:29.000Z"
      }
    }
  }
}
```

`GET /api/v1/items/:id` 商品の詳細取得
```json
{
  "status": "SUCCESS",
  "message": "loaded the item",
  "data": {
    "item": {
      "id": 22,
      "title": "サンドイッチ",
      "description": "卵とハムとレタス",
      "price": 150,
      "created_at": "2019-08-18T17:47:14.000Z",
      "updated_at": "2019-08-18T17:47:15.000Z",
      "image": "https://mask/rails/active_storage/blobs/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBCdz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--aa0c04094dda4465ced33f34039b3f8ffe45b6cc/20190818174714834.jpeg",
      "shop": {
        "id": 2,
        "name": "セブンファミリー",
        "created_at": "2019-08-18T17:24:29.000Z",
        "updated_at": "2019-08-18T17:24:29.000Z"
      }
    }
  }
}
```
`PATCH /api/v1/items/:id` 商品の更新  
`DELETE /api/v1/items/:id` 商品の削除

`GET /api/v1/items/search?word=1` 商品の検索  
```json
{
  "status": "SUCCESS",
  "message": "loaded the items",
  "data": {
    "items": [
      {
        "id": 32,
        "title": "にわとりくん",
        "description": "今なら唐揚げ1個増量",
        "price": 200,
        "created_at": "2019-08-18T17:51:02.000Z",
        "updated_at": "2019-08-18T17:51:03.000Z",
        "shop_id": 12,
        "image": "https://mask/rails/active_storage/blobs/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBFUT09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--d7f8eafa7ef524dc1e1b085ef2abe638f8734efa/20190818175102698.png",
        "shop": {
          "id": 12,
          "name": "ローンソ",
          "created_at": "2019-08-18T17:48:39.000Z",
          "updated_at": "2019-08-18T17:48:39.000Z"
        }
      }
    ]
  }
}
```

`GET /api/v1/shops/names` 存在する店舗名検索
```json
{
  "status": "SUCCESS",
  "message": "loaded the shops",
  "data": {
    "shop_names": [
      "セブンファミリー",
      "ローンソ"
    ]
  }
}
```
`GET /api/v1/shops`  店舗一覧取得
```json
{
  "status": "SUCCESS",
  "message": "loaded the shops",
  "data": {
    "shops": [
      {
        "id": 2,
        "name": "セブンファミリー",
        "created_at": "2019-08-18T17:24:29.000Z",
        "updated_at": "2019-08-18T17:24:29.000Z"
      },
      {
        "id": 12,
        "name": "ローンソ",
        "created_at": "2019-08-18T17:48:39.000Z",
        "updated_at": "2019-08-18T17:48:39.000Z"
      }
    ]
  }
}
```
`POST /api/v1/shops`  店舗作成
#### 入力
|JSON Key  |型  |サイズ |必須  |値の説明  |
|---|---|---|---|---|
|shop[name] |String |200 |◯ |店舗名 |

#### 出力 
```json
{
  "status": "SUCCESS",
  "message": "loaded the shop",
  "data": {
    "shop": {
      "id": 2,
      "name": "セブンファミリー",
      "created_at": "2019-08-18T17:24:29.000Z",
      "updated_at": "2019-08-18T17:24:29.000Z"
    }
  }
}
```


`GET /api/v1/shops/:id` 店舗の詳細取得
```json
{
  "status": "SUCCESS",
  "message": "loaded the shop",
  "data": {
    "shop": {
      "id": 2,
      "name": "セブンファミリー",
      "created_at": "2019-08-18T17:24:29.000Z",
      "updated_at": "2019-08-18T17:24:29.000Z",
      "items": [
        {
          "id": 12,
          "title": "おにぎり",
          "description": "",
          "price": 100,
          "created_at": "2019-08-18T17:44:27.000Z",
          "updated_at": "2019-08-18T17:44:46.000Z",
          "shop_id": 2
        },
        {
          "id": 22,
          "title": "サンドイッチ",
          "description": "卵とハムとレタス",
          "price": 150,
          "created_at": "2019-08-18T17:47:14.000Z",
          "updated_at": "2019-08-18T17:47:15.000Z",
          "shop_id": 2
        },
        {
          "id": 42,
          "title": "家族チキン",
          "description": "美味しいチキン",
          "price": 180,
          "created_at": "2019-08-18T17:55:34.000Z",
          "updated_at": "2019-08-18T17:55:35.000Z",
          "shop_id": 2
        }
      ]
    }
  }
}
```
