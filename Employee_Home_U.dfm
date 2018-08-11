inherited frmEmployeeHome: TfrmEmployeeHome
  Caption = 'Employee Home'
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lblNote: TLabel [0]
    Left = 43
    Top = 322
    Width = 27
    Height = 13
    Caption = 'Note:'
  end
  object lblCategory: TLabel [1]
    Left = 43
    Top = 85
    Width = 45
    Height = 13
    Caption = 'Category'
  end
  object lblCurrentOrder: TLabel [2]
    Left = 264
    Top = 88
    Width = 66
    Height = 13
    Caption = 'Current order'
  end
  object lblOpenOrders: TLabel [3]
    Left = 488
    Top = 88
    Width = 60
    Height = 13
    Caption = 'Open orders'
  end
  inherited pnlHeader: TPanel
    inherited btnViewAccount: TButton
      Hint = 'Manage account details'
      ParentShowHint = False
      ShowHint = True
    end
  end
  object lstItems: TListBox
    Left = 40
    Top = 136
    Width = 185
    Height = 177
    Hint = 'Double click an item to quickly add to order'
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
    OnClick = lstItemsClick
    OnDblClick = lstItemsDblClick
  end
  object cmbCategories: TComboBox
    Left = 104
    Top = 82
    Width = 121
    Height = 21
    Hint = 'Filter items by category'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    Text = 'All'
    OnChange = cmbCategoriesChange
    Items.Strings = (
      'All')
  end
  object edtNote: TEdit
    Left = 80
    Top = 319
    Width = 145
    Height = 21
    Hint = 'Note for person preparing e.g. no tomato'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
  end
  object btnAdd: TButton
    Left = 40
    Top = 346
    Width = 185
    Height = 25
    Hint = 'Add selected item to order'
    Caption = 'Add'
    Default = True
    Enabled = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    OnClick = btnAddClick
  end
  object edtFilter: TEdit
    Left = 40
    Top = 109
    Width = 185
    Height = 21
    Hint = 'Filter items by name'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
    TextHint = 'Filter'
    OnChange = edtFilterChange
  end
  object lstOrderItems: TListBox
    Left = 264
    Top = 107
    Width = 185
    Height = 206
    Hint = 'Double click an item to view its note'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ItemHeight = 14
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 6
    OnDblClick = lstOrderItemsDblClick
  end
  object btnClearOrder: TButton
    Left = 400
    Top = 317
    Width = 49
    Height = 25
    Hint = 'Remove all items from order'
    Caption = 'Clear'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 7
    OnClick = btnClearOrderClick
  end
  object btnConfirm: TButton
    Left = 264
    Top = 317
    Width = 97
    Height = 25
    Hint = 'Place the order'
    Caption = 'Confirm order'
    Enabled = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 8
    OnClick = btnConfirmClick
  end
  object lstOrders: TListBox
    Left = 488
    Top = 107
    Width = 185
    Height = 206
    Hint = 'Double click an order to open it'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ItemHeight = 14
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 9
    OnDblClick = lstOrdersDblClick
  end
end
