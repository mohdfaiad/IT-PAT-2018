unit TUser_U;

interface

uses DateUtils, SysUtils;

type
  TUserType = (Employee = 1, Manager);

  TUser = class(TObject)
    private
      id: integer;
      firstName: string;
      lastname: string;
      userType: TUserType;
      registerDate: TDateTime;
    public
      constructor Create(id: integer; firstname, lastname: string; userType: TUserType; registerDate: TDateTime);

      // Accessors
      function GetID: integer;
      function GetFirstName: string;
      function GetLastName: string;
      function GetFullName: string;
      function GetType: TUserType;
      function GetDateRegistered: TDateTime;
      function GetDaysRegistered: integer;
      function ToString: string;

      // Mutators
      procedure SetFirstName(firstname: string);
      procedure SetLastName(lastname: string);
  end;

implementation

{ TUser }

constructor TUser.Create(id: integer; firstname, lastname: string;
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

function TUser.GetID: integer;
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
  result := Format('%s [%f] (Account is %f days old)', [self.GetFullName, self.GetDaysRegistered, self.id]);
end;

end.
