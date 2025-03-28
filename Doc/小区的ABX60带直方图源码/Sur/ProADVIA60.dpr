program ProADVIA60;

uses
  Forms,
  UfrmMain in 'UfrmMain.pas' {frmMain},
  UYDComm in 'UYDComm.pas',
  UMyconst in 'UMyconst.pas',
  UCommFunction in 'UCommFunction.pas',
  Parser in 'Parser.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'ProADVIA60';
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
