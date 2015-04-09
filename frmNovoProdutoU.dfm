object frmNovoProdutoF: TfrmNovoProdutoF
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Cadastro de Produto'
  ClientHeight = 185
  ClientWidth = 428
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lbCodigo: TLabel
    Left = 8
    Top = 8
    Width = 33
    Height = 13
    Caption = 'C'#243'digo'
  end
  object lbDescricao: TLabel
    Left = 96
    Top = 8
    Width = 46
    Height = 13
    Caption = 'Descri'#231#227'o'
  end
  object lbValorVenda: TLabel
    Left = 152
    Top = 54
    Width = 72
    Height = 13
    Caption = 'Valor de Venda'
  end
  object lbValorUnt: TLabel
    Left = 8
    Top = 54
    Width = 64
    Height = 13
    Caption = 'Valor Unit'#225'rio'
  end
  object lbQuantidade: TLabel
    Left = 296
    Top = 54
    Width = 56
    Height = 13
    Caption = 'Quantidade'
  end
  object lbCategoria: TLabel
    Left = 8
    Top = 98
    Width = 47
    Height = 13
    Caption = 'Categoria'
  end
  object lbUndMedida: TLabel
    Left = 232
    Top = 98
    Width = 91
    Height = 13
    Caption = 'Unidade de Medida'
  end
  object lbFornecedor: TLabel
    Left = 8
    Top = 141
    Width = 55
    Height = 13
    Caption = 'Fornecedor'
  end
  object edtCodigo: TEdit
    Left = 8
    Top = 21
    Width = 64
    Height = 21
    Font.Charset = DEFAULT_CHARSET
    Font.Color = cl3DDkShadow
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    NumbersOnly = True
    ParentFont = False
    ReadOnly = True
    TabOrder = 0
  end
  object edtDescricao: TEdit
    Left = 96
    Top = 21
    Width = 256
    Height = 21
    CharCase = ecUpperCase
    TabOrder = 1
  end
  object edtValorVenda: TEdit
    Left = 152
    Top = 67
    Width = 121
    Height = 21
    TabOrder = 3
    OnExit = edtValorVendaExit
  end
  object edtValorUnt: TEdit
    Left = 8
    Top = 67
    Width = 121
    Height = 21
    TabOrder = 2
    OnExit = edtValorUntExit
  end
  object edtQuantidade: TEdit
    Left = 296
    Top = 67
    Width = 121
    Height = 21
    TabOrder = 4
  end
  object cbCategoria: TComboBox
    Left = 8
    Top = 111
    Width = 201
    Height = 21
    Style = csDropDownList
    CharCase = ecUpperCase
    TabOrder = 5
    OnChange = cbCategoriaChange
  end
  object cbFornecedor: TComboBox
    Left = 8
    Top = 156
    Width = 265
    Height = 21
    Style = csDropDownList
    CharCase = ecUpperCase
    TabOrder = 7
  end
  object cbUndMedida: TComboBox
    Left = 232
    Top = 111
    Width = 185
    Height = 21
    Style = csDropDownList
    CharCase = ecUpperCase
    TabOrder = 6
    OnChange = cbUndMedidaChange
  end
  object btnGravar: TButton
    Left = 312
    Top = 152
    Width = 105
    Height = 25
    Caption = 'Gravar'
    Default = True
    TabOrder = 9
    OnClick = btnGravarClick
  end
  object btnAlterar: TButton
    Left = 312
    Top = 152
    Width = 105
    Height = 25
    Caption = 'Alterar'
    Enabled = False
    TabOrder = 8
    Visible = False
    OnClick = btnAlterarClick
  end
  object chBAtivo: TCheckBox
    Left = 373
    Top = 25
    Width = 47
    Height = 17
    Caption = 'Ativo?'
    Checked = True
    Enabled = False
    State = cbChecked
    TabOrder = 10
  end
end
