unit Authenticate_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TfrmAuthenticate = class(TForm)
    imgLogo: TImage;
    pnlLogin: TPanel;
    lblWelcome: TLabel;
    edtID: TEdit;
    edtPassword: TEdit;
    btnLogin: TButton;
    procedure btnLoginClick(Sender: TObject);
    procedure edtIDChange(Sender: TObject);
  private
    { Private declarations }
    const
      TAG: string = 'FORM_AUTHENTICATE';
  public
    { Public declarations }
  end;

var
  frmAuthenticate: TfrmAuthenticate;

implementation

uses Employee_Home_U, Utilities_U, TUser_U;

{$R *.dfm}

var
  user: TUser;

procedure TfrmAuthenticate.btnLoginClick(Sender: TObject);
var
  frmEmployeeHome: TfrmEmployeeHome;
begin


  if Utilities.loginUser(edtID.Text, edtPassword.Text, user, true) then
  begin
    ShowMessage('Logged in ' + user.ToString);

     case user.getType of
      manager:
      begin
        Showmessage('Manager home');
      end;
      employee :
      begin
        frmEmployeeHome := TfrmEmployeeHome.Create(nil);
        frmEmployeeHome.setUser(user);
        frmEmployeeHome.Show;
        self.Hide;
      end;
    end;
  end else
  begin
    showmessage('Could not find matching ID/password combination.');
  end;
end;

procedure TfrmAuthenticate.edtIDChange(Sender: TObject);
begin
  // Prevent user from entering non-numeric ID
  try
    strtoint(edtID.Text);
  except
    edtID.Text := copy(edtID.Text, 1, length(edtID.Text)-1);
    edtID.SelStart := length(edtID.text);
  end;
end;

end.
