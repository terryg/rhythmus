@ECHO OFF

IF '%1'=='/?' GOTO :Usage
SET INPUT=%1
SET OUTPUT=output.html
SET DICT=rhythmus.dict
IF '%INPUT%'=='' SET /P INPUT=Input file: 

ECHO.
ECHO.

IF NOT '%2'=='' SET OUTPUT=%2
IF NOT '%3'=='' SET DICT=%1

IF '%INPUT%'=='' GOTO :Usage
IF '%OUTPUT%'=='' GOTO :Usage
IF '%DICT%'=='' GOTO :Usage

IF NOT EXIST %INPUT% (
  ECHO Could not find file: %INPUT%
  GOTO :Usage
) ELSE ( 
  ruby rhythmus.rb -d %DICT% -o %OUTPUT% %INPUT%
)

SET /P FINI=[enter] 

GOTO :EOF

:Usage
ECHO.
ECHO RHYTHMUS
ECHO.
ECHO Usage: RHYTHMUS.BAT [INPUT] [OUTPUT] [DICTIONARY]
ECHO.
ECHO Rhythmus parses the INPUT file, searching for words in the
ECHO DICTIONARY file.  It will query for unknown words and update
ECHO the DICTIONARY.  DICTIONARY defaults to "rhythmus.dict" in 
ECHO this directory.  The OUTPUT file contains HTML formatted
ECHO text of the INPUT file, denoting syllables and provisional
ECHO rankings. OUTPUT defaults to "output.html" in this directory.
ECHO.
ECHO NOTE: Filenames are relative to the directory the script is in. 
ECHO.
ECHO Examples:
ECHO RHYTHMUS.BAT 
ECHO RHYTHMUS.BAT examples\amphibrachic_tetrameter.txt
ECHO RHYTHMUS.BAT test\the_turtle-nash.txt turtle.html turtle.dict
ECHO.

SET /P FINI=[enter] 

GOTO :EOF
