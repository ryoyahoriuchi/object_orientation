# 自動販売機の使用説明書

## 1. 使用方法
- irbを開き、下記のコマンドを打ってファイルを開きます。
 ```
 require_relative "vending_machine"
 ```
 - 自動販売機を起動させます。
 ```
 VendingMachine.start
 ```
-  数字を入力し、【`1:購入`】か【`2:管理業務`】を選びます。
 
**1.1【1:購入】の場合** 

- 【`1:お金を投入、2:払い戻し、3:購入する`】が表示されますので、 数字を入力して行いたい操作を選択します。

>【1:お金を投入】の場合
- 対応可能硬貨 [`10, 50, 100, 500, 1000`] を投入します。

>【2:払い戻し】の場合
- 投入した金額が釣り銭として戻ってきます。

>【3:購入する】の場合
- 投入した金額に応じて、購入可能リストが表示されます。
- その中から購入したいものを選択します。
- 購入操作を行った後、投入した金額に応じてお釣りが戻ってきます。

**1.2【2:管理業務】の場合** 
- 数字を入力し、【`1:商品追加、2:商品リスト表示、3:売上表示、4:終了`】のどちらかを指定します。
> 【1:商品追加】の場合 
- 【`何のジュースを追加しますか？`】が表示されたら、数字を入力して追加したいジュースを指定します。
- 【`何円に設定しますか？`】が表示されたら、設定したい金額を入力します。
- 【`何本格納しますか?`】が表示されたら、格納したい本数を入力します。
- 格納されたジュースの情報（名前と値段と在庫）が表示されます。
>【2:商品リスト表示】の場合
- 格納されているジュースの情報（名前と値段と在庫）が表示されます。
>【3:売上表示】の場合
- 売上高が表示されます。
>【4:終了】の場合
- プログラムが終了します。

## 2.機能
**2.1 購入機能** 
- 10円玉、50円玉、100円玉、500円玉、1000円札を１つずつ投入できます。
- 想定外のもの（硬貨：１円玉、５円玉。お札：千円札以外のお札）が投入された場合は、投入金額に加算せず、それをそのまま釣り銭としてユーザに出力します。
- 投入金額、在庫の点で購入可能なドリンクのリストを表示できます。
- 払い戻し操作を行うと、投入金額の総計、あるいは現在の投入金額からジュース購入金額を引いた釣り銭を出力します。

**2.2 管理機能** 
- ジュースを3種類（`コラー、レッドブル、水`）管理できます。
- 現在の売上金額を表示できます。
- 格納されているジュースの情報（名前と値段と在庫）を表示できます。
- ジュースの在庫を追加できます。

## 3. 備考

### 3.1 変数名の付け方に注意したこと
- [TDDBC仙台02/課題用語集](http://devtesting.jp/tddbc/?TDDBC%E4%BB%99%E5%8F%B002%2F%E8%AA%B2%E9%A1%8C%E7%94%A8%E8%AA%9E%E9%9B%86)に近いものにしました。

### 3.2 クラスに持たせた責任範囲の考え方
- 一つに負担をかけすぎないようにしました。

### 3.3 こだわりの実装ポイント
- ○○○
### 3.4 ソニックガーデンさんに聞いてみたい事・リファクタしてもらいたい箇所など
- ○○○
