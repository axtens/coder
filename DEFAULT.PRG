PARA cDstDir, cSrcDir

?? [VEN2DOCS v1.1 (c) Copyright United Construction Pty Ltd, 1993.]
if pcount() < 2
? [Syntax:]
? [       VEN2DOCS destination_path\ source_path\]
quit
end
if right(cDstDir,1) != "\"
? [destination_path needs a trailing backslash]
quit
end
if right(cSrcDir,1) != "\"
? [source_path needs a trailing backslash]
quit
end
if !file(cDstDir+"*.*")
? cDstDir," not found"
quit
end
if !file(cSrcDir+"*.*")
? cSrcDir," not found"
quit
end
USE (cDstDir+"drawing.dbf") ALIAS DST NEW
USE (cSrcDir+"drawing.dbf") ALIAS SRC NEW
CLS
@ 1,1 SAY [New Records in ]+(cDstDir+"drawing.dbf")
Select SRC
GOTO TOP
WHILE .NOT. SRC->(EOF())
 SELECT DST
 APPEND BLANK
 @ 2, 1 SAY RECNO()
 REPLACE DST->draw_no WITH SRC->drawing
 REPLACE DST->distcode WITH SRC->order
 REPLACE DST->equip_no WITH SRC->tag_no
 REPLACE DST->client_no WITH SRC->client_no
 REPLACE DST->title WITH SRC->title
 REPLACE DST->rev_no WITH SRC->revision
 REPLACE DST->remarks WITH SRC->comments
 REPLACE DST->rev_date WITH SRC->received
 SELECT SRC
 SKIP
END
SELECT DST
USE
Select SRC
USE

USE (cDstDir+"distname") ALIAS DST NEW
USE  ALIAS SRC NEW
CLS
@ 1,1 SAY [New Records in ]+(cDstDir+"distname")
Select SRC
GOTO TOP
WHILE .NOT. SRC->(EOF())
 SELECT DST
 APPEND BLANK
 @ 2, 1 SAY RECNO()
 REPLACE DST->distcode WITH SRC->order
 REPLACE DST->descript WITH SRC->
 SELECT SRC
 SKIP
END
SELECT DST
USE
Select SRC
USE

USE (cDstDir+"distcode") ALIAS DST NEW
USE (cSrcDir+"distcode") ALIAS SRC NEW
CLS
@ 1,1 SAY [New Records in ]+(cDstDir+"distcode")
Select SRC
GOTO TOP
WHILE .NOT. SRC->(EOF())
 SELECT DST
 APPEND BLANK
 @ 2, 1 SAY RECNO()
 REPLACE DST->compcode WITH SRC->compcode
 REPLACE DST->distcode WITH SRC->order
 REPLACE DST->fs_copy WITH SRC->fs_Copy
 REPLACE DST->a3_copy WITH SRC->a3_copy
 SELECT SRC
 SKIP
END
SELECT DST
USE
Select SRC
USE

USE (cDstDir+"company") ALIAS DST NEW
USE (cSrcDir+"company") ALIAS SRC NEW
CLS
@ 1,1 SAY [New Records in ]+(cDstDir+"company")
Select SRC
GOTO TOP
WHILE .NOT. SRC->(EOF())
 SELECT DST
 APPEND BLANK
 @ 2, 1 SAY RECNO()
 REPLACE DST->compcode WITH SRC->compcode
 REPLACE DST->name WITH SRC->name
 REPLACE DST->street WITH SRC->street
 REPLACE DST->town WITH SRC->town
 REPLACE DST->attention WITH SRC->attention
 REPLACE DST->telephone WITH SRC->telephone
 REPLACE DST->fs_copy WITH SRC->fs_Copy
 REPLACE DST->a3_copy WITH SRC->a3_copy
 REPLACE DST->dist WITH SRC->dist
 REPLACE DST->selc WITH SRC->selc
 SELECT SRC
 SKIP
END
SELECT DST
USE
Select SRC
USE

USE (cDstDir+"rev") ALIAS DST NEW
USE (cSrcDir+"history") ALIAS SRC NEW
CLS
@ 1,1 SAY [New Records in ]+(cDstDir+"rev")
Select SRC
GOTO TOP
WHILE .NOT. SRC->(EOF())
 SELECT DST
 APPEND BLANK
 @ 2, 1 SAY RECNO()
 REPLACE DST->draw_no WITH SRC->drawing
 REPLACE DST->rev_no WITH SRC->revision
 REPLACE DST->rev_date WITH SRC->received
 REPLACE DST->remarks WITH SRC->comments
 SELECT SRC
 SKIP
END
SELECT DST
USE
Select SRC
USE

USE (cDstDir+"issue") ALIAS DST NEW
USE (cSrcDir+"issue") ALIAS SRC NEW
CLS
@ 1,1 SAY [New Records in ]+(cDstDir+"issue")
Select SRC
GOTO TOP
WHILE .NOT. SRC->(EOF())
 SELECT DST
 APPEND BLANK
 @ 2, 1 SAY RECNO()
 REPLACE DST->issue WITH SRC->issue
 REPLACE DST->draw_no WITH SRC->drawing
 REPLACE DST->rev_no WITH SRC->revision
 REPLACE DST->selc WITH SRC->selc
 SELECT SRC
 SKIP
END
SELECT DST
USE
Select SRC
USE

