unit TUser_U;

interface

uses DateUtils, SysUtils;

type
  TUserType = (Employee = 1, Manager);

  TUser = class(TObject)
    private
      id: string;  // TODO: make IDs string
      firstName: string;
      lastname: string;
      userType: TUserType;
      registerDate: TDateTime;
    public
      constructor Create(id: string; firstname, lastname: string; userType: TUserType; registerDate: TDateTime);

      // Accessors
      function GetID: string;
      function GetFirstName: string;
      function GetLastName: string;
      function GetFullName: string;
      function GetType: TUserType;
      function GetDateRegistered: TDateTime;
      function GetDaysRegistered: integer;

      // Mutators
      procedure SetFirstName(firstname: string);
      procedure SetLastName(lastname: string);

      // Auxilary
      function ToString: string;
  end;

  TUserArray = array of TUser;

implementation

{ TUser }

constructor TUser.Create(id: string; firstname, lastname: string;
  userType: TUserType; registerDate: TDateTime);
begin
  self.id := id;
  self.firstName := firstName;
  self.lastname := lastName;
  self.userType := userType;
  self.registerDate := registerdate;
end;

function TUser.GetDateRegistered: TDateTime;
begin
  result := self.registerDate;
end;

function TUser.GetDaysRegistered: integer;
begin
  result := DaysBetween(Date(), self.registerDate);
end;

function TUser.GetFirstName: string;
begin
  result := self.firstName;
end;

function TUser.GetFullName: string;
begin
  result := Format('%s %s', [self.firstName, self.lastname]);
end;

function TUser.GetID: string;
begin
  result := self.id;
end;

function TUser.GetLastName: string;
begin
  result := self.lastname;
end;

function TUser.GetType: TUserType;
begin
  result := self.userType;
end;

procedure TUser.SetFirstName(firstname: string);
begin
  self.firstName := firstName;
end;

procedure TUser.SetLastName(lastname: string);
begin
  self.lastname := lastname;
end;

function TUser.ToString: string;
begin
  result := Format('[%s] %s (Account is %s days old)', [self.id, self.GetFullName, inttostr(self.GetDaysRegistered)]);
end;

end.
