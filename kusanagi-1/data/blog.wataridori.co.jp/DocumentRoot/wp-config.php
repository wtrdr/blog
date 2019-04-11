<?php
/**
 * WordPress の基本設定
 *
 * このファイルは、MySQL、テーブル接頭辞、秘密鍵、ABSPATH の設定を含みます。
 * より詳しい情報は {@link http://wpdocs.sourceforge.jp/wp-config.php_%E3%81%AE%E7%B7%A8%E9%9B%86 
 * wp-config.php の編集} を参照してください。MySQL の設定情報はホスティング先より入手できます。
 *
 * このファイルはインストール時に wp-config.php 作成ウィザードが利用します。
 * ウィザードを介さず、このファイルを "wp-config.php" という名前でコピーして直接編集し値を
 * 入力してもかまいません。
 *
 * @package WordPress
 */

// 注意: 
// Windows の "メモ帳" でこのファイルを編集しないでください !
// 問題なく使えるテキストエディタ
// (http://wpdocs.sourceforge.jp/Codex:%E8%AB%87%E8%A9%B1%E5%AE%A4 参照)
// を使用し、必ず UTF-8 の BOM なし (UTF-8N) で保存してください。

// ** MySQL 設定 - この情報はホスティング先から入手してください。 ** //
/** WordPress のためのデータベース名 */
define( 'DB_NAME', 'wataridori-blog' );

/** MySQL データベースのユーザー名 */
define( 'DB_USER', 'wataridori' );

/** MySQL データベースのパスワード */
define( 'DB_PASSWORD', 'ErLcjwmIRbTO61BX' );

/** MySQL のホスト名 */
define( 'DB_HOST', 'mysql' );

/** データベースのテーブルを作成する際のデータベースの文字セット */
define( 'DB_CHARSET', 'utf8mb4' );

/** データベースの照合順序 (ほとんどの場合変更する必要はありません) */
define('DB_COLLATE', '');

/**#@+
 * 認証用ユニークキー
 *
 * それぞれを異なるユニーク (一意) な文字列に変更してください。
 * {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org の秘密鍵サービス} で自動生成することもできます。
 * 後でいつでも変更して、既存のすべての cookie を無効にできます。これにより、すべてのユーザーを強制的に再ログインさせることになります。
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',         'wDu8@8]]ri}xrg;S$d!:4SqJj !svP6HzVS=ZBV6`3c74&2;lAF|JQs~d#+smXAS' );
define( 'SECURE_AUTH_KEY',  ':c?{KHjgjHzCZUFD[9c~*Tt(2wCbBuY<9gY|3}6NoBYyI]rl4zq]GxWs@v@pDQ]V' );
define( 'LOGGED_IN_KEY',    'TV9P7vHJE?U$E[l.FTY!H|AkQqD+6oZolXp g*|%/WAuQBKFu<y4Mc5<>=h4mOT6' );
define( 'NONCE_KEY',        '<lCc8|L~{n*jOmFM|N4toc/}44Di1EX@#-4/hgz24B5 le(SJem&@I ^HL1Q:--9' );
define( 'AUTH_SALT',        '7zFRu8|<tsD%<73>}7:%+vpcy!ch.6el &4;pc*XCNBr@H~hHWJd^8A2f| N.Zf0' );
define( 'SECURE_AUTH_SALT', 'PTI$RLZWPd.^PL3qzHm^nU`qe$.43Fi>xvW=HzHjLJ_lI<S[CN@0mQ!Z<L:19*&H' );
define( 'LOGGED_IN_SALT',   'OYVR6QFfl6ABQkMCVc2*64e3wp0m:H$[,xf[C7KTePw-);ko4xWfp xGtX*b~uz<' );
define( 'NONCE_SALT',       'Do-1ti%LT|kA9XB50a:g{|p)t5Qlk{7^?5=bi0AHWl@B?M>JeGCg#ieA`LJ]Qr5}' );

/**#@-*/

/**
 * WordPress データベーステーブルの接頭辞
 *
 * それぞれにユニーク (一意) な接頭辞を与えることで一つのデータベースに複数の WordPress を
 * インストールすることができます。半角英数字と下線のみを使用してください。
 */
$table_prefix  = 'wp_';

/**
 * 開発者へ: WordPress デバッグモード
 *
 * この値を true にすると、開発中に注意 (notice) を表示します。
 * テーマおよびプラグインの開発者には、その開発環境においてこの WP_DEBUG を使用することを強く推奨します。
 */
define('WP_DEBUG', false);

#define('FORCE_SSL_ADMIN', true);
#define('WP_CACHE', true);

/* 編集が必要なのはここまでです ! WordPress でブログをお楽しみください。 */

/** Absolute path to the WordPress directory. */
if ( !defined('ABSPATH') )
	define('ABSPATH', dirname(__FILE__) . '/');

/** Sets up WordPress vars and included files. */
require_once(ABSPATH . 'wp-settings.php');
define(FS_METHOD,direct);
