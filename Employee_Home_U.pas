unit Employee_Home_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmTemplate_U, StdCtrls, ExtCtrls, TItem_U, Vcl.ComCtrls, Math, Utilities_U,
  TUser_U, TOrder_U, Logger_U, Data_Module_U;

type
  TfrmEmployeeHome = class(TfrmTemplate)
    lstItems: TListBox;
    cmbCategories: TComboBox;
    edtNote: TEdit;
    btnAdd: TButton;
    lblNote: TLabel;
    lblCategory: TLabel;
    edtFilter: TEdit;
    lstOrderItems: TListBox;
    btnClearOrder: TButton;
    btnConfirm: TButton;
    lstOrders: TListBox;
    procedure FormCreate(Sender: TObject);
    procedure lstItemsClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure cmbCategoriesChange(Sender: TObject);
    procedure edtFilterChange(Sender: TObject);
    procedure lstItemsDblClick(Sender: TObject);
    procedure btnConfirmClick(Sender: TObject);
    procedure btnClearOrderClick(Sender: TObject);
    procedure lstOrdersClick(Sender: TObject);
  private
    const
      TAG: string = 'EMPLOYEE_HOME';
    { Private declarations }
    procedure test;
    procedure filterItems;
    procedure updateOrder;
    procedure updateOrders;
  public
    { Public declarations }
    items: TItemArray;
    categories: TStringArray;
    orderItems: TItemArray;
    order: TOrder;
    orders: TOrderArray;
  end;

var
  frmEmployeeHome: TfrmEmployeeHome;

implementation

{$R *.dfm}

procedure TfrmEmployeeHome.btnAddClick(Sender: TObject);
var
  item: TItem;
begin
  inherited;
  // Add to order
  setLength(orderItems, length(orderItems) + 1);
  item := items[lstItems.ItemIndex];
  item.SetNote(edtNote.Text);
  orderItems[length(orderItems) - 1] := item;
  updateOrder;
  
  // Reset
  lstItems.itemIndex := -1;
  edtFilter.Text := '';
  cmbCategories.ItemIndex := -1;
  btnAdd.enabled := false;
  edtNote.Text := '';
end;

procedure TfrmEmployeeHome.btnClearOrderClick(Sender: TObject);
begin
  inherited;
  orderItems := nil;
  finalize(orderItems);
  setLength(orderItems, 0);
  updateOrder;
end;

procedure TfrmEmployeeHome.btnConfirmClick(Sender: TObject);
begin
  inherited;
  // TODO: Receipt
  if Utilities.newOrder(order, getUser, 'Preparing', now, orderItems) then
  begin
    setLength(orders, length(orders)+1);
    orders[length(orders)-1] := order;
    updateOrders;
    Showmessage(order.ToString);
  end else
  begin
    Showmessage('Could not create order, see logs for more information.');
  end;
end;

procedure TfrmEmployeeHome.cmbCategoriesChange(Sender: TObject);
var
  item: TItem;
begin
  inherited;
  filterItems;
end;

procedure TfrmEmployeeHome.edtFilterChange(Sender: TObject);
begin
  inherited;
  filterItems;
end;

procedure TfrmEmployeeHome.filterItems;
var
  item: TItem;
begin
  lstItems.Clear;
  for item in items do
  begin
    if ((length(edtFilter.Text) = 0) or (pos(edtFilter.Text, lowercase(item.GetTitle)) > 0)) and 
    ((cmbCategories.ItemIndex <= 0) or (item.GetCategory = cmbCategories.Text)) then
    begin
       lstItems.items.add(Format('%-20s%-3.2f', [item.GetTitle, item.GetPrice]));  
    end;
  end;
end;

procedure TfrmEmployeeHome.FormCreate(Sender: TObject);
var
  item: TItem;
  order: TOrder;
  category: string;
begin
  inherited;
  lstItems.Clear;

  // Load items
  if Utilities.getItems(items) then
  begin
    for item in items do
    begin
      lstItems.items.add(Format('%-20s%-3.2f', [item.GetTitle, item.GetPrice]));
    end;
  end;

  // Load categories
  if Utilities.getCategories(categories) then
  begin
    for category in categories do
    begin
      cmbCategories.Items.Add(category);
    end;
  end;
  
  // Load open orders
  if Utilities.getOrders(orders, getUser) then
  begin
    updateOrders;
  end;
  
//  if sender = self then
//    test
end;

procedure TfrmEmployeeHome.lstItemsClick(Sender: TObject);
begin
  inherited;
  if lstItems.ItemIndex > -1 then
  begin
    btnAdd.Enabled := true;
  end;
end;

procedure TfrmEmployeeHome.lstItemsDblClick(Sender: TObject);
begin
  inherited;
  if lstItems.ItemIndex > -1 then
  begin
    btnAdd.Click;
  end;
end;

procedure TfrmEmployeeHome.lstOrdersClick(Sender: TObject);
begin
  inherited;
  // TODO: Implement updating order details
end;

procedure TfrmEmployeeHome.test;
var
  user: TUser;
  item: TItem;
  arrItems: TItemArray;
  order: TOrder;
begin
  user := TUser.Create('1', 'Stephan', 'Cilliers', employee, now());
  self.setUser(user);

  item := TItem.Create('1', 'Big Daddy', 'Burger', 24.99);

  setLength(arrItems, 2);
  arrItems[0] := item;
  arrItems[1] := item;
  order := TOrder.Create('1', user, 'Ordered', date(), arrItems);
//  showmessage(order.ToString);

  TLogger.clear;
  TLogger.log(TAG, debug, 'Session started');

//  data_module.test;
end;

procedure TfrmEmployeeHome.updateOrder;
var
  item: TItem;
  subtotal: Double;
begin
  // TODO: Abbreviate order with duplicates with qty
  lstOrderItems.Clear;
  subtotal := 0;
  for item in orderItems do
  begin
    subtotal := subtotal + item.GetPrice;
    lstOrderItems.items.add(Format('%-20s%-3.2f', [item.GetTitle, item.GetPrice]));
  end;
  lstOrderItems.Items.Add('');
  lstOrderItems.Items.Add(Format('Total: R%.2f', [subtotal]));
end;

procedure TfrmEmployeeHome.updateOrders;
var
  order: TOrder;
begin
  lstOrders.clear;
  lstOrders.Items.Add(Format('%-4s %-10s %-4s', ['ID', 'Status', 'Price']));
  for order in orders do
  begin 
    lstOrders.Items.Add(Format('%-4s %-10s %-4.2f', [order.GetID, order.GetStatus, order.GetTotal]));
  end;
end;

end.
