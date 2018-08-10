program PoSify;

uses
  Forms,
  frmTemplate_U in 'frmTemplate_U.pas' {frmTemplate},
  TUser_U in 'TUser_U.pas',
  Employee_Home_U in 'Employee_Home_U.pas' {frmEmployeeHome},
  Data_Module_U in 'Data_Module_U.pas' {data_module: TDataModule},
  TItem_U in 'TItem_U.pas',
  TOrder_U in 'TOrder_U.pas',
  Logger_U in 'Logger_U.pas',
  Utilities_U in 'Utilities_U.pas',
  Authenticate_U in 'Authenticate_U.pas' {frmAuthenticate},
  Manager_Home_U in 'Manager_Home_U.pas' {frmManagerHome},
  New_User_U in 'New_User_U.pas' {frmNewUser},
  Login_U in 'Login_U.pas' {frmLogin},
  Edit_User_Profile_U in 'Edit_User_Profile_U.pas' {frmEditUserProfile},
  Menu_Management_U in 'Menu_Management_U.pas' {frmManageMenu},
  Order_Details_U in 'Order_Details_U.pas' {frmOrderDetails};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := False;
  Application.CreateForm(Tdata_module, data_module);
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.ShowMainForm := false;
  Application.Run;
end.
