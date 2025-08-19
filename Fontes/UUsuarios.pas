unit UUsuarios;

interface

uses
FireDAC.Comp.Client;

type
  TUsuarios = class
  private
    FNmUsuario: string;
    FCdUsuario: Integer;
    FSenha: string;
    FLogin: string;
    procedure SetCdUsuario(const Value: Integer);
    procedure SetLogin(const Value: string);
    procedure SetNmUsuario(const Value: string);
    procedure SetSenha(const Value: string);

  protected

  public
    function Inserir(var codigo: Integer; var mensagem: string): Boolean;
    function Alterar(var mensagem: string): Boolean;
    function Deletar(var mensagem: string): Boolean;
    function VerificarLogin(login: string; senha: string) : Boolean;

  published
    property CdUsuario: Integer read FCdUsuario write SetCdUsuario;
    property Login: string read FLogin write SetLogin;
    property NmUsuario: string read FNmUsuario write SetNmUsuario;
    property Senha: string read FSenha write SetSenha;

  end;

implementation

uses UDM, System.SysUtils, UAuditoriaLogin;

function TUsuarios.Alterar(var mensagem: string): Boolean;
begin
   try

    dm.DBFinanceiro.StartTransaction;
    dm.QUpdate.Close;
    dm.QUpdate.SQL.Clear;
    dm.QUpdate.SQL.Add(' UPDATE USUARIOS SET LOGIN=:LOGIN, NM_USUARIO=:NM_USUARIO, SENHA=:SENHA WHERE CD_USUARIO=:CD_USUARIO');
    dm.QUpdate.ParamByName('LOGIN').AsString := FLogin;
    dm.QUpdate.ParamByName('NM_USUARIO').AsString := FNmUsuario;
    dm.QUpdate.ParamByName('SENHA').AsString := FSenha;
    dm.QUpdate.ParamByName('CD_USUARIO').AsInteger := FCdUsuario;
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

function TUsuarios.Deletar(var mensagem: string): Boolean;
begin
   try

    dm.DBFinanceiro.StartTransaction;
    dm.QDelete.Close;
    dm.QDelete.SQL.Clear;
    dm.QDelete.SQL.Add(' DELETE FROM USUARIOS WHERE CD_USUARIO=:CD_USUARIO');
    dm.QDelete.ParamByName('CD_USUARIO').AsInteger := FCdUsuario;
    dm.QDelete.ExecSQL;

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

function TUsuarios.Inserir(var codigo: Integer; var mensagem: string): Boolean;
begin
   try

    dm.DBFinanceiro.StartTransaction;
    FCdUsuario := dm.GeraSequencia('GEN_USUARIOS') ;
    codigo := FCdUsuario;

    dm.QInsere.Close;
    dm.QInsere.SQL.Clear;
    dm.QInsere.SQL.Add(' INSERT INTO USUARIOS (CD_USUARIO, LOGIN, NM_USUARIO, SENHA)'+
                       ' VALUES (:CD_USUARIO, :LOGIN, :NM_USUARIO, :SENHA)');
    dm.QInsere.ParamByName('CD_USUARIO').AsInteger := FCdUsuario ;
    dm.QInsere.ParamByName('LOGIN').AsString  := FLogin;
    dm.QInsere.ParamByName('NM_USUARIO').AsString := FNmUsuario;
    dm.QInsere.ParamByName('SENHA').AsString := FSenha;
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

procedure TUsuarios.SetCdUsuario(const Value: Integer);
begin
  FCdUsuario := Value;
end;

procedure TUsuarios.SetLogin(const Value: string);
begin
  FLogin := Value;
end;

procedure TUsuarios.SetNmUsuario(const Value: string);
begin
  FNmUsuario := Value;
end;

procedure TUsuarios.SetSenha(const Value: string);
begin
  FSenha := Value;
end;

function TUsuarios.VerificarLogin(login, senha: string): Boolean;
var
  auditoria: TAuditoriaLogin;
  mensagem: string;
begin
  dm.QSelect.Close;
  dm.QSelect.SQL.Clear;
  dm.QSelect.SQL.Add('SELECT * FROM USUARIOS WHERE LOGIN =:LOGIN AND SENHA =:SENHA');
  dm.QSelect.ParamByName('LOGIN').AsString := login;
  dm.QSelect.ParamByName('SENHA').AsString := senha;

  dm.QSelect.Open();


  if dm.QSelect.IsEmpty then
  begin
    Result := false;
  end
  else
  begin

    auditoria := TAuditoriaLogin.Create();
    auditoria.NmUsuario := dm.QSelect.FieldByName('NM_USUARIO').AsString;
    auditoria.Inserir(mensagem);

    Result := true;
  end;

  dm.QSelect.Close();
end;

end.
