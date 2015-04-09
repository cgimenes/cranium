object DataF: TDataF
  OldCreateOrder = False
  Height = 87
  Width = 280
  object dbConexao: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=MSDASQL.1;Persist Security Info=False;Data Source=dbcra' +
      'nium'
    LoginPrompt = False
    Left = 24
    Top = 24
  end
  object dbComando: TADOCommand
    Connection = dbConexao
    Parameters = <>
    Left = 88
    Top = 24
  end
  object dbQuery: TADOQuery
    Connection = dbConexao
    Parameters = <>
    Left = 152
    Top = 24
  end
  object dbRvVendedor: TADOQuery
    Connection = dbConexao
    CursorType = ctStatic
    Filtered = True
    Parameters = <>
    SQL.Strings = (
      '')
    Left = 216
    Top = 24
  end
end
