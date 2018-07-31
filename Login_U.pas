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

uses Utilities_U, Manager_Home_U, Employee_Home_U, frmTemplate_U;

{$R *.dfm}

procedure TfrmLogin.btnLoginClick(Sender: TObject);
var
  form: TfrmTemplate;
begin
  // TODO: Remember me functionality
  // TODO: Validate input
  if Utilities.loginUser(edtUserID.Text, edtPassword.Text, user, true) then
  begin
    if user.GetType = employee then
    begin
      form := TfrmEmployeeHome.Create(nil);
    end else
    begin
      form := TfrmManagerHome.Create(nil);
    end;
    form.setUser(user);
    form.Show;
    self.Hide;
  end else
  begin
    edtPassword.SetFocus;
    showmessage('Failed to log in');
  end;

end;

end.
