object frmNovoCadastroF: TfrmNovoCadastroF
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Cadastro de Pessoa'
  ClientHeight = 481
  ClientWidth = 385
  Color = clBtnFace
  DefaultMonitor = dmDesktop
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lbCNPJ: TLabel
    Left = 8
    Top = 210
    Width = 25
    Height = 13
    Caption = 'CNPJ'
    Enabled = False
  end
  object lbCEP: TLabel
    Left = 8
    Top = 255
    Width = 19
    Height = 13
    Caption = 'CEP'
    Enabled = False
  end
  object lbCod: TLabel
    Left = 8
    Top = 79
    Width = 33
    Height = 13
    Caption = 'C'#243'digo'
  end
  object lbRS: TLabel
    Left = 8
    Top = 122
    Width = 60
    Height = 13
    Caption = 'Raz'#227'o Social'
    Enabled = False
  end
  object lbNomeF: TLabel
    Left = 83
    Top = 79
    Width = 79
    Height = 13
    Caption = 'Nome (Fantasia)'
    Enabled = False
  end
  object lbIE: TLabel
    Left = 140
    Top = 210
    Width = 183
    Height = 13
    Caption = 'Inscri'#231#227'o Estadual (somente n'#250'meros)'
    Enabled = False
  end
  object lbEndereco: TLabel
    Left = 105
    Top = 255
    Width = 45
    Height = 13
    Caption = 'Endere'#231'o'
    Enabled = False
  end
  object lbBairro: TLabel
    Left = 8
    Top = 295
    Width = 28
    Height = 13
    Caption = 'Bairro'
    Enabled = False
  end
  object lbCargo: TLabel
    Left = 175
    Top = 387
    Width = 29
    Height = 13
    Caption = 'Cargo'
    Enabled = False
  end
  object lbEmail: TLabel
    Left = 8
    Top = 431
    Width = 28
    Height = 13
    Caption = 'E-mail'
    Enabled = False
  end
  object lbCidade: TLabel
    Left = 175
    Top = 295
    Width = 33
    Height = 13
    Caption = 'Cidade'
    Enabled = False
  end
  object lbTelefone: TLabel
    Left = 8
    Top = 343
    Width = 42
    Height = 13
    Caption = 'Telefone'
    Enabled = False
  end
  object lbFax: TLabel
    Left = 223
    Top = 343
    Width = 18
    Height = 13
    Caption = 'Fax'
    Enabled = False
  end
  object lbContato: TLabel
    Left = 8
    Top = 387
    Width = 39
    Height = 13
    Caption = 'Contato'
    Enabled = False
  end
  object lbCelular: TLabel
    Left = 118
    Top = 343
    Width = 33
    Height = 13
    Caption = 'Celular'
    Enabled = False
  end
  object lbRG: TLabel
    Left = 8
    Top = 163
    Width = 110
    Height = 13
    Caption = 'RG (somente n'#250'meros)'
    Enabled = False
  end
  object lbCPF: TLabel
    Left = 140
    Top = 165
    Width = 19
    Height = 13
    Caption = 'CPF'
    Enabled = False
  end
  object lbDN: TLabel
    Left = 281
    Top = 165
    Width = 96
    Height = 13
    Caption = 'Data de Nascimento'
    Enabled = False
  end
  object lbNumero: TLabel
    Left = 314
    Top = 255
    Width = 37
    Height = 13
    Caption = 'N'#250'mero'
    Enabled = False
  end
  object lbUF: TLabel
    Left = 334
    Top = 295
    Width = 13
    Height = 13
    Caption = 'UF'
    Enabled = False
  end
  object cbUF: TComboBox
    Left = 334
    Top = 308
    Width = 43
    Height = 21
    Style = csDropDownList
    CharCase = ecUpperCase
    Enabled = False
    TabOrder = 15
    Items.Strings = (
      'AC'
      'AL'
      'AP'
      'AM'
      'BA'
      'CE'
      'DF'
      'ES'
      'GO'
      'MA'
      'MT'
      'MS'
      'MG'
      'PA'
      'PB'
      'PR'
      'PE'
      'PI'
      'RJ'
      'RN'
      'RS'
      'RO'
      'RR'
      'SC'
      'SP'
      'SE'
      'TO')
  end
  object btnGravar: TButton
    Left = 303
    Top = 442
    Width = 71
    Height = 25
    Caption = 'Gravar'
    Default = True
    Enabled = False
    TabOrder = 23
    OnClick = btnGravarClick
  end
  object edtCNPJ: TMaskEdit
    Left = 8
    Top = 223
    Width = 104
    Height = 21
    Enabled = False
    EditMask = '99.999.999/9999-99;0;_'
    MaxLength = 18
    TabOrder = 8
  end
  object edtCEP: TMaskEdit
    Left = 8
    Top = 268
    Width = 70
    Height = 21
    Enabled = False
    EditMask = '99999-999;0;_'
    MaxLength = 9
    TabOrder = 10
    OnExit = edtCEPExit
  end
  object edtCod: TEdit
    Left = 8
    Top = 92
    Width = 52
    Height = 21
    Font.Charset = DEFAULT_CHARSET
    Font.Color = cl3DDkShadow
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    NumbersOnly = True
    ParentFont = False
    ReadOnly = True
    TabOrder = 2
  end
  object edtRS: TEdit
    Left = 8
    Top = 135
    Width = 369
    Height = 21
    CharCase = ecUpperCase
    Enabled = False
    TabOrder = 4
  end
  object edtNomeF: TEdit
    Left = 83
    Top = 92
    Width = 294
    Height = 21
    CharCase = ecUpperCase
    Enabled = False
    TabOrder = 3
  end
  object edtEndereco: TEdit
    Left = 105
    Top = 268
    Width = 192
    Height = 21
    CharCase = ecUpperCase
    Enabled = False
    TabOrder = 11
  end
  object edtBairro: TEdit
    Left = 8
    Top = 308
    Width = 148
    Height = 21
    CharCase = ecUpperCase
    Enabled = False
    TabOrder = 13
  end
  object edtCargo: TEdit
    Left = 175
    Top = 400
    Width = 202
    Height = 21
    CharCase = ecUpperCase
    Enabled = False
    TabOrder = 20
  end
  object edtEmail: TEdit
    Left = 8
    Top = 444
    Width = 270
    Height = 21
    Enabled = False
    TabOrder = 21
  end
  object edtCidade: TEdit
    Left = 175
    Top = 308
    Width = 144
    Height = 21
    CharCase = ecUpperCase
    Enabled = False
    TabOrder = 14
  end
  object edtContato: TEdit
    Left = 8
    Top = 400
    Width = 136
    Height = 21
    CharCase = ecUpperCase
    Enabled = False
    TabOrder = 19
  end
  object edtTelefone: TMaskEdit
    Left = 8
    Top = 356
    Width = 86
    Height = 21
    Enabled = False
    EditMask = '(00)0000-0000;0;_'
    MaxLength = 13
    TabOrder = 16
  end
  object edtFax: TMaskEdit
    Left = 223
    Top = 356
    Width = 88
    Height = 21
    Enabled = False
    EditMask = '(00)0000-0000;0;_'
    MaxLength = 13
    TabOrder = 18
  end
  object edtIE: TEdit
    Left = 140
    Top = 223
    Width = 183
    Height = 21
    Enabled = False
    MaxLength = 14
    NumbersOnly = True
    TabOrder = 9
  end
  object rgPessoa: TRadioGroup
    Left = 8
    Top = 8
    Width = 85
    Height = 57
    Caption = 'Pessoa'
    Items.Strings = (
      'F'#237'sica'
      'Jur'#237'dica')
    TabOrder = 0
    OnClick = rgPessoaClick
  end
  object edtCelular: TMaskEdit
    Left = 118
    Top = 356
    Width = 90
    Height = 21
    Enabled = False
    EditMask = '(00)0000-0000;0;_'
    MaxLength = 13
    TabOrder = 17
  end
  object gbTipo: TGroupBox
    Left = 113
    Top = 8
    Width = 261
    Height = 57
    Caption = 'Tipo'
    TabOrder = 1
    object chbCliente: TCheckBox
      Left = 19
      Top = 25
      Width = 54
      Height = 17
      Caption = 'Cliente'
      TabOrder = 0
    end
    object chbFornecedor: TCheckBox
      Left = 88
      Top = 25
      Width = 77
      Height = 17
      Caption = 'Fornecedor'
      TabOrder = 1
    end
    object chbColaborador: TCheckBox
      Left = 171
      Top = 25
      Width = 77
      Height = 17
      Caption = 'Colaborador'
      TabOrder = 2
    end
  end
  object edtCPF: TMaskEdit
    Left = 140
    Top = 178
    Width = 119
    Height = 21
    Enabled = False
    EditMask = '999.999.999-99;0;_'
    MaxLength = 14
    TabOrder = 6
  end
  object edtRG: TEdit
    Left = 8
    Top = 178
    Width = 110
    Height = 21
    Enabled = False
    MaxLength = 11
    NumbersOnly = True
    TabOrder = 5
  end
  object edtNumero: TEdit
    Left = 314
    Top = 268
    Width = 63
    Height = 21
    Enabled = False
    NumbersOnly = True
    TabOrder = 12
  end
  object btnAlterar: TButton
    Left = 303
    Top = 442
    Width = 71
    Height = 25
    Caption = 'Alterar'
    Enabled = False
    TabOrder = 22
    Visible = False
    OnClick = btnAlterarClick
  end
  object dtpData: TDateTimePicker
    Left = 281
    Top = 178
    Width = 96
    Height = 21
    Date = 40884.858075289360000000
    Format = 'dd/MM/yyyy'
    Time = 40884.858075289360000000
    TabOrder = 7
  end
  object chbAtivo: TCheckBox
    Left = 330
    Top = 71
    Width = 47
    Height = 17
    Caption = 'Ativo?'
    Checked = True
    Enabled = False
    State = cbChecked
    TabOrder = 24
  end
  object IdHTTP: TIdHTTP
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentType = 'text/html'
    Request.Accept = 'text/html, */*'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    HTTPOptions = [hoForceEncodeParams]
    Left = 280
    Top = 208
  end
  object XMLBuscaCEP: TXMLDocument
    Left = 336
    Top = 208
    DOMVendorDesc = 'MSXML'
  end
end
