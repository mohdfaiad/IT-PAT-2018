unit TItem_U;

interface

uses SysUtils;

type
  TItem = class(TObject)
    private
      id: string;
      title: string;
      category: string;
      price: double;
      note: string;
    public
      constructor Create(id: string; title, category: string; price: double);

      // Accessors
      function GetID: string;
      function GetTitle: string;
      function GetPrice: double;
      function GetNote: string;

      // Mutators
      procedure SetNote(note: string);

      // Auxilary
      function ToString: string;
  end;

  TItemArray = array of TItem;
implementation

{ TItem }

constructor TItem.Create(id: string; title, category: string; price: double);
begin
  self.id := id;
  self.title := title;
  self.category := category;
  self.price := price;
end;

function TItem.GetID: string;
begin
  result := self.id;
end;

function TItem.GetNote: string;
begin
  result := self.note;
end;

function TItem.GetPrice: double;
begin
  result := self.price;
end;

function TItem.GetTitle: string;
begin
  result := self.title;
end;

procedure TItem.SetNote(note: string);
begin
  self.note := note;
end;

function TItem.ToString: string;
begin
  result := Format('[%s] Title: %s, Category: %s, Price: %m', [id, title, category, price]);
end;

end.
