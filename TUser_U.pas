unit TUser_U;

interface

uses SysUtils;

type
  TUserType = (Employee = 1, Manager);

  TUser = class(TObject)
    private
      id: integer;
      firstName: string;
      lastname: string;
      userType: TUserType;
      registerDate: date;
    public
      constructor Create(id: integer; firstname, lastname: string; userType: TUserType; registerDate: date);

      // Accessors
      function GetID: integer;
      function GetFirstName: string;
      function GetLastName: string;
      function GetFullName: string;
      function GetType: TUserType;
      function GetDateRegistered: date;
      function GetDaysRegistered: integer;
      function ToString: string;

      // Mutators
      procedure SetFirstName(firstname: string);
      procedure SetLastName(lastname: string);
  end;

implementation

end.
