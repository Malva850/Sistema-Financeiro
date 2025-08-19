unit UAuditoriaLogin;

interface

type
  TAuditoriaLogin = class
    private
    FNmUsuario: string;
    FHora: string;
    FCdAuditoriaLogin: Integer;
    FData: TDate;
    procedure SetCdAuditoriaLogin(const Value: Integer);
    procedure SetData(const Value: TDate);
    procedure SetHora(const Value: string);
    procedure SetNmUsuario(const Value: string);

    protected

    public
    constructor Create();
    function Inserir(var mensagem: string): Boolean;

    published
    property CdAuditoriaLogin: Integer read FCdAuditoriaLogin write SetCdAuditoriaLogin;
    property Data: TDate read FData write SetData;
    property Hora: string read FHora write SetHora;
    property NmUsuario: string read FNmUsuario write SetNmUsuario;
  end;

implementation

{ TAuditoriaLogin }

uses UDM, System.SysUtils;

constructor TAuditoriaLogin.Create();
begin
  inherited Create;
  FData := Now;
  FHora := TimeToStr(Now);
end;

function TAuditoriaLogin.Inserir(var mensagem: string): Boolean;
begin
   try


      {
      CREATE TABLE AUDITORIA_LOGIN (
      CD_AUDITORIA_LOGIN INT PRIMARY KEY NOT NULL,
      DATA DATE NOT NULL,
      HORA VARCHAR(8) NOT NULL,
      NM_USUARIO VARCHAR(50) NOT NULL)

      }

    dm.DBFinanceiro.StartTransaction;
    FCdAuditoriaLogin := dm.GeraSequencial('GEN_AUDITORIA_LOGIN');

    dm.QInsere.Close;
    dm.QInsere.SQL.Clear;
    dm.QInsere.SQL.Add(' INSERT INTO AUDITORIA_LOGIN (CD_AUDITORIA_LOGIN, DATA, ' +
                       ' HORA, NM_USUARIO) VALUES (:CD_AUDITORIA_LOGIN, :DATA, '+
                       ' :HORA, :NM_USUARIO)');
    dm.QInsere.ParamByName('CD_AUDITORIA_LOGIN').AsInteger := FCdAuditoriaLogin ;
    dm.QInsere.ParamByName('DATA').AsDate  := FData;
    dm.QInsere.ParamByName('HORA').AsString := FHora;
    dm.QInsere.ParamByName('NM_USUARIO').AsString := FNmUsuario;
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

procedure TAuditoriaLogin.SetCdAuditoriaLogin(const Value: Integer);
begin
  FCdAuditoriaLogin := Value;
end;

procedure TAuditoriaLogin.SetData(const Value: TDate);
begin
  FData := Value;
end;

procedure TAuditoriaLogin.SetHora(const Value: string);
begin
  FHora := Value;
end;

procedure TAuditoriaLogin.SetNmUsuario(const Value: string);
begin
  FNmUsuario := Value;
end;

end.

