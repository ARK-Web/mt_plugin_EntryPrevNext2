# mt_plugin_EntryPrevNext2

メインカテゴリが同じ記事同士で 前へ / 次へ できるMT用プラグイン
====

ARK-Web/mt_plugin_EntryPrevNext2 - 前の記事 / 次の記事 を出力する用プラグイン

### 概要

前の記事 / 次の記事 を出力するタグ MTEntryPrevious2/Next2 を提供します。

メインカテゴリが自分と同じ記事同士で 前へ/次へ するリンクを追加できます。


### 動作条件

* MT6対応
* スタティックパブリッシング限定

### ダウンロード

[https://github.com/ARK-Web/mt_plugin_EntryPrevNext2](https://github.com/ARK-Web/mt_plugin_EntryPrevNext2)

### インストール

zipファイルを解凍して現れる [EntryPrevNext2]フォルダごと、MTディレクトリ/plugins  ディレクトリにアップロードします。


### 使い方

MTデフォルトの MTEntryPrevious/Next とほぼ同じ使い方ですが、
by_category="1" モディファイア指定時に、次/前記事として メインカテゴリを同じくする記事だけを対象にする点が異なります。


* by_author="0 | 1" モディファイア
1 を指定すると、現在の記事の作者が書いた前(/後)の記事を呼び出します。初期値は 0 です。

* by_category="0 | 1" モディファイア
1 を指定すると、現在の記事と *同じプライマリカテゴリ（メインカテゴリ）の前(/後)の記事* を呼び出します。初期値は 0 です。

* 参考
  * [MTEntryPrevious](https://www.movabletype.jp/documentation/appendices/tags/entryprevious.html)
  * [MTEntryNext](https://www.movabletype.jp/documentation/appendices/tags/entrynext.html)


### デフォルトのEntryPrevious/Nextと動作の違いについて

例えば
catAに所属する記事1,2,3があり、それぞれのメインカテゴリは catA, catB, catA だったとします。
記事1 の「次の記事」はどうなるかというと、

**デフォルトの EntryNext  by_category="1" の場合** → 「次の記事」は 記事2

	※ 記事1のメインカテゴリは catA。catAに属する次の記事が出力されるので記事2が表示されます。ここで記事2 のメインカテゴリが 必ずしもcatAでなくてもいい点がポイントです。
	 記事2のメインカテゴリは catB なので、ユーザが次へ、次へとたどっていくとcatAの記事を見ているつもりが、いつのまにかcatBの記事を 前へ/次へしている、ということになってしまいます。

**EntryNext2 by_category="1" の場合** → 「次の記事」は 記事3

	※メインカテゴリが catA な記事は、記事1と3です。
	記事2はcatAに所属していますがメインカテゴリではないので対象からはずれます。
