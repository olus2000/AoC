! Copyright (C) 2025 Aleksander "olus2000" Sabak.
! See https://factorcode.org/license.txt for BSD license.
USING: io.encodings.utf8 io.files kernel literals math
math.parser sequences splitting ;
IN: AoC.2025.06

auto-use


CONSTANT: input
  $[ "vocab:AoC/2025/06/06.in" utf8 file-lines ]


: parse-1 ( strs -- numbers ops )
  [ " " split harvest ] map unclip-last
  [ [ [ string>number ] map ] map flip ] dip ;


: cephalopod-math ( numbers ops -- n )
  [ [ unclip-slice ] dip '[ _ "+" = [ + ] [ * ] if ] reduce ]
  2map sum ;


: part-1 ( input -- n ) parse-1 cephalopod-math ;


: parse-2 ( strs -- numbers ops )
  unclip-last
  [ flip [ [ CHAR: \s = ] all? ] split-when harvest
    [ [ [ CHAR: \s = ] reject string>number ] map ] map ]
  [ " " split harvest ] bi* ;


: part-2 ( input -- n ) parse-2 cephalopod-math ;
