! Copyright (C) 2025 Aleksander "olus2000" Sabak.
! See https://factorcode.org/license.txt for BSD license.
USING: arrays io.encodings.utf8 io.files kernel literals math
math.parser sequences sequences.extras splitting ;
IN: AoC.2025.01


CONSTANT: input
  $[ "vocab:AoC/2025/01/01.in" utf8 file-lines ]


: parse ( lines -- numbers )
  [ unclip [ string>number ] dip CHAR: L = [ neg ] when ] map ;


: count-zero-stops ( moves -- stops )
  50 [ + 100 mod ] accumulate* [ 0 = ] count ;


: part-1 ( input -- n ) parse count-zero-stops ;


: explode ( n -- ns ) [ abs ] [ sgn ] bi <array> ;


: part-2 ( input -- n )
  parse [ explode ] map-concat count-zero-stops ;
