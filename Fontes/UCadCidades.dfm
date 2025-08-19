inherited frmCadCidades: TfrmCadCidades
  Caption = 'CIDADES'
  ClientHeight = 656
  ClientWidth = 811
  ExplicitWidth = 827
  ExplicitHeight = 695
  PixelsPerInch = 96
  TextHeight = 13
  inherited PageControl1: TPageControl
    Width = 811
    Height = 656
    ExplicitWidth = 811
    ExplicitHeight = 656
    inherited TabSheet1: TTabSheet
      ExplicitLeft = 12
      ExplicitTop = 22
      ExplicitWidth = 803
      ExplicitHeight = 628
      object Label3: TLabel [0]
        Left = 26
        Top = 63
        Width = 33
        Height = 13
        Caption = 'C'#243'digo'
      end
      object Label4: TLabel [1]
        Left = 26
        Top = 115
        Width = 27
        Height = 13
        Caption = 'Nome'
      end
      object Label5: TLabel [2]
        Left = 388
        Top = 115
        Width = 13
        Height = 13
        Caption = 'UF'
      end
      inherited ToolBar1: TToolBar
        Width = 803
        TabOrder = 3
        ExplicitWidth = 803
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
      object edtUF: TEdit
        Left = 388
        Top = 134
        Width = 57
        Height = 21
        CharCase = ecUpperCase
        TabOrder = 2
      end
      object edtNome: TEdit
        Left = 26
        Top = 134
        Width = 345
        Height = 21
        CharCase = ecUpperCase
        TabOrder = 1
      end
      object edtCodigo: TEdit
        Left = 26
        Top = 82
        Width = 57
        Height = 21
        CharCase = ecUpperCase
        Enabled = False
        TabOrder = 0
      end
      object DBLookupComboBox1: TDBLookupComboBox
        Left = 250
        Top = 462
        Width = 321
        Height = 21
        KeyField = 'CD_CIDADE'
        ListField = 'NM_CIDADE'
        ListSource = DSCidades
        TabOrder = 4
      end
      object BitBtn3: TBitBtn
        Left = 378
        Top = 500
        Width = 75
        Height = 25
        Caption = 'BitBtn3'
        TabOrder = 5
        OnClick = BitBtn3Click
      end
      object BitBtn4: TBitBtn
        Left = 498
        Top = 506
        Width = 75
        Height = 25
        Caption = 'BitBtn4'
        TabOrder = 6
        OnClick = BitBtn4Click
      end
    end
    inherited TabSheet2: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 803
      ExplicitHeight = 628
      object Label1: TLabel [0]
        Left = 24
        Top = 19
        Width = 33
        Height = 13
        Caption = 'C'#243'digo'
      end
      object Label2: TLabel [1]
        Left = 96
        Top = 19
        Width = 27
        Height = 13
        Caption = 'Nome'
      end
      object Label6: TLabel [2]
        Left = 458
        Top = 19
        Width = 13
        Height = 13
        Caption = 'UF'
      end
      object edtUfPesq: TEdit [3]
        Left = 458
        Top = 38
        Width = 57
        Height = 21
        CharCase = ecUpperCase
        TabOrder = 0
      end
      object edtNomePesq: TEdit [4]
        Left = 96
        Top = 38
        Width = 345
        Height = 21
        CharCase = ecUpperCase
        TabOrder = 1
      end
      object edtCodigoPesq: TEdit [5]
        Left = 24
        Top = 38
        Width = 57
        Height = 21
        CharCase = ecUpperCase
        TabOrder = 2
      end
      inherited DBGrid1: TDBGrid
        TabOrder = 3
        OnDblClick = BitBtn2Click
        Columns = <
          item
            Expanded = False
            FieldName = 'CD_CIDADE'
            Title.Caption = 'C'#243'digo'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NM_CIDADE'
            Title.Caption = 'Nome'
            Width = 587
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'UF'
            Title.Caption = 'Uf'
            Width = 45
            Visible = True
          end>
      end
      inherited BitBtn1: TBitBtn
        Left = 542
        Top = 27
        Height = 37
        TabOrder = 4
        OnClick = BitBtn1Click
        ExplicitLeft = 542
        ExplicitTop = 27
        ExplicitHeight = 37
      end
      inherited BitBtn2: TBitBtn
        Left = 346
        Top = 382
        TabOrder = 5
        ExplicitLeft = 346
        ExplicitTop = 382
      end
    end
  end
  inherited QPesquisa: TFDQuery
    SQL.Strings = (
      'select * from cidades')
    Left = 350
    Top = 220
    object QPesquisaCD_CIDADE: TIntegerField
      FieldName = 'CD_CIDADE'
      Origin = 'CD_CIDADE'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object QPesquisaNM_CIDADE: TStringField
      FieldName = 'NM_CIDADE'
      Origin = 'NM_CIDADE'
      Required = True
      Size = 50
    end
    object QPesquisaUF: TStringField
      FieldName = 'UF'
      Origin = 'UF'
      Required = True
      FixedChar = True
      Size = 2
    end
  end
  inherited DsPesquisa: TDataSource
    Left = 412
    Top = 214
  end
  object QCidades: TFDQuery
    Connection = DM.DBFinanceiro
    SQL.Strings = (
      'select * from cidades order by nm_cidade')
    Left = 358
    Top = 432
    object IntegerField1: TIntegerField
      FieldName = 'CD_CIDADE'
      Origin = 'CD_CIDADE'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object StringField1: TStringField
      FieldName = 'NM_CIDADE'
      Origin = 'NM_CIDADE'
      Required = True
      Size = 50
    end
    object StringField2: TStringField
      FieldName = 'UF'
      Origin = 'UF'
      Required = True
      FixedChar = True
      Size = 2
    end
  end
  object DSCidades: TDataSource
    DataSet = QCidades
    Left = 426
    Top = 428
  end
end
