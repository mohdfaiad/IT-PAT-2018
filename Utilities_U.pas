unit Utilities_U;

interface

uses TUser_U, TItem_U, TOrder_U, ADODB, data_module_U, Logger_U, IdGlobal, IdHash, IdHashMessageDigest, SysUtils, Dialogs;

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

      class function getEmployees(var employees: TUserArray): boolean;
      class function removeUser(user: TUser): boolean;

      // Item
      class function newItem(var item: TItem; title, category: string; price: double): boolean;
      class function getItems(var items: TItemArray): boolean;
      class function getOrderItems(var items: TItemArray; orderID: string): boolean;

      // Order
      class function newOrder(var order: TOrder; employee: TUser; status: string; createDate: TDateTime; items: TItemArray): boolean;
      class function updateOrder(var order: TOrder; newStatus: String): boolean;
      class function getOrders(var orders: TOrderArray; employee: TUser): boolean;

      // Misc
      class function getMD5Hash(s: string): string;
      class function getLastID(var query: TADOQuery { or TQuery } ): Integer;
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

class function Utilities.getEmployees(var employees: TUserArray): boolean;
var
  qry: TADOQuery;
  user: TUser;
begin
  try
    qry := data_module.queryDatabase('SELECT * FROM Users WHERE Type = 1 ORDER BY LastName', data_module.qry);

    while not qry.Eof do
    begin
      setLength(employees, length(employees)+1);
      user := TUser.Create(
        qry.FieldByName('ID').AsString,
        qry.FieldByName('FirstName').AsString,
        qry.FieldByName('LastName').AsString,
        TUserType(qry.FieldByName('Type').AsInteger),
        qry.FieldByName('RegisterDate').AsDateTime
      );
      employees[length(employees)-1] := user;
      qry.Next;
    end;
    result := true;
  except
    result := false;
  end;
end;

class function Utilities.getItems(var items: TItemArray): boolean;
var
  qry: TADOQuery;
  item: TItem;
begin
  try
    qry := data_module.queryDatabase('SELECT * FROM Items', data_module.qry);

    while not qry.Eof do
    begin
      setLength(items, length(items)+1);
      item := TItem.Create(
        qry.FieldByName('ID').AsString,
        qry.FieldByName('Title').AsString,
        qry.FieldByName('Category').AsString,
        qry.FieldByName('Price').AsFloat
      );
      items[length(items)-1] := item;
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

class function Utilities.getOrderItems(var items: TItemArray;
  orderID: string): boolean;
var
  qry: TADOQuery;
  item: TItem;
begin
  // TODO: Test
  try
    qry := data_module.queryDatabase(
      'SELECT Items.ID AS [ID], Title, Category, Price, Note FROM Items ' +
      'INNER JOIN Order_Item ON Items.ID = Order_Item.ItemID ' +
      'WHERE Order_Item.OrderID = ' + orderID,
    data_module.qry);

    while not qry.Eof do
    begin
      setLength(items, length(items)+1);
      item := TItem.Create(
        qry.FieldByName('ID').AsString,
        qry.FieldByName('Title').AsString,
        qry.FieldByName('Category').AsString,
        qry.FieldByName('Price').AsFloat
      );
      item.SetNote(qry.FieldByName('Note').AsString);
      items[length(items)-1] := item;
      qry.Next;
    end;
    result := true;
  except
    result := false;
  end;

end;

class function Utilities.getOrders(var orders: TOrderArray; employee: TUser): boolean;
var
  qry: TADOQuery;
  order: TOrder;
  id: string;
begin
  try
    qry := data_module.queryDatabase(Format('SELECT * FROM Orders WHERE EmployeeID = %s', [employee.GetID]), data_module.qry);

    while not qry.Eof do
    begin
      setLength(orders, length(orders)+1);
      id := qry.FieldByName('ID').AsString;

      TItem.Create(
        qry.FieldByName('ID').AsString,
        qry.FieldByName('Title').AsString,
        qry.FieldByName('Category').AsString,
        qry.FieldByName('Price').AsFloat
      );
      orders[length(order)-1] := order;
      qry.Next;
    end;
    result := true;
  except
    result := false;
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
  result := data_module.modifyDatabase(Format('INSERT INTO Items (Title, Category, Price) VALUES (%s, %s, %s)', [
    quotedstr(title),
    quotedStr(category),
    floattostr(price)
  ]), data_module.qry);

  item := TItem.Create(inttostr(getLastID(data_module.qry)), title, category, price);

  if result then
  begin
    TLogger.log(TAG, Debug, 'Successfully added new item with ID: ' + item.GetID);
  end else
  begin
    TLogger.log(TAG, Debug, 'Failed to add item with name: ' + item.GetTitle);
  end;
end;

class function Utilities.newOrder(var order: TOrder; employee: TUser;
  status: string; createDate: TDateTime; items: TItemArray): boolean;
var
  item: TItem;
  note: string;
begin
  result := data_module.modifyDatabase(Format('INSERT INTO Orders (EmployeeID, Status, CreateDate) VALUES (%s, %s, #%s#)', [
    employee.GetID,
    quotedStr(status),
    FormatDateTime('c', createDate)
  ]), data_module.qry);

  order := TOrder.Create(inttostr(getLastID(data_module.qry)), employee, status, createDate, items);

  for item in items do
  begin
    note := item.GetNote; // TODO: Check if null - return empty string
    result := result and data_module.modifyDatabase(Format('INSERT INTO Order_Item (OrderID, ItemID, [Note]) VALUES (%s, %s, %s)', [
    order.GetID,
    item.GetID,
    quotedStr(note)
  ]), data_module.qry);
    showmessage(booltostr(result));
  end;

  if result then
  begin
    TLogger.log(TAG, Debug, 'Successfully created order with ID: ' + order.GetID);
  end else
  begin
    TLogger.log(TAG, Debug, 'Failed to create order with ID: ' + order.GetID);
  end;
end;

class function Utilities.newUser(var user: TUser; password: string;
  firstname, lastname: string; userType: TUserType; registerDate: TDateTime): boolean;
begin
  // password := getMD5Hash(password); // TODO:
  result := data_module.modifyDatabase(Format('INSERT INTO Users (FirstName, LastName, [Type], [Password], RegisterDate) VALUES (%s, %s, %s, %s, #%s#)', [
    quotedstr(firstName),
    quotedStr(lastName),
    inttostr(ord(userType)),
    quotedStr(password),
    datetostr(registerdate)
  ]), data_module.qry);

  result := true; // TODO: Remove
end;

class function Utilities.removeUser(user: TUser): boolean;
begin
  result := data_module.modifyDatabase(Format('DELETE FROM Users WHERE ID = %s', [user.GetID]), data_module.qry);

  if result then
  begin
    TLogger.log(TAG, Debug, 'Successfully removed user with ID: ' + user.GetID);
  end else
  begin
    TLogger.log(TAG, Debug, 'Failed to remove user with ID: ' + user.GetID);
  end;
end;

class function Utilities.updateOrder(var order: TOrder; newStatus: String): boolean;
begin
  result := data_module.modifyDatabase(Format('UPDATE Orders SET Status = %s WHERE ID = %s', [
    quotedStr(newStatus),
    order.GetID
  ]), data_module.qry);
  if result then
    order.SetStatus(newstatus);  // TODO: Does this belong here?

  if result then
  begin
    TLogger.log(TAG, Debug, 'Successfully changed information of order with ID: ' + order.GetID);
  end else
  begin
    TLogger.log(TAG, Debug, 'Failed to change information of order with ID: ' + order.GetID);
  end;
end;

class function Utilities.updateUserInformation(user: TUser;
  var newUser: TUser): boolean;
begin
  newUser := TUser.Create(user.GetID, user.GetFirstName, user.GetLastName, user.GetType, user.GetDateRegistered);
  // Update information
  result := data_module.modifyDatabase(Format('UPDATE Users SET FirstName = %s, LastName = %s, [Type] = %s WHERE [ID] = %s', [
    quotedStr(newUser.GetFirstName),
    quotedStr(newUser.GetLastName),
    inttostr(integer(newUser.GetType)),
    newUser.GetID
  ]), data_module.qry);

  if result then
  begin
    TLogger.log(TAG, Debug, 'Successfully changed information of user with ID: ' + user.getID);
  end else
  begin
    TLogger.log(TAG, Debug, 'Failed to change information of user with ID: ' + user.getID);
  end;
end;

// http://www.swissdelphicenter.com/en/showcode.php?id=1749
class function Utilities.getLastID(var query: TADOQuery): Integer;
begin
  result := -1;
  try
    query.sql.clear;
    query.sql.Add('SELECT @@IDENTITY');
    query.Active := true;
    query.First;
    result := query.Fields.Fields[0].AsInteger;
  finally
    query.Active := false;
    query.sql.clear;
  end;
end;

end.
