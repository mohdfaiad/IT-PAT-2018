unit TForm_Employee_Home;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmTemplate_U, StdCtrls, ExtCtrls;

type
  TfrmEmployeeHome = class(TfrmTemplate)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmEmployeeHome: TfrmEmployeeHome;

implementation

uses TUser_U, TItem_U;

{$R *.dfm}

procedure TfrmEmployeeHome.FormCreate(Sender: TObject);
var
  user: TUser;
  item: TItem;
begin
  inherited;
  // Test
  user := TUser.Create(1, 'Stephan', 'Cilliers', employee, now());
  self.setUser(user);

  item := TItem.Create(1, 'Big Daddy', 'Burger');
  showmessage(item.ToString);


end;

end.
