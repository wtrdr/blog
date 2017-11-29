---
title: ブログ移行計画 -その4- ドメイン修正
date: 2017-11-30
draft: false
tags:
- トリログ
- 会社
- Tech
- 備忘録
description: ドメイン修正
keywords:
- 株式会社ワタリドリ
- wataridori inc.
- blog
- wtrdr
isCJKLanguage: true
thumbnailImage: /img/2017-11-30/6.png
thumbnailImagePosition: left
---
## ドメイン修正

さて、新しいやつは自前のドメインで運用するようにしよう。
全然使ってないけど弊社ドメインはある

*wataridori.co.jp* という立派なやつが。

### 「お名前.com」から「さくらインターネット」

今使っているのが最安のお名前メールだったのでそこまで自由度はないだろうなーと思っていたが、このメールサービスの設定からだとレコードの設定がかなり制限されてしまっていることに気づいてしまった。。。

無念だ。でも激安だったから月額にしておいてよかった。これはさくらインターネットに移行しよう。ということで移管作業開始。

### さくらのメールボックスの利用を開始する

結局やりたいことってDNSレコードをいじって、メールはさくら、ブログはgithub pageに飛ばしたい。くらいなのです。とりあえず2週間無料らしいので[さくらのメールボックス](https://www.sakura.ne.jp/mail/)を試して無理そうならレンタルサーバー借りることにしよう。

### ドメイン移管依頼

調べてみるところによると属性型JPドメイン（co.jpとか）は無料で移管可能。（そういうもんらしい）

さくらの方から申請ををするとお名前.comの方に移管依頼が飛ぶっぽい。（[参考URL](https://help.sakura.ad.jp/hc/ja/articles/206052992?_ga=2.175047842.1428514606.1511015094-2024478295.1510720885&_bdld=LhK7y.l+Z+SbR)）
お名前.comの方には特に作業が必要なさそう。（後日メールがきて承認すれば大丈夫だった。[参考URL](https://help.onamae.com/app/answers/detail/a_id/8593)）

ということでお問い合わせからメッセージを送る。
少ししてさくらインターネットから以下のようなメールが届いて

> ドメイン: wataridori.co.jp
> 
> 平素よりさくらインターネットを御利用頂きまして
> 誠に有難うございます。ドメイン担当の富家です。
> 
> 本日、上記属性型・地域型ドメインの指定事業者変更申請を
> 行いましたので、お知らせします。
> 
> ==============================================================
> 
> 　申請番号：XXXXXXXXXXXXXXX
> 　現在の指定事業者：YYYYYYYYYYYYYYYYYYY
> 
> ==============================================================

その後お名前.comから以下のようなメールが届いて

> ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
> ■ お名前.com  by GMO ■
> ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
> An English version of this message is contained below.
> ───────────────────────────────────
> ■重要■トランスファー申請に関する確認のご連絡
> ───────────────────────────────────
> XXXXXXXXXXXXXXX 様
> 
> ドメイン名：wataridori.co.jp
> 
> お名前.com  by GMOは、上記ドメインについて に他社
> レジストラへの、トランスファー申請を承りました。
> 
> トランスファー手続きにつきまして、期日までにお客様のご意思を確認の上、
> 承認・拒否どちらかのお手続きをお願いいたします。
> 
> 【対応期日】
> 　各種JPドメイン：本メール送信日時から168時間（7日）後まで
> 　JPドメイン以外：本メール送信日時から96時間（4日）後まで
> 
> 【お手続き方法】
> 1.下記URLへアクセスしてください。
> http://url!!!!!!!!!!!!!!!!!!!!!!!!!!!
> 2.ドメイン名をご確認の上、トランスファーを承認する場合は「承認する」、
> 　拒否する場合は「拒否する」をクリックしてください。
> 3.確認画面が表示されますので内容を確認し、間違いなければ「完了」をク
> ......

指定されたURLに飛んで承認して移管作業は終了。

## CDN + ドメインレコード修正

調べてみると[github pageをカスタムドメインにするとsslが使えなくなる](https://github.com/isaacs/github/issues/156)ようだ。
さらに調べてみると[Cloudflareを使うとsslを使えるようになる](https://hackernoon.com/set-up-ssl-on-github-pages-with-custom-domains-for-free-a576bdf51bc)というのが見つかる。

なるほど。なんとかなりそうだ。

### まずはメールアドレスを有効にしよう
さくらのメールボックスを使っているのでそちらの設定をしよう。

ドメイン設定に行き
{{< image classes="fancybox fig-100 clear center" thumbnail-width="60%" src="/img/2017-11-30/1.png" title="" >}}
新しいドメインを追加を押し
{{< image classes="fancybox fig-100 clear center" thumbnail-width="60%" src="/img/2017-11-30/2.png" title="" >}}
ドメインを追加する
{{< image classes="fancybox fig-100 clear center" thumbnail-width="60%" src="/img/2017-11-30/3.png" title="" >}}

これで移管したドメインを使ってメールの送受信ができるようになるかな。（メールアカウントを作って確認した。[gmailへの設定の仕方はこちら](https://help.sakura.ad.jp/hc/ja/articles/206371101-Gmail-%E3%82%A6%E3%82%A7%E3%83%96%E3%83%96%E3%83%A9%E3%82%A6%E3%82%B6-%E3%82%92%E5%88%A9%E7%94%A8%E3%81%99%E3%82%8B)）

### DNSの様子を確認してみる

[ここ](https://help.sakura.ad.jp/hc/ja/articles/206205831#ac02)で示されている通りにいくとネームサーバーの情報を確認できる。

メール関連の情報が記載されているのが確認できる。
{{< image classes="fancybox fig-100 clear center" thumbnail-width="60%" src="/img/2017-11-30/4.png" title="" >}}

github pageをカスタムドメインにするためには、

1. [repositoryの設定からCNAMEファイルを作成](https://help.github.com/articles/adding-or-removing-a-custom-domain-for-your-github-pages-site/)
1. [`blog`の`CNAME`レコードを作って、向き先を`wtrdr.github.io`を設定](https://help.github.com/articles/setting-up-a-www-subdomain/)

すれば良さそうではある。

が今回はCloudflareを設定するので1.だけやって一旦置いておく。

### Cloudflareの設定をする

1. Cloudflareにドメインを追加する
1. CloudflareにCNAME blog wtrdr.github.ioを追加
   これで blog.wataridori.co.jp => Cloudflare => github.io => github page という経路ができる
1. Cloudflareのセキュリティ設定をしてsslを有効にする

というのが大きな流れだ。

ちなみに

**Cloudflareとは**
CDNサービスの一種。コンテンツキャッシュしたりして高速化したりアプリに到達する前に攻撃を抑えたりすることができるようにする。

CloudflareはメインとしてSaaSの手前に置いてセキュリティ担保したり高速化したりするものみたいだ。

#### Cloudflareのサインアップ
[Cloudflareサインアップ](https://www.cloudflare.com/a/sign-up)
ここにメールアドレスとパスワード。

#### ドメインの設定
ログインした後に[Add Site](https://www.cloudflare.com/a/setup)からドメインを追加。
今回は`wataridori.co.jp`に対するDNSの設定を行うので`wataridori.co.jp`を追加した。

自動的にさくらインターネットのレコード設定が読み込まれている。
dns関連の設定はひとまずCloudflareに移ったので、ここに対して色々書いていく。

最終的にこうしてみた。

{{< image classes="fancybox fig-100 clear center" thumbnail-width="60%" src="/img/2017-11-30/5.png" title="" >}}

上から

- Aレコードでsakuraが指定していたipをそのまま指定
  wataridori.co.jpはsakuraに向く。
- CNAMEレコードでblogはgithub pageに設定
  blog.wataridori.co.jpはgithub pageに向く。
  オレンジ雲に設定するとCDN経由でコンテンツを配信する。
  これでsslと高速化が実現できる
- MXレコードで@を指定
  メール送受信はsakuraのサーバーに向く。
- TXTはsakuraによって指定されていたspfが入ってる

こんなところか。

あとはFree Websiteを選んで次に出てくるネームサーバの情報をさくらインターネットのWhois設定から書き換えてco.jpからの解決がCloudflareに向くようにする。

#### セキュリティ設定

ダッシュボードの**Crypto**を選択し先に進むとSSLってのがある。
ここFullでもやり方があるらしいが一旦Flexibleにしておく。

{{< image classes="fancybox fig-100 clear center" thumbnail-width="60%" src="/img/2017-11-30/7.png" title="" >}}

Full:     client --SSL-> Cloudflare --SSL--> github page
Flexible: client --SSL-> Cloudflare -------> github page

ってのが違いっぽい。

------

Always Use HTTPSをonにする
{{< image classes="fancybox fig-100 clear center" thumbnail-width="60%" src="/img/2017-11-30/8.png" title="" >}}

------

HTTP Strict Transport Security (HSTS)の箇所をEnable HSTSをクリックして
[I understand] => [Next]と先に進んで以下のように設定して[Save]

{{< image classes="fancybox fig-100 clear center" thumbnail-width="60%" src="/img/2017-11-30/9.png" title="" >}}

------

さてこれでセキュリティ周りの設定は完了か。

#### 確認

{{< image classes="fancybox fig-100 clear center" thumbnail-width="100%" src="/img/2017-11-30/6.png" title="" >}}

**良さげだ！**
