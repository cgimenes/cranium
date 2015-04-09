object frmProdutoSelecionadoVF: TfrmProdutoSelecionadoVF
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Produto Selecionado'
  ClientHeight = 125
  ClientWidth = 328
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
  object lbCodigo: TLabel
    Left = 8
    Top = 8
    Width = 33
    Height = 13
    Caption = 'C'#243'digo'
    Enabled = False
  end
  object lbDescricao: TLabel
    Left = 71
    Top = 8
    Width = 102
    Height = 13
    Caption = 'Descri'#231#227'o do Produto'
    Enabled = False
  end
  object lbValorUn: TLabel
    Left = 8
    Top = 48
    Width = 44
    Height = 13
    Caption = 'Valor Un.'
  end
  object lbQuantidade: TLabel
    Left = 117
    Top = 48
    Width = 56
    Height = 13
    Caption = 'Quantidade'
  end
  object lbTotal: TLabel
    Left = 228
    Top = 48
    Width = 24
    Height = 13
    Caption = 'Total'
  end
  object edtCodigo: TEdit
    Left = 8
    Top = 21
    Width = 57
    Height = 21
    Enabled = False
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
    Left = 71
    Top = 21
    Width = 246
    Height = 21
    Enabled = False
    ReadOnly = True
    TabOrder = 1
  end
  object edtValorUn: TEdit
    Left = 8
    Top = 61
    Width = 100
    Height = 21
    TabOrder = 2
    OnExit = edtValorUnExit
  end
  object edtQuantidade: TEdit
    Left = 117
    Top = 61
    Width = 105
    Height = 21
    NumbersOnly = True
    TabOrder = 3
    OnExit = edtQuantidadeExit
  end
  object edtTotal: TEdit
    Left = 228
    Top = 61
    Width = 89
    Height = 21
    ReadOnly = True
    TabOrder = 4
  end
  object btnOK: TButton
    Left = 128
    Top = 93
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 5
    OnClick = btnOKClick
  end
end
