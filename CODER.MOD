MODULE Coder;
FROM Strings IMPORT CompareStr;
FROM InOut IMPORT WriteString, WriteLine, RedirectOutput;
FROM SLICE IMPORT Slice;
FROM XDOS IMPORT ReadFileLine;
FROM Files IMPORT Read, Open, READ, Close;
FROM XString IMPORT RightTrim, Exact;
FROM System IMPORT GetArg, Terminate;
FROM DevIO IMPORT CardErr, WriteErr, NLErr, LineErr;
TYPE
    tString = ARRAY [0..127] OF CHAR;
VAR
    i : INTEGER;
    cLines,
    n : CARDINAL;
    axString,
    axTemp1,
    axTemp2,
    axTemp3 : tString;
    bDebug,
    bFlag : BOOLEAN;

PROCEDURE Syntax( axNotFound : ARRAY OF CHAR);
BEGIN
    LineErr(" lines processed.");
    WriteErr("Syntax error. Line:");
    CardErr(cLines,3);
    WriteErr(". Keyword [");
    WriteErr( axNotFound);
    LineErr("] not found. Error ignored.")
END Syntax;

PROCEDURE Parameters();
BEGIN
    WriteString("PARA ");
    WHILE axString[0] <> 0X DO
        Slice(axString, axTemp1);
        WriteString(axTemp1);
        IF axString[0] <> 0X THEN
            WriteString(", ")
        END;
    END;
    WriteLine("")
END Parameters;

PROCEDURE InTo();
VAR axTmp : tString;
BEGIN

  IF bFlag THEN
      WhileEnd;
  END;
  Slice( axString, axTemp1);
  WriteLine("SELECT 1");
  WriteString("USE ");
  RightTrim( axTemp1);
  WriteString( axTemp1);
  axTmp := axTemp1;
  WriteLine(" ALIAS DST ");
  Slice( axString, axTemp1); (* put *)
  IF NOT Exact(axTemp1, "put") THEN
    Syntax("put")
  ELSE
    Slice( axString, axTemp1)
  END;
  WriteLine("SELECT 2");
  WriteString("USE ");
  RightTrim( axTemp1);
  WriteString( axTemp1);
  WriteLine(" ALIAS SRC ");
  WriteLine("CLEAR");
  WriteString("@ 1,1 SAY [New Records in ]+");
  WriteString( axTmp);
  WriteLine("");
  WriteLine("Select SRC");
  WriteLine("GOTO TOP");
  WriteLine("DO WHILE .NOT. EOF()");
  WriteLine(" SELECT DST");
  WriteLine(" APPEND BLANK");
  WriteLine(" @ 2, 1 SAY RECNO()");
END InTo;

PROCEDURE Replace();
BEGIN
  bFlag := TRUE;
  Slice( axString, axTemp1);
  WriteString(" REPLACE DST->");
  RightTrim( axTemp1);
  WriteString( axTemp1);
  Slice( axString, axTemp1);
  IF NOT Exact(axTemp1, "with") THEN
    Syntax("with")
  ELSE
    Slice( axString, axTemp1)
  END;
  WriteString(" WITH SRC->");
  RightTrim( axTemp1);
  WriteLine( axTemp1);
END Replace;
PROCEDURE WhileEnd();
BEGIN
    WriteLine(" SELECT SRC");
    WriteLine(" SKIP");
    WriteLine("ENDDO");
    WriteLine("SELECT DST");
    WriteLine("USE");
    WriteLine("Select SRC");
    WriteLine("USE");
    WriteLine("")
END WhileEnd;

BEGIN
    LineErr("CODER v1.0 (c) Copyright Bruce M. Axtens, 1993.");
    GetArg(axTemp1,n);
    IF n=0 THEN
        axTemp2 := 'DEFAULT.CDR'
    ELSE
        axTemp2 := axTemp1
    END;

    GetArg(axTemp1,n);
    IF n=0 THEN
        axTemp3 := 'DEFAULT.PRG'
    ELSE
        axTemp3 := axTemp1
    END;

    GetArg( axTemp1, n);
    IF n # 0 THEN
        bDebug := ( CAP(axTemp1[0])='D')
    ELSE
        bDebug := FALSE
    END;

    Open(i,axTemp2,READ);
    IF i = -1 THEN
        WriteErr("Could not open ");
        WriteErr( axTemp2);
        NLErr;
        Terminate(1)
    END;
    RedirectOutput(axTemp3);
    cLines := 0;
    ReadFileLine(i,axString,n);
    bFlag := FALSE;
    WHILE n <> 0 DO
        INC( cLines);
        WriteErr( CHR(13));
        CardErr( cLines,5);
        IF bDebug THEN
            RightTrim(axString);
            WriteString("**CODER: ");
            WriteLine(axString);
        END;
        Slice( axString, axTemp1);
        IF Exact(axTemp1,"par") THEN
            Parameters()
        ELSE
            IF Exact(axTemp1,"into") THEN
                InTo();
            ELSE
                IF Exact(axTemp1,"rep") THEN
                    Replace()
                ELSE
                    IF Exact( axTemp1,"code") THEN
                        RightTrim( axString);
                        WriteLine( axString)
                    ELSE
                        IF Exact( axTemp1, "end") THEN
                            Close(i);
                            Terminate(0)
                        END
                    END
                END
            END;
        END;
        ReadFileLine(i,axString,n);
    END;
    Close(i);
    IF bFlag THEN
        WhileEnd()
    END;
    LineErr(" lines processed.")

END Coder.
