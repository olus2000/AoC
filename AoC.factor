! Copyright (C) 2025 Aleksander "olus2000" Sabak.
! See https://factorcode.org/license.txt for BSD license.
USING: accessors continuations formatting http http.client io
io.backend io.encodings.utf8 io.files io.pathnames kernel
literals multiline namespaces sequences tools.scaffold ;
IN: AoC

<PRIVATE

CONSTANT: root $[ "vocab:AoC" normalize-path parent-directory ]

CONSTANT: path-format
  $[ "vocab:AoC" "%04d" "%02d" 3append-path ]

CONSTANT: vocab-format "AoC.%04d.%02d"

CONSTANT: url-format "https://adventofcode.com/%d/day/%d/input"

CONSTANT: AoC-main-format [[ auto-use


CONSTANT: input
  $[ "%s" utf8 file-lines ]


: parse ( strs -- parsed )


: part-1 ( input -- n )
  parse ;


: part-2 ( input -- n )
  parse ;
]]

INITIALIZED-SYMBOL: AoC-session [ "" ]

: scaffold-AoC-vocab ( day -- )
  [ year>> ] [ day>> ] bi vocab-format sprintf
  root swap scaffold-vocab-in ;

: day>AoC-path ( day -- path )
  [ year>> ] [ day>> ] bi path-format sprintf ;

: day>AoC-url ( day -- url )
  [ year>> ] [ day>> ] bi url-format sprintf ;

: (get-AoC-input) ( url -- input )
  <get-request> AoC-session get-global "session" <cookie>
  put-cookie http-request nip ;

: correct-session ( -- )
  "Enter new session cookie:" print
  readln AoC-session set-global ;

: get-AoC-input ( url -- input )
  [ (get-AoC-input) ]
  [ dup download-failed?
    [ { { "Correct session cookie" 1 } } rethrow-restarts drop
      correct-session get-AoC-input ] [ rethrow ] if ] recover ;

: path>input-file ( path -- path' )
  dup file-name ".in" append append-path ;

: scaffold-AoC-input ( day -- )
  [ day>AoC-url get-AoC-input ] [ day>AoC-path path>input-file ]
  bi utf8 set-file-contents ;

: path>main-file ( path -- path' )
  dup file-name ".factor" append append-path ;

: day>main-contents ( day -- str )
  day>AoC-path path>input-file AoC-main-format sprintf ;

: default-AoC-main ( day -- )
  [ day>main-contents ] [ day>AoC-path path>main-file ] bi utf8
  [ write ] with-file-appender ;

PRIVATE>


: scaffold-AoC ( day -- )
  [ scaffold-AoC-vocab ] [ default-AoC-main ]
  [ scaffold-AoC-input ] tri ;
