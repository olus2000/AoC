! Copyright (C) 2025 Aleksander "olus2000" Sabak.
! See https://factorcode.org/license.txt for BSD license.
USING: io.encodings.utf8 io.files kernel literals math sequences
;
IN: AoC.2025.03


CONSTANT: input
  $[ "vocab:AoC/2025/03/03.in" utf8 file-lines ]


: parse ( strs -- parsed ) [ [ CHAR: 0 - ] map ] map ;


: maximum-index ( seq -- maxium index )
  [ maximum dup ] keep index ;


: biggest-pair ( digits -- n )
  [ 1 head-slice* maximum-index ] keep
  swap 1 + tail-slice maximum swap 10 * + ;


: part-1 ( input -- n ) parse [ biggest-pair ] map-sum ;


: biggest-set ( digits n -- n index )
  [ drop 0 -1 ]
  [ [ dup 1 head-slice* ] dip 1 - biggest-set
    1 + rot over tail-slice maximum-index
    -rotd [ 10 * + ] [ + ] 2bi* ] if-zero ;


: part-2 ( input -- n ) parse [ 12 biggest-set drop ] map-sum ;
