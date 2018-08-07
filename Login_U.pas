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
    chkRememberMe: TCheckBox;
    procedure btnLoginClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    cached: boolean;
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
  // TODO: Validate input
//
  if Utilities.loginUser(edtUserID.Text, edtPassword.Text, user, cached) then
  begin
    if chkRememberMe.Checked or cached then
    begin

      Utilities.persistLogin(edtUserId.Text, edtPassword.Text, cached);
    end else
    begin
      Utilities.depersistLogin;
    end;

    edtUserId.Text := '';
    edtPassword.Text := '';

    if user.GetType = employee then
    begin
      form := TfrmEmployeeHome.Create(nil);
    end else
    begin
      form := TfrmManagerHome.Create(nil);
    end;
    form.setUser(user);

    self.Hide;
    form.Show;
  end else
  begin
    edtPassword.SetFocus;
    showmessage('Failed to log in');
  end;

end;




procedure TfrmLogin.FormCreate(Sender: TObject);
var
 email, password: string;
begin
  cached := false;

  // Login persistence
  if FileExists(Utilities.LOGIN_CACHE_FILE) then
  begin
    if Utilities.getPersistedLogin(email, password) then
    begin
      self.Hide;
      cached := true;
      edtUserId.Text := email;
      edtPassword.Text := password;
      btnLoginClick(self);
    end else
    begin
      self.show;
    end;
  end else
  begin
    self.show;
  end;
end;

end.
