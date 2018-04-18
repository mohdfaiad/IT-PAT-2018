program PoSify;

uses
  Forms,
  frmTemplate_U in 'frmTemplate_U.pas' {frmTemplate},
  TUser_U in 'TUser_U.pas',
  TForm_Employee_Home in 'TForm_Employee_Home.pas' {frmEmployeeHome},
  Data_Module_U in 'Data_Module_U.pas' {data_module: TDataModule},
  TItem_U in 'TItem_U.pas',
  TOrder_U in 'TOrder_U.pas',
  Logger_U in 'Logger_U.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := False;
  Application.CreateForm(Tdata_module, data_module);
  Application.CreateForm(TfrmEmployeeHome, frmEmployeeHome);
  Application.Run;
end.
