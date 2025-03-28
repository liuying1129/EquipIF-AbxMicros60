unit UfrmMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, LYTray, Menus, StdCtrls, Buttons,UYDComm, XPMenu, DB, Grids,
  DBGrids, ADODB, ComCtrls, ExtCtrls, ImgList,registry,AppEvnts,inifiles,
  ToolWin, LYAboutBox,CPortCtl,StrUtils, ActnList, Spin, CPort, CheckLst,AdoConEd,
  SPComm;

type
  TEdtList=array of tedit;

type
  TfrmMain = class(TForm)
    LYTray1: TLYTray;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    XPMenu1: TXPMenu;
    ADOQuery1: TADOQuery;
    ADOConnection1: TADOConnection;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    ImageList1: TImageList;
    ApplicationEvents1: TApplicationEvents;
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    LYAboutBox1: TLYAboutBox;
    ActionList1: TActionList;
    editpass: TAction;
    about: TAction;
    stop: TAction;
    TabSheet4: TTabSheet;
    Panel3: TPanel;
    BitBtn3: TBitBtn;
    Memo1: TMemo;
    TabSheet3: TTabSheet;
    Panel4: TPanel;
    Memo2: TMemo;
    Button1: TButton;
    ADOQuery_temp: TADOQuery;
    Panel1: TPanel;
    Label29: TLabel;
    Label30: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    chkboxAutorun: TCheckBox;
    cbCOMM: TComboBox;
    btnSet: TBitBtn;
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    edtBaudRate: TEdit;
    edtStopbit: TEdit;
    edtDatabit: TEdit;
    edtParity: TEdit;
    edtLisClassName: TEdit;
    edtLisFormCaption: TEdit;
    SpEdtItmeID: TEdit;
    Label8: TLabel;
    ADOConn_Test: TADOConnection;
    btnTestConnStr: TBitBtn;
    GroupBox1: TGroupBox;
    Label9: TLabel;
    edtQuaContSpecNo: TEdit;
    Label10: TLabel;
    edtQuaContMonth: TEdit;
    Label11: TLabel;
    edtQuaContyear: TEdit;
    Label12: TLabel;
    edtMainAppProfilePath: TEdit;
    ComboBox1: TComboBox;
    Label13: TLabel;
    Label14: TLabel;
    Edit1: TEdit;
    Label15: TLabel;
    Edit2: TEdit;
    Comm1: TComm;
    editcommword: TEdit;
    Label16: TLabel;
    Label_status: TLabel;
    procedure N3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    //���Ӳ�����Ϣ���м�¼,���ظü�¼��Ψһ�����Ϊ������������
    procedure addrecord(const itemid:string;var checkunid:integer); //����itemidû�õ�
    procedure addoreditvalueRecord(const checkunid:integer); //�������������ӻ�༭������������
    procedure BitBtn3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure N1Click(Sender: TObject);
    procedure ApplicationEvents1Activate(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton7Click(Sender: TObject);
    procedure btnSetClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btnTestConnStrClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Comm1ReceiveData(Sender: TObject; Buffer: Pointer;
      BufferLength: Word);
  private
    { Private declarations }
    procedure WMSyscommand(var message:TWMMouse);message WM_SYSCOMMAND;
    procedure ReadConfig;
    procedure WriteConfig;
    procedure UpdateConfig;{�����ļ���Ч}
    function LoadInputPassDll:boolean;
    function getmaxlsh:string;
    procedure alledittrue;
    procedure alleditfalse;
//    function GetChkItemNum(MainItemID:integer):integer;//��������ĿID�õ�������Ŀ������ϸ��Ŀ��Ŀ
    //function GetMaxUnid: integer;
//    procedure combinchecklistbox(CheckListBox:TCheckListBox);
  public
    { Public declarations }
    PROCEDURE UPDATEPANEL;
    procedure SaveDatatoDB(var valetudinarianInfoId:integer);
    procedure ReadMachineItem(itemid:string);//��ȡָ��������Ŀ��������Ϣ
//    PROCEDURE ReadCalcItem(itemid:integer);   //��ȡָ��������Ŀ��������Ϣ
//    procedure ReplaceCalaExpress(valetudinarianInfoId:integer);
//    function CreateEdt(MainItemID,RecordNum: integer): TEdtList;
//    procedure WriteToEdt(valetudinarianInfoId,itemid,RecordNum:integer;
//                    edtchkitem:TEdtList);//��̬������Edit��д����
    procedure SendMsgToLIS(const valetudinarianInfoId:integer);
    procedure SaveDataToQuaContDB;
  end;

var
  frmMain: TfrmMain;
  lycomport:Tlycomport;
  hnd:integer;

    MachineItemCount:integer; //����ϸ��Ŀ����
    Machine_ItemValu:array of string; //ÿ��������Ŀ��ֵ
    PKItemID:string; //����Ŀ���,�������ļ��ж�ȡ
    Machine_specNo:string; //�걾��

    //=========������Ŀ��itemmachine�����ֶ���Ϣ========
    Machine_itemid:array of string;//��ʾ���  //��UYDCOMM��Ԫ��Ҫ�õ����ʶ���Ϊȫ�ֱ���
    Machine_english_name:array of string;
    Machine_name:array of string;
    Machine_unit_str:array of string;
    Machine_minvalue:array of string;
    Machine_maxvalue:array of string;
    Machine_pritorder:array of integer;
    Machine_Getmoney:array of single;
    //Machine_valuetype:ARRAY OF STRING;
    Machine_unid:array of integer;
    //Machine_defaultValue:array of string;
    Machine_pkcombin_id:array of string;
    //Machine_COMMWORD:ARRAY OF STRING;
    Machine_machinekeyword:array of string;
    Machine_Histogram:array of String;
    //====================================================

implementation

uses umyconst,ucommfunction,Parser, DESCrypt;

const
  CR=#$D+#$A;
  STX=#$2;ETX=#$3;ACK=#$6;NAK=#$15;
var
    max_channelNo:integer;//���Ļ�����Ŀͨ����
    CalcItemCount:integer; //����ϸ��Ŀ����

    //=========������Ŀ��cacuitem�����ֶ���Ϣ===========
    Calc_english_name:array of string;
    Calc_name:array of string;
    Calc_unit_str:array of string;
    Calc_minvalue:array of string;
    Calc_maxvalue:array of string;
    Calc_pritorder:array of string;
    Calc_Getmoney:array of single;
    Calc_unid:array of integer;
    calc_express:array of string;//������ʽ
    //====================================================

{$R *.dfm}

procedure TfrmMain.FormCreate(Sender: TObject);
var
  ctext        :string;
  reg          :tregistry;
  AppPath2:string;
  newconnstr: string;
  userid, password, datasource, initialcatalog, provider: string;
  ConfigIni:tinifile;
begin
  AppPath2:=ExtractFilePath(application.ExeName);

  ConfigIni := tinifile.Create(apppath2 + 'AppProfile.ini');

  //=======================��ȡLIS���Ӳ���========================//
  provider := configini.ReadString('SystemPassword', 'AA', '');
  provider := DeCryptStr(provider, 'YIDA'); //����
  datasource := configini.ReadString('SystemPassword', 'BB', ''); //��¼ADO�����ַ���
  datasource := DeCryptStr(datasource, 'YIDA'); //����
  initialcatalog := configini.ReadString('SystemPassword', 'CC', ''); //��¼ADO�����ַ���
  initialcatalog := DeCryptStr(initialcatalog, 'YIDA'); //����
  userid := configini.ReadString('SystemPassword', 'DD', ''); //��¼ADO�����ַ���
  userid := DeCryptStr(userid, 'YIDA'); //����
  password := configini.ReadString('SystemPassword', 'EE', ''); //��¼ADO�����ַ���
  password := DeCryptStr(password, 'YIDA'); //����

  newconnstr := newconnstr + 'user id=' + UserID + ';';
  newconnstr := newconnstr + 'password=' + Password + ';';
  newconnstr := newconnstr + 'data source=' + datasource + ';';
  newconnstr := newconnstr + 'provider=' + provider + ';';
  newconnstr := newconnstr + 'Initial Catalog=' + initialcatalog + ';';
  try
    ADOConnection1.Connected := false;
    //ADOConnection1.ConnectionString :=''
    ADOConnection1.ConnectionString := newconnstr;
    //ADOConnection1.ConnectionString :='Provider=SQLOLEDB.1;Password="";Persist Security Info=True;User ID=sa;Initial Catalog=Clinic2004zj;Data Source=.';
    ADOConnection1.Connected := true;
  except
    Application.MessageBox('���򿪷�����ѯע�ᣡ', 'ϵͳ��ʾ', MB_ICONWARNING + MB_ok);
    //APPLICATION.Terminate;
  end;
  //==============================================================//

//  lycomport:=tlycomport.Create(application);
//  ComLedRx.ComPort:=lycomport.dllo;
//  comledtx.ComPort:=lycomport.dllo;

  AppPath:=extractfilepath(paramstr(0));

  ReadConfig;{��ȡ�����ļ�};

  UpdateConfig;{�����ļ���Ч}

  IF cbCOMM.Text='' THEN cbCOMM.ItemIndex:=0; {��ʼ��������Ͽ�--ѡ�񴮿�}
  PageControl1.ActivePageIndex:=0;
  lytray1.Hint:='���ݽ��շ���'+sLinkFile;
   //lytray1.Hint:=sLinkFile;
//=============================��ʼ������=====================================//
    reg:=tregistry.Create;
    reg.RootKey:=HKEY_CURRENT_USER;
    reg.OpenKey('\sunyear',true);
    ctext:=reg.ReadString('pass');
    if ctext='' then
    begin
        reg:=tregistry.Create;
        reg.RootKey:=HKEY_CURRENT_USER;
        reg.OpenKey('\sunyear',true);
        reg.WriteString('pass',cryptstr(sPASSOPEN,0));
        MessageBox(application.Handle,pchar('��л��ʹ�����Ƽ����ܼ��ϵͳ��'+chr(13)+'���ס��ʼ�����룺'+sPASSOPEN),
                    'ϵͳ��ʾ',MB_OK+MB_ICONinformation);     //WARNING
    end;
    reg.CloseKey;
    reg.Free;
//============================================================================//
end;

procedure TfrmMain.ReadMachineItem(itemid: string);
Var
    i:integer;
begin
    adoquery1.Close;
    adoquery1.SQL.Clear;
    adoquery1.SQL.Text:='select clinicchkitem.*,tmptable.combinitem as combinitemid '+
                        'from clinicchkitem,(select *  from clinicchkitem tmp where tmp.combinitem is not null) tmptable '+
                        ' where  clinicchkitem.COMMWORD=:p_COMMWORD '+  //������ĸ�������豸
                        //' and itemtype=:P_itemtype '
                        ' and clinicchkitem.dlttype=''2'' '+      //������Ŀ
                        //' and (clinicchkitem.combinitem='''' or clinicchkitem.combinitem is  null )'+   //�����Ŀ��Ϊ��
                        ' and clinicchkitem.itemid = tmptable.itemid  ';

    {adoquery1.SQL.Text:='select * from clinicchkitem '+
                        ' where  COMMWORD=:p_COMMWORD '+  //������ĸ�������豸
                        //itemtype=:P_itemtype
                        //' and  '+
                        ' and dlttype=''2'' '+      //������Ŀ
                        ' and combinitem IS NOT NULL '+//�����Ŀ��Ϊ��
                        ' order by unid ASC '; }
    adoquery1.Parameters.ParamByName('p_COMMWORD').Value:=trim(editcommword.text);//'R';
    //adoquery1.Parameters.ParamByName('p_caculexpress').Value:='';
    //adoquery1.SQL.Text := 'select * from clinicchkitem where  dlttype=2 ';
    adoquery1.Open;
    machineitemcount:=adoquery1.RecordCount;//�õ�ָ������ϸ��Ŀ������
    if   machineitemcount = 0 then
    begin
    MessageBox(application.Handle,pchar('�������û������ݣ�'),
                    'ϵͳ��ʾ',MB_OK+MB_ICONinformation);     //WARNING

    end else
    begin
    end;
    //machineitemcount:=10;
    setlength(machine_itemid,machineitemcount);
    setlength(Machine_english_name,MachineItemCount);
    setlength(Machine_name,MachineItemCount);
    setlength(Machine_unit_str,MachineItemCount);
    setlength(Machine_minvalue,MachineItemCount);
    setlength(Machine_maxvalue,MachineItemCount);
    setlength(Machine_pritorder,MachineItemCount);
    setlength(Machine_Getmoney,MachineItemCount);
    setlength(Machine_unid,MachineItemCount);
    setlength(Machine_pkcombin_id,MachineItemCount);
    //setlength(Machine_COMMWORD,MachineItemCount);
    setlength(Machine_machinekeyword,MachineItemCount);
    Setlength(Machine_histogram,MachineItemCount);
    //machinekeyword

    I:=0;
    adoquery1.First;
    while not adoquery1.Eof do
    begin
      machine_itemid[i]:=TRIM(adoquery1.fieldbyname('itemid').AsString);
      Machine_unid[i]:=adoquery1.fieldbyname('unid').AsInteger;
      Machine_english_name[i]:=TRIM(adoquery1.fieldbyname('english_name').AsString);
      //Machine_english_name[i]:=UPPERCASE(Machine_english_name[i]);//��д
      Machine_name[i]:=adoquery1.fieldbyname('name').AsString;
      Machine_unit_str[i]:=adoquery1.fieldbyname('unit').AsString;
      //Machine_minvalue[i]:=adoquery1.fieldbyname('minvalue').AsString;
      //Machine_maxvalue[i]:=adoquery1.fieldbyname('maxvalue').AsString;
      Machine_pritorder[i]:=adoquery1.fieldbyname('printorder').AsInteger;
      Machine_Getmoney[i]:=strtofloatdef(adoquery1.fieldbyname('price').asstring,0);
      //Machine_pkcombin_id[i]:=adoquery1.fieldbyname('combinitem').AsString;
      //Machine_COMMWORD[I]:=adoquery1.fieldbyname('COMMWORD').AsString;
      //Machine_COMMWORD[I]:=trim(SpEdtItmeID.text);
      Machine_machinekeyword[I]:=adoquery1.fieldbyname('machinekeyword').AsString;
      INC(I);
      adoquery1.Next;
    end;
    adoquery1.Close;
end;

procedure TfrmMain.SaveDatatoDB(var valetudinarianInfoId:integer);
//valetudinarianInfoIdΪ���˻�����Ϣ���еġ��Զ����ӵ�Ψһ��š��ֶ�ֵ
Begin
  ADOQuery1.Close;
  ADOQuery1.SQL.Clear;
  ADOQuery1.SQL.Text:='select * from chk_con where checkid=:P_checkid and '+
                        'check_date=:P_check_date ';//and combin_id=:P_combin_id';
  ADOQuery1.Parameters.ParamByName('P_checkid').Value:=Machine_specNo;
  ADOQuery1.Parameters.ParamByName('P_check_date').Value:=date;
  //adoquery1.Parameters.ParamByName('P_combin_id').Value:=sITEMTYPE;
  ADOQuery1.Open;
  if ADOQuery1.RecordCount>0 then //�иò��˻�����Ϣ�����
  begin
    valetudinarianInfoId:=adoquery1.fieldbyname('unid').AsInteger;
  end else               //û�иò��˻�����Ϣ�����
  begin
    addrecord(PKItemID,valetudinarianInfoId); //���Ӳ�����Ϣ���м�¼
  end;
  addoreditvalueRecord(valetudinarianInfoId);   //���ӻ�༭���������м�¼
  //addOrEditCalcValu(valetudinarianInfoId);  //�������������ӻ�༭������������
end;

procedure TfrmMain.addrecord(const itemid:string;var checkunid:integer); //���Ӳ�����Ϣ���м�¼
var                //����itemidû�õ�
  unid:integer;

  deptname:string;
  flagetype:string;
  typeflagcase:string;
  check_doctor:string;
  chkstatus:string;
  ConfigIni: tinifile;
  lsh:string;
begin
        lsh:=getmaxlsh;

  //============Ĭ��ֵ====================================//
  ConfigIni := tinifile.Create(trim(edtMainAppProfilePath.Text));
  deptname:=ConfigIni.ReadString('DefaultValetInfo','deptname','');
  flagetype:=ConfigIni.ReadString('DefaultValetInfo','flagetype','');
  typeflagcase:=ConfigIni.ReadString('DefaultValetInfo','typeflagcase','');
  check_doctor:=ConfigIni.ReadString('DefaultValetInfo','check_doctor','');
  chkstatus:=ConfigIni.ReadString('DefaultValetInfo','chkstatus','');
  ConfigIni.Free;
  //======================================================//

    ADOQuery1.Close;
    ADOQuery1.SQL.Clear;
    ADOQuery1.SQL.Text:='Insert into chk_con (checkid,check_date,combin_id,patientname,'+
    'report_date,sex,deptname,check_doctor,Diagnosetype,flagetype,typeflagcase,lsh,printtimes )'+
    ' values (:P_checkid,:P_check_date,:p_combin_id,:P_patientname,'+
    ':P_report_date,:P_sex,:P_deptname,:P_check_doctor,:P_Diagnosetype,:P_flagetype,:P_typeflagcase,:P_lsh,:p_printtimes )';
    ADOQuery1.Parameters.ParamByName('P_checkid').Value:=Machine_specNo ;
    ADOQuery1.Parameters.ParamByName('P_check_date').Value:=date ;
    ADOQuery1.Parameters.ParamByName('p_combin_id').Value:=sITEMTYPE ;
    ADOQuery1.Parameters.ParamByName('P_patientname').Value:='' ;
    ADOQuery1.Parameters.ParamByName('P_report_date').Value:=date ;
    ADOQuery1.Parameters.ParamByName('P_sex').Value:='��' ;
    ADOQuery1.Parameters.ParamByName('P_deptname').Value:=deptname ;
    ADOQuery1.Parameters.ParamByName('P_check_doctor').Value:=check_doctor ;
    ADOQuery1.Parameters.ParamByName('P_Diagnosetype').Value:=chkstatus ;
    ADOQuery1.Parameters.ParamByName('P_flagetype').Value:=flagetype ;
    ADOQuery1.Parameters.ParamByName('P_typeflagcase').Value:=typeflagcase ;
    ADOQuery1.Parameters.ParamByName('P_lsh').Value:=lsh ;
    ADOQuery1.Parameters.ParamByName('p_printtimes').Value:=0 ;
    adoquery1.ExecSQL;

    ADOQuery1.Close;
    ADOQuery1.SQL.Clear;
    ADOQuery1.SQL.Text:='select * from chk_con '+
                        ' where checkid=:P_checkid '+
                        //' and combin_id=:P_combin_id '+
                        ' and check_date=:P_check_date ';
    ADOQuery1.Parameters.ParamByName('P_checkid').Value:=Machine_specNo ;
    ADOQuery1.Parameters.ParamByName('P_check_date').Value:=date ;
    //ADOQuery1.Parameters.ParamByName('P_combin_id').Value:=sITEMTYPE ;
    adoquery1.Open;
    if adoquery1.RecordCount=0 then
    begin
      showmessage('���������������뿪������ϵ!');//�ող�����Ҳ����ˣ����Ǽ�������
      application.Terminate;
    end else
    begin
      checkunid:=adoquery1.fieldbyname('unid').AsInteger;
    end;

    //checkunid:=unid+1;
end;

procedure TfrmMain.addoreditvalueRecord(const checkunid:integer); //�������������ӻ�༭������������
Var
    i,J:integer;

    pitemid:string;
    Pcheckunid : integer;
    Pdtltype : integer;
    Punid : integer;
    Penglish_name : string;
    Pitemvalue : string;
    PCheck_date : TDatetime;
    PName : string;
    PUnit : string;
    PMin_value : string;
    PMax_value : string;
    PGetmoney : real;
    Pprintorder : integer;
    ppkcombin_id:string;
    Ppkunid:integer;
    PCOMMWORD:STRING;
begin
      Ppkunid:=checkunid ;
      Pdtltype:=2 ;  //������Ŀ
      pCheck_date:=date;
      for i :=0  to MachineItemCount-1 do
      begin
        pitemvalue:=Machine_ItemValu[i];
        //Punid:=Machine_unid[i];
        //penglish_name:=Machine_english_name[i];
        //pName:=Machine_name[i];
        //pUnit:=Machine_unit_str[i];
        //pMin_value:=Machine_minvalue[i];
        //pMax_value:=Machine_maxvalue[i];
        //Pprintorder:=Machine_pritorder[i];
        //pGetmoney:=Machine_Getmoney[i];

        pitemid:=machine_itemid[i];
        punid:=Machine_unid[i];
        penglish_name:=Machine_english_name[i];
        pname:=Machine_name[i];
        punit:=Machine_unit_str[i];
        pMin_value:=Machine_minvalue[i];
        pMax_value:=Machine_maxvalue[i];
        Pprintorder:=Machine_pritorder[i];
        pGetmoney:=Machine_Getmoney[i];
        ppkcombin_id:=Machine_pkcombin_id[i];
        //PCOMMWORD:=Machine_COMMWORD[I];

        adoquery1.Close;
        adoquery1.SQL.Clear;
        adoquery1.SQL.Text:='select * from chk_valu where itemid=:p_itemid '+
                            ' and pkunid='+inttostr(checkunid)+
                            ' and pkcombin_id=:P_pkcombin_id ';//+
        adoquery1.Parameters.ParamByName('p_itemid').Value:=machine_itemid[i];
        adoquery1.Parameters.ParamByName('P_pkcombin_id').Value:=Machine_pkcombin_id[i];
        adoquery1.Open;

        if adoquery1.RecordCount>0 then   //�����������иü���ֵ��������޸�
        begin
          if pitemvalue<>'' then
          begin
            ADOQUERY1.Edit;
            ADOQUERY1.FieldByName('itemvalue').AsString:=pitemvalue;
            if uppercase(penglish_name)='WBC' THEN
            BEGIN
              ADOQUERY1.FieldByName('Histogram').AsString:=WBCOSTR;
            END;
            if uppercase(penglish_name)='RBC' THEN
            BEGIN
              ADOQUERY1.FieldByName('Histogram').AsString:=RBCOSTR;
            END;
            if uppercase(penglish_name)='PLT' THEN
            BEGIN
              ADOQUERY1.FieldByName('Histogram').AsString:=PLTOSTR;
            END;
            ADOQUERY1.Post;
          end;
        end else                          //����������û�иü���ֵ����������
        begin
          if pitemvalue<>'' then   //ȫ������(����������ļ�����Ŀ���ֹ���Ŀ)
          begin
            ADOQUERY1.Close;
            ADOQUERY1.Sql.Clear;
            ADOQUERY1.Sql.text:=
            'Insert into chk_valu ('+
            ' pkunid,pkcombin_id,itemid,COMMWORD,english_name,itemvalue,Name,Unit,Getmoney,printorder,Histogram) values ('+
            ':P_pkunid,:P_pkcombin_id,:P_itemid,:p_COMMWORD,:P_english_name,:P_itemvalue,:P_Name,:P_Unit,:P_Getmoney,:P_printorder,:p_Histogram) ';
            {'Insert into chk_valu ('+
            ' pkunid,pkcombin_id,itemid,COMMWORD,english_name,itemvalue,Name,Unit,Min_value,Max_value,Getmoney,printorder,Histogram) values ('+
            ':P_pkunid,:P_pkcombin_id,:P_itemid,:p_COMMWORD,:P_english_name,:P_itemvalue,:P_Name,:P_Unit,:P_Min_value,:P_Max_value,:P_Getmoney,:P_printorder,:p_Histogram) ';}
            ADOQUERY1.Parameters.ParamByName('P_pkunid').Value:=Ppkunid ;
            ADOQUERY1.Parameters.ParamByName('P_pkcombin_id').Value:=Ppkcombin_id ;
            ADOQUERY1.Parameters.ParamByName('P_itemid').Value:=Pitemid ;
            ADOQUERY1.Parameters.ParamByName('P_english_name').Value:=Penglish_name;
            ADOQUERY1.Parameters.ParamByName('P_itemvalue').Value:=Pitemvalue ;
            ADOQUERY1.Parameters.ParamByName('P_Name').Value:=PName ;
            ADOQUERY1.Parameters.ParamByName('P_Unit').Value:=PUnit ;
            //ADOQUERY1.Parameters.ParamByName('P_Min_value').Value:=PMin_value ;
            //ADOQUERY1.Parameters.ParamByName('P_Max_value').Value:=PMax_value ;
            ADOQUERY1.Parameters.ParamByName('P_Getmoney').Value:=PGetmoney ;
            ADOQUERY1.Parameters.ParamByName('P_printorder').Value:=Pprintorder ;
            ADOQUERY1.Parameters.ParamByName('p_COMMWORD').Value:=trim(editcommword.text);//'R' ;
            if uppercase(penglish_name)='WBC' THEN
            BEGIN
              ADOQUERY1.Parameters.ParamByName('p_Histogram').Value:=WBCOSTR ;
            END ELSE
              if uppercase(penglish_name)='RBC' THEN
              BEGIN
                ADOQUERY1.Parameters.ParamByName('p_Histogram').Value:=RBCOSTR;
              END ELSE
                if uppercase(penglish_name)='PLT' THEN
                BEGIN
                  ADOQUERY1.Parameters.ParamByName('p_Histogram').Value:=PLTOSTR;
                END ELSE ADOQUERY1.Parameters.ParamByName('p_Histogram').Value:='';
            Try
              ADOQUERY1.EXECSql ;
            except
              Application.MessageBox('��ͨ�������洢ʧ��!','ϵͳ��ʾ',MB_ICONWARNING);
            End;
          end;
        end;
      end;
end;

procedure TfrmMain.BitBtn3Click(Sender: TObject);
begin
  if fileexists(apppath+'CommErr.log') then
    memo1.Lines.LoadFromFile(apppath+'commerr.log');
end;

procedure TfrmMain.UPDATEPANEL;
begin
//
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    //if LoadInputPassDll then action:=cafree else action:=caNone;
end;

procedure TfrmMain.N3Click(Sender: TObject);
begin
//    if not LoadInputPassDll then exit;
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

procedure TfrmMain.ToolButton1Click(Sender: TObject);
TYPE
    TDLLProce=procedure;
VAR
   HLIB:THANDLE;
   DLLproce:TDLLproce;
begin
   HLIB:=LOADLIBRARY('ModifyPass.dll');
   IF HLIB=0 THEN BEGIN SHOWMESSAGE(sCONNECTDEVELOP);EXIT; END;
   DLLproce:=TDLLproce(GETPROCADDRESS(HLIB,'showModifyPass'));
   IF @DLLproce=NIL THEN BEGIN SHOWMESSAGE(sCONNECTDEVELOP);EXIT; END;
   DLLproce;
   FREELIBRARY(HLIB);
end;

procedure TfrmMain.ToolButton7Click(Sender: TObject);
begin
  LYAboutBox1.ProcuctName:='���ܼ��ϵͳ(for ABX micros60 OT';
  LYAboutBox1.Version:='Version:2005.12';
  LYAboutBox1.Copyright:='��Ȩ����,�Ͻ������룬�����';
  LYAboutBox1.Comments:='�㶫���ҽ�ƿƼ����޹�˾';
  LYAboutBox1.Author:='����� (020)87072388  fax:(020)87072366';
  LYAboutBox1.WebPage:='edasys@21cn.net';
  LYAboutBox1.Execute;
end;

procedure TfrmMain.ReadConfig;
var
  configini:tinifile;
begin
  CONFIGINI:=TINIFILE.Create(apppath+'AppProfile.ini');

  cbcomm.ItemIndex:=configini.ReadInteger('CommPort','Port',1)-1;
  edtBaudRate.Text:=inttostr(configini.ReadInteger('commport','baudrate',9600));
  edtDatabit.Text:=inttostr(configini.ReadInteger('commport','DataBit',8));
  edtStopbit.Text:=inttostr(configini.ReadInteger('commport','StopBit',1));
  edtParity.Text:=inttostr(configini.ReadInteger('commport','Parity',3));

  editcommword.Text:=configini.ReadString('item','word','A');
  SpEdtItmeID.Text:=configini.ReadString('item','id','');
  chkboxautorun.Checked:=configini.readBool('position','autorun',false);
  edtQuaContSpecNo.Text:=configini.ReadString('position','QuaContSpecNo','9999');
  EDIT1.Text:=configini.ReadString('position','QuaContSpecNoH','9999');
  EDIT2.Text:=configini.ReadString('position','QuaContSpecNoL','9999');
  combobox1.ItemIndex:=configini.ReadInteger('position','QuaContType',0);
  //edtQuaContyear.text:=configini.ReadString('position','QuaContyear','2003');
  //edtQuaContmonth.text:=configini.ReadString('position','QuaContmonth','');
  edtMainAppProfilePath.Text:=configini.ReadString('position','MainAppProfilePath','');

  edtLisClassName.Text:=configini.ReadString('Message','ClassName','TFRMMAIN');
  edtLisFormCaption.Text:=configini.ReadString('Message','FormCaption','LC_LIS');

  configini.Free;
end;

procedure TfrmMain.WriteConfig;
VAR
  ConfigIni:tinifile;
begin
  ConfigIni:=tinifile.Create(apppath+'AppProfile.ini');

  configini.WriteInteger('CommPort','Port',cbComm.ItemIndex+1); {��¼ͨ�Ŷ˿�}
  configini.WriteInteger('CommPort','BaudRate',strtointdef(edtBaudRate.Text,9600)); {��¼ͨ�Ŷ˿�}
  configini.WriteInteger('CommPort','DataBit',strtointdef(edtDataBit.Text,8)); {��¼ͨ�Ŷ˿�}
  configini.WriteInteger('CommPort','StopBit',strtointdef(edtStopBit.Text,1)); {��¼ͨ�Ŷ˿�}
  configini.WriteInteger('CommPort','Parity',strtointdef(edtParity.Text,3)); {��¼ͨ�Ŷ˿�}

  configini.Writestring('Item','word',trim(editcommword.Text)); {������ĸ}
  configini.WriteString('Item','ID',trim(SpEdtItmeID.text)); {��¼��ĿID}
  configini.WriteBool('position','autorun',chkboxAutorun.Checked);{��¼�����Ƿ��Զ�����}
  configini.Writestring('position','QuaContSpecNo',UPPERCASE(TRIM(edtQuaContSpecNo.Text)));{��¼�����Ƿ��Զ�����}
  configini.Writestring('position','QuaContSpecNoH',UPPERCASE(TRIM(EDIT1.Text)));{��¼�����Ƿ��Զ�����}
  configini.Writestring('position','QuaContSpecNoL',UPPERCASE(TRIM(EDIT2.Text)));{��¼�����Ƿ��Զ�����}
  configini.WriteInteger('position','QuaContType',combobox1.ItemIndex);{��¼�����Ƿ��Զ�����}
  //configini.Writestring('position','QuaContyear',edtQuaContyear.Text);{��¼�����Ƿ��Զ�����}
  //configini.Writestring('position','QuaContmonth',edtQuaContmonth.Text);{��¼�����Ƿ��Զ�����}
  configini.Writestring('position','MainAppProfilePath',edtMainAppProfilePath.Text);{��¼�����Ƿ��Զ�����}

  configini.WriteString('Message','ClassName',edtLisClassName.Text);
  configini.WriteString('Message','FormCaption',edtLisFormCaption.Text);

  configini.Free;
end;

procedure TfrmMain.UpdateConfig;        
begin
  PKItemID:=trim(SpEdtItmeID.text);
  //lycomport.openport(cbcomm.ItemIndex+1,strtointdef(edtBaudRate.Text,9600),
  //      strtointdef(edtDataBit.Text,8),strtointdef(edtStopBit.Text,1),
  //      strtointdef(edtParity.Text,3));
  OperateLinkFile(application.ExeName,sLinkFile,15,chkboxAutorun.Checked);
  comm1.StopComm;
  comm1.CommName:=trim(cbcomm.Text);
  comm1.StartComm;
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

procedure TfrmMain.btnSetClick(Sender: TObject);
begin
  if LoadInputPassDll then
  begin
    alledittrue;
    
    btnset.Enabled:=false;
    btnok.Enabled:=true;
    btncancel.Enabled:=true;
  end;
end;

procedure TfrmMain.btnCancelClick(Sender: TObject);
begin
    alleditFALSE;

  btnset.Enabled:=true;
  btnok.Enabled:=false;
  btncancel.Enabled:=false;
  
  ReadConfig;{��ȡ�����ļ�};
end;

procedure TfrmMain.btnOKClick(Sender: TObject);
begin
    alleditFALSE;

  btnset.Enabled:=true;
  btnok.Enabled:=false;
  btncancel.Enabled:=false;

  WriteConfig;   {д�����ļ�}

  UpdateConfig;{�����ļ���Ч}
end;

{function TfrmMain.GetChkItemNum(MainItemID: integer): integer;
//�õ�ָ����Ŀ�����������л���ϸ��Ŀ������
begin
  ADOQuery1.Close;
  ADOQuery1.SQL.Clear;
  adoquery1.SQL.Text:='select count(*) as ��Ŀ���� from itemmachine where pkitemid='
                        +inttostr(MainItemID);
  ADOQuery1.Open;
  result:=adoquery1.FieldByName('��Ŀ����').AsInteger;
  ADOQuery1.Close;
end;    }

{function TfrmMain.CreateEdt(MainItemID,RecordNum: integer): TEdtList;
var
  i              :integer;
  LabWidth       :integer;
  Lablist        :array of string;
  unid           :array of integer;
  labChkItem     :array of tlabel;
  sclboxchkitem  :tscrollbox;
begin
  setlength(lablist,recordnum);

  //=�ҳ���������һ������¼���(labwidth) ���������б�LABLIST��===========//
  ADOQuery1.Close;
  ADOQuery1.SQL.Clear;
  adoquery1.SQL.Text:='select unid,name,editchannelno from itemmachine where pkitemid='
                        +inttostr(MainItemID)+' order by editchannelno ASC ';
  ADOQuery1.Open;

  i:=0;
  ADOQuery1.First;
  while not ADOQuery1.Eof do
  begin
    if length(ADOQuery1.fieldbyname('name').asstring)>LabWidth then
      labwidth:=length(ADOQuery1.fieldbyname('name').asstring);
    lablist[i]:=ADOQuery1.fieldbyname('name').AsString;
    inc(i);
    ADOQuery1.Next;
  end;
  ADOQuery1.Close;
  labwidth:=labwidth*7;   //һ��Ӣ���ַ��Ŀ��Ϊ7PIX
  //==========================================================================//

  //===============��̬����SCROLLBOX��������LABEL��EDIT=======================//
  if sclboxchkitem<>nil then sclboxchkitem:=nil;
  sclboxchkitem:=tscrollbox.Create(self);
  sclboxchkitem.Parent:=Tabsheet1;
  sclboxchkitem.Align:=alclient;
  //==========================================================================//

  //===============��̬����LABEL��EDIT========================================//
  setlength(labChkItem,RecordNum);
  setlength(result,RecordNum);
  for i :=0  to RecordNum-1 do
  begin
    labChkItem[i]:=TLabel.Create(sclboxchkitem);
    labchkitem[i].Parent:=sclboxchkitem;
    LABCHKITEM[I].Left:=10;
    LABCHKITEM[I].Top:=(I+1)*13*2;
    LABCHKITEM[I].AutoSize:=FALSE;
    LABCHKITEM[I].Alignment:=taRightJustify;
    LABCHKITEM[I].Width:=LABWIDTH;
    LABCHKITEM[I].Caption:=lablist[i];

    result[i]:=tedit.Create(sclboxchkitem);
    result[i].Parent:=sclboxchkitem;
    result[i].Left:=10+labwidth+3;
    result[i].Top:=(I+1)*13*2;
    result[I].Color:=clInfoBk;
    result[I].Enabled:=false;
    result[I].Ctl3D:=FALSE;
  end;
  //==========================================================================//
end;   }

{procedure TfrmMain.WriteToEdt(valetudinarianInfoId,itemid,RecordNum:integer;
                                                        edtchkitem:TEdtList);
{��̬������Edit��д����,valetudinarianInfoIdΪ�ò��˵�Ψһ��ţ��ֶ����ɣ�,
itemidΪ����Ŀid��recordnumΪ������Ŀ��ϸ��Ŀ����}
{var
  checkunid:integer;
  unid:array of integer;
  i:integer;
begin
    ADOQuery1.Close;
    ADOQuery1.SQL.Clear;
    ADOQuery1.SQL.Text:='select * from itemmachine where pkitemid='
                        +inttostr(ITEMID)+'order by editchannelno ASC';
    ADOQuery1.Open;

    setlength(unid,RecordNum);
    i:=0;
    while not ADOQuery1.Eof do   //��ϸ��Ŀ��Ψһ��ű�����UNID������
    begin
      unid[i]:=ADOQuery1.fieldbyname('unid').AsInteger; //unidΪclinicchkitem(ϸ��Ŀ)��Ψһ���
      ADOQuery1.Next;
      INC(I);
    end;

    i:=0;
    while i<RecordNum do
    begin
      ADOQuery1.Close;
      ADOQuery1.SQL.Clear;
      ADOQuery1.SQL.Text:='select itemvalue from chk_valu where'+
                        ' checkunid=:P_checkunid and unid=:P_Unid';
      ADOQuery1.Parameters.ParamByName('P_checkunid').Value:=valetudinarianInfoId;
      ADOQuery1.Parameters.ParamByName('P_Unid').Value:=unid[i];
      ADOQuery1.Open;

      edtchkitem[i].Text:=ADOQuery1.fieldbyname('itemvalue').AsString;
      inc(i);
    end;
    ADOQuery1.Close;
end;   }

procedure TfrmMain.Button1Click(Sender: TObject);
VAR
  I:INTEGER;
  linenum:integer;
  sendstr:string;
begin
  sendstr:='';
  LineNum:=manystr(CR,MEMO2.Text)+1;
  for I :=0  to LineNum-1 do
  begin
    sendstr:=sendstr+trim(memo2.Lines[i])+CR;
  end;
  sendstr:=STX+sendstr+ETX;
  RFM:=sendstr;
  lycomport.RECDATA(self,sendstr);

          //ReadMachineItem(pkitemid); //�õ���ǰ������Ŀ��������Ϣ,������ʾ���itemid��ScoutIIGetItemValuҪ�õ�
          //ScoutIIGetItemValue;
          //frmMain.SaveDatatoDB(valetudinarianInfoId);
          //frmMain.SendMsgToLIS(valetudinarianInfoId);


end;

{procedure TfrmMain.ReadCalcItem(itemid: integer);
//itemidΪ����Ŀ�Զ������ֶ�ֵ��
Var
    i:integer;
begin
    adoquery1.Close;
    adoquery1.SQL.Clear;
    adoquery1.SQL.Text:='select * from cacuitem where pkitemid='
                        +inttostr(itemid)+'order by unid ASC';
    adoquery1.Open;
    CalcItemCount:=adoquery1.RecordCount;//�ô���Ŀ�����ļ�����Ŀ��Ŀ

    setlength(Calc_english_name,CalcItemCount);//������Ŀ��Ӣ����
    setlength(Calc_name,CalcItemCount);        //������Ŀ������
    setlength(Calc_unit_str,CalcItemCount);    //������Ŀ�ĵ�λ
    setlength(Calc_minvalue,CalcItemCount);    //������Ŀ����Сֵ
    setlength(Calc_maxvalue,CalcItemCount);    //������Ŀ�����ֵ
    setlength(Calc_pritorder,CalcItemCount);   //������Ŀ�Ĵ�ӡ���
    setlength(Calc_Getmoney,CalcItemCount);    //������Ŀ�ļ۸�
    setlength(Calc_unid,CalcItemCount);        //������Ŀ��Ψһ���
    setlength(calc_express,CalcItemCount);     //������Ŀ�ļ�����ʽ

    I:=0;
    adoquery1.First;
    while not adoquery1.Eof do
    begin
      Calc_unid[i]:=adoquery1.fieldbyname('unid').AsInteger;
      Calc_english_name[i]:=adoquery1.fieldbyname('english_name').AsString;
      Calc_name[i]:=adoquery1.fieldbyname('name').AsString;
      Calc_unit_str[i]:=adoquery1.fieldbyname('unit').AsString;
      Calc_minvalue[i]:=adoquery1.fieldbyname('min_value').AsString;
      Calc_maxvalue[i]:=adoquery1.fieldbyname('max_value').AsString;
      Calc_pritorder[i]:=adoquery1.fieldbyname('printorder').AsString;
      Calc_Getmoney[i]:=strtofloatdef(adoquery1.fieldbyname('price').asstring,0);
      calc_express[i]:=adoquery1.fieldbyname('cacuexpression').AsString;
      INC(I);
      adoquery1.Next;
    end;
end;   }

{procedure TfrmMain.ReplaceCalaExpress(valetudinarianInfoId: integer);//�滻��������ʽ��ֵ
//valetudinarianInfoIdΪ���˻�����Ϣ���еġ��ֶ����ӵ�Ψһ��š��ֶ�ֵ
var
  i,j:integer;
  querystr:string;
  itemvalueJ:string;
  mathparser:TMathParser;
begin
  for  i:=0  to CalcItemCount-1 do
  begin
      for  j:=0  to max_channelNo do //Ѱ�ҡ�[ͨ����]��
      begin
        if pos('['+inttostr(j)+']',calc_express[i])<>0 then
        begin
          //============�ҵ�ָ��ͨ���ŵĻ�����ĿֵitemvalueJ==================//
          querystr:='select itemvalue '+
                    ' from chk_valu,itemmachine '+
                    ' where chk_valu.checkunid=:P_checkunid '+
                    ' and itemmachine.editchannelno=:P_editchannelno '+
                    ' and itemmachine.pkitemid=:pkitemid '+
                    ' and itemmachine.unid=chk_valu.unid ';
          ADOQuery_temp.Close;
          ADOQuery_temp.SQL.Clear;
          ADOQuery_temp.SQL.Text:=querystr;
          ADOQuery_temp.Parameters.ParamByName('P_checkunid').Value:=valetudinarianInfoId;
          ADOQuery_temp.Parameters.ParamByName('P_editchannelno').Value:=j;
          ADOQuery_temp.Parameters.ParamByName('pkitemid').Value:=PKItemID;
          ADOQuery_temp.Open;
          itemvalueJ:=ADOQuery_temp.fieldbyname('itemvalue').AsString;
          ADOQuery_temp.Close;
          //==================================================================//
          calc_express[i]:=
            StringReplace(calc_express[i],'['+inttostr(j)+']',itemvalueJ,[rfReplaceAll,rfIgnoreCase]);
        end;
      end;
      mathparser:=tmathparser.Create(self);
      mathparser.ParseString:=calc_express[i];
      mathparser.Parse;
      if mathparser.ParseError then
      begin
        calc_express[i]:='';
        //showmessage('���ʽ�д���');
      end else
      begin
        calc_express[i]:=format('%.2f',[mathparser.ParseValue]);
      end;
      mathparser.Free;
  end;
end;   }

procedure TfrmMain.SendMsgToLIS(const valetudinarianInfoId:integer);
var
 Cds: TCopyDataStruct;
 Hwnd: THandle;
begin
 // small data (32 bits): top of form
 Cds.dwData := Top;
 // size of data
 Cds.cbData := Length (inttostr(valetudinarianInfoId)) + 1;
 // allocate memory for the large block and fill it
 GetMem (Cds.lpData, Cds.cbData );
 StrCopy (Cds.lpData, PChar (inttostr(valetudinarianInfoId)));
 // get the handle of the target window
// Hwnd := FindWindow (pchar(trim(edtLisClassName.text)),pchar(trim(edtLisFormName.text)));
 Hwnd := FindWindow (PCHAR(TRIM(edtLisClassName.TEXT)),PCHAR(TRIM(edtLisFormCaption.TEXT)));
 if Hwnd <> 0 then
 begin
    SendMessage (
       Hwnd, WM_COPYDATA, Handle, Cardinal(@Cds)) ;
 end;
 //else
 //  ShowMessage ('GetData window not found.');
 FreeMem (Cds.lpData);
end;

{function TFRMMAIN.GetMaxUnid: integer;
var
    AdoDempQuery:tadoquery;
    i,j:integer;
begin
     AdoDempQuery:=tadoquery.Create(nil);
     AdoDempQuery.Connection := UFRMDATAMODUAL.FRMDATAMODUAL.DbMain;
     AdoDempQuery.Close ;
     AdoDempQuery.SQL.Clear ;
     adodempquery.SQL.Add('select max(unid) as ii from chk_con ' );
     adodempquery.Open ;
             if(adodempquery.FieldByName('ii').AsString = null)or(trim(adodempquery.FieldByName('ii').AsString) ='')then
                 i:=0
             else
                 i:=adodempquery.FieldByName('ii').AsInteger ;

     AdoDempQuery.Close ;
     AdoDempQuery.SQL.Clear ;
     adodempquery.SQL.Add('select max(unid) as jj from chk_con_day ' );
     adodempquery.Open ;
             if(adodempquery.FieldByName('jj').AsString = null)or(trim(adodempquery.FieldByName('jj').AsString) ='')then
                 j:=0
             else
                 j:=adodempquery.FieldByName('jj').AsInteger ;

     result:=i;
     if j>i then result:=j;
end;         }

{procedure TfrmMain.combinchecklistbox(CheckListBox: TCheckListBox);
const sqll='select id,name from combinitem where itemtype=:P_itemtype order by id';
    var adotemp3:tadoquery;
begin
     adotemp3:=tadoquery.Create(nil);
     adotemp3.Connection:=ADOConnection1;
     adotemp3.Close;
     adotemp3.SQL.Clear;
     adotemp3.SQL.Text:=sqll;
     adotemp3.Parameters.ParamByName('P_itemtype').Value:=sITEMTYPE;
     adotemp3.Open;
     adotemp3.First;
     CheckListBox.Items.Clear;

     while not adotemp3.Eof do
     begin
     CheckListBox.Items.Add(trim(adotemp3.fieldbyname('id').AsString)+'   '+adotemp3.fieldbyname('name').AsString);
     adotemp3.Next;
     end;

end;   }

procedure TfrmMain.btnTestConnStrClick(Sender: TObject);
begin
  EditConnectionString(ADOConn_Test);
end;

procedure TfrmMain.SaveDataToQuaContDB;
var
        adotemp:tadoquery;
        i:integer;
        head_unid:integer;
        rfm2,showid:string;
        showidpos:integer;
  YY,MM,DD:WORD;
begin
  DecodeDate(DATE,YY,MM,DD);

  for i :=0  to MachineItemCount-1 do
  begin
        head_unid:=0;
        adotemp:=tadoquery.Create(nil);
        adotemp.Connection:=ADOConnection1;
        adotemp.Close;
        adotemp.SQL.Clear;
        adotemp.SQL.Text:='select * from qcghead where itemname=:P_itemname and '+
                        'qc_year=:P_qc_year and qc_month=:P_qc_month and qc_type='+inttostr(combobox1.ItemIndex+1);
        adotemp.Parameters.ParamByName('P_itemname').Value:=Machine_name[i];
        adotemp.Parameters.ParamByName('P_qc_year').Value:=trim(edtQuaContyear.Text);
        adotemp.Parameters.ParamByName('P_qc_month').Value:=trim(edtQuaContmonth.Text);
        adotemp.Open;
        if adotemp.RecordCount>0 then //�и���Ŀ���ʿ�ֵ�����
        begin
          head_unid:=adotemp.fieldbyname('unid').AsInteger;
        end else               //û�и���Ŀ���ʿ�ֵ�����
        begin
          if Machine_ItemValu[i]<>'' then
          begin
            adotemp.Close;
            adotemp.SQL.Clear;
            adotemp.SQL.Text:='Insert into qcghead (itemname,qc_year,qc_month,qc_type)'+
            ' values (:P_itemname,:P_qc_year,:p_qc_month,:P_qc_type)';
            adotemp.Parameters.ParamByName('P_itemname').Value:=Machine_name[i] ;
            adotemp.Parameters.ParamByName('P_qc_year').Value:=trim(edtQuaContyear.Text);
            adotemp.Parameters.ParamByName('p_qc_month').Value:=trim(edtQuaContmonth.Text);
            adotemp.Parameters.ParamByName('P_qc_type').Value:=combobox1.ItemIndex+1;
            adotemp.ExecSQL;

            adotemp.Close;
            adotemp.SQL.Clear;
            adotemp.SQL.Text:='select * from qcghead '+
                                ' where itemname=:P_itemname '+
                                ' and qc_year=:P_qc_year '+
                                ' and qc_month=:P_qc_month '+
                                ' and qc_type='+inttostr(combobox1.ItemIndex);  //qc_type=1��ʾ��ֵ�ʿ�
            adotemp.Parameters.ParamByName('P_itemname').Value:=Machine_name[i] ;
            adotemp.Parameters.ParamByName('P_qc_year').Value:=trim(edtQuaContyear.Text);
            adotemp.Parameters.ParamByName('P_qc_month').Value:=trim(edtQuaContmonth.Text);
            adotemp.Open;
            if adotemp.RecordCount=0 then
            begin
              showmessage('���������������뿪������ϵ!');//�ող�����Ҳ����ˣ����Ǽ�������
              application.Terminate;
            end else
            begin
              head_unid:=adotemp.fieldbyname('unid').AsInteger;
            end;
          end;
        end;


    if head_unid<>0 then
    begin
        adotemp.Close;
        adotemp.SQL.Clear;
        adotemp.SQL.Text:='select * from qcgdata where pkunid=:P_pkunid'+
                            ' and gettime=:P_gettime ';
        adotemp.Parameters.ParamByName('p_pkunid').Value:=head_unid;
        adotemp.Parameters.ParamByName('P_gettime').Value:=dd;
        adotemp.Open;

        if adotemp.RecordCount>0 then   //�����������иü���ֵ��������޸�
        begin
          if Machine_ItemValu[i]<>'' then
          begin
            adotemp.Edit;
            if (uppercase(trim(Machine_specNo))=uppercase(trim(frmmain.edtQuaContSpecNo.Text))) then
                adotemp.FieldByName('result').AsString:=Machine_ItemValu[i];
            if (uppercase(trim(Machine_specNo))=uppercase(trim(frmmain.edit1.Text)))and(combobox1.ItemIndex=1) then
                adotemp.FieldByName('hv_result').AsString:=Machine_ItemValu[i];
            if (uppercase(trim(Machine_specNo))=uppercase(trim(frmmain.edit2.Text)))and(combobox1.ItemIndex=1) then
                adotemp.FieldByName('lv_result').AsString:=Machine_ItemValu[i];
            adotemp.Post;
          end;
        end else                          //����������û�иü���ֵ����������
        begin
          if Machine_ItemValu[i]<>'' then
          begin
            adotemp.Close;
            adotemp.Sql.Clear;
            adotemp.Sql.text:=
            'Insert into qcgdata ('+
            ' pkunid,gettime,result,hv_result,lv_result) values ('+
            ':P_pkunid,:P_gettime,:P_result,:P_hv_result,:P_lv_result) ';
            adotemp.Parameters.ParamByName('P_pkunid').Value:=head_unid ;
            adotemp.Parameters.ParamByName('P_gettime').Value:=dd;
            if (uppercase(trim(Machine_specNo))=uppercase(trim(frmmain.edtQuaContSpecNo.Text))) then
                adotemp.Parameters.ParamByName('P_result').Value:=Machine_ItemValu[i]
            else adotemp.Parameters.ParamByName('P_result').Value:='';
            if (uppercase(trim(Machine_specNo))=uppercase(trim(frmmain.edit1.Text)))and(combobox1.ItemIndex=1) then
                adotemp.Parameters.ParamByName('P_hv_result').Value:=Machine_ItemValu[i]
            else adotemp.Parameters.ParamByName('P_hv_result').Value:='';
            if (uppercase(trim(Machine_specNo))=uppercase(trim(frmmain.edit2.Text)))and(combobox1.ItemIndex=1) then
                adotemp.Parameters.ParamByName('P_lv_result').Value:=Machine_ItemValu[i]
            else adotemp.Parameters.ParamByName('P_lv_result').Value:='';
            Try
              adotemp.EXECSql ;
            except
              Application.MessageBox('�ʿؼ������洢ʧ��!','ϵͳ��ʾ',MB_ICONWARNING);
            End;
          end;
        end;
    end;
  end;
end;

function TfrmMain.getmaxlsh: string;
var
  maxid: string;
  adotemp5:tadoquery;
begin
        adotemp5:=tadoquery.Create(nil);
        adotemp5.Connection:=self.ADOConnection1;
  ADOtemp5.Close;
  ADOtemp5.SQL.Clear;
  ADOtemp5.SQL.Add('select max(LSH)+1 as maxid from chk_con WHERE CHECK_DATE=:p_CHECK_DATE ');
  ADOTEMP5.Parameters.ParamByName('p_CHECK_DATE').Value:=DATETOSTR(DATE);
  ADOtemp5.open;
  maxid := ADOtemp5.FieldByName('maxid').AsString;
  if trim(maxid) = '' then
    maxid := '0001';
  if Length(maxid) = 1 then
    maxid := '000' + maxid;
  if Length(maxid) = 2 then
    maxid := '00' + maxid;
  if Length(maxid) = 3 then
    maxid := '0' + maxid;
  result := maxid;
  adotemp5.Free;
end;

procedure TfrmMain.FormShow(Sender: TObject);
VAR
  YY,MM,DD:WORD;
begin
  DecodeDate(DATE,YY,MM,DD);
  edtQuaContyear.Text:=INTTOSTR(YY);
  EDTQUACONTMONTH.Text:=rightstr('00'+INTTOSTR(MM),2);
end;

procedure TfrmMain.alleditfalse;
begin
  cbcomm.Enabled:=false;
    edtBaudRate.Enabled:=false;
    edtDatabit.Enabled:=false;
    edtStopbit.Enabled:=false;
    edtParity.Enabled:=false;
  SpEdtItmeID.Enabled:=false;
  chkboxAutorun.Enabled:=false;
    edtLisClassName.Enabled:=false;
    edtLisFormCaption.Enabled:=false;
    edtQuaContSpecNo.Enabled:=false;
    edtQuaContyear.Enabled:=false;
    edtQuaContmonth.Enabled:=false;
    edtMainAppProfilePath.Enabled:=false;
    combobox1.Enabled:=false;
    edit1.Enabled:=false;
    edit2.Enabled:=false;
    editcommword.Enabled:=false;
end;

procedure TfrmMain.alledittrue;
begin
    cbcomm.Enabled:=true;
    edtBaudRate.Enabled:=true;
    edtDatabit.Enabled:=true;
    edtStopbit.Enabled:=true;
    edtParity.Enabled:=true;
    SpEdtItmeID.Enabled:=true;
    chkboxAutorun.Enabled:=true;
    edtLisClassName.Enabled:=true;
    edtLisFormCaption.Enabled:=true;
    edtQuaContSpecNo.Enabled:=true;
    edit1.Enabled:=true;
    edit2.Enabled:=true;
    edtQuaContyear.Enabled:=true;
    edtQuaContmonth.Enabled:=true;
    edtMainAppProfilePath.Enabled:=true;
    combobox1.Enabled:=true;
    editcommword.Enabled:=true;
end;

procedure TfrmMain.Comm1ReceiveData(Sender: TObject; Buffer: Pointer;
  BufferLength: Word);
var
    pbuffer:pchar;
    srfm:string;
    sendstr:string;
    sendstrLen,i:integer;
    valetudinarianInfoId:integer;
    lastpos:integer;
    F: TextFile;
begin
        //=============���յ��ַ��ŵ�SRFM��================
        pbuffer:=buffer;
        SETLENGTH(srfm,BufferLength);
        for  i:=1  to BufferLength do srfm[i]:=pbuffer[i-1];
        //=================================================
        
        //if srfm=#$5 then begin rfm:='';rfmHisto:='';end;
        //��ʾ��ǰ���յ�����
        RFM:=srfm;

        Label_status.caption:=RFM;
        if pos(ETX,RFM)>  0 then //�ò��˵ļ������ѽ������
        begin
          rfmHisto:=srfm;   //ԭ֭ԭζ������
          RFM:=UPPERCASE(RFM);
          lastpos:=pos('MICROS60',RFM);
          if lastpos>0 then  RFM:=copy(RFM,1,lastpos);//��ȡ���õĲ���
          ReadMachineItem(pkitemid); //�õ���ǰ������Ŀ��������Ϣ,������ʾ���itemid��english_name��ScoutIIGetItemValuҪ�õ�
          ScoutIIGetItemValue;
          if (uppercase(trim(Machine_specNo))=uppercase(trim(frmmain.edtQuaContSpecNo.Text)))
              or(uppercase(trim(Machine_specNo))=uppercase(trim(frmmain.edit1.Text)))
              or(uppercase(trim(Machine_specNo))=uppercase(trim(frmmain.edit2.Text))) then
          begin     //���浽�ʿر���
              frmmain.SaveDataToQuaContDB;
          end else  //���浽���˱���
          begin
              //�������ݵ����ݿ�
              frmMain.SaveDatatoDB(valetudinarianInfoId);
              //֪ͨLIS��������ʾ
              frmMain.SendMsgToLIS(valetudinarianInfoId);
          end;
          //��ʾ��ǰ�������ݵĽ��
          Label_status.caption:=datetostr(date)+' '+timetostr(now)+' | '+Machine_specNo;
          //======���ò��˵ļ�����д���ļ���=============
          //AssignFile(F, 'ACTDIFF.txt'); { File selected in dialog }
          //rewrite(F);
          //writeln(F, rfmHisto);                        { Read first line of file }
          //CloseFile(F);
          //===============================================
        end;
        //DELETE(SRFM,1,1);     //ɾ��ÿ�����ݿ�ͷ��#$2
        //RFM:=RFM+srfm;

        //==========����ȷ��ָ��======================
        //sendstr:=ACK;
        // sendstrLen:=length(sendstr);

        // comm1.WriteCommData(@sendstr[1],sendstrLen);
        //============================================
end;

initialization
    hnd := CreateMutex(nil, True, Pchar(sLinkFile));
    if GetLastError = ERROR_ALREADY_EXISTS then
    begin
        MessageBox(application.Handle,pchar('�ó������������У�'),
                    'ϵͳ��ʾ',MB_OK+MB_ICONinformation);     //WARNING
        Halt;
    end;

finalization
    if hnd <> 0 then CloseHandle(hnd);

end.
