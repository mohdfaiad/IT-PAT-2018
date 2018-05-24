unit Utilities_U;

interface

uses TUser_U, TItem_U, TOrder_U, ADODB, data_module_U, Logger_U, IdGlobal, IdHash, IdHashMessageDigest, SysUtils;

type
  Utilities = class
    private
      const
        TAG: string = 'UTILITIES';
    public
      // User
      class function loginUser(userID, password: string; var user: TUser; hashed: boolean = false): boolean;
      class function newUser(var user: TUser; password: string; firstname, lastname: string; userType: TUserType; registerDate: TDateTime): boolean;
      class function changePassword(user: TUser; oldPassword, newPassword: string): boolean;
      class function updateUserInformation(user: TUser; var newUser: TUser): boolean;

      class function getEmployees(var arrEmployees: TUserArray): boolean;
      class function removeUser(user: TUser): boolean;

      // Item
      class function newItem(var item: TItem; title, category: string; price: double): boolean;

      // Order
      class function newOrder(var order: TOrder; employee: TUser; status: string; createDate: TDateTime; items: TItemArray): boolean;

      // Misc
      class function getMD5Hash(s: string): string;
  end;

implementation

{ Utilities }

class function Utilities.changePassword(user: TUser; oldPassword,
  newPassword: string): boolean;
var
  qry: TADOQuery;
begin
  // Check if old password is correct
  qry := data_module.queryDatabase('SELECT * FROM Users WHERE [ID] = ' + user.getID + ' AND [Password] = ' + QuotedStr(getMD5Hash(oldPassword)), data_module.qry);

  if qry.eof then
  begin
    TLogger.log(TAG, Debug, 'Failed to change password of user with ID: ' + user.getID);
    result := false;
    Exit;
  end;

  // Update password
  result := data_module.modifyDatabase('UPDATE Users SET [Password] = ' + QuotedStr(getMD5Hash(newPassword)) +
  ' WHERE [ID] = ' + user.getID, data_module.qry);

  if result then
  begin
    TLogger.log(TAG, Debug, 'Successfully changed password of user with ID: ' + user.getID);
  end else
  begin
    TLogger.log(TAG, Debug, 'Failed to change password of user with ID: ' + user.getID);
  end;
end;

class function Utilities.getEmployees(var arrEmployees: TUserArray): boolean;
var
  qry: TADOQuery;
  user: TUser;
begin
  try
    qry := data_module.queryDatabase('SELECT * FROM Users WHERE Type = 1 ORDER BY LastName', data_module.qry);

    while not qry.Eof do
    begin
      setLength(arrEmployees, length(arrEmployees)+1);
      user := TUser.Create(
        qry.FieldByName('ID').AsString,
        qry.FieldByName('FirstName').AsString,
        qry.FieldByName('LastName').AsString,
        TUserType(qry.FieldByName('Type').AsInteger),
        qry.FieldByName('RegisterDate').AsDateTime
      );
      arrEmployees[length(arrEmployees)-1] := user;
      qry.Next;
    end;
    result := true;
  except
    result := false;
  end;
end;

class function Utilities.getMD5Hash(s: string): string;
var
  hashMessageDigest5: TIdHashMessageDigest5;
begin
  hashMessageDigest5 := nil;
  try
    hashMessageDigest5 := TIdHashMessageDigest5.Create;
    result := IdGlobal.IndyLowerCase(hashMessageDigest5.HashStringAsHex(s));
  finally
    hashMessageDigest5.Free;
  end;
end;

class function Utilities.loginUser(userID, password: string; var user: TUser;
  hashed: boolean): boolean;
var
  qry: TADOQuery;
  id, firstname, lastname: string;
  userType: Integer;
  registerDate: TDateTime;
begin
  {
    1. Check if user exists
    2. Retrieve user record
    3. Create and return TUser object
  }
  if not hashed then
    password := getMD5Hash(password);

  qry := data_module.queryDatabase('SELECT * FROM Users WHERE ID = ' + userID
      + ' AND password = ' + quotedStr(password), data_module.qry);

  // 1. Check if user exists
  if not qry.Eof then
  begin
    // 2. Retrieve user record
    id := qry.FieldByName('ID').AsString;
    userType := qry.FieldByName('Type').AsInteger;
    firstname := qry.FieldByName('FirstName').AsString;
    lastname := qry.FieldByName('LastName').AsString;
    registerDate := qry.FieldByName('RegisterDate').AsDateTime;

    // 3. Create and return TUser object
    user := TUser.Create(id, firstname, lastname, TUserType(userType), registerDate);

    TLogger.log(TAG, Debug,
      'Successfully logged in user with ID: ' + id);

    result := true;
    Exit;
  end
  else
    result := false;

  TLogger.log(TAG, Error, 'Failed login attempt with ID: ' + ID);

end;

class function Utilities.newItem(var item: TItem; title, category: string;
  price: double): boolean;
begin

end;

class function Utilities.newOrder(var order: TOrder; employee: TUser;
  status: string; createDate: TDateTime; items: TItemArray): boolean;
begin

end;

class function Utilities.newUser(var user: TUser; password: string;
  firstname, lastname: string; userType: TUserType; registerDate: TDateTime): boolean;
begin
  // password := getMD5Hash(password); // TODO:
  result := data_module.modifyDatabase(Format('INSERT INTO Users (FirstName, LastName, Type, RegisterDate) VALUES ("%s", "%s", %s, #%s#)', [
    firstName,
    lastName,
    inttostr(ord(userType)),
    datetostr(registerdate)
  ]), data_module.qry);

end;

class function Utilities.removeUser(user: TUser): boolean;
begin
  result := data_module.modifyDatabase(Format('DELETE FROM Users WHERE ID = %s', [user.GetID]), data_module.qry);
end;

class function Utilities.updateUserInformation(user: TUser;
  var newUser: TUser): boolean;
begin

end;

end.
