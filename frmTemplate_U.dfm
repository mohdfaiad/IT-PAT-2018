object frmTemplate: TfrmTemplate
  Left = 0
  Top = 0
  Caption = 'PoSify by Stephan Cilliers'
  ClientHeight = 410
  ClientWidth = 708
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  DesignSize = (
    708
    410)
  PixelsPerInch = 96
  TextHeight = 13
  object pnlHeader: TPanel
    Left = 8
    Top = 8
    Width = 692
    Height = 41
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Welcome'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      692
      41)
    object btnLogout: TButton
      Left = 8
      Top = 9
      Width = 75
      Height = 25
      Caption = 'Logout'
      TabOrder = 0
      OnClick = btnLogoutClick
    end
    object btnViewAccount: TButton
      Left = 609
      Top = 9
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'View Account'
      TabOrder = 1
      OnClick = btnViewAccountClick
    end
  end
end
