unit UYDComm;

interface
uses
  CPort,Classes,forms,windows,SysUtils,StrUtils;

type
  TLYComPort=class(tobject)
  private
    FUNCTION COMPDATA (const S:STRING;var Errtype:string):boolean;
    procedure setsigle(sender: tobject);
  public
    dllo: TComPort;
    PacketUC: TComDataPacket;
    PROCEDURE SEND(S:STRING);
    function openport(comport,baudrate,databit,stopbit,parity:integer):boolean;
    constructor Create(AOwer:Tcomponent);
    destructor Destroy; override ;
    PROCEDURE RECDATA(sender:tobject;const data:string);
  end;
  
procedure ScoutIIGetItemValue;

var
  RFM,rfmHisto:STRING;       //��������
  AppPath:string;
  wbcOstr,rbcOstr,pltOstr:string;


implementation
uses ufrmmain,umyconst,ucommfunction;
const
  CR=#$D#$A;
  STX=#$2;ETX=#$3;ACK=#$6;NAK=#$15;ETB=#$17;
  SEPARATOR=#$1C;
  
procedure ScoutIIGetItemValue;
const
  ItemValuLen=5;
var
  i:integer;
  showID:string;
  showIDLen:integer;
  showIDPos:integer;
  OPos:integer;
  wbcCstr,rbcCstr,pltCstr:string;
  tempRFM:string;
  pos1,pos2:integer;
  PwbcCstr,PrbcCstr,PpltCstr:pchar;
  wbcCstrPos,rbcCstrPos,pltCstrPos,iiPos:integer;
  wbcCstrLen,rbcCstrLen,pltCstrLen:integer;
begin
  //================ȡ��������================================================//

    Machine_specNo:=UPPERCASE(RFM);
    pos1:=pos('U 000000000000',Machine_specNo);
    Machine_specNo:=copy(Machine_specNo,pos1+LENGTH('U 000000000000'),4);
    Machine_specNo:=trim(Machine_specNo);
    Machine_specNo:=trim(frmMain.editcommword.text)+ rightstr('0000'+Machine_specNo,4);
    //���� I0099
  //==========================================================================//
  setlength(Machine_ItemValu,MachineItemCount);
  for  i:=0  to MachineItemCount-1 do
  begin
    Machine_ItemValu[i]:='';
    showID:=UPPERCASE(trim(Machine_machinekeyword[i]));
    showID:=#$D+showID+' ';
    showIDLen:=length(showid);
    //showIDLen:=1;
    showIDPos:=pos(showid,RFM);
    if showIDPos<>0 THEN   //��Rfm���ҵ�������Ŀ�����
    BEGIN
        Machine_ItemValu[i]:=trim(copy(rfm,showIDPos+showIDLen,ItemValuLen));  // ItemValuLen := 11

        //pos2 := pos(' ',Machine_ItemValu[i]);
        //pos1 := pos('=',Machine_ItemValu[i]);

        // ȡ�ո�ǰ����
        //if pos2>0 thenMachine_ItemValu[i]:=copy(Machine_ItemValu[i],1,pos2-1);
        // ȡ�ո�󲿷�
        //if pos2>0 then Machine_ItemValu[i]:=copy(Machine_ItemValu[i],pos2+1,length(Machine_ItemValu[i]));
        
        //if pos1>0 then Machine_ItemValu[i]:=copy(Machine_ItemValu[i],pos1+1,length(Machine_ItemValu[i]));
        //Machine_ItemValu[i]:=trim(Machine_ItemValu[i]);

        //Machine_ItemValu[i]:=LeftStr(Machine_ItemValu[i],pos2 - 1)
        //Machine_ItemValu[i]:=StrTofloatStr(Machine_ItemValu[i]);//
        IF  Machine_ItemValu[i] ='--.--'THEN   Machine_ItemValu[i]:='';


         try
            Machine_ItemValu[i]:=FLOATTOSTR(STRTOFLOAT(Machine_ItemValu[i]));
         except
         End;


    END;  //
  end;

              //========�ֽ�ͼ������==================    (ֱ��ͼ)


               //�����ǿ�����㷨
              //WBC============
              wbccstrpos:=pos(#$D+'W ',RFM);
              WBCCSTR:=RFM;
              DELETE(WBCCSTR,1,WBCCSTRPOS+length(#$D+'W ')+2);
              IIPOS:=POS(#$D+'X ',WBCCSTR);
              WBCCSTR:=COPY(WBCCSTR,1,IIPOS-3);

              //wbcCstrLen:=length(wbccstr);
              //wbccstr:=leftstr(wbccstr,wbccstrlen-37);//-37

              wbcCstrLen:=length(WBCCSTR);
              PwbcCstr:=StrAlloc(wbcCstrLen+1);
              for i :=1 to wbcCstrLen do
              begin
                PwbcCstr[i-1]:=WBCCSTR[i];
              end;
              DIFF_decode(PwbcCstr,wbcOstr,wbcCstrLen);

              //RBC============
              rbccstrpos:=pos(#$D+'X ',RFM);
              RBCCSTR:=RFM;
              DELETE(RBCCSTR,1,RBCCSTRPOS+length(#$D+'X ')+2);
              IIPOS:=POS(#$D+'Y ',RBCCSTR);
              RBCCSTR:=COPY(RBCCSTR,1,IIPOS-3);

              //RBCCstrLen:=length(rbccstr);
              //rbccstr:=leftstr(rbccstr,rbccstrlen-10);

              RBCCstrLen:=length(RBCCSTR);
              PRBCCstr:=StrAlloc(RBCCstrLen+1);
              for i :=1 to RBCCstrLen do
              begin
                PRBCCstr[i-1]:=RBCCSTR[i];
              end;
              DIFF_decode(PRBCCstr,RBCOstr,RBCCstrLen);

              //PLT============
              PLTcstrpos:=pos(#$D+'Y ',RFM);   //RAW��FIT
              PLTCSTR:=RFM;
              DELETE(PLTCSTR,1,PLTCSTRPOS+length(#$D+'Y ')+2);
              IIPOS:=POS(#$D+'S ',PLTCSTR);     // '|||||F||||'
              PLTCSTR:=COPY(PLTCSTR,1,IIPOS-3);

              //pltCstrLen:=length(pltcstr);
              //pltcstr:=leftstr(pltcstr,pltcstrlen-10);

              PLTCstrLen:=length(PLTCSTR);
              PPLTCstr:=StrAlloc(PLTCstrLen+1);
              for i :=1 to PLTCstrLen do
              begin
                PPLTCstr[i-1]:=PLTCSTR[i];
              end;
              DIFF_decode(PPLTCstr,PLTOstr,PLTCstrLen);
              //======================================

end;

{ TLYComPort }

constructor TLYComPort.Create(AOwer: Tcomponent);
begin
  dllo:=tcomport.Create(nil);
  PacketUC:= TComDataPacket.Create(nil);
  packetuc.ComPort:=dllo;
  packetuc.IncludeStrings:=true;
  dllo.OnAfterOpen:= setsigle;
  packetuc.OnPacket:=RECDATA;
  packetUC.StartString:=STX+'D ';
  packetUC.StopString:=ETX;
  //packetuc.Size:=15;
end;

destructor TLYComPort.Destroy;
begin
  inherited Destroy;
  dllo.Free;
  packetuc.Free;
end;

function TLYComPort.openport(comport, baudrate, databit, stopbit,
  parity: integer): boolean;
begin
    result:=false;
    if dllo.Connected then dllo.Close;
    dllo.BeginUpdate;
    case comport of
      1:if dllo.Port<>'COM1' then dllo.Port:='COM1';
      2:if dllo.Port<>'COM2' then dllo.Port:='COM2';
      3:if dllo.Port<>'COM3' then dllo.Port:='COM3';
      4:if dllo.Port<>'COM4' then dllo.Port:='COM4';
    end;
    case baudrate of
      1200:if dllo.BaudRate<>br1200 then dllo.BaudRate:=br1200;
      2400:if dllo.BaudRate<>br2400 then dllo.BaudRate:=br2400;
      4800:if dllo.BaudRate<>br4800 then dllo.BaudRate:=br4800;
      9600:if dllo.BaudRate<>br9600 then dllo.BaudRate:=br9600;
      19200:if dllo.BaudRate<>br19200 then dllo.BaudRate:=br19200;
    end;
    case databit of
      7:if dllo.DataBits<>dbseven then dllo.DataBits:=dbseven;
      8:if dllo.DataBits<>dbeight then dllo.DataBits:=dbeight;
    end;
    case stopbit of
      0:if dllo.StopBits<>sbone5stopbits then dllo.StopBits:=sbone5stopbits;
      1:if dllo.StopBits<>sbonestopbit then dllo.StopBits:=sbonestopbit;
      2:if dllo.StopBits<>sbtwostopbits then dllo.StopBits:=sbtwostopbits;
    end;
    case parity of
      1:if dllo.Parity.Bits<>preven then dllo.Parity.Bits:=preven;
      2:if dllo.Parity.Bits<>prmark then dllo.Parity.Bits:=prmark;
      3:if dllo.Parity.Bits<>prnone then dllo.Parity.Bits:=prnone;
      4:if dllo.Parity.Bits<>prodd then dllo.Parity.Bits:=prodd;
      5:if dllo.Parity.Bits<>prspace then dllo.Parity.Bits:=prspace;
    end;
    dllo.EndUpdate;
    try
      if not dllo.Connected then dllo.Open;
      result:=true;
    except
      MessageBox(application.Handle,PCHAR('�򿪶˿�COM'+INTTOSTR(comport)+'ʧ�ܣ������ѱ�ռ��!'),'ϵͳ��ʾ',MB_OK+mb_iconerror);
    end;
end;

function TLYComPort.COMPDATA(const S: STRING;var Errtype:string): boolean;
VAR
    DATASTR:STRING;
    i,len:integer;
BEGIN
  result:=false;
  len:=length(s);
  if pos(#$D#$A,s)=0 then
  begin
    Errtype:='���ݴ������';
    exit;
  end;
  //datastr:=copy(s,2,len-2); //����һͷһβ
  //for  i:=1  to length(datastr) do
  //begin
  //  if not(ord(datastr[i]) in [42,48..57,65..90,97..122]) then {*,0..9,A..Z,a..z}
  //  begin
  //    errtype:='�Ƿ��ַ�';
  //    exit;
  //  end;
  //end;
  RESULT:=true;
END;

procedure TLYComPort.RECDATA(sender: tobject; const data: string);
VAR
  errtype:string;
  LOGSTR:STRING;
  valetudinarianInfoId:integer;
  edtChkItem:TEdtList;
BEGIN
  RFM:=data;
  RFM:=uppercase(rfm);
{  if not COMPDATA(rfm,errtype) then
  begin
//====��¼������־ ,��¼�������ݼ���ǰ����ʱ��================================//
    LOGSTR:=formatdatetime('yyyy"��"mm"��"dd"��"hh"ʱ"nn"��"ss"��"',now)+'�յ���������(��������:'+errtype+'):'+rfm+CR;
    RecordLog(appPath+'CommErr.log',LOGSTR);
//============================================================================//

    //send(NAK);
  end else     }
  begin
    //send(ACK);
    frmMain.ReadMachineItem(pkitemid); //�õ���ǰ������Ŀ��������Ϣ,������ʾ���itemid��ScoutIIGetItemValuҪ�õ�
    ScoutIIGetItemValue;
    if (uppercase(trim(Machine_specNo))=uppercase(trim(frmmain.edtQuaContSpecNo.Text)))
        or(uppercase(trim(Machine_specNo))=uppercase(trim(frmmain.edit1.Text)))
        or(uppercase(trim(Machine_specNo))=uppercase(trim(frmmain.edit2.Text))) then
    begin     //���浽�ʿر���
        frmmain.SaveDataToQuaContDB;
    end else  //���浽���˱���
    begin
        frmMain.SaveDatatoDB(valetudinarianInfoId);
        frmMain.SendMsgToLIS(valetudinarianInfoId);
        
    end;

    //===============�����������������ʾ���������SaveDatatoDB�¼���=======//
    //edtChkItem:=frmMain.CreateEdt(PKItemID,MachineItemCount);
    //frmMain.WriteToEdt(valetudinarianInfoId,PKItemID,MachineItemCount,edtChkItem);
    //========================================================================//
  end;
END;

procedure TLYComPort.setsigle(sender: tobject);
begin
  dllo.SetDTR(true);
  dllo.SetRTS(true);
end;

procedure TLYComPort.SEND(S: STRING);
begin
  DLLO.Writestr(s);
end;

end.
