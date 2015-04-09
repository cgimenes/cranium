object frmRltMovDataF: TfrmRltMovDataF
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Relat'#243'rio de Movimenta'#231#227'o por Data'
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
    Top = 105
    Width = 53
    Height = 13
    Caption = 'Data Inicial'
  end
  object lbDataFinal: TLabel
    Left = 8
    Top = 153
    Width = 48
    Height = 13
    Caption = 'Data Final'
  end
  object rgCV: TRadioGroup
    Left = 8
    Top = 18
    Width = 145
    Height = 65
    Caption = 'Tipo de Movimenta'#231#227'o'
    Items.Strings = (
      'Venda'
      'Compra')
    TabOrder = 0
    OnClick = rgCVClick
  end
  object dtpDataInicial: TDateTimePicker
    Left = 8
    Top = 118
    Width = 145
    Height = 21
    Date = 40869.895199722230000000
    Format = 'dd/MM/yyyy'
    Time = 40869.895199722230000000
    TabOrder = 1
  end
  object dtpDataFinal: TDateTimePicker
    Left = 8
    Top = 166
    Width = 145
    Height = 21
    Date = 40869.895199722230000000
    Format = 'dd/MM/yyyy'
    Time = 40869.895199722230000000
    TabOrder = 2
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
    Left = 8
    Top = 210
    Width = 145
    Height = 25
    Caption = 'Gerar Relat'#243'rio'
    Default = True
    Enabled = False
    TabOrder = 3
    OnClick = btnGerarClick
  end
  object btnImprimir: TButton
    Left = 8
    Top = 370
    Width = 145
    Height = 25
    Caption = 'Imprimir'
    Enabled = False
    TabOrder = 5
    OnClick = btnImprimirClick
  end
  object btnNovoRlt: TButton
    Left = 8
    Top = 258
    Width = 145
    Height = 25
    Caption = 'Novo Relat'#243'rio'
    Default = True
    Enabled = False
    TabOrder = 4
    OnClick = btnNovoRltClick
  end
end
