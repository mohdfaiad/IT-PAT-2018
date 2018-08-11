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
  object lstEmployees: TListBox
    Left = 24
    Top = 96
    Width = 193
    Height = 257
    Hint = 'All employees'
    ItemHeight = 13
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
  object pnlDetails: TPanel
    Left = 424
    Top = 96
    Width = 249
    Height = 121
    Caption = 'pnlDetails'
    TabOrder = 4
    Visible = False
    object redDetails: TRichEdit
      Left = 8
      Top = 8
      Width = 233
      Height = 105
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      Zoom = 100
    end
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
    TabOrder = 5
    OnClick = btnManageMenuClick
  end
end
