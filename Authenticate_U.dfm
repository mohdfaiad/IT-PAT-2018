object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 424
  ClientWidth = 681
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object imgLogo: TImage
    Left = 240
    Top = 48
    Width = 193
    Height = 145
  end
  object lblWelcome: TLabel
    Left = 280
    Top = 221
    Width = 109
    Height = 13
    Caption = 'Welcome, please log in'
  end
  object pnlLogin: TPanel
    Left = 240
    Top = 248
    Width = 193
    Height = 121
    TabOrder = 0
    object edtID: TEdit
      Left = 16
      Top = 16
      Width = 161
      Height = 21
      TabOrder = 0
      TextHint = 'User ID'
    end
    object edtPassword: TEdit
      Left = 16
      Top = 43
      Width = 161
      Height = 21
      TabOrder = 1
      TextHint = 'Password'
    end
    object btnLogin: TButton
      Left = 16
      Top = 80
      Width = 161
      Height = 25
      Caption = 'Login'
      TabOrder = 2
    end
  end
end
