unit Menu_Management_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, DB, Spin, StdCtrls,
  Grids, DBGrids, ExtCtrls, DBCtrls, Utilities_U;

type
  TfrmManageMenu = class(TForm)
    grdMenu: TDBGrid;
    lblItems: TLabel;
    lblNewItem: TLabel;
    edtTitle: TEdit;
    cmbCategory: TComboBox;
    spnPrice: TSpinEdit;
    lblPrice: TLabel;
    btnCreate: TButton;
    navItems: TDBNavigator;
    procedure FormCreate(Sender: TObject);
    procedure btnCreateClick(Sender: TObject);
  private
    { Private declarations }
    categories: TStringArray;
  public
    { Public declarations }
  end;

var
  frmManageMenu: TfrmManageMenu;

implementation

{$R *.dfm}

uses Data_Module_U, TItem_U;

procedure TfrmManageMenu.btnCreateClick(Sender: TObject);
var
  item: TItem;
begin
  // Validation
  if not ((length(edtTitle.Text) > 0) and (length(cmbCategory.Text) > 0)) and (spnPrice.Value >= 0) then
  begin
    Showmessage('Please provide a Title and Category');
    exit;
  end;

  if Utilities.newItem(item, edtTitle.Text, cmbCategory.Text, spnPrice.Value) then
  begin
    data_module.tblItems.Refresh;
    grdMenu.DataSource.DataSet.Refresh; // TODO: Fix referesh after adding

    Showmessage('Successfully added ' + item.ToString);
  end else
  begin
    Showmessage('Could not add item. Check logs for more information');
  end;
end;

procedure TfrmManageMenu.FormCreate(Sender: TObject);
var
  category: string;
begin
  grdMenu.DataSource.DataSet.Open;
  grdMenu.DataSource.DataSet.Refresh;

  if Utilities.getCategories(categories) then
  begin
    for category in categories do
    begin
      cmbCategory.Items.Add(category);
    end;
  end;
end;

end.
