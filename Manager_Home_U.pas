unit Manager_Home_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmTemplate_U, StdCtrls, ExtCtrls, Grids, DBGrids, ComCtrls, TUser_U, TItem_U, TOrder_U, Logger_U, Data_Module_U, Utilities_U,
  New_User_U;

type
  TfrmManagerHome = class(TfrmTemplate, INewUserDelegate)
    lstEmployees: TListBox;
    btnNewEmployee: TButton;
    btnRemoveEmployee: TButton;
    Label1: TLabel;
    pnlDetails: TPanel;
    redDetails: TRichEdit;
    btnManageMenu: TButton;
    procedure FormCreate(Sender: TObject);
    procedure lstEmployeesClick(Sender: TObject);
    procedure btnRemoveEmployeeClick(Sender: TObject);
    procedure btnNewEmployeeClick(Sender: TObject);
    procedure btnManageMenuClick(Sender: TObject);
  private
    { Private declarations }
    procedure refreshEmployees;
    procedure showDetails(employee: TUser);
  public
    { Public declarations }
    procedure didCreateNewUser;
  end;

var
  frmManagerHome: TfrmManagerHome;

implementation

{$R *.dfm}

uses Menu_Management_U;

var
  arrEmployees: TUserArray;

procedure TfrmManagerHome.btnManageMenuClick(Sender: TObject);
var
  frmManageMenu: TfrmManageMenu;
begin
  inherited;
  frmManageMenu := TfrmManageMenu.Create(self);
  frmManageMenu.ShowModal;
end;

procedure TfrmManagerHome.btnNewEmployeeClick(Sender: TObject);
var
  frmNewUser: TfrmNewUser;
begin
  inherited;
  frmNewUser := TFrmNewUser.Create(self, self);
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

procedure TfrmManagerHome.didCreateNewUser;
begin
  self.refreshEmployees;
end;

procedure TfrmManagerHome.FormCreate(Sender: TObject);
var
  titles: TStringArray;
  quantities: TIntegerArray;
begin
  inherited;
  refreshEmployees;

  // TODO: Charts
  if Utilities.getMostPopularByCategory(titles, quantities, 'Beverage') then
  begin
//    showmessage(titles[0]);
  end;
  
end;

procedure TfrmManagerHome.lstEmployeesClick(Sender: TObject);
begin
  inherited;
  btnRemoveEmployee.Enabled := true;

  if lstEmployees.ItemIndex > -1 then
  begin
    showDetails(arrEmployees[lstEmployees.ItemIndex]);
  end;
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

procedure TfrmManagerHome.showDetails(employee: TUser);
var
  ordersTaken: integer;
  revenueGenerated: double;
begin
  // TODO: Show stats
  pnlDetails.visible := true;
  redDetails.Clear;
  redDetails.Lines.Add(employee.GetFullName);
  redDetails.Lines.Add('');
  redDetails.Lines.Add('Register date ' + datetostr(employee.GetDateRegistered) + ' (' + inttostr(employee.GetDaysRegistered) + ' days)');

  redDetails.Lines.Add('');
  
  if Utilities.getOrderCount(ordersTaken, employee) then
  begin
    redDetails.Lines.Add(inttostr(ordersTaken) + ' orders processed.');
  end;

  if Utilities.getRevenueGenerated(revenueGenerated, employee) then
  begin
    redDetails.Lines.Add(Format('R%.2f revenue generated.', [revenueGenerated]));
  end;

end;

end.
