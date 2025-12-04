! Copyright (C) 2025 Your name.
! See https://factorcode.org/license.txt for BSD license.
USING: ;
IN: AoC.2025.04

auto-use


CONSTANT: input
  $[ "vocab:AoC/2025/04/04.in" utf8 file-lines ]


: parse ( strs -- parsed )
  [ [ <enumerated> ] dip
    '[ [ _ 2array ] dip CHAR: @ = ] assoc-map
    [ nip ] assoc-filter keys >hash-set ] map-index union-all ;


: [n-1..n+1] ( n -- range ) [ 1 - ] [ 1 + ] bi [a..b] ;


: neighbourhood-count ( points coords -- n )
  first2 [ [n-1..n+1] ] bi@ cartesian-product concat
  intersect length ;


: part-1 ( input -- n )
  parse dup members [ neighbourhood-count 4 <= ] with count ;


: print-paper ( points width height -- )
  swap '[ _ CHAR: . <string> ] replicate dup rot members
  [ first2 rot nth CHAR: @ -rot set-nth ] with each
  [ print ] each ;


: part-2 ( input -- n )
  parse [ cardinality ] keep dup [ 2dup [ cardinality ] bi@ > ]
  [ nip dup dup members [ neighbourhood-count 4 > ] with filter
    >hash-set ] do while drop cardinality - ;
