! Copyright (C) 2025 Aleksander "olus2000" Sabak.
! See https://factorcode.org/license.txt for BSD license.
USING: arrays io.encodings.utf8 io.files kernel literals make
math math.order math.parser sequences sets sorting splitting ;
IN: AoC.2025.05

auto-use


CONSTANT: input
  $[ "vocab:AoC/2025/05/05.in" utf8 file-lines ]


: parse ( strs -- ranges ingredients )
  { "" } split1
  [ [ "-" split1 [ string>number ] bi@ 2array ] map ]
  [ [ string>number ] map ] bi* ;


: part-1 ( input -- n )
  parse swap '[ _ [ in? ] with any? ] count ;


: ?join-ranges ( range1 range2 -- range3 )
  over second over first 1 - >=
  [ [ first2 ] [ second ] bi* max 2array ]
  [ [ , ] dip ] if ;


: part-2 ( input -- n )
  parse drop sort unclip swap
  [ [ ?join-ranges ] each , ] { } make
  [ first2 swap - 1 + ] map-sum ;
