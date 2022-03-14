# 自動販売機の使用説明書

## 1. 使用方法
**1.1** irbを開き、下記のコマンドを打ってファイルを開きます。
 ```
 require_relative "vending_machine"
 ```
**1.2** 自動販売機を起動させます。
 ```
 VendingMachine.start
 ```
**1.3**   1:購入　か　2:管理業務を選びます。
> 1:購入を選んだら下記の３つの選択肢が出てきます。
` 1:お金を投入、2:払い戻し、3:購入する`

1:お金を投入の場合

10円玉、50円玉、100円玉、500円玉、1000円札を投入できます。

2:払い戻しの場合

3:購入するの場合
購入可能リストが出力されます。
 ["coke", "water", "redbull"]
 買いたいジュースの番号を選択します
 1
 お金を投入します（ 対応可能硬貨： [10, 50, 100, 500, 1000] ）
 
 

## 2.機能
### 2.1 購入機能
- 10円玉、50円玉、100円玉、500円玉、1000円札を１つずつ投入できる。
- 想定外のもの（硬貨：１円玉、５円玉。お札：千円札以外のお札）が投入された場合は、投入金額に加算せず、それをそのまま釣り銭としてユーザに出力する。
- 投入は複数回できる。
- 投入金額の総計を取得できる。
- 投入金額、在庫の点で購入可能なドリンクのリストを取得できる。
- 払い戻し操作を行うと、投入金額の総計を釣り銭として出力する。
- 払い戻し操作では現在の投入金額からジュース購入金額を引いた釣り銭を出力する。

### 2.2 管理機能
- ジュースを3種類（コラー、レッドブル、水）管理できる。
- 現在の売上金額を取得できる。
- 格納されているジュースの情報（名前と値段と在庫）を取得できる。
- ジュースの在庫を追加できる。

## 3. 備考

### 3.1 変数名の付け方に注意したこと
- [TDDBC仙台02/課題用語集](http://devtesting.jp/tddbc/?TDDBC%E4%BB%99%E5%8F%B002%2F%E8%AA%B2%E9%A1%8C%E7%94%A8%E8%AA%9E%E9%9B%86)に近いものにしました。

### 3.2 クラスに持たせた責任範囲の考え方
- 一つに負担をかけすぎないようにしました

### 3.3 こだわりの実装ポイント
- ○○○
### 3.4 ソニックガーデンさんに聞いてみたい事・リファクタしてもらいたい箇所など
- ○○○
