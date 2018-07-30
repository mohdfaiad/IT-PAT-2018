unit Login_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, pngimage, TUser_U;

type
  TfrmLogin = class(TForm)
    picLogo: TImage;
    edtUserID: TEdit;
    edtPassword: TEdit;
    lblWelcome: TLabel;
    btnLogin: TButton;
    procedure btnLoginClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;
  user: TUser;

implementation

uses Utilities_U, Manager_Home_U, Employee_Home_U;

{$R *.dfm}

procedure TfrmLogin.btnLoginClick(Sender: TObject);
var
  frmManager: TfrmManagerHome;
  frmEmployee: TfrmEmployeeHome;
begin
  // TODO: Validate input
  if Utilities.loginUser(edtUserID.Text, edtPassword.Text, user, true) then
  begin
    // TODO: Launch appropriate form
  end else
  begin
    edtPassword.SetFocus;
    showmessage('Failed to log in');
  end;

end;

end.
