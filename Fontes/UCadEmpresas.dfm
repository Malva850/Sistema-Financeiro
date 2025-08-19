inherited frmCadEmpresas: TfrmCadEmpresas
  Caption = 'frmCadEmpresas'
  ClientHeight = 554
  OnCloseQuery = FormCloseQuery
  OnShow = FormShow
  ExplicitHeight = 593
  PixelsPerInch = 96
  TextHeight = 13
  inherited PageControl1: TPageControl
    Height = 554
    ExplicitHeight = 211
    inherited TabSheet1: TTabSheet
      ExplicitLeft = 8
      ExplicitTop = 24
      ExplicitHeight = 418
      object Label1: TLabel [0]
        Left = 35
        Top = 68
        Width = 33
        Height = 13
        Anchors = [akLeft, akTop, akRight]
        Caption = 'C'#243'digo'
      end
      object Label2: TLabel [1]
        Left = 111
        Top = 68
        Width = 27
        Height = 13
        Anchors = [akLeft, akTop, akRight]
        Caption = 'Nome'
      end
      object Label3: TLabel [2]
        Left = 528
        Top = 68
        Width = 25
        Height = 13
        Anchors = [akLeft, akTop, akRight]
        Caption = 'CNPJ'
      end
      inherited ToolBar1: TToolBar
        inherited ToolButton1: TToolButton
          OnClick = ToolButton1Click
        end
        inherited ToolButton2: TToolButton
          OnClick = ToolButton2Click
        end
        inherited ToolButton3: TToolButton
          OnClick = ToolButton3Click
        end
      end
      object edtPesqCodigo: TEdit
        Left = 35
        Top = 87
        Width = 69
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        ReadOnly = True
        TabOrder = 1
      end
      object edtPesqNome: TEdit
        Left = 111
        Top = 87
        Width = 410
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        CharCase = ecUpperCase
        TabOrder = 2
      end
      object edtCNPJ: TMaskEdit
        Left = 528
        Top = 87
        Width = 126
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        EditMask = '99.999.999/9999-99;0; '
        MaxLength = 18
        TabOrder = 3
        Text = ''
      end
    end
    inherited TabSheet2: TTabSheet
      OnShow = TabSheet2Show
      ExplicitHeight = 418
      inherited DBGrid1: TDBGrid
        Left = 0
        Top = 0
        Width = 918
        Height = 526
        Align = alClient
        DataSource = DsDados
        OnDblClick = DBGrid1DblClick
        Columns = <
          item
            Expanded = False
            FieldName = 'CD_EMPRESA'
            Title.Alignment = taCenter
            Title.Caption = 'Cod. Empresa'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'Tahoma'
            Title.Font.Style = [fsBold]
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NM_EMPRESA'
            Title.Alignment = taCenter
            Title.Caption = 'Nome Empresa'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'Tahoma'
            Title.Font.Style = [fsBold]
            Width = 400
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NR_CPF_CNPJ'
            Title.Alignment = taCenter
            Title.Caption = 'CPF/CNPJ'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'Tahoma'
            Title.Font.Style = [fsBold]
            Width = 100
            Visible = True
          end>
      end
      inherited BitBtn1: TBitBtn
        Left = 800
        Top = 13
        ExplicitLeft = 800
        ExplicitTop = 13
      end
    end
  end
  object DsDados: TDataSource
    DataSet = QDados
    Left = 348
    Top = 278
  end
  object QDados: TFDQuery
    Connection = DM.DBFinanceiro
    SQL.Strings = (
      'SELECT'
      '    EMPRESAS.CD_EMPRESA,'
      '    EMPRESAS.NM_EMPRESA,'
      '    EMPRESAS.NR_CPF_CNPJ'
      'FROM'
      '    EMPRESAS')
    Left = 398
    Top = 282
    object QDadosCD_EMPRESA: TIntegerField
      FieldName = 'CD_EMPRESA'
      Origin = 'CD_EMPRESA'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object QDadosNM_EMPRESA: TStringField
      FieldName = 'NM_EMPRESA'
      Origin = 'NM_EMPRESA'
      Required = True
      Size = 50
    end
    object QDadosNR_CPF_CNPJ: TStringField
      FieldName = 'NR_CPF_CNPJ'
      Origin = 'NR_CPF_CNPJ'
      Required = True
      Size = 14
    end
  end
end
