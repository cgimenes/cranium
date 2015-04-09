object frmConsultaMovF: TfrmConsultaMovF
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Consulta de Movimenta'#231#227'o'
  ClientHeight = 470
  ClientWidth = 736
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
  object lbConsultas: TLabel
    Left = 343
    Top = 17
    Width = 112
    Height = 13
    Caption = 'Palavra ou Valor Chave'
  end
  object lbAte: TLabel
    Left = 458
    Top = 34
    Width = 17
    Height = 13
    Caption = 'At'#233
  end
  object lbTipo: TLabel
    Left = 176
    Top = 17
    Width = 80
    Height = 13
    Caption = 'Tipo de Consulta'
  end
  object edtConsultas: TEdit
    Left = 343
    Top = 30
    Width = 247
    Height = 21
    CharCase = ecUpperCase
    TabOrder = 2
  end
  object rgCV: TRadioGroup
    Left = 7
    Top = 9
    Width = 153
    Height = 46
    Caption = 'Tipo de Movimenta'#231#227'o'
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      'Venda'
      'Compra')
    TabOrder = 0
    OnClick = rgCVClick
  end
  object dtpDataInicial: TDateTimePicker
    Left = 343
    Top = 30
    Width = 98
    Height = 21
    Date = 40869.895199722230000000
    Format = 'dd/MM/yyyy'
    Time = 40869.895199722230000000
    Enabled = False
    TabOrder = 3
    Visible = False
  end
  object sgConsultas: TStringGrid
    Left = 7
    Top = 61
    Width = 721
    Height = 403
    ColCount = 6
    FixedCols = 0
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goRowSelect]
    TabOrder = 6
    OnDblClick = sgConsultasDblClick
    ColWidths = (
      53
      182
      79
      84
      193
      121)
  end
  object btnConsultar: TButton
    Left = 629
    Top = 28
    Width = 98
    Height = 25
    Caption = 'Consultar'
    Default = True
    TabOrder = 5
    OnClick = btnConsultarClick
  end
  object cbConsulta: TComboBox
    Left = 176
    Top = 30
    Width = 145
    Height = 21
    Style = csDropDownList
    CharCase = ecUpperCase
    TabOrder = 1
    OnClick = cbConsultaClick
    Items.Strings = (
      'C'#211'DIGO'
      'CLIENTE'
      'DATA')
  end
  object dtpDataFinal: TDateTimePicker
    Left = 492
    Top = 30
    Width = 98
    Height = 21
    Date = 40869.895199722230000000
    Format = 'dd/MM/yyyy'
    Time = 40869.895199722230000000
    Enabled = False
    TabOrder = 4
    Visible = False
  end
end
