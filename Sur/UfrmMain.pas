unit UfrmMain;

interface

uses
  Windows, SysUtils, Classes, Forms,Messages, 
  LYTray, Menus, Buttons, ADODB,
  ActnList, AppEvnts, ToolWin, 
  registry,inifiles,Dialogs,StrUtils, 
  DB, CPort,Variants,ComObj, ComCtrls, StdCtrls, Controls, ExtCtrls;

type
  TfrmMain = class(TForm)
    LYTray1: TLYTray;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    ADOConnection1: TADOConnection;
    ApplicationEvents1: TApplicationEvents;
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ActionList1: TActionList;
    editpass: TAction;
    about: TAction;
    stop: TAction;
    ToolButton2: TToolButton;
    Memo1: TMemo;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Button1: TButton;
    ToolButton5: TToolButton;
    ToolButton9: TToolButton;
    ComPort1: TComPort;
    OpenDialog1: TOpenDialog;
    ComDataPacket1: TComDataPacket;
    procedure N3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure N1Click(Sender: TObject);
    procedure ApplicationEvents1Activate(Sender: TObject);
    procedure ToolButton7Click(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ToolButton5Click(Sender: TObject);
    procedure ComPort1AfterOpen(Sender: TObject);
    procedure ComDataPacket1Packet(Sender: TObject; const Str: String);
  private
    { Private declarations }
    procedure WMSyscommand(var message:TWMMouse);message WM_SYSCOMMAND;
    procedure UpdateConfig;{配置文件生效}
    function LoadInputPassDll:boolean;
    function MakeDBConn:boolean;
    function DIFF_decode(const Value:string):string;
    function GetSpecNo(const Value:string):string; //取得联机号
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses ucommfunction;

const
  CR=#$D+#$A;
  STX=#$2;ETX=#$3;ACK=#$6;NAK=#$15;EOF=#$1A;
  sCryptSeed='lc';//加解密种子
  sCONNECTDEVELOP='错误!请与开发商联系!' ;
  IniSection='Setup';

var
  ConnectString:string;
  GroupName:string;//
  SpecType:string ;//
  SpecStatus:string ;//
  CombinID:string;//
  LisFormCaption:string;//
  QuaContSpecNoG:string;
  QuaContSpecNo:string;
  QuaContSpecNoD:string;
  EquipChar:string;
  ifRecLog:boolean;//是否记录调试日志

  //RFM:STRING;       //返回数据
  hnd:integer;
  bRegister:boolean;

{$R *.dfm}

function ifRegister:boolean;
var
  HDSn,RegisterNum,EnHDSn:string;
  configini:tinifile;
  pEnHDSn:Pchar;
begin
  result:=false;
  
  HDSn:=GetHDSn('C:\')+'-'+GetHDSn('D:\')+'-'+ChangeFileExt(ExtractFileName(Application.ExeName),'');

  CONFIGINI:=TINIFILE.Create(ChangeFileExt(Application.ExeName,'.ini'));
  RegisterNum:=CONFIGINI.ReadString(IniSection,'RegisterNum','');
  CONFIGINI.Free;
  pEnHDSn:=EnCryptStr(Pchar(HDSn),sCryptSeed);
  EnHDSn:=StrPas(pEnHDSn);

  if Uppercase(EnHDSn)=Uppercase(RegisterNum) then result:=true;

  if not result then messagedlg('对不起,您没有注册或注册码错误,请注册!',mtinformation,[mbok],0);
end;

function GetConnectString:string;
var
  Ini:tinifile;
  userid, password, datasource, initialcatalog: string;
  ifIntegrated:boolean;//是否集成登录模式

  pInStr,pDeStr:Pchar;
  i:integer;
begin
  result:='';
  
  Ini := tinifile.Create(ChangeFileExt(Application.ExeName,'.INI'));
  datasource := Ini.ReadString('连接数据库', '服务器', '');
  initialcatalog := Ini.ReadString('连接数据库', '数据库', '');
  ifIntegrated:=ini.ReadBool('连接数据库','集成登录模式',false);
  userid := Ini.ReadString('连接数据库', '用户', '');
  password := Ini.ReadString('连接数据库', '口令', '107DFC967CDCFAAF');
  Ini.Free;
  //======解密password
  pInStr:=pchar(password);
  pDeStr:=DeCryptStr(pInStr,sCryptSeed);
  setlength(password,length(pDeStr));
  for i :=1  to length(pDeStr) do password[i]:=pDeStr[i-1];
  //==========

  result := result + 'user id=' + UserID + ';';
  result := result + 'password=' + Password + ';';
  result := result + 'data source=' + datasource + ';';
  result := result + 'Initial Catalog=' + initialcatalog + ';';
  result := result + 'provider=' + 'SQLOLEDB.1' + ';';
  result := result + 'Persist Security Info=True;';//连接SQL SERVER 2008时必需
  if ifIntegrated then
    result := result + 'Integrated Security=SSPI;';
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var
  ctext        :string;
  reg          :tregistry;
begin
  ComDataPacket1.StartString:=STX;
  ComDataPacket1.StopString:=ETX;

  ConnectString:=GetConnectString;
  
  UpdateConfig;
  if ifRegister then bRegister:=true else bRegister:=false;

  lytray1.Hint:='数据接收服务'+ExtractFileName(Application.ExeName);

//=============================初始化密码=====================================//
    reg:=tregistry.Create;
    reg.RootKey:=HKEY_CURRENT_USER;
    reg.OpenKey('\sunyear',true);
    ctext:=reg.ReadString('pass');
    if ctext='' then
    begin
        reg:=tregistry.Create;
        reg.RootKey:=HKEY_CURRENT_USER;
        reg.OpenKey('\sunyear',true);
        reg.WriteString('pass','JIHONM{');
        //MessageBox(application.Handle,pchar('感谢您使用智能监控系统，'+chr(13)+'请记住初始化密码：'+'lc'),
        //            '系统提示',MB_OK+MB_ICONinformation);     //WARNING
    end;
    reg.CloseKey;
    reg.Free;
//============================================================================//
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    if LoadInputPassDll then action:=cafree else action:=caNone;
end;

procedure TfrmMain.N3Click(Sender: TObject);
begin
    if not LoadInputPassDll then exit;
    application.Terminate;
end;

procedure TfrmMain.N1Click(Sender: TObject);
begin
  show;
end;

procedure TfrmMain.ApplicationEvents1Activate(Sender: TObject);
begin
  hide;
end;

procedure TfrmMain.WMSyscommand(var message: TWMMouse);
begin
  inherited;
  if message.Keys=SC_MINIMIZE then hide;
  message.Result:=-1;
end;

procedure TfrmMain.ToolButton7Click(Sender: TObject);
begin
  if MakeDBConn then ConnectString:=GetConnectString;
end;

procedure TfrmMain.UpdateConfig;
var
  INI:tinifile;
  CommName,BaudRate,DataBit,StopBit,ParityBit:string;
  autorun:boolean;
begin
  ini:=TINIFILE.Create(ChangeFileExt(Application.ExeName,'.ini'));

  CommName:=ini.ReadString(IniSection,'串口选择','COM1');
  BaudRate:=ini.ReadString(IniSection,'波特率','9600');
  DataBit:=ini.ReadString(IniSection,'数据位','8');
  StopBit:=ini.ReadString(IniSection,'停止位','1');
  ParityBit:=ini.ReadString(IniSection,'校验位','None');
  autorun:=ini.readBool(IniSection,'开机自动运行',false);
  ifRecLog:=ini.readBool(IniSection,'调试日志',false);

  GroupName:=trim(ini.ReadString(IniSection,'工作组',''));
  EquipChar:=trim(uppercase(ini.ReadString(IniSection,'仪器字母','')));//读出来是大写就万无一失了
  SpecType:=ini.ReadString(IniSection,'默认样本类型','');
  SpecStatus:=ini.ReadString(IniSection,'默认样本状态','');
  CombinID:=ini.ReadString(IniSection,'组合项目代码','');

  LisFormCaption:=ini.ReadString(IniSection,'检验系统窗体标题','');

  QuaContSpecNoG:=ini.ReadString(IniSection,'高值质控联机号','9999');
  QuaContSpecNo:=ini.ReadString(IniSection,'常值质控联机号','9998');
  QuaContSpecNoD:=ini.ReadString(IniSection,'低值质控联机号','9997');

  ini.Free;

  OperateLinkFile(application.ExeName,'\'+ChangeFileExt(ExtractFileName(Application.ExeName),'.lnk'),15,autorun);
  ComPort1.Close;
  ComPort1.Port:=CommName;
  if BaudRate='1200' then
    ComPort1.BaudRate:=br1200
    else if BaudRate='4800' then
      ComPort1.BaudRate:=br4800
      else if BaudRate='9600' then
        ComPort1.BaudRate:=br9600
        else if BaudRate='19200' then
          ComPort1.BaudRate:=br19200
          else ComPort1.BaudRate:=br9600;
  if DataBit='5' then
    ComPort1.DataBits:=dbFive
    else if DataBit='6' then
      ComPort1.DataBits:=dbSix
      else if DataBit='7' then
        ComPort1.DataBits:=dbSeven
        else if DataBit='8' then
          ComPort1.DataBits:=dbEight
          else ComPort1.DataBits:=dbEight;
  if StopBit='1' then
    ComPort1.StopBits:=sbOneStopBit
    else if StopBit='2' then
      ComPort1.StopBits:=sbTwoStopBits
      else if StopBit='1.5' then
        ComPort1.StopBits:=sbOne5StopBits
        else ComPort1.StopBits:=sbOneStopBit;
  if ParityBit='None' then
    ComPort1.Parity.Bits:=prNone
    else if ParityBit='Odd' then
      ComPort1.Parity.Bits:=prOdd
      else if ParityBit='Even' then
        ComPort1.Parity.Bits:=prEven
        else if ParityBit='Mark' then
          ComPort1.Parity.Bits:=prMark
          else if ParityBit='Space' then
            ComPort1.Parity.Bits:=prSpace
            else ComPort1.Parity.Bits:=prNone;
  try
    ComPort1.Open;
  except
    showmessage('串口'+ComPort1.Port+'打开失败!');
  end;
end;

function TfrmMain.LoadInputPassDll: boolean;
TYPE
    TDLLFUNC=FUNCTION:boolean;
VAR
    HLIB:THANDLE;
    DLLFUNC:TDLLFUNC;
    PassFlag:boolean;
begin
    result:=false;
    HLIB:=LOADLIBRARY('OnOffLogin.dll');
    IF HLIB=0 THEN BEGIN SHOWMESSAGE(sCONNECTDEVELOP);EXIT; END;
    DLLFUNC:=TDLLFUNC(GETPROCADDRESS(HLIB,'showfrmonofflogin'));
    IF @DLLFUNC=NIL THEN BEGIN SHOWMESSAGE(sCONNECTDEVELOP);EXIT; END;
    PassFlag:=DLLFUNC;
    FREELIBRARY(HLIB);
    result:=passflag;
end;

function TfrmMain.GetSpecNo(const Value:string):string;//取得联机号
const
  spBs='u ';//#$D+
var
  s1Pos:integer;
  spBsLen:integer;
begin
    spBsLen:=length(spBs);
    s1Pos:=pos(LowerCase(spbs),Value);
    result:=copy(Value,s1pos+spBsLen,16);
    result:='0000'+result;
    result:=rightstr(result,4);
end;

function TfrmMain.DIFF_decode(const Value:string):string;
var
  i:integer;
begin
  for i :=1  to length(Value) do
  begin
    //if Value[i]=#$3F then CONTINUE;
    if ord(Value[i])<32 then CONTINUE;//32为空格代表的字符，按理应该是最小值了

    result:=result+' '+inttostr(ord(Value[i]));
  end;

  //while length(ss)>0 do
  //begin
  //  result:=result+' '+inttostr(ord(SS[1]));//-20
  //  delete(ss,1,1);
  //end;

  //result:=trim(result);
end;

function TfrmMain.MakeDBConn:boolean;
var
  newconnstr,ss: string;
  Label labReadIni;
begin
  result:=false;

  labReadIni:
  newconnstr := GetConnectString;
  try
    ADOConnection1.Connected := false;
    ADOConnection1.ConnectionString := newconnstr;
    ADOConnection1.Connected := true;
    result:=true;
  except
  end;
  if not result then
  begin
    ss:='服务器'+#2+'Edit'+#2+#2+'0'+#2+#2+#3+
        '数据库'+#2+'Edit'+#2+#2+'0'+#2+#2+#3+
        '集成登录模式'+#2+'CheckListBox'+#2+#2+'0'+#2+#2+#3+
        '用户'+#2+'Edit'+#2+#2+'0'+#2+#2+#3+
        '口令'+#2+'Edit'+#2+#2+'0'+#2+#2+'1';
    if ShowOptionForm('连接数据库','连接数据库',Pchar(ss),Pchar(ChangeFileExt(Application.ExeName,'.ini'))) then
      goto labReadIni else application.Terminate;
  end;
end;

procedure TfrmMain.ToolButton2Click(Sender: TObject);
var
  ss:string;
begin
  if LoadInputPassDll then
  begin
    ss:='串口选择'+#2+'Combobox'+#2+'COM1'+#13+'COM2'+#13+'COM3'+#13+'COM4'+#2+'0'+#2+#2+#3+
      '波特率'+#2+'Combobox'+#2+'19200'+#13+'9600'+#13+'4800'+#13+'2400'+#13+'1200'+#2+'0'+#2+#2+#3+
      '数据位'+#2+'Combobox'+#2+'8'+#13+'7'+#13+'6'+#13+'5'+#2+'0'+#2+#2+#3+
      '停止位'+#2+'Combobox'+#2+'1'+#13+'1.5'+#13+'2'+#2+'0'+#2+#2+#3+
      '校验位'+#2+'Combobox'+#2+'None'+#13+'Even'+#13+'Odd'+#13+'Mark'+#13+'Space'+#2+'0'+#2+#2+#3+
      '工作组'+#2+'Edit'+#2+#2+'1'+#2+#2+#3+
      '仪器字母'+#2+'Edit'+#2+#2+'1'+#2+#2+#3+
      '检验系统窗体标题'+#2+'Edit'+#2+#2+'1'+#2+#2+#3+
      '默认样本类型'+#2+'Edit'+#2+#2+'1'+#2+#2+#3+
      '默认样本状态'+#2+'Edit'+#2+#2+'1'+#2+#2+#3+
      '组合项目代码'+#2+'Edit'+#2+#2+'1'+#2+#2+#3+
      '开机自动运行'+#2+'CheckListBox'+#2+#2+'1'+#2+#2+#3+
      '调试日志'+#2+'CheckListBox'+#2+#2+'0'+#2+'注:强烈建议在正常运行时关闭'+#2+#3+
      '高值质控联机号'+#2+'Edit'+#2+#2+'2'+#2+#2+#3+
      '常值质控联机号'+#2+'Edit'+#2+#2+'2'+#2+#2+#3+
      '低值质控联机号'+#2+'Edit'+#2+#2+'2'+#2+#2+#3;

  if ShowOptionForm('',Pchar(IniSection),Pchar(ss),Pchar(ChangeFileExt(Application.ExeName,'.ini'))) then
	  UpdateConfig;
  end;
end;

procedure TfrmMain.BitBtn2Click(Sender: TObject);
begin
  Memo1.Lines.Clear;
end;

procedure TfrmMain.BitBtn1Click(Sender: TObject);
begin
  memo1.Lines.SaveToFile('c:\comm.txt');
  showmessage('保存成功!');
end;

procedure TfrmMain.Button1Click(Sender: TObject);
var
  ls:Tstrings;
  ss:string;
begin
  OpenDialog1.DefaultExt := '.txt';
  OpenDialog1.Filter := 'txt (*.txt)|*.txt';
  if not OpenDialog1.Execute then exit;
  ls:=Tstringlist.Create;
  ls.LoadFromFile(OpenDialog1.FileName);
  ss:=stringreplace(ls.Text,#13#10,#13,[rfReplaceAll]);//实际数据中#13后是没有#10的
  ComDataPacket1Packet(nil,ss);
  ls.Free;
end;

procedure TfrmMain.ToolButton5Click(Sender: TObject);
var
  ss:string;
begin
  ss:='RegisterNum'+#2+'Edit'+#2+#2+'0'+#2+'将该窗体标题栏上的字符串发给开发者,以获取注册码'+#2;
  if bRegister then exit;
  if ShowOptionForm(Pchar('注册:'+GetHDSn('C:\')+'-'+GetHDSn('D:\')+'-'+ChangeFileExt(ExtractFileName(Application.ExeName),'')),Pchar(IniSection),Pchar(ss),Pchar(ChangeFileExt(Application.ExeName,'.ini'))) then
    if ifRegister then bRegister:=true else bRegister:=false;
end;

procedure TfrmMain.ComPort1AfterOpen(Sender: TObject);
begin
//在北山此问题折腾了我，一定要注释下面两句才行(然来不是所有的都要将DTR、RTS设为true)
//  TComPort(Sender).SetDTR(true);
//  TComPort(Sender).SetRTS(true);
end;

procedure TfrmMain.ComDataPacket1Packet(Sender: TObject;
  const Str: String);
const
  BS=#$D;
  BsLen=3;
  ValLen=5;
var
  SpecNo:string;
  FInts:OleVariant;
  ReceiveItemInfo:OleVariant;
  i:integer;
  sValue:STRING;
  wbcOstr,RbcOstr,PLTOstr:string;
  wbccstrpos,rbccstrpos,PLTcstrpos:integer;
  wbccstr,RBCCSTR,PLTCSTR:string;
  //tmpPos:integer;
begin
  if length(memo1.Lines.Text)>=60000 then memo1.Lines.Clear;//memo只能接受64K个字符
  memo1.Lines.Add(Str);

  SpecNo:=GetSpecNo(Str);

  //========分解图形数据==================
  wbcOstr:='';RbcOstr:='';PLTOstr:='';

  //WBC
  wbccstrpos:=pos(BS+'W',Str);
  if wbccstrpos>0 then
  begin
    wbccstr:=Str;
    delete(wbccstr,1,wbccstrpos+1);
    WBCCSTR:=COPY(wbccstr,1,128);
    //tmpPos:=pos(BS+'X',wbccstr);
    //if tmpPos>0 then
    //begin
      //WBCCSTR:=COPY(wbccstr,1,tmpPos-1);
      wbcOstr:=DIFF_decode(wbcCstr);
    //end;
  end;

  //RBC
  rbccstrpos:=pos(BS+'X',Str);
  if rbccstrpos>0 then
  begin
    RBCCSTR:=Str;
    delete(RBCCSTR,1,rbccstrpos+1);
    RBCCSTR:=COPY(RBCCSTR,1,128);
    //tmpPos:=pos(BS+'Y',RBCCSTR);
    //if tmpPos>0 then
    //begin
    //  RBCCSTR:=COPY(RBCCSTR,1,tmpPos-1);
      RbcOstr:=DIFF_decode(RbcCstr);
    //end;
  end;

  //PLT
  PLTcstrpos:=pos(BS+'Y',Str);
  if PLTcstrpos>0 then
  begin
    PLTCSTR:=Str;
    delete(PLTCSTR,1,PLTcstrpos+1);
    PLTCSTR:=COPY(PLTCSTR,1,113);//文档中是128个点，但后面的点有些上翘，影响图形
    //tmpPos:=pos(BS+'S',PLTCSTR);
    //if tmpPos>0 then
    //begin
    //  PLTCSTR:=COPY(PLTCSTR,1,tmpPos-1);
      PLTOstr:=DIFF_decode(PLTCstr);
    //end;
  end;
  //======================================}

  ReceiveItemInfo:=VarArrayCreate([0,17],varVariant);//一次做18项

  i:=pos(BS+'! ',Str);
  sValue:=trim(ifthen(i>0,copy(Str,i+BsLen,ValLen)));
  ReceiveItemInfo[0]:=VarArrayof(['!',sValue,wbcOstr,'']);//WBC

  i:=pos(BS+'2 ',Str);
  sValue:=trim(ifthen(i>0,copy(Str,i+BsLen,ValLen)));
  ReceiveItemInfo[1]:=VarArrayof(['2',sValue,RbcOstr,'']);//RBC

  i:=pos(BS+'3 ',Str);
  sValue:=trim(ifthen(i>0,copy(Str,i+BsLen,ValLen)));
  ReceiveItemInfo[2]:=VarArrayof(['3',sValue,'','']);//HGB

  i:=pos(BS+'4 ',Str);
  sValue:=trim(ifthen(i>0,copy(Str,i+BsLen,ValLen)));
  ReceiveItemInfo[3]:=VarArrayof(['4',sValue,'','']);//HCT

  i:=pos(BS+'5 ',Str);
  sValue:=trim(ifthen(i>0,copy(Str,i+BsLen,ValLen)));
  ReceiveItemInfo[4]:=VarArrayof(['5',sValue,'','']);//MCV

  i:=pos(BS+'6 ',Str);
  sValue:=trim(ifthen(i>0,copy(Str,i+BsLen,ValLen)));
  ReceiveItemInfo[5]:=VarArrayof(['6',sValue,'','']);//MCH

  i:=pos(BS+'7 ',Str);
  sValue:=trim(ifthen(i>0,copy(Str,i+BsLen,ValLen)));
  ReceiveItemInfo[6]:=VarArrayof(['7',sValue,'','']);//MCHC

  i:=pos(BS+'8 ',Str);
  sValue:=trim(ifthen(i>0,copy(Str,i+BsLen,ValLen)));
  ReceiveItemInfo[7]:=VarArrayof(['8',sValue,'','']);//RDW

  i:=pos(BS+'@ ',Str);
  sValue:=trim(ifthen(i>0,copy(Str,i+BsLen,ValLen)));
  ReceiveItemInfo[8]:=VarArrayof(['@',sValue,PLTOstr,'']);//PLT

  i:=pos(BS+'A ',Str);
  sValue:=trim(ifthen(i>0,copy(Str,i+BsLen,ValLen)));
  ReceiveItemInfo[9]:=VarArrayof(['A',sValue,'','']);//MPV

  i:=pos(BS+'B ',Str);
  sValue:=trim(ifthen(i>0,copy(Str,i+BsLen,ValLen)));
  ReceiveItemInfo[10]:=VarArrayof(['B',sValue,'','']);//THT

  i:=pos(BS+'C ',Str);
  sValue:=trim(ifthen(i>0,copy(Str,i+BsLen,ValLen)));
  ReceiveItemInfo[11]:=VarArrayof(['C',sValue,'','']);//PDW

  i:=pos(BS+'" ',Str);
  sValue:=trim(ifthen(i>0,copy(Str,i+BsLen,ValLen)));
  ReceiveItemInfo[12]:=VarArrayof(['"',sValue,'','']);//LYM

  i:=pos(BS+'# ',Str);
  sValue:=trim(ifthen(i>0,copy(Str,i+BsLen,ValLen)));
  ReceiveItemInfo[13]:=VarArrayof(['#',sValue,'','']);//LYM%

  i:=pos(BS+'$ ',Str);
  sValue:=trim(ifthen(i>0,copy(Str,i+BsLen,ValLen)));
  ReceiveItemInfo[14]:=VarArrayof(['$',sValue,'','']);//MID

  i:=pos(BS+'% ',Str);
  sValue:=trim(ifthen(i>0,copy(Str,i+BsLen,ValLen)));
  ReceiveItemInfo[15]:=VarArrayof(['%',sValue,'','']);//MID%

  i:=pos(BS+'& ',Str);
  sValue:=trim(ifthen(i>0,copy(Str,i+BsLen,ValLen)));
  ReceiveItemInfo[16]:=VarArrayof(['&',sValue,'','']);//GRA
  
  i:=pos(BS+''' ',Str);
  sValue:=trim(ifthen(i>0,copy(Str,i+BsLen,ValLen)));
  ReceiveItemInfo[17]:=VarArrayof(['''',sValue,'','']);//GRA%
  
  if bRegister then
  begin
    FInts :=CreateOleObject('Data2LisSvr.Data2Lis');
    FInts.fData2Lis(ReceiveItemInfo,(SpecNo),'',
      (GroupName),(SpecType),(SpecStatus),(EquipChar),
      (CombinID),'',(LisFormCaption),(ConnectString),
      (QuaContSpecNoG),(QuaContSpecNo),(QuaContSpecNoD),'',
      ifRecLog,true,'常规');
    if not VarIsEmpty(FInts) then FInts:= unAssigned;
  end;
end;

initialization
    hnd := CreateMutex(nil, True, Pchar(ExtractFileName(Application.ExeName)));
    if GetLastError = ERROR_ALREADY_EXISTS then
    begin
        MessageBox(application.Handle,pchar('该程序已在运行中！'),
                    '系统提示',MB_OK+MB_ICONinformation);     //WARNING
        Halt;
    end;

finalization
    if hnd <> 0 then CloseHandle(hnd);

end.
