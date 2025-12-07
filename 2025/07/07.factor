! Copyright (C) 2025 Aleksander "olus2000" Sabak.
! See https://factorcode.org/license.txt for BSD license.
USING: assocs assocs.extras hash-sets hashtables
io.encodings.utf8 io.files kernel literals math sequences sets ;
IN: AoC.2025.07


CONSTANT: input
  $[ "vocab:AoC/2025/07/07.in" utf8 file-lines ]


: parse ( strs -- splitters )
  [ <enumerated> [ CHAR: . = ] reject-values
    keys >hash-set ] map ;


: tachyon-step ( beams splitters -- beams' nsplits )
  [ diff ] [ intersect ] 2bi
  [ members [ [ 1 + ] map >hash-set ] [ [ 1 - ] map >hash-set ]
    bi union union ] [ cardinality ] bi ;


: part-1 ( input -- n )
  parse unclip-slice swap [ tachyon-step ] map-sum nip ;


: quantum-step ( beams splitters -- beams' )
  members
  [ [ of ] [ nip [ 1 + ] [ 1 - ] bi overd ] [ 0 set-of ]
    2tri [ at+ ] keep [ at+ ] keep ] each ;


: part-2 ( input -- n )
  parse unclip members first 1 swap associate
  swap [ quantum-step ] each values sum ;
