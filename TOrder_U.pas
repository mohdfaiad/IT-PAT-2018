unit TOrder_U;

interface

uses SysUtils, TUser_U, TItem_U;

type
  TOrder = class(TObject)
    private
      id: integer;
      employee: TUser;
      status: string;
      createDate: date;
      completeDate: date;
      items: TItemArray;
    public
      constructor Create(id: integer; employee: TUser; status: string; createDate: date, items: array of TItem);
      function GetID: integer;
      function GetEmployee: TUser;
      function GetStatus: string;
      procedure SetStatus(status: string);
      function GetCreateDate: date;
      function GetCompleteDate: date;
      procedure SetCompleteDate(completeDate: date); // Maybe use Complete method instead
      function IsComplete: boolean;
      function GetItems: TItemArray;
      function GetTotal: double;
      function ToString: string;
  end;

implementation

end.
