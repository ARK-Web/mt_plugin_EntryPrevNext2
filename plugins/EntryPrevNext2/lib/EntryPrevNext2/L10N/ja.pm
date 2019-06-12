package EntryPrevNext2::L10N::ja;

use strict;
use warnings;
use base 'EntryPrevNext2::L10N::en_us';

use vars qw( %Lexicon );

%Lexicon = (
    '_PLUGIN_DESCRIPTION' => '前の記事 / 次の記事 を出力するタグ MTEntryPrevious2/Next2 を提供します。<br />
メインカテゴリが自分と同じ記事同士で 前へ/次へ するリンクを追加できます。',
    'Rebuild prev/next entries' => '前後のエントリーの再構築',
    'Rebuild prev/next entries in same category when entry was saved.' => 'エントリーが保存された際に、メインカテゴリ内の前後のエントリーの再構築を行う',
);
1;
