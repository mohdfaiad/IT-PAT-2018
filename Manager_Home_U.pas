unit Manager_Home_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmTemplate_U, StdCtrls, ExtCtrls, Grids, DBGrids;

type
  TfrmManagerHome = class(TfrmTemplate)
    lstEmployees: TListBox;
    btnNewEmployee: TButton;
    btnRemoveEmployee: TButton;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure lstEmployeesClick(Sender: TObject);
    procedure btnRemoveEmployeeClick(Sender: TObject);
    procedure btnNewEmployeeClick(Sender: TObject);
  private
    { Private declarations }
    procedure refreshEmployees;
    procedure test;
  public
    { Public declarations }
  end;

var
  frmManagerHome: TfrmManagerHome;

implementation

uses TUser_U, TItem_U, TOrder_U, Logger_U, Data_Module_U, Utilities_U,
  New_User_U;

{$R *.dfm}

var
  arrEmployees: TUserArray;

procedure TfrmManagerHome.btnNewEmployeeClick(Sender: TObject);
var
  frmNewUser: TfrmNewUser;
begin
  inherited;
  frmNewUser := TFrmNewUser.Create(self);
  frmNewUser.ShowModal;
  refreshEmployees;
end;

procedure TfrmManagerHome.btnRemoveEmployeeClick(Sender: TObject);
var
  selectedUser: TUser;
  optionselected: integer;
begin
  inherited;
  selectedUser := arrEmployees[lstEmployees.ItemIndex];
  optionselected := MessageDlg('Remove ' + selectedUser.GetFullName + '?',mtInformation, mbOKCancel, 0);

  if TMsgDlgBtn(optionSelected) <> mbOK then  // ??
  begin
    if Utilities.removeUser(selectedUser) then
      refreshEmployees;
  end;

end;

procedure TfrmManagerHome.FormCreate(Sender: TObject);
begin
  inherited;
  if sender = self then
    test;


end;

procedure TfrmManagerHome.lstEmployeesClick(Sender: TObject);
begin
  inherited;
  btnRemoveEmployee.Enabled := true;
end;

procedure TfrmManagerHome.refreshEmployees;
var
  user: TUser;
begin
  lstEmployees.clear;
  setLength(arrEmployees, 0);
  if Utilities.getEmployees(arrEmployees) then
  begin
    for user in arrEmployees do
    begin
      lstEmployees.Items.Add(Format('(%s) %s', [user.GetID, user.GetFullName]));
    end;
  end;
end;

procedure TfrmManagerHome.test;
var
  user: TUser;
  items: TItemArray;
  item: TItem;
  order: TOrder;
begin
  user := TUser.Create('2', 'Stephan', 'Cilliers', employee, now());
  self.setUser(user);

  refreshEmployees;
//  if Utilities.getItems(items) then
//  begin
//    showmessage(inttostr(length(items)));
//  end;
//
//  if Utilities.newOrder(order, self.getUser, 'Preparing', Date, items) then
//  begin
//    showmessage(order.ToString);
//  end;
//
//  if Utilities.updateOrder(order, 'Fetch') then
//  begin
//    showmessage(order.ToString);
//  end;


end;

end.
