unit frmTemplate_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TUser_U;

type
  TfrmTemplate = class(TForm)
  private
    currentUser: TUser;
  public
    function getUser: TUser;
    procedure setUser(user: TUser);
  end;

var
  frmTemplate: TfrmTemplate;

implementation

{$R *.dfm}

end.
