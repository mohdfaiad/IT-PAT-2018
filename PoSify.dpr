program PoSify;

uses
  Forms,
  frmTemplate_U in 'frmTemplate_U.pas' {frmTemplate},
  TUser_U in 'TUser_U.pas',
  TForm_Employee_Home in 'TForm_Employee_Home.pas' {frmEmployeeHome},
  Data_Module_U in 'Data_Module_U.pas' {data_module: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := False;
  Application.CreateForm(TfrmEmployeeHome, frmEmployeeHome);
  Application.CreateForm(Tdata_module, data_module);
  Application.Run;
end.
