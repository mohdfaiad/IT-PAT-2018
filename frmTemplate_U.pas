unit frmTemplate_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TUser_U, StdCtrls, ExtCtrls;

type
  TfrmTemplate = class(TForm)
    pnlHeader: TPanel;
    btnLogout: TButton;
    btnViewAccount: TButton;
    procedure btnViewAccountClick(Sender: TObject);
    procedure btnLogoutClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    currentUser: TUser;
  public
    function getUser: TUser;
    procedure setUser(user: TUser);
    constructor create(owner: tcomponent; user: TUser); reintroduce; overload;
  end;

var
  frmTemplate: TfrmTemplate;

implementation

uses Edit_User_Profile_U, Utilities_U, Logger_U, Login_U;

{$R *.dfm}

{ TfrmTemplate }

procedure TfrmTemplate.btnLogoutClick(Sender: TObject);
begin
  self.Hide;
  frmLogin.Show;
  frmLogin.cached := false;
  self.currentUser.Free;
  Utilities.depersistLogin;
//  TLogger.log(TAG, TLogType.Debug, 'Logged out user');
end;

procedure TfrmTemplate.btnViewAccountClick(Sender: TObject);
var
  form: TfrmEditUserProfile;
begin
  form := TfrmEditUserProfile.create(self, self.getUser);
  form.showmodal;
end;

constructor TfrmTemplate.create(owner: tcomponent; user: TUser);
begin
  inherited create(owner);
  self.setUser(user);
end;

procedure TfrmTemplate.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  try
    application.Terminate;
  except

  end;
end;

function TfrmTemplate.getUser: TUser;
begin
  result := self.currentUser;
end;

procedure TfrmTemplate.setUser(user: TUser);
begin
  self.currentUser := user;
  self.pnlHeader.Caption := Format('Welcome %s', [self.currentUser.GetFirstName]);
end;

end.
