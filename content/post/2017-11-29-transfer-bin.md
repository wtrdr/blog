---
title: ブログ移行計画 -その3- 移行スクリプト
date: 2017-11-29
draft: false
tags:
- トリログ
- 会社
- Tech
- 備忘録
description: ブログ移行計画 -その3- 移行スクリプト
keywords:
- 株式会社ワタリドリ
- wataridori inc.
- blog
- wtrdr
isCJKLanguage: true
thumbnailImage: /img/2017-11-29/main.png
thumbnailImagePosition: left
---
## 移行スクリプトを作るぞ
[weebly](https://wataridori.weebly.com/)からの移行がめんどくさい。
バックアップが取れるっぽかったのでそこからファイル解析してmarkdownに直せばいいかと思っていたがfeed分しか載っていないみたいで全部移行することはできなかった。

なので自分達で書いたブログを自分でクローリングする羽目になってしまった。


## rubyでしれっと書くか
時間を取られたくもなかったので文字列操作それなりに緩そうなrubyで作成を開始。

1. 全ブログをMISSEに取れるURLを探す
1. 取れたhtmlから必要そうなコンテンツを取得する
1. 取れたhtmlから画像を取得する
1. markdownの文字列に変換する
1. fileにwriteする
1. link周りを修正する
1. 体裁を整えるのを目視でやろう

結果的には最後に全部目を通すことになったのだが。
（どうしてもtag情報を綺麗に全部取るのがめんどくさかったので）

## スクリプト
最終的には[script(github)](https://github.com/wtrdr/blog/tree/master/bin)こうなった。

そんなに難しいことはなく、
nokogiri使ってhtml適当にさばいて、
各elementをclass化して、
element => markdownをセコセコ書き、
linkコンバートしておしまい。

## 振り返る

- writeの仕方がまずかったかstringの改行周りにたまーに謎のバイト文字が入る
- tagはやっぱ手でやってよかった
- hugoでCJK使うには設定が必要
- 3,4日で出来たのは良かった気がする

最終的にはこうなった
{{< image classes="fig-100 clear" thumbnail-width="100%" src="/img/2017-11-29/main.png" title="" >}}

