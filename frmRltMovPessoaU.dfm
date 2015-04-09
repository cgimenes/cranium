object frmRltMovPessoaF: TfrmRltMovPessoaF
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Relat'#243'rio de Movimenta'#231#227'o por Pessoa'
  ClientHeight = 419
  ClientWidth = 897
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
    Left = 8
    Top = 202
    Width = 53
    Height = 13
    Caption = 'Data Inicial'
  end
  object lbDataFinal: TLabel
    Left = 8
    Top = 250
    Width = 48
    Height = 13
    Caption = 'Data Final'
  end
  object lbNome: TLabel
    Left = 8
    Top = 157
    Width = 27
    Height = 13
    Caption = 'Nome'
  end
  object rgCV: TRadioGroup
    Left = 8
    Top = 96
    Width = 145
    Height = 55
    Caption = 'Tipo de Movimenta'#231#227'o'
    Items.Strings = (
      'Venda'
      'Compra')
    TabOrder = 1
  end
  object dtpDataInicial: TDateTimePicker
    Left = 8
    Top = 215
    Width = 145
    Height = 21
    Date = 40869.895199722230000000
    Format = 'dd/MM/yyyy'
    Time = 40869.895199722230000000
    TabOrder = 3
  end
  object dtpDataFinal: TDateTimePicker
    Left = 8
    Top = 263
    Width = 145
    Height = 21
    Date = 40869.895199722230000000
    Format = 'dd/MM/yyyy'
    Time = 40869.895199722230000000
    TabOrder = 4
  end
  object sgRelatorios: TStringGrid
    Left = 168
    Top = 8
    Width = 721
    Height = 403
    ColCount = 6
    FixedCols = 0
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goRowSelect]
    TabOrder = 8
    ColWidths = (
      53
      182
      79
      84
      193
      121)
  end
  object btnGerar: TButton
    Left = 8
    Top = 299
    Width = 145
    Height = 25
    Caption = 'Gerar Relat'#243'rio'
    Default = True
    Enabled = False
    TabOrder = 5
    OnClick = btnGerarClick
  end
  object btnImprimir: TButton
    Left = 8
    Top = 380
    Width = 145
    Height = 25
    Caption = 'Imprimir'
    Enabled = False
    TabOrder = 7
    OnClick = btnImprimirClick
  end
  object btnNovoRlt: TButton
    Left = 8
    Top = 339
    Width = 145
    Height = 25
    Caption = 'Novo Relat'#243'rio'
    Default = True
    Enabled = False
    TabOrder = 6
    OnClick = btnNovoRltClick
  end
  object rgTipo: TRadioGroup
    Left = 8
    Top = 8
    Width = 145
    Height = 72
    Caption = 'Tipo'
    Items.Strings = (
      'Cliente'
      'Fornecedor'
      'Colaborador')
    TabOrder = 0
    OnClick = rgTipoClick
  end
  object cbPessoa: TComboBox
    Left = 8
    Top = 170
    Width = 145
    Height = 21
    Style = csDropDownList
    CharCase = ecUpperCase
    TabOrder = 2
  end
end
