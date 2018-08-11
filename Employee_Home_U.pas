unit Employee_Home_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmTemplate_U, StdCtrls, ExtCtrls, TItem_U, ComCtrls, Math, Utilities_U,
  TUser_U, TOrder_U, Logger_U, Data_Module_U, StrUtils, Order_Details_U, ShellAPI;

type
  TfrmEmployeeHome = class(TfrmTemplate, IOrderDetailsDelegate)
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
    lblCurrentOrder: TLabel;
    lblOpenOrders: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure lstItemsClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure cmbCategoriesChange(Sender: TObject);
    procedure edtFilterChange(Sender: TObject);
    procedure lstItemsDblClick(Sender: TObject);
    procedure btnConfirmClick(Sender: TObject);
    procedure btnClearOrderClick(Sender: TObject);
    procedure lstOrdersDblClick(Sender: TObject);
    procedure lstOrderItemsDblClick(Sender: TObject);
  private
    const
      TAG: string = 'EMPLOYEE_HOME';
    { Private declarations }
    procedure filterItems;
    procedure updateOrder;
    procedure updateOrders;
  public
    { Public declarations }
    items: TItemArray;
    filteredItems: TItemArray;
    categories: TStringArray;
    orderItems: TItemArray;
    order: TOrder;
    orders: TOrderArray;
    procedure didUpdateOrder;
  end;

var
  frmEmployeeHome: TfrmEmployeeHome;

implementation

{$R *.dfm}



procedure TfrmEmployeeHome.btnAddClick(Sender: TObject);
var
  selectedItem: TItem;
  item: TItem;
begin
  inherited;
  // Add to order
  setLength(orderItems, length(orderItems) + 1);
  selectedItem := filteredItems[lstItems.ItemIndex];
  item := selectedItem.Copy;
  item.SetNote(edtNote.Text);
  orderItems[length(orderItems) - 1] := item;
  btnConfirm.Enabled := true;
  updateOrder;
  
  // Reset
  lstItems.itemIndex := -1;
  edtFilter.Text := '';
  cmbCategories.ItemIndex := 0;
  btnAdd.enabled := false;
  edtNote.Text := '';
  filterItems;
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
  if Utilities.newOrder(order, getUser, 'Preparing', now, orderItems) then
  begin
    setLength(orders, length(orders)+1);
    orders[length(orders)-1] := order;
    updateOrders;
    if Utilities.createReceipt(order) then
    begin
      // Open receipt in notepad
      ShellExecute(Handle, nil,
      PChar(ExtractFilePath(Application.ExeName) + 'Receipts\Order_' + order.getID + '.txt'),
      nil, nil, SW_SHOWNORMAL)
    end;

  end else
  begin
    Showmessage('Could not create order, see logs for more information.');
  end;

  btnConfirm.Enabled := false;
end;

procedure TfrmEmployeeHome.cmbCategoriesChange(Sender: TObject);
begin
  inherited;
  filterItems;
end;

procedure TfrmEmployeeHome.didUpdateOrder;
begin
  orders := nil;
  finalize(orders);
  setLength(orders, 0);
  // Load open orders
  if Utilities.getIncompleteOrders(orders, getUser) then
  begin
    updateOrders;
  end;
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
  filteredItems := nil;
  finalize(filteredItems);
  setLength(filteredItems, 0);

  lstItems.Clear;
  for item in items do
  begin
    if ((length(edtFilter.Text) = 0) or (pos(edtFilter.Text, lowercase(item.GetTitle)) > 0)) and 
    ((cmbCategories.ItemIndex <= 0) or (item.GetCategory = cmbCategories.Text)) then
    begin
      setLength(filteredItems, length(filteredItems)+1);
      filteredItems[length(filteredItems)-1] := item.Copy;
      lstItems.items.add(Format('%-20s%-3.2f', [item.GetTitle, item.GetPrice]));
    end;
  end;
end;

procedure TfrmEmployeeHome.FormCreate(Sender: TObject);
var
  item: TItem;
  category: string;
begin
  inherited;
  lstItems.Clear;

  // Load items
  if Utilities.getItems(items) then
  begin
    filterItems;
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
  if Utilities.getIncompleteOrders(orders, getUser) then
  begin
    updateOrders;
  end;
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

procedure TfrmEmployeeHome.lstOrderItemsDblClick(Sender: TObject);
var
  item: TItem;
begin
  inherited;
  if (lstOrderItems.ItemIndex = -1) or (lstOrderItems.ItemIndex >= length(orderItems)) then
    exit;

  item := orderItems[lstOrderItems.ItemIndex];
  showmessage(quotedStr(item.GetTitle) + ' note: ' + quotedStr(ifthen(length(item.GetNote) > 0, item.getNote, 'None')));
end;

procedure TfrmEmployeeHome.lstOrdersDblClick(Sender: TObject);
var
  order: TOrder;
  form: TFrmOrderDetails;
begin
  inherited;
  if (lstOrders.ItemIndex = -1) or (lstOrders.ItemIndex > length(orders))  then
    exit;

  order := orders[lstOrders.itemIndex-1];

  form := TfrmOrderDetails.create(self, self, order);
  form.ShowModal;
end;


procedure TfrmEmployeeHome.updateOrder;
var
  item: TItem;
  subtotal: Double;
begin
  // IMPROVEMENT: Abbreviate order with duplicates with qty
  lstOrderItems.Clear;
  subtotal := 0;
  for item in orderItems do
  begin
    subtotal := subtotal + item.GetPrice;
    lstOrderItems.items.add(Format('%-20s%-3.2f', [item.GetTitle + ifthen(length(item.GetNote) > 0, '*', ''), item.GetPrice]));
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
    if not order.IsComplete then
     lstOrders.Items.Add(Format('%-4s %-10s %-4.2f', [order.GetID, order.GetStatus, order.GetTotal]));
  end;
end;

end.
