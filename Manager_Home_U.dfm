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
  inherited pnlHeader: TPanel
    inherited btnViewAccount: TButton
      ExplicitLeft = 609
    end
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
end
