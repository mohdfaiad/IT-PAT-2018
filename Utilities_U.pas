unit Utilities_U;

interface

uses TUser_U, TItem_U, TOrder_U;

type
  Utilities = class
    public
      // User
      class function newUser(var user: TUser; var password: string; firstname, lastname: string): boolean;
      class function changePassword(user: TUser; oldPassword, newPassword: string): boolean;
      class function updateUserInformation(user: TUser; var newUser: TUser): boolean;

      // Item
      class function newItem(var item: TItem; title, category: string; price: double): boolean;

      // Order
      class function newOrder(var order: TOrder; employee: TUser; status: string; createDate: TDateTime; items: TItemArray): boolean;
  end;

implementation

end.
