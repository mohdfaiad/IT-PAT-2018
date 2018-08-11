object frmNewUser: TfrmNewUser
  Left = 0
  Top = 0
  Caption = 'New User'
  ClientHeight = 142
  ClientWidth = 279
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 56
    Top = 77
    Width = 31
    Height = 13
    Caption = 'Type: '
  end
  object edtFirstName: TEdit
    Left = 56
    Top = 16
    Width = 161
    Height = 21
    TabOrder = 0
    Text = 'First Name'
    TextHint = 'First Name'
  end
  object edtLastName: TEdit
    Left = 56
    Top = 43
    Width = 161
    Height = 21
    TabOrder = 1
    TextHint = 'Last Name'
  end
  object btnCreate: TButton
    Left = 56
    Top = 109
    Width = 161
    Height = 25
    Caption = 'Create'
    Default = True
    TabOrder = 2
    OnClick = btnCreateClick
  end
  object cmbUserType: TComboBox
    Left = 93
    Top = 74
    Width = 124
    Height = 21
    ItemIndex = 0
    TabOrder = 3
    Text = 'Employee'
    Items.Strings = (
      'Employee'
      'Manager')
  end
end
