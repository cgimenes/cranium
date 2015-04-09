object frmConsultaProdutoF: TfrmConsultaProdutoF
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Consulta de Produtos'
  ClientHeight = 342
  ClientWidth = 558
  Color = clBtnFace
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
    Left = 192
    Top = 8
    Width = 112
    Height = 13
    Caption = 'Palavra ou Valor Chave'
  end
  object lbTipo: TLabel
    Left = 8
    Top = 8
    Width = 80
    Height = 13
    Caption = 'Tipo de Consulta'
  end
  object cbConsultas: TComboBox
    Left = 8
    Top = 21
    Width = 161
    Height = 21
    Style = csDropDownList
    CharCase = ecUpperCase
    TabOrder = 0
    OnClick = cbConsultasClick
    Items.Strings = (
      'C'#211'DIGO'
      'DESCRI'#199#195'O'
      'CATEGORIA')
  end
  object edtConsultas: TEdit
    Left = 192
    Top = 21
    Width = 247
    Height = 21
    CharCase = ecUpperCase
    TabOrder = 1
  end
  object btnConsultas: TButton
    Left = 453
    Top = 19
    Width = 97
    Height = 25
    Caption = 'Consultar'
    Default = True
    TabOrder = 3
    OnClick = btnConsultasClick
  end
  object sgConsultas: TStringGrid
    Left = 8
    Top = 50
    Width = 542
    Height = 284
    ColCount = 4
    DefaultRowHeight = 20
    FixedCols = 0
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goRowSelect]
    TabOrder = 4
    OnDblClick = sgConsultasDblClick
    ColWidths = (
      49
      332
      79
      74)
  end
  object cbCategoria: TComboBox
    Left = 192
    Top = 21
    Width = 247
    Height = 21
    Style = csDropDownList
    Enabled = False
    TabOrder = 2
    Visible = False
  end
end
