object data_module: Tdata_module
  OldCreateOrder = False
  Height = 217
  Width = 297
  object connection: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=Database.mdb;Persis' +
      't Security Info=False'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 128
    Top = 48
  end
  object qry: TADOQuery
    Connection = connection
    Parameters = <>
    Left = 136
    Top = 96
  end
end
