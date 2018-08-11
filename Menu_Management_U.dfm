object frmManageMenu: TfrmManageMenu
  Left = 0
  Top = 0
  Caption = 'Menu Management - PoSify'
  ClientHeight = 384
  ClientWidth = 571
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lblItems: TLabel
    Left = 16
    Top = 37
    Width = 27
    Height = 13
    Caption = 'Items'
  end
  object lblNewItem: TLabel
    Left = 384
    Top = 37
    Width = 46
    Height = 13
    Caption = 'New Item'
  end
  object lblPrice: TLabel
    Left = 392
    Top = 113
    Width = 27
    Height = 13
    Caption = 'Price:'
  end
  object grdMenu: TDBGrid
    Left = 16
    Top = 56
    Width = 337
    Height = 257
    Hint = 'Use the navigator to remove items'
    DataSource = data_module.srcItems
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object edtTitle: TEdit
    Left = 384
    Top = 56
    Width = 137
    Height = 21
    TabOrder = 1
    TextHint = 'Title'
  end
  object cmbCategory: TComboBox
    Left = 384
    Top = 83
    Width = 137
    Height = 21
    TabOrder = 2
    Text = 'Category'
  end
  object spnPrice: TSpinEdit
    Left = 448
    Top = 110
    Width = 73
    Height = 22
    MaxValue = 1
    MinValue = 1
    TabOrder = 3
    Value = 0
  end
  object btnCreate: TButton
    Left = 384
    Top = 144
    Width = 137
    Height = 25
    Hint = 'Add item to menu'
    Caption = 'Create'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    OnClick = btnCreateClick
  end
  object navItems: TDBNavigator
    Left = 56
    Top = 319
    Width = 240
    Height = 25
    Hint = 'Press the check mark to commit changes'
    DataSource = data_module.srcItems
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
  end
end
