unit UEmpresas;

interface

uses
  FireDAC.Comp.Client;

type
  TEmpresas = class
  private
    FCdEmpresa: Integer;
    FNr_CPF_CNPJ: String;
    FNmEmpresa : String;
    procedure SetCdEmpresa(const Value: Integer);
    procedure SetNr_CPF_CNPJ(const Value: String);
    procedure SetNmEmpresa(const Value: String);

  public
    constructor Create;
    function Inserir(PMensagem : String): Boolean;
    function Alterar(PMensagem : String): Boolean;
    function Apagar (PMensagem:String): Boolean;
    function Localizar(PCodigo, PNome, PCPFCNPJ : String; var Query : TFDQuery): boolean;

  published
    property CdEmpresa : Integer read FCdEmpresa write SetCdEmpresa;
    property Nr_CPF_CNPJ : String read FNr_CPF_CNPJ write SetNr_CPF_CNPJ;
    property NmEmpresa : String read FNmEmpresa write SetNmEmpresa;
end;


implementation

{ TEmpresas }

uses UDM, System.SysUtils;

{ TEmpresas }

constructor TEmpresas.Create;
begin
  FCdEmpresa := 0;
  FNr_CPF_CNPJ := '';
  FNmEmpresa := '';
end;

procedure TEmpresas.SetCdEmpresa(const Value: Integer);
begin
  FCdEmpresa := Value;
end;

procedure TEmpresas.SetNmEmpresa(const Value: String);
begin
  FNmEmpresa := Value;
end;

procedure TEmpresas.SetNr_CPF_CNPJ(const Value: String);
begin
  FNr_CPF_CNPJ := Value;
end;

function TEmpresas.Inserir(PMensagem : String): Boolean;
begin
  try
    dm.DBFinanceiro.StartTransaction;
    FCdEmpresa := DM.GeraSequencial('GEN_EMPRESAS_ID') ;
    CdEmpresa := FCdEmpresa;

    dm.QInsere.Close;
    dm.QInsere.SQL.Clear;
    dm.QInsere.SQL.Add(' INSERT INTO EMPRESAS (CD_EMPRESA, NM_EMPRESA, NR_CPF_CNPJ)'+
                       ' VALUES (:PCD_EMPRESA, :PNM_EMPRESA, :PNR_CPF_CNPJ)');
    dm.QInsere.ParamByName('PCD_EMPRESA').AsInteger := CdEmpresa ;
    dm.QInsere.ParamByName('PNM_EMPRESA').AsString  := NmEmpresa;
    dm.QInsere.ParamByName('PNR_CPF_CNPJ').AsString := Nr_CPF_CNPJ;
    dm.QInsere.ExecSQL;

    dm.DBFinanceiro.Commit;
    dm.DBFinanceiro.CommitRetaining;

    Result := true;

  except
    on E: Exception do
    begin
      dm.DBFinanceiro.Rollback;
      PMensagem := e.Message;
      Result := false;
    end;
  end;

end;

function TEmpresas.Alterar(PMensagem : String): Boolean;
begin
  try
    dm.DBFinanceiro.StartTransaction;
    dm.QUpdate.Close;
    dm.QUpdate.SQL.Clear;
    dm.QUpdate.SQL.Add(' UPDATE EMPRESAS SET NM_EMPRESA = :PNM_EMPRESA, NR_CPF_CNPJ = :PNR_CPF_CNPJ WHERE CD_EMPRESA = :PCD_EMPRESA');
    dm.QUpdate.ParamByName('PCD_EMPRESA').AsInteger := CdEmpresa;
    dm.QUpdate.ParamByName('PNM_EMPRESA').AsString  := NmEmpresa;
    dm.QUpdate.ParamByName('PNR_CPF_CNPJ').AsString := Nr_CPF_CNPJ;
    dm.QUpdate.ExecSQL;

    dm.DBFinanceiro.Commit;
    dm.DBFinanceiro.CommitRetaining;

    Result := true;

  except
    on E: Exception do
    begin
      dm.DBFinanceiro.Rollback;
      PMensagem := e.Message;
      Result := false;
    end;
  end;

end;

function TEmpresas.Apagar(PMensagem:String): Boolean;
begin
  try
    dm.DBFinanceiro.StartTransaction;
    dm.QUpdate.Close;
    dm.QUpdate.SQL.Clear;
    dm.QUpdate.SQL.Add(' DELETE FROM EMPRESAS WHERE CD_EMPRESA = :PCD_EMPRESA');
    dm.QUpdate.ParamByName('PCD_EMPRESA').AsInteger := CdEmpresa ;
    dm.QUpdate.ExecSQL;

    dm.DBFinanceiro.Commit;
    dm.DBFinanceiro.CommitRetaining;

    Result := true;

  except
    on E: Exception do
    begin
      dm.DBFinanceiro.Rollback;
      PMensagem := e.Message;
      Result := false;
    end;
  end;

end;

function TEmpresas.Localizar(PCodigo, PNome, PCPFCNPJ : String; var Query : TFDQuery): boolean;
begin
  Query.Close;
  Query.SQL.Clear;
  Query.SQL.Add(' select * from EMPRESAS WHERE 1=1');

  if trim(PCodigo)<>'' then
  begin
    Query.SQL.Add(' AND CD_EMPRESA=:PCD_EMPRESA') ;
    Query.ParamByName('PCD_EMPRESA').AsString := PCodigo ;
  end;

  if trim(PNome)<>'' then
  begin
    Query.SQL.Add(' AND NM_EMPRESA LIKE :PNOME');
    Query.ParamByName('PNOME').AsString := '%'+PNome+'%';
  end;

  if trim(PCPFCNPJ)<>'' then
  begin
    Query.SQL.Add(' AND NR_CPF_CNPJ LIKE :PCPFCNPJ');
    Query.ParamByName('PCPFCNPJ').AsString := '%'+PCPFCNPJ+'%';
  end;

  Query.Open();

  if Query.IsEmpty then
  begin
    Result := false;
  end
  else
  begin
    Result := true;
  end;

end;

end.
