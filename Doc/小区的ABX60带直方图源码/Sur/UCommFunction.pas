unit UCommFunction;

interface
uses Windows,Types,SysUtils,StrUtils,ComObj,ActiveX,ShlObj;

function cryptstr(const s:string; stype: dword):string;
procedure RecordLog(logFile:string;logStr:string);
function manystr(ss:string;sourstr:string):integer;
procedure OperateLinkFile(ExePathAndName:string; LinkFileName: widestring;
  LinkFilePos:integer;AddorDelete: boolean);
FUNCTION StrTofloatExt(sourStr:string):single;
FUNCTION StrTofloatStr(sourStr:string):string;
procedure DIFF_decode(ASTMField:Pchar;var Histogram:string;FieldSize:integer);
//procedure DIFF_decodeABX(ASTMField:Pchar;var Histogram:string;FieldSize:integer);

implementation
const OFFSET=$30;

//procedure DIFF_decodeABX(ASTMField:Pchar;var Histogram:string;FieldSize:integer);
//var
//begin
//end;

procedure DIFF_decode(ASTMField:Pchar;var Histogram:string;FieldSize:integer);

var
  HistIdx,FieldIdx:integer;
  BitArray:integer;
begin
    Histogram :='';
    while FieldIdx<FieldSize-1 do
    begin
    Histogram :=Histogram +' '+inttostr(ord(ASTMField[FieldIdx])-20);
    inc(FieldIdx,1)
    end ;
{
  Histogram:='';
  HistIdx:=0;FieldIdx:=0;
  //一次译解4 个字符
  while FieldIdx<FieldSize-3 do
  begin
    BitArray:=(ord(ASTMField[FieldIdx])-OFFSET);
    BitArray:=(BitArray shl 6)+(ord(ASTMField[FieldIdx+1])-OFFSET);
    BitArray:=(BitArray shl 6)+(ord(ASTMField[FieldIdx+2])-OFFSET);
    BitArray:=(BitArray shl 6)+(ord(ASTMField[FieldIdx+3])-OFFSET);
    Histogram:=Histogram+' '+inttostr((BitArray and $FF0000) shr 16);
    Histogram:=Histogram+' '+inttostr((BitArray and $00FF00) shr 8);
    Histogram:=Histogram+' '+inttostr(BitArray and $0000FF);
    inc(FieldIdx,4);
    inc(HistIdx,3);
  end;

  if FieldIdx=FieldSize-3 then
  begin
    // 3 个字节离开转变
    BitArray:=ord(ASTMField[FieldIdx])-OFFSET;
    BitArray:=(BitArray shl 6)+(ord(ASTMField[FieldIdx+1])-OFFSET);
    BitArray:=(BitArray shl 6)+(ord(ASTMField[FieldIdx+2])-OFFSET);
    Histogram:=Histogram+' '+inttostr((BitArray and $00FF00) shr 8);
    Histogram:=Histogram+' '+inttostr(BitArray and $0000FF);
  end else
    if  FieldIdx=FieldSize-2 then
    begin
      //2个字节离开转变
      BitArray:=ord(ASTMField[FieldIdx])-OFFSET;
      BitArray:=(BitArray shl 6)+(ord(ASTMField[FieldIdx+1])-OFFSET);
      Histogram:=Histogram+' '+inttostr(BitArray and $0000FF);
    end;  }
end;

function manystr(ss:string;sourstr:string):integer;
var
        i:integer;
        l,ll,lll:integer;
begin
        result:=0;
        i:=0;
        while pos(ss,sourstr)<>0 do
        begin
                l:=length(sourstr);
                ll:=pos(ss,sourstr);
                lll:=length(ss);
                //sourstr:=rightstr(sourstr,l-ll-lll+1);
                sourstr:=copy(sourstr,ll+lll,l-ll-lll+1);
                inc(i);
        end;
        result:=i;
end;

function cryptstr(const s:string; stype: dword):string;
var
  i: integer;
  fkey: integer;
begin
  result:='';
  case stype of
  0:   {加密}
    begin
      randomize;
      fkey := random($ff);
      for i:=1 to length(s) do result := result+chr( ord(s[i]) xor i xor fkey);
      result := result + char(fkey);
    end;
  1:    {解密}
    begin
      fkey :=  ord(s[length(s)]);
      for i:=1 to length(s) - 1 do
      result := result+chr( ord(s[i]) xor i xor fkey);
    end;
   end;
end;

procedure RecordLog(logFile:string;logStr:string);
var
    ErrLog:textfile;
begin
    if not fileexists(logfile) then
    begin
      assignfile(errlog,logfile);
      rewrite(errlog);
      closefile(errlog);
    end;
    assignfile(errlog,logfile);
    append(errlog);
    writeln(errlog,logStr);
    closefile(errlog);
end;

procedure OperateLinkFile(ExePathAndName:string; LinkFileName: widestring;
  LinkFilePos:integer;AddorDelete: boolean);
VAR
  tmpobject:IUnknown;
  tmpSLink:IShellLink;
  tmpPFile:IPersistFile;
  PIDL:PItemIDList;
  LinkFilePath:array[0..MAX_PATH]of char;
  StartupFilename:string;
begin
  case LinkFilePos of
    1:SHGetSpecialFolderLocation(0,CSIDL_BITBUCKET,pidl);
    2:SHGetSpecialFolderLocation(0,CSIDL_CONTROLS,pidl);
    3:SHGetSpecialFolderLocation(0,CSIDL_DESKTOP,pidl);
    4:SHGetSpecialFolderLocation(0,CSIDL_DESKTOPDIRECTORY,pidl);
    5:SHGetSpecialFolderLocation(0,CSIDL_DRIVES,pidl);
    6:SHGetSpecialFolderLocation(0,CSIDL_FONTS,pidl);
    7:SHGetSpecialFolderLocation(0,CSIDL_NETHOOD,pidl);
    8:SHGetSpecialFolderLocation(0,CSIDL_NETWORK,pidl);
    9:SHGetSpecialFolderLocation(0,CSIDL_PERSONAL,pidl);
    10:SHGetSpecialFolderLocation(0,CSIDL_PRINTERS,pidl);
    11:SHGetSpecialFolderLocation(0,CSIDL_PROGRAMS,pidl);
    12:SHGetSpecialFolderLocation(0,CSIDL_RECENT,pidl);
    13:SHGetSpecialFolderLocation(0,CSIDL_SENDTO,pidl);
    14:SHGetSpecialFolderLocation(0,CSIDL_STARTMENU,pidl);
    15:SHGetSpecialFolderLocation(0,CSIDL_STARTUP,pidl);
    16:SHGetSpecialFolderLocation(0,CSIDL_TEMPLATES,pidl);
  end;
  shgetpathfromidlist(pidl,LinkFilePath);
  linkfilename:=LinkFilePath+LinkFileName;
  if AddorDelete then
  begin
    if not fileexists(linkfilename) then
    begin
      startupfilename:=ExePathAndName;
      tmpobject:=createcomobject(CLSID_ShellLink);
      tmpSLink:=tmpobject as ishelllink;
      tmpPfile:=tmpobject as IPersistFile;
      tmpslink.SetPath(pchar(startupfilename));
      tmpslink.SetWorkingDirectory(pchar(extractfilepath(startupfilename)));
      tmppfile.save(pwchar(linkfilename),false);
    end;
  end else
  begin
    if fileexists(linkfilename) then deletefile(linkfilename);
  end;
end;

FUNCTION StrTofloatStr(sourStr:string):string;
//加强型的STRTOFLOAT函数,能提取字符串中第一个浮点数或整数,返回的是字符串。
//例：StrTofloatExt(#$21+'-45.67'+'是')=-45.67
//例：StrTofloatExt(#$21+'-.67'+'是')=-.67
//刘鹰；2003-11-19
var
  sourStrLen:integer;
  i:integer;
  ifFUSHU:BOOLEAN;
begin
  ifFUSHU:=false;
  sourStrLen:=length(sourStr);
  for i :=1  to sourStrLen do
  begin
    if ord(sourstr[i]) in [46,48..57] then
    begin
      if i>=2 then if sourstr[i-1]='-' then ifFUSHU:=true;//是否负数
      delete(sourStr,1,i-1);
      break;
    end;
  end;
  sourStrLen:=length(sourStr);
  for i :=1  to sourStrLen do
  begin
    if not(ord(sourstr[i]) in [46,48..57]) then
    begin
      sourstr:=leftstr(sourstr,i-1);
      break;
    end;
  end;
  result:=sourstr;
  if ifFUSHU then result:='-'+result;
end;

FUNCTION StrTofloatExt(sourStr:string):single;
//加强型的STRTOFLOAT函数,能提取字符串中第一个浮点数或整数。
//例：StrTofloatExt(#$21+'-45.67'+'是')=-45.67
//例：StrTofloatExt(#$21+'-.67'+'是')=-0.67
//刘鹰；2003-5-8
var
  sourStrLen:integer;
  i:integer;
  ifFUSHU:BOOLEAN;
begin
  ifFUSHU:=false;       
  sourStrLen:=length(sourStr);
  for i :=1  to sourStrLen do
  begin
    if ord(sourstr[i]) in [46,48..57] then
    begin
      if i>=2 then if sourstr[i-1]='-' then ifFUSHU:=true;//是否负数
      delete(sourStr,1,i-1);
      break;
    end;
  end;
  sourStrLen:=length(sourStr);
  for i :=1  to sourStrLen do
  begin
    if not(ord(sourstr[i]) in [46,48..57]) then
    begin
      sourstr:=leftstr(sourstr,i-1);
      break;
    end;
  end;
  result:=strtofloatdef(sourstr,0);
  if ifFUSHU then result:=result*(-1);
end;

end.
