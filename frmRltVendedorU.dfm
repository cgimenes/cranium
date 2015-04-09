object frmRltVendedorF: TfrmRltVendedorF
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Relat'#243'rio de Venda por Vendedor'
  ClientHeight = 460
  ClientWidth = 738
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
  object lbDataInicial: TLabel
    Left = 240
    Top = 8
    Width = 53
    Height = 13
    Caption = 'Data Inicial'
  end
  object lbDataFinal: TLabel
    Left = 351
    Top = 10
    Width = 48
    Height = 13
    Caption = 'Data Final'
  end
  object lbVendedor: TLabel
    Left = 8
    Top = 8
    Width = 46
    Height = 13
    Caption = 'Vendedor'
  end
  object dtpDataInicial: TDateTimePicker
    Left = 240
    Top = 21
    Width = 89
    Height = 21
    Date = 40869.895199722230000000
    Format = 'dd/MM/yyyy'
    Time = 40869.895199722230000000
    TabOrder = 1
  end
  object dtpDataFinal: TDateTimePicker
    Left = 351
    Top = 23
    Width = 89
    Height = 21
    Date = 40869.895199722230000000
    Format = 'dd/MM/yyyy'
    Time = 40869.895199722230000000
    TabOrder = 2
  end
  object sgRelatorios: TStringGrid
    Left = 8
    Top = 50
    Width = 721
    Height = 403
    ColCount = 6
    FixedCols = 0
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goRowSelect]
    TabOrder = 6
    ColWidths = (
      53
      182
      79
      84
      193
      121)
  end
  object btnGerar: TButton
    Left = 463
    Top = 19
    Width = 85
    Height = 25
    Caption = 'Gerar Relat'#243'rio'
    Default = True
    Enabled = False
    TabOrder = 3
    OnClick = btnGerarClick
  end
  object btnImprimir: TButton
    Left = 645
    Top = 19
    Width = 85
    Height = 25
    Caption = 'Imprimir'
    Enabled = False
    TabOrder = 5
    OnClick = btnImprimirClick
  end
  object btnNovoRlt: TButton
    Left = 554
    Top = 19
    Width = 85
    Height = 25
    Caption = 'Novo Relat'#243'rio'
    Default = True
    Enabled = False
    TabOrder = 4
    OnClick = btnNovoRltClick
  end
  object cbPessoa: TComboBox
    Left = 8
    Top = 21
    Width = 201
    Height = 21
    Style = csDropDownList
    CharCase = ecUpperCase
    TabOrder = 0
    OnClick = cbPessoaClick
  end
  object RvVendedor: TRvProject
    ProjectFile = 'RvVendedor.rav'
    Left = 272
    Top = 240
  end
  object RvConVendedor: TRvDataSetConnection
    RuntimeVisibility = rtDeveloper
    DataSet = DataF.dbRvVendedor
    Left = 368
    Top = 240
  end
end
