unit UAberturasCaixas;

interface

uses
  FireDAC.Comp.Client;

type
  TAberturasCaixas = class
    private
    FCdCaixa: Integer;
    FHrAbertura: string;
    FDtFechamento: TDate;
    FCdUsuario: Integer;
    FCdAberturaCaixa: Integer;
    FHrFechamento: string;
    FDtAbertura: TDate;
    procedure SetCdAberturaCaixa(const Value: Integer);
    procedure SetCdCaixa(const Value: Integer);
    procedure SetCdUsuario(const Value: Integer);
    procedure SetDtAbertura(const Value: TDate);
    procedure SetDtFechamento(const Value: TDate);
    procedure SetHrAbertura(const Value: string);
    procedure SetHrFechamento(const Value: string);


    protected

    public
      function Inserir(var codigo: Integer; var mensagem: string):Boolean;
      function Alterar(var mensagem:string):Boolean;
      function Deletar(var mensagem:string): Boolean;
      function MostrarAberturasCaixa(CdUsuario: string;   var Query: TFDQuery): boolean;
      function CaixaAberto(CdUsuario,  PCdCaixa : Integer; PDtAbertura:TDate): boolean;
      function FecharCaixa(PCdAberturaCaixa : integer): Boolean;

    published
      property CdAberturaCaixa: Integer read FCdAberturaCaixa write SetCdAberturaCaixa;
      property CdCaixa: Integer read FCdCaixa write SetCdCaixa;
      property DtAbertura: TDate read FDtAbertura write SetDtAbertura;
      property DtFechamento: TDate read FDtFechamento write SetDtFechamento;
      property CdUsuario: Integer read FCdUsuario write SetCdUsuario;
      property HrAbertura: string read FHrAbertura write SetHrAbertura;
      property HrFechamento: string read FHrFechamento write SetHrFechamento;
  end;

implementation

uses UDM, System.SysUtils;

function TAberturasCaixas.Alterar(var mensagem: string): Boolean;
begin
   try

    dm.DBFinanceiro.StartTransaction;
    dm.QUpdate.Close;
    dm.QUpdate.SQL.Clear;
    dm.QUpdate.SQL.Add(' UPDATE ABERTURAS_CAIXAS SET CD_CAIXA=:CD_CAIXA, ' +
                       ' DT_ABERTURA=:DT_ABERTURA, DT_FECHAMENTO=:DT_FECHAMENTO '+
                       ' CD_USUARIO=:CD_USUARIO, HR_ABERTURA=:HR_ABERTURA, ' +
                       ' HR_FECHAMENTO=:HR_FECHAMENTO ' +
                       ' WHERE CD_ABERTURA_CAIXA=:CD_ABERTURA_CAIXA');

    dm.QUpdate.ParamByName('CD_ABERTURA_CAIXA').AsInteger := FCdAberturaCaixa ;
    dm.QUpdate.ParamByName('CD_CAIXA').AsInteger  := FCdCaixa;
    dm.QUpdate.ParamByName('DT_ABERTURA').AsDate := FDtAbertura;
    dm.QUpdate.ParamByName('DT_FECHAMENTO').AsDate := FDtFechamento;
    dm.QUpdate.ParamByName('CD_USUARIO').AsInteger := FCdUsuario;
    dm.QUpdate.ParamByName('HR_ABERTURA').AsString := FHrAbertura;
    dm.QUpdate.ParamByName('HR_FECHAMENTO').AsString := FHrFechamento;
    dm.QUpdate.ExecSQL;

    dm.DBFinanceiro.Commit;
    dm.DBFinanceiro.CommitRetaining;

    Result := true;

  except
    on E: Exception do
    begin
      dm.DBFinanceiro.Rollback;
      mensagem := E.Message;
      Result := false;
    end;
  end;
end;

function TAberturasCaixas.Deletar(var mensagem: string): Boolean;
begin
  try

    dm.DBFinanceiro.StartTransaction;
    dm.QDelete.Close;
    dm.QDelete.SQL.Clear;
    dm.QDelete.SQL.Add(' DELETE FROM ABERTURAS_CAIXAS WHERE CD_ABERTURA_CAIXA=:CD_ABERTURA_CAIXA');
    dm.QDelete.ParamByName('CD_ABERTURA_CAIXA').AsInteger := FCdAberturaCaixa;
    dm.QDelete.ExecSQL;

    dm.DBFinanceiro.Commit;
    dm.DBFinanceiro.CommitRetaining;

    mensagem := 'APAGADO COM SUCESSO!';

    Result := true;

  except
    on E: Exception do
    begin
      dm.DBFinanceiro.Rollback;
      mensagem := E.Message;
      Result := false;
    end;
  end;
end;

function TAberturasCaixas.Inserir(var codigo: Integer;var mensagem: string): Boolean;
begin
   try

    dm.DBFinanceiro.StartTransaction;
    FCdAberturaCaixa := dm.GeraSequencial('GEN_ABERTURASCAIXAS') ;
    codigo := FCdAberturaCaixa;

    dm.QInsere.Close;
    dm.QInsere.SQL.Clear;
    dm.QInsere.SQL.Add(' INSERT INTO ABERTURAS_CAIXAS (CD_ABERTURA_CAIXA, ' +
                       ' CD_CAIXA, DT_ABERTURA, DT_FECHAMENTO, CD_USUARIO, ' +
                       ' HR_ABERTURA, HR_FECHAMENTO) ' +
                       ' VALUES (:CD_ABERTURA_CAIXA, ' +
                       ' :CD_CAIXA, :DT_ABERTURA, :DT_FECHAMENTO, :CD_USUARIO, ' +
                       ' :HR_ABERTURA, :HR_FECHAMENTO)');

    dm.QInsere.ParamByName('CD_ABERTURA_CAIXA').AsInteger := FCdAberturaCaixa ;
    dm.QInsere.ParamByName('CD_CAIXA').AsInteger  := FCdCaixa;
    dm.QInsere.ParamByName('DT_ABERTURA').AsDate := FDtAbertura;
    dm.QInsere.ParamByName('DT_FECHAMENTO').Clear;
    dm.QInsere.ParamByName('CD_USUARIO').AsInteger := FCdUsuario;
    dm.QInsere.ParamByName('HR_ABERTURA').AsString := FHrAbertura;
    dm.QInsere.ParamByName('HR_FECHAMENTO').clear;
    dm.QInsere.ExecSQL;

    dm.DBFinanceiro.Commit;
    dm.DBFinanceiro.CommitRetaining;

    Result := true;

  except
    on E: Exception do
    begin
      dm.DBFinanceiro.Rollback;
      mensagem := e.Message;
      Result := false;
    end;
  end;
end;





procedure TAberturasCaixas.SetCdAberturaCaixa(const Value: Integer);
begin
  FCdAberturaCaixa := Value;
end;

procedure TAberturasCaixas.SetCdCaixa(const Value: Integer);
begin
  FCdCaixa := Value;
end;

procedure TAberturasCaixas.SetCdUsuario(const Value: Integer);
begin
  FCdUsuario := Value;
end;

procedure TAberturasCaixas.SetDtAbertura(const Value: TDate);
begin
  FDtAbertura := Value;
end;

procedure TAberturasCaixas.SetDtFechamento(const Value: TDate);
begin
  FDtFechamento := Value;
end;

procedure TAberturasCaixas.SetHrAbertura(const Value: string);
begin
  FHrAbertura := Value;
end;

procedure TAberturasCaixas.SetHrFechamento(const Value: string);
begin
  FHrFechamento := Value;
end;

function TAberturasCaixas.MostrarAberturasCaixa(CdUsuario: string; var Query: TFDQuery): boolean;
begin
  Query.Close;
  Query.SQL.Clear;
  Query.SQL.Add('  SELECT  ac.*, c.nm_caixa'+
                '  FROM aberturas_caixas AC, CAIXAS C'+
                '  WHERE AC.cd_caixa=C.cd_CAIXA '+
                '  AND AC.cd_usuario=:PCdUsuario'+
                '  ORDER BY AC.dt_abertura desc , cast(ac.hr_abertura as time) desc');
  Query.ParamByName('PCdUsuario').AsString := CdUsuario;
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

function TAberturasCaixas.CaixaAberto(CdUsuario,  PCdCaixa : Integer; PDtAbertura:TDate): boolean;
begin
  Dm.QVaziaDM.Close;
  Dm.QVaziaDM.SQL.Clear;
  Dm.QVaziaDM.SQL.Add(' SELECT  AC.CD_ABERTURA_CAIXA '+
                      ' FROM ABERTURAS_CAIXAS AC'+
                      ' WHERE AC.DT_FECHAMENTO IS NULL'+
                      ' AND  AC.CD_CAIXA=:PCDCAIXA '+
                      ' AND AC.CD_USUARIO=:PCDUSUARIO'+
                      ' AND AC.DT_ABERTURA=:PDT_ABERTURA');
  Dm.QVaziaDM.ParamByName('PCDCAIXA').AsInteger := PCdCaixa;
  Dm.QVaziaDM.ParamByName('PCDUSUARIO').AsInteger := CdUsuario;
  Dm.QVaziaDM.ParamByName('PDT_ABERTURA').AsDate := PDtAbertura;
  Dm.QVaziaDM.Open();
  if Dm.QVaziaDM.IsEmpty then
  begin
    Result := false;
  end
  else
  begin
    Result := true;
  end;
end;



function TAberturasCaixas.FecharCaixa(PCdAberturaCaixa : integer): Boolean;
begin
  try

    dm.DBFinanceiro.StartTransaction;
    dm.QUpdate.Close;
    dm.QUpdate.SQL.Clear;
    dm.QUpdate.SQL.Add(' UPDATE ABERTURAS_CAIXAS SET  DT_FECHAMENTO=current_date,  HR_FECHAMENTO= substring(current_time from 1 for 5 ) ' +
                       ' WHERE CD_ABERTURA_CAIXA=:CD_ABERTURA_CAIXA');
    dm.QUpdate.ParamByName('CD_ABERTURA_CAIXA').AsInteger := PCdAberturaCaixa ;
    dm.QUpdate.ExecSQL;

    dm.DBFinanceiro.Commit;
    dm.DBFinanceiro.CommitRetaining;

    Result := true;

  except
    on E: Exception do
    begin
      dm.DBFinanceiro.Rollback;
      Result := false;
    end;
  end;
end;




end.
