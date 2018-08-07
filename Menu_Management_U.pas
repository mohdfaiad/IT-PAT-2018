unit Menu_Management_U;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Samples.Spin, Vcl.StdCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Vcl.DBCtrls;

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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmManageMenu: TfrmManageMenu;

implementation

{$R *.dfm}

uses Data_Module_U;

procedure TfrmManageMenu.FormCreate(Sender: TObject);
begin
  grdMenu.DataSource.DataSet.Open;
  grdMenu.DataSource.DataSet.Refresh;
end;

end.
