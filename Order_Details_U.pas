unit Order_Details_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, TOrder_U, StrUtils,
  Menus;

type
  IOrderDetailsDelegate = Interface(IInterface)
    procedure didUpdateOrder;
  End;
  TfrmOrderDetails = class(TForm)
    lstItems: TListBox;
    cmbStatus: TComboBox;
    btnUpdate: TButton;
    lblDetails: TLabel;
    procedure btnUpdateClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lstItemsDblClick(Sender: TObject);
  private
    { Private declarations }
    order: TOrder;
    sender: IOrderDetailsDelegate;
    procedure setOrder(order: TOrder);
  public
    { Public declarations }
    constructor create(aowner: TComponent; sender: IOrderDetailsDelegate; order: TOrder); reintroduce; overload;
  end;

var
  frmOrderDetails: TfrmOrderDetails;

implementation

{$R *.dfm}

uses TItem_U, Utilities_U;



{ TfrmOrderDetails }

procedure TfrmOrderDetails.btnUpdateClick(Sender: TObject);
begin
  if cmbStatus.Text <> order.GetStatus then
  begin
    Utilities.updateOrder(order, cmbStatus.Text);
    self.sender.didUpdateOrder;
    if order.IsComplete then
    begin
      self.CloseModal;
      self.Close;
    end;
  end;
end;

constructor TfrmOrderDetails.create(aowner: TComponent;
  sender: IOrderDetailsDelegate; order: TOrder);
begin
  inherited create(aowner);
  self.order := order;
  self.sender := sender;
end;

procedure TfrmOrderDetails.FormCreate(Sender: TObject);
begin
  setOrder(self.order);
end;

procedure TfrmOrderDetails.lstItemsDblClick(Sender: TObject);
var
  item: TItem;
begin
  if (lstItems.ItemIndex = -1) or (lstItems.ItemIndex >= length(order.GetItems)) then
    exit;

  item := self.order.GetItems[lstItems.ItemIndex];
  showmessage(quotedStr(item.GetTitle) + ' note: ' + quotedStr(ifthen(length(item.GetNote) > 0, item.getNote, 'None')));

end;

procedure TfrmOrderDetails.setOrder(order: TOrder);
var
  item: TItem;
  subtotal: double;
begin
  self.order := order;

  self.Caption := 'Order ' + order.GetID + ' details';

  // Label
  lblDetails.Caption := order.ToString;

  // Items
  lstItems.Clear;
  subtotal := 0;
  for item in order.GetItems do
  begin
    subtotal := subtotal + item.GetPrice;
    lstItems.items.add(Format('%-20s%-3.2f', [item.GetTitle + ifthen(length(item.GetNote) > 0, '*', ''), item.GetPrice]));
  end;
  lstItems.Items.Add('');
  lstItems.Items.Add(Format('Total: R%.2f', [subtotal]));

  // Status
  cmbStatus.Text := order.GetStatus;
end;

end.
