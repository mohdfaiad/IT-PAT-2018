inherited frmManagerHome: TfrmManagerHome
  Caption = 'Manager Home'
  OnCreate = FormCreate
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
    ItemHeight = 13
    TabOrder = 1
    OnClick = lstEmployeesClick
  end
  object btnNewEmployee: TButton
    Left = 24
    Top = 359
    Width = 75
    Height = 25
    Caption = 'New'
    TabOrder = 2
    OnClick = btnNewEmployeeClick
  end
  object btnRemoveEmployee: TButton
    Left = 142
    Top = 359
    Width = 75
    Height = 25
    Caption = 'Remove'
    Enabled = False
    TabOrder = 3
    OnClick = btnRemoveEmployeeClick
  end
  object pnlDetails: TPanel
    Left = 232
    Top = 96
    Width = 201
    Height = 257
    Caption = 'pnlDetails'
    TabOrder = 4
    Visible = False
    object redDetails: TRichEdit
      Left = 8
      Top = 8
      Width = 185
      Height = 241
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
end
