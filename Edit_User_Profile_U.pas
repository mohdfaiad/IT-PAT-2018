unit Edit_User_Profile_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, TUser_U;

type
  TfrmEditUserProfile = class(TForm)
    btnUpdate: TButton;
    edtFirstName: TEdit;
    edtLastName: TEdit;
    lblFirstName: TLabel;
    lblLastName: TLabel;
    edtNewPassword: TEdit;
    edtOldPassword: TEdit;
    lblNewPassword: TLabel;
    edtNewPasswordConfirm: TEdit;
    lblConfirmNewPassword: TLabel;
    lblOldPassword: TLabel;
    btnChangePassword: TButton;
    procedure fieldSelected(sender: TObject);
    procedure profileFieldChanged(sender: TObject);
    procedure passwordFieldChanged(sender: TObject);
    procedure btnChangePasswordClick(Sender: TObject);
    procedure btnUpdateClick(Sender: TObject);
  private
    { Private declarations }
    userOld: TUser;
    userNew: TUser;
    sender: Tform;
  public
    { Public declarations }
    constructor create(sender: tform; user: TUser); reintroduce; overload;
  end;

var
  frmEditUserProfile: TfrmEditUserProfile;

implementation

uses Utilities_U, frmTemplate_U;

{$R *.dfm}

{ TfrmEditUserProfile }


procedure TfrmEditUserProfile.btnChangePasswordClick(Sender: TObject);
begin
  // Validation
  if length(edtNewPassword.Text) < 6 then
  begin
    edtNewPassword.SetFocus;
    Showmessage('New password must have at least 6 characters.');
    Exit;
  end else if edtNewPassword.Text <> edtNewPasswordConfirm.Text then
  begin
    edtNewPasswordConfirm.SetFocus;
    Showmessage('New passwords must match.');
    exit;
  end;

  if Utilities.changePassword(userOld, edtOldPassword.Text, edtNewPassword.Text) then
  begin
    Utilities.depersistLogin;
    showmessage('Password changed successfully');
  end else
  begin
    Showmessage('Could not change password. Try again.');
  end;
end;

procedure TfrmEditUserProfile.btnUpdateClick(Sender: TObject);
var
  validUser: TUser;
begin
  userNew := TUser.Create(userOld.GetID, edtFirstName.Text, edtLastName.Text, userOld.GetType, userOld.GetDateRegistered);

  if Utilities.updateUserInformation(userNew, validUser) then
  begin
    (self.sender as tfrmTemplate).setUser(validUser);
    showmessage('Information changed successfully');
  end else
  begin
    Showmessage('Could not change information. Try again.')
  end;


end;

constructor TfrmEditUserProfile.create(sender: tform; user: TUser);
begin
  inherited create(sender);
  self.userOld := user;
  edtFirstName.Text := user.getFirstName;
  self.sender := sender;
  edtLastName.Text := user.getLastName;
end;

procedure TfrmEditUserProfile.fieldSelected(sender: TObject);
begin
  (sender as TEdit).SelectAll;
end;

procedure TfrmEditUserProfile.passwordFieldChanged(sender: TObject);
begin
  if not ((edtOldPassword.Text = '') and (edtNewPassword.Text = '') and (edtNewPasswordConfirm.Text = '')) then
  begin
    btnChangePassword.Enabled := true;
  end else
  begin
    btnChangePassword.Enabled := false;
  end;
end;

procedure TfrmEditUserProfile.profileFieldChanged(sender: TObject);
begin
  // Validation (different, not empty)
  if (not ((edtFirstName.Text = userold.getFirstName) and
    (edtLastName.Text = userold.getLastName))) and
    (((length(edtFirstName.Text) > 0) and (length(edtLastName.Text) > 0))) then
  begin
    btnUpdate.Enabled := true;
  end else
  begin
    btnUpdate.Enabled := false;
  end;
end;

end.
