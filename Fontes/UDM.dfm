object DM: TDM
  OldCreateOrder = False
  Height = 648
  Width = 907
  object DBFinanceiro: TFDConnection
    Params.Strings = (
      
        'Database=127.0.0.1:D:\Unesc\Unesc_Portal\Praticas_Desenvolviment' +
        'o_Software_2\Sistemas\2021_FINANCEIRO\Bd\FINANCEIRO.FDB'
      'User_Name=sysdba'
      'Password=masterkey'
      'DriverID=FB')
    Connected = True
    LoginPrompt = False
    Left = 120
    Top = 40
  end
  object QInsere: TFDQuery
    Connection = DBFinanceiro
    Left = 136
    Top = 120
  end
  object QGenerator: TFDQuery
    Connection = DBFinanceiro
    Left = 224
    Top = 120
  end
  object QSelect: TFDQuery
    Connection = DBFinanceiro
    Left = 304
    Top = 120
  end
  object QUpdate: TFDQuery
    Connection = DBFinanceiro
    Left = 144
    Top = 192
  end
  object QDelete: TFDQuery
    Connection = DBFinanceiro
    Left = 216
    Top = 190
  end
  object QVaziaDM: TFDQuery
    Connection = DBFinanceiro
    Left = 374
    Top = 210
  end
end
