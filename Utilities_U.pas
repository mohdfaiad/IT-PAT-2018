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
      class function newUser(var user: TUser; var password: string; firstname, lastname: string): boolean;
      class function changePassword(user: TUser; oldPassword, newPassword: string): boolean;
      class function updateUserInformation(user: TUser; var newUser: TUser): boolean;

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

class function Utilities.newItem(var item: TItem; title, category: string;
  price: double): boolean;
begin

end;

class function Utilities.newOrder(var order: TOrder; employee: TUser;
  status: string; createDate: TDateTime; items: TItemArray): boolean;
begin

end;

class function Utilities.newUser(var user: TUser; var password: string;
  firstname, lastname: string): boolean;
begin

end;

class function Utilities.updateUserInformation(user: TUser;
  var newUser: TUser): boolean;
begin

end;

end.
