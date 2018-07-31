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
  private
    currentUser: TUser;
  public
    function getUser: TUser;
    procedure setUser(user: TUser);
  end;

var
  frmTemplate: TfrmTemplate;

implementation

uses Edit_User_Profile_U;

{$R *.dfm}

{ TfrmTemplate }

procedure TfrmTemplate.btnViewAccountClick(Sender: TObject);
var
  form: TfrmEditUserProfile;
begin
  form := TfrmEditUserProfile.create(self, self.getUser);
  form.showmodal;
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
