---
title: "ブログ移行計画 -その後- HugoBuilder"
date: 2017-12-02T15:46:15+09:00
draft: false
tags:
- トリログ
- Tech
- 備忘録
- 挑戦
description: ブログ移行した後に出てきた問題に対処します。
keywords:
- 株式会社ワタリドリ
- wataridori inc.
- blog
- wtrdr
isCJKLanguage: true
---
## ブログの仕組み

嫁の[久しぶりのブログ、新しいブロブ]({{< relref "post/2017-12-02.md" >}})で書かれていたので少しだけ解説を付け足しておこう。このブログがどうやって動いているのか。

必要なものは下記の通り

- Github Page
- Hugo
- Cloudflare

それぞれ簡単に補足説明をすると

### [Github Page](https://pages.github.com/)
静的なファイルのホスティングサービス。かな。
他にも色々ある。google driveでもホスティングとしては可能なんじゃないかな。

超シンプルなwebの仕組みとしては、
URLを入力してEnter!ってやると誰かのPCにたどり着く。
そこでhtmlを返せば画面が表示されるのだ。

その表示したいhtmlを保持しておいて、Enter!ってやってきた人にhtmlを返す役割を担ってくれるのがホスティングサービス。

Github Pageはもうちょい機能的に色々やってくれるけど大枠はそんな感じ。
だからこれだけでもwebページを公開することは可能だ。

### [Hugo](https://gohugo.io/)
これは自分のPCで動くものである。

やってくれるのは静的な（ある程度動的にもできるけど）webサイトを構築してくれるソフトウェア。

上で書いたとおりGithub Pageに最終的に上げたいのはhtmlである。なので、もちろん1ページ1ページ懇切丁寧に作っても全然構わない。ただ共通部分とかがあったり、GoogleAnalyticsのタグを埋めたり、keywordとかtitleとか埋めたりそれなりめんどくさいのだ。

例）
```html
<html>
  <head>
    <title>TITLE!!</title>
    <meta property="og:title" content="TITLE!">
    ....
  </head>
  <body>
    <p>ここからブログの内容を書く</p>
  </body>
</html>
```

こんな感じで書かないといけない。ツライ。headの内容とかの仕様変更があったら大変。追加したい項目とかあるととてもツライ。そしてhtmlとかあんまり書きたくない。それならweeblyでいい。。。とそんな感じなのである。

なので、そんなめんどくさいことはhugo君がやってくれますよ。なのであなた方はマークダウンでサイトの内容を書く方だけ頑張ってください。という感じです。

例）
```markdown
---
title: "ブログ移行計画 -その後- HugoBuilder"
date: 2017-12-02T15:46:15+09:00
draft: false
tags:
- トリログ
- Tech
- 備忘録
- 挑戦
description: ブログ移行した後に出てきた問題に対処します。
keywords:
- 株式会社ワタリドリ
- wataridori inc.
- blog
- wtrdr
isCJKLanguage: true
---
## ブログの仕組み
....
```

こんな感じでファイルを作ればいい。あとは`hugo`というコマンドを実行すればよろしくhtmlを生成してくれる。そして作られたhtmlをGithub Pageに上げてあげればOKということ。

### Cloudflare
これは[ブログ移行計画 -ラスト- ドメイン修正]({{< relref "post/2017-11-30-domain-transfer.md" >}})に書いてあるので参考に。

## 浮上した新たな問題

これまたエンジニアっぽい話なのだが上記Hugoでhtmlを生成するのだが今はシステムを組んでいないので自分も嫁も自分のPC上でビルドしないといけない。
一人で作業するならいいんだが二人で作業すると生成物がバッティングして衝突する。
毎回気にするのもめんどくさいのでbuildとdeployのシステムをいれることにした。

### [Deployment with Wercker](https://gohugo.io/hosting-and-deployment/deployment-with-wercker/)
Hugoの公式にdeployシステムの導入について記載があった。ちょうど今参画しているプロジェクトの方でもWercker使っているし一つやってみるか。ということでやってみる。

公式通りにwerckerがGithubのレポジトリにアクセスできるように設定する。

wercker.ymlという設定ファイルが必要なのでそれを作る。この辺りからHugoのマニュアルの方がWerckerの仕様と合わなくなってきてるな。boxをdebianに設定しろとか、自動的にwercker.yml作られるよ。とか書いてあるけどそんなことはなさそうだ。

探り探りやるか。

MarketplaceからHugo Buildで検索して

{{< image classes="fancybox fig-70" src="/img/2017-12-02/2.png" >}}

`arjen`さんのやつを選択してStepの内容をコピー

{{< image classes="fancybox fig-70" src="/img/2017-12-02/3.png" >}}

wercker.ymlは多分こんな感じになるんだろう。

```
box: golang:latest
build:
  steps:
    - arjen/hugo-build:
        version: "0.31.1"
        theme: "peak"
```

この状態で

```sh
git add wercker.yml
git commit -m "Add: wercker.yml"
git push origin master
```

なんか失敗する。themeが人のやつを拡張してsubmoduleで追加しているからwerckerが取得できてないっぽい。ということでsubmoduleからsubtreeに修正するか。（[ref: Qiita](https://qiita.com/horimislime/items/577b6de47f2e897b4e2a)）

```
rm -rf themes/peak
git remote add peak https://github.com/wtrdr/hugo-tranquilpeak-theme
git subtree add --prefix=themes/peak peak master --squash
```

これで大丈夫かな。