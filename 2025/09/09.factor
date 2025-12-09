! Copyright (C) 2025 Aleksander "olus2000" Sabak.
! See https://factorcode.org/license.txt for BSD license.
USING: arrays assocs combinators.short-circuit grouping
io.encodings.utf8 io.files kernel literals math
math.combinatorics math.order math.parser namespaces ranges
sequences sorting splitting ;
IN: AoC.2025.09

auto-use


CONSTANT: input
  $[ "vocab:AoC/2025/09/09.in" utf8 file-lines ]


: parse ( strs -- parsed )
  [ "," split [ string>number ] map ] map ;


: area ( p1 p2 -- n ) [ - abs 1 + ] [ * ] 2map-reduce ;


: part-1 ( input -- n )
  parse 2 <combinations>
  [ first2 area ] maximum-by first2 area ;


SYMBOLS: h-bounds v-bounds ;


: with-bounds ( ..a quot: ( ..a -- ..b ) -- ..b )
 '[ { h-bounds v-bounds }
   2 [ 100000 [ { 100000 0 } clone ] replicate ] replicate zip
   _ with-variables ] call ; inline


: bind-vertical ( x1 x2 y -- )
  [ [a..b] ] dip dup
  '[ v-bounds get
     [ first2 [ _ min ] [ _ max ] bi* 2array ] change-nth ]
  each ;


: bind-horizontal ( x y1 y2 -- )
  [a..b] swap dup
  '[ h-bounds get
     [ first2 [ _ min ] [ _ max ] bi* 2array ] change-nth ]
  each ;


: bind-points ( a b -- )
  [ first2 ] bi@ swapd [ 2dup ] dip
  bind-horizontal bind-vertical ;


: valid-v-line? ( x1 x2 y -- ? )
  [ [a..b] ] dip dup
  '[ v-bounds get nth first2 [ _ <= ] [ _ >= ] bi* and ] all? ;


: valid-h-line? ( x y1 y2 -- ? )
  [a..b] swap dup
  '[ h-bounds get nth first2 [ _ <= ] [ _ >= ] bi* and ] all? ;


: valid-rect? ( a b -- ? )
  [ first2 ] bi@ swapd
  { [ valid-h-line? nip ]
    [ nipd valid-h-line? ]
    [ nip valid-v-line? ]
    [ drop valid-v-line? ] } 4 n&& ;


: part-2 ( input -- n )
  [ parse dup 2 <circular-clumps> [ first2 bind-points ] each
    2 <combinations> [ first2 area ] inv-sort-by
    [ first2 valid-rect? ] find nip first2 area ] with-bounds ;
