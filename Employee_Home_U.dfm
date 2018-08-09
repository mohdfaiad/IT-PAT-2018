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
  object lstItems: TListBox
    Left = 40
    Top = 136
    Width = 185
    Height = 177
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ItemHeight = 14
    ParentFont = False
    TabOrder = 1
    OnClick = lstItemsClick
    OnDblClick = lstItemsDblClick
  end
  object cmbCategories: TComboBox
    Left = 104
    Top = 82
    Width = 121
    Height = 21
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
    TabOrder = 3
  end
  object btnAdd: TButton
    Left = 40
    Top = 346
    Width = 185
    Height = 25
    Caption = 'Add'
    Default = True
    Enabled = False
    TabOrder = 4
    OnClick = btnAddClick
  end
  object edtFilter: TEdit
    Left = 40
    Top = 109
    Width = 185
    Height = 21
    TabOrder = 5
    TextHint = 'Filter'
    OnChange = edtFilterChange
  end
  object lstOrderItems: TListBox
    Left = 264
    Top = 107
    Width = 185
    Height = 206
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ItemHeight = 14
    ParentFont = False
    TabOrder = 6
  end
  object btnClearOrder: TButton
    Left = 400
    Top = 317
    Width = 49
    Height = 25
    Caption = 'Clear'
    TabOrder = 7
    OnClick = btnClearOrderClick
  end
  object btnConfirm: TButton
    Left = 264
    Top = 317
    Width = 97
    Height = 25
    Caption = 'Confirm order'
    TabOrder = 8
    OnClick = btnConfirmClick
  end
  object lstOrders: TListBox
    Left = 488
    Top = 107
    Width = 185
    Height = 206
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ItemHeight = 14
    ParentFont = False
    TabOrder = 9
    OnClick = lstOrdersClick
  end
end
