unit TOrder_U;

interface

uses SysUtils, TUser_U, TItem_U;

type
  TOrder = class(TObject)
    private
      id: string;
      employee: TUser;
      status: string;
      createDate: TDateTime;
      completeDate: TDateTime;
      items: TItemArray;
    public
      constructor Create(id: string; employee: TUser; status: string; createDate: TDateTime; items: TItemArray);
      // Accessors
      function GetID: string;
      function GetEmployee: TUser;
      function GetStatus: string;
      function GetCreateDate: TDateTime;
      function GetCompleteDate: TDateTime;
      function GetItems: TItemArray;
      function GetTotal: double;
      function IsComplete: boolean;

      // Mutators
      procedure SetStatus(status: string);
      procedure SetCompleteDate(completeDate: TDateTime);

      // Auxilary
      function ToString: string;
  end;

  TOrderArray = array of TOrder;

implementation

{ TOrder }

constructor TOrder.Create(id: string; employee: TUser; status: string;
  createDate: TDateTime; items: TItemArray);
begin
  self.id := id;
  self.employee := employee;
  self.status := status;
  self.createDate := date;
  self.items := items;
  self.completeDate := -69000;
end;

function TOrder.GetCompleteDate: TDateTime;
begin
  completeDate := self.completeDate;
end;

function TOrder.GetCreateDate: TDateTime;
begin
  result := self.createDate;
end;

function TOrder.GetEmployee: TUser;
begin
  result := self.employee;
end;

function TOrder.GetID: string;
begin
  result := self.id;
end;

function TOrder.GetItems: TItemArray;
begin
  result := self.items;
end;

function TOrder.GetStatus: string;
begin
  result := self.status;
end;

function TOrder.GetTotal: double;
var
  total: double;
  item: TItem;
begin
  for item in items do
  begin
    total := total + item.GetPrice;
  end;

  result := total;
end;

function TOrder.IsComplete: boolean;
begin
  result := self.completeDate > -69000;
end;

procedure TOrder.SetCompleteDate(completeDate: TDateTime);
begin
  self.completeDate := completeDate;
end;

procedure TOrder.SetStatus(status: string);
begin
  self.status := status;
end;

function TOrder.ToString: string;
begin
  result := Format('[%s] Employee: %s, Items: %s, Total: %m', [id, employee.GetFullName, inttostr(length(items)), self.GetTotal]);
end;

end.
