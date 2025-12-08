! Copyright (C) 2025 Your name.
! See https://factorcode.org/license.txt for BSD license.
USING: accessors assocs disjoint-sets io.encodings.utf8 io.files
kernel literals math math.combinatorics math.parser math.vectors
sequences sets sorting splitting ;
IN: AoC.2025.08

auto-use


CONSTANT: input
  $[ "vocab:AoC/2025/08/08.in" utf8 file-lines ]


: parse ( strs -- parsed )
  [ "," split [ string>number ] map ] map ;


: part-1 ( input -- n )
  parse [ <disjoint-set> tuck add-atoms ] keep
  2 <combinations> [ first2 distance ] sort-by 1000 head
  [ first2 pick equate ] each
  counts>> values sort 3 tail* product ;


: part-2 ( input -- n )
  parse [ <disjoint-set> tuck add-atoms ] keep
  2 <combinations> [ first2 distance ] sort-by
  [ first2 pick [ equiv? ] [ equate ] 3bi ] reject
  last first2 [ first ] bi@ * nip ;
