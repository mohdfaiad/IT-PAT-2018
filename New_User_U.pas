unit New_User_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  INewUserDelegate = Interface(IInterface)
    procedure didCreateNewUser;
  End;
  TfrmNewUser = class(TForm)
    edtFirstName: TEdit;
    edtLastName: TEdit;
    btnCreate: TButton;
    cmbUserType: TComboBox;
    Label1: TLabel;
    procedure btnCreateClick(Sender: TObject);
  private
    { Private declarations }
    sender: INewUserDelegate;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); reintroduce; overload;
  end;

var
  frmNewUser: TfrmNewUser;

implementation

uses Utilities_U, TUser_U;

{$R *.dfm}

procedure TfrmNewUser.btnCreateClick(Sender: TObject);
var
  user: TUser;
begin
  // TODO: Validation
  // TODO: Store default password in config file
  if Utilities.newUser(user, 'password', edtFirstName.Text, edtLastName.Text, TUserType(cmbUserType.ItemIndex+1), Date()) then
  begin
    ShowMessage('User created. Use default password: "password" to log in.');
    self.sender.didCreateNewUser;
  end else
  begin
    ShowMessage('Something went wrong.');
  end;

  self.CloseModal;
  self.Close;

end;


constructor TfrmNewUser.Create(AOwner: TComponent);
begin
  inherited;
  showmessage('new user');
  self.sender := sender as INewUserDelegate;
end;

end.
