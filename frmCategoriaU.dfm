object frmCategoriaF: TfrmCategoriaF
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Gerenciar Categorias'
  ClientHeight = 413
  ClientWidth = 453
  Color = clBtnFace
  DefaultMonitor = dmDesktop
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lbCategoria: TLabel
    Left = 8
    Top = 369
    Width = 75
    Height = 13
    Caption = 'Nova Categoria'
  end
  object btnAdicionar: TButton
    Left = 350
    Top = 380
    Width = 83
    Height = 25
    Caption = 'Adicionar'
    Default = True
    TabOrder = 3
    OnClick = btnAdicionarClick
  end
  object gbInativas: TGroupBox
    Left = 232
    Top = 8
    Width = 212
    Height = 352
    Caption = 'Categorias Inativas'
    TabOrder = 1
    object listInativas: TListBox
      Left = 11
      Top = 21
      Width = 190
      Height = 292
      ItemHeight = 13
      TabOrder = 0
    end
    object btnAtivar: TBitBtn
      Left = 67
      Top = 319
      Width = 88
      Height = 25
      Caption = 'Ativar'
      Default = True
      DoubleBuffered = True
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
      ParentDoubleBuffered = False
      TabOrder = 1
      OnClick = btnAtivarClick
    end
  end
  object gbAtivas: TGroupBox
    Left = 8
    Top = 8
    Width = 212
    Height = 352
    Caption = 'Categorias Ativas'
    TabOrder = 0
    object listAtivas: TListBox
      Left = 11
      Top = 21
      Width = 190
      Height = 292
      ItemHeight = 13
      TabOrder = 0
    end
    object btnDesativar: TBitBtn
      Left = 67
      Top = 319
      Width = 88
      Height = 25
      Cancel = True
      Caption = 'Desativar'
      DoubleBuffered = True
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333333333000033338833333333333333333F333333333333
        0000333911833333983333333388F333333F3333000033391118333911833333
        38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
        911118111118333338F3338F833338F3000033333911111111833333338F3338
        3333F8330000333333911111183333333338F333333F83330000333333311111
        8333333333338F3333383333000033333339111183333333333338F333833333
        00003333339111118333333333333833338F3333000033333911181118333333
        33338333338F333300003333911183911183333333383338F338F33300003333
        9118333911183333338F33838F338F33000033333913333391113333338FF833
        38F338F300003333333333333919333333388333338FFF830000333333333333
        3333333333333333333888330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
      ParentDoubleBuffered = False
      TabOrder = 1
      OnClick = btnDesativarClick
    end
  end
  object edtNovoTipo: TDBEdit
    Left = 8
    Top = 382
    Width = 329
    Height = 21
    CharCase = ecUpperCase
    DataField = 'NOME'
    DataSource = dsCategoria
    TabOrder = 2
  end
  object tblCategoria: TADOTable
    Connection = DataF.dbConexao
    CursorType = ctStatic
    TableName = 'CATEGORIA'
    Left = 96
    Top = 160
    object tblCategoriaNOME: TStringField
      FieldName = 'NOME'
      Size = 500
    end
    object tblCategoriaCODIGO: TIntegerField
      FieldName = 'CODIGO'
    end
    object tblCategoriaATIVO: TStringField
      FieldName = 'ATIVO'
      FixedChar = True
      Size = 1
    end
  end
  object dsCategoria: TDataSource
    DataSet = tblCategoria
    Left = 96
    Top = 104
  end
end