inherited frmManagerHome: TfrmManagerHome
  Caption = 'Manager Home'
  OnCreate = FormCreate
  ExplicitWidth = 724
  ExplicitHeight = 449
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel [0]
    Left = 24
    Top = 77
    Width = 51
    Height = 13
    Caption = 'Employees'
  end
  object lblDetails: TLabel [1]
    Left = 248
    Top = 77
    Width = 81
    Height = 13
    Caption = 'Employee Details'
  end
  object lblPopularItems: TLabel [2]
    Left = 248
    Top = 218
    Width = 64
    Height = 13
    Caption = 'Popular items'
  end
  object lblLast7Days: TLabel [3]
    Left = 488
    Top = 77
    Width = 55
    Height = 13
    Caption = 'Last 7 days'
  end
  object lstEmployees: TListBox
    Left = 24
    Top = 96
    Width = 193
    Height = 257
    Hint = 'All employees'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ItemHeight = 14
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnClick = lstEmployeesClick
  end
  object btnNewEmployee: TButton
    Left = 24
    Top = 359
    Width = 75
    Height = 25
    Hint = 'Create a new account'
    Caption = 'New'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    OnClick = btnNewEmployeeClick
  end
  object btnRemoveEmployee: TButton
    Left = 142
    Top = 359
    Width = 75
    Height = 25
    Hint = 'Delete the user'#39's account'
    Caption = 'Remove'
    Enabled = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    OnClick = btnRemoveEmployeeClick
  end
  object btnManageMenu: TButton
    Left = 576
    Top = 359
    Width = 97
    Height = 25
    Hint = 'Add/remove items available for purchase.'
    Caption = 'Manage Menu'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    OnClick = btnManageMenuClick
  end
  object lstPopularItems: TListBox
    Left = 248
    Top = 264
    Width = 209
    Height = 89
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ItemHeight = 14
    ParentFont = False
    TabOrder = 5
  end
  object redDetails: TRichEdit
    Left = 248
    Top = 96
    Width = 209
    Height = 105
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 6
    Zoom = 100
  end
  object cmbCategories: TComboBox
    Left = 248
    Top = 237
    Width = 209
    Height = 21
    ItemIndex = 0
    TabOrder = 7
    Text = 'All Categories'
    OnChange = cmbCategoriesChange
    Items.Strings = (
      'All Categories')
  end
  object lstLast7Days: TListBox
    Left = 488
    Top = 96
    Width = 185
    Height = 105
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ItemHeight = 14
    ParentFont = False
    TabOrder = 8
  end
  object btnRestaurantName: TButton
    Left = 512
    Top = 17
    Width = 99
    Height = 25
    Caption = 'Restaurant Name'
    TabOrder = 9
    OnClick = btnRestaurantNameClick
  end
end
