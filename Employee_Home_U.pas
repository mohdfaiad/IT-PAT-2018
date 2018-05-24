unit Employee_Home_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmTemplate_U, StdCtrls, ExtCtrls;

type
  TfrmEmployeeHome = class(TfrmTemplate)
    procedure FormCreate(Sender: TObject);
  private
    const
      TAG: string = 'EMPLOYEE_HOME';
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmEmployeeHome: TfrmEmployeeHome;

implementation

uses TUser_U, TItem_U, TOrder_U, Logger_U, Data_Module_U;

{$R *.dfm}

procedure TfrmEmployeeHome.FormCreate(Sender: TObject);
var
  user: TUser;
  item: TItem;
  arrItems: TItemArray;
  order: TOrder;
begin
  inherited;
  // Test
  user := TUser.Create('1', 'Stephan', 'Cilliers', employee, now());
  self.setUser(user);

  item := TItem.Create('1', 'Big Daddy', 'Burger', 24.99);

  setLength(arrItems, 2);
  arrItems[0] := item;
  arrItems[1] := item;
  order := TOrder.Create(1, user, 'Ordered', date(), arrItems);
//  showmessage(order.ToString);

  TLogger.clear;
  TLogger.log(TAG, debug, 'Session started');

  data_module.test;

end;

end.
