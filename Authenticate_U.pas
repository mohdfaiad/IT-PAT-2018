unit Authenticate_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TForm2 = class(TForm)
    imgLogo: TImage;
    pnlLogin: TPanel;
    lblWelcome: TLabel;
    edtID: TEdit;
    edtPassword: TEdit;
    btnLogin: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

end.
