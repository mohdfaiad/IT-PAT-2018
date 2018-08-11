object frmOrderDetails: TfrmOrderDetails
  Left = 0
  Top = 0
  Caption = 'Order Details'
  ClientHeight = 295
  ClientWidth = 238
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
  object lblDetails: TLabel
    Left = 24
    Top = 8
    Width = 3
    Height = 13
  end
  object lstItems: TListBox
    Left = 24
    Top = 48
    Width = 185
    Height = 161
    Hint = 'Double click an item to view its note'
    ItemHeight = 13
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    OnDblClick = lstItemsDblClick
  end
  object cmbStatus: TComboBox
    Left = 24
    Top = 224
    Width = 185
    Height = 21
    ItemIndex = 0
    TabOrder = 1
    Text = 'Preparing'
    Items.Strings = (
      'Preparing'
      'Collect'
      'Complete')
  end
  object btnUpdate: TButton
    Left = 24
    Top = 251
    Width = 185
    Height = 25
    Caption = 'Update'
    TabOrder = 2
    OnClick = btnUpdateClick
  end
end
