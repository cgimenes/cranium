object frmNovaVendaF: TfrmNovaVendaF
  Left = 0
  Top = 0
  ActiveControl = cbCategoria
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Nova Venda'
  ClientHeight = 433
  ClientWidth = 942
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
  object lbTotal: TLabel
    Left = 568
    Top = 19
    Width = 49
    Height = 19
    Caption = 'Total:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbVlrTotal: TLabel
    Left = 630
    Top = 8
    Width = 104
    Height = 33
    Caption = 'R$ 0,00'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbCategoria: TLabel
    Left = 8
    Top = 3
    Width = 47
    Height = 13
    Caption = 'Categoria'
  end
  object cbCategoria: TComboBox
    Left = 8
    Top = 16
    Width = 249
    Height = 21
    Style = csDropDownList
    CharCase = ecUpperCase
    TabOrder = 0
    OnClick = cbCategoriaClick
  end
  object btnFinalizar: TButton
    Left = 794
    Top = 16
    Width = 140
    Height = 25
    Caption = 'Finalizar Venda'
    TabOrder = 3
    OnClick = btnFinalizarClick
  end
  object gbCategoria: TGroupBox
    Left = 8
    Top = 43
    Width = 454
    Height = 382
    Caption = 'Produtos da Categoria Selecionada'
    TabOrder = 1
    object sgProdutos: TStringGrid
      Left = 11
      Top = 20
      Width = 433
      Height = 350
      ColCount = 4
      DefaultRowHeight = 20
      FixedCols = 0
      RowCount = 2
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goRowSelect]
      TabOrder = 0
      OnDblClick = sgProdutosDblClick
      ColWidths = (
        57
        239
        64
        64)
    end
  end
  object gbAdicionados: TGroupBox
    Left = 480
    Top = 43
    Width = 454
    Height = 382
    Caption = 'Produtos Adicionados ao Pedido'
    TabOrder = 2
    object sgVenda: TStringGrid
      Left = 11
      Top = 20
      Width = 433
      Height = 350
      ColCount = 4
      DefaultRowHeight = 20
      FixedCols = 0
      RowCount = 2
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goRowSelect]
      TabOrder = 0
      OnDblClick = sgVendaDblClick
      ColWidths = (
        57
        239
        64
        64)
    end
  end
end
