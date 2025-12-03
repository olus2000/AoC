! Copyright (C) 2025 Aleksander "olus2000" Sabak.
! See https://factorcode.org/license.txt for BSD license.
USING: grouping io.encodings.utf8 io.files kernel literals math
math.parser math.primes.factors prettyprint ranges sequences
sequences.extras splitting ;
IN: AoC.2025.02


CONSTANT: input
  $[ "vocab:AoC/2025/02/02.in" utf8 file-lines ]


: parse ( str -- ranges )
  "," split [ "-" split1 [ string>number ] bi@ [a..b] ] map ;


: silly? ( n -- ? )
  number>string dup length 2 /i [ head ] [ tail ] 2bi = ;


: part-1 ( input -- n )
  first parse [ [ silly? ] filter sum ] map-sum ;


: very-silly? ( n -- ? )
  number>string dup length divisors but-last
  [ <groups> all-equal? ] with any? ;

: part-2 ( input -- n )
  first parse [ [ very-silly? ] filter sum ] map-sum ;
