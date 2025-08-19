unit USubCategorias;

interface

uses
  FireDAC.Comp.Client;


type
  TSubCategorias = class
  private
    FCdSubCategoria: Integer;
    FCdCategoria: Integer;
    FNmSubCategoria: String;
    procedure SetCdCategoria(const Value: Integer);
    procedure SetCdSubCategoria(const Value: Integer);
    procedure SetNmSubCategoria(const Value: String);

  protected

  public
    constructor create;
    function Inserir(var PCodigo : Integer; var PMensagem:String): Boolean;
    function Alterar(var PMensagem:String): Boolean;
    function Apagar(var PMensagem:String): Boolean;
    function Localizar(PNome : String; var Query : TFDQuery): boolean;

  published
    property CdSubCategoria : Integer read FCdSubCategoria write SetCdSubCategoria;
    property NmSubCategoria : String read FNmSubCategoria write SetNmSubCategoria;
    property CdCategoria : Integer read FCdCategoria write SetCdCategoria;

  end;

implementation

{ TSubCategorias }

uses UDM, System.SysUtils, UCategorias;

constructor TSubCategorias.create;
begin
  CdSubCategoria := 0;
  NmSubCategoria := '' ;
  CdCategoria := 0;
end;

procedure TSubCategorias.SetCdCategoria(const Value: Integer);
begin
  FCdCategoria := Value;
end;

procedure TSubCategorias.SetCdSubCategoria(const Value: Integer);
begin
  FCdSubCategoria := Value;
end;

procedure TSubCategorias.SetNmSubCategoria(const Value: String);
begin
  FNmSubCategoria := Value;
end;

function TSubCategorias.Inserir(var PCodigo: Integer;
  var PMensagem: String): Boolean;
begin
 try

    dm.DBFinanceiro.StartTransaction;
    FCdSubCategoria := DM.GeraSequencial('GEN_SUBCATEGORIAS') ;
    PCodigo := FCdSubCategoria;

    dm.QInsere.Close;
    dm.QInsere.SQL.Clear;
    dm.QInsere.SQL.Add(' INSERT INTO SUBCATEGORIAS (CD_SUBCATEGORIA, NM_SUBCATEGORIA, CD_CATEGORIA )'+
                       ' VALUES (:PCD_SUBCATEGORIA, :PNM_SUBCATEGORIA, :PCD_CATEGORIA)');
    dm.QInsere.ParamByName('PCD_SUBCATEGORIA').AsInteger := FCdSubCategoria ;
    dm.QInsere.ParamByName('PNM_SUBCATEGORIA').AsString  := FNmSubCategoria;
    dm.QInsere.ParamByName('PCD_CATEGORIA').AsInteger  := FCdCategoria;
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

function TSubCategorias.Alterar(var PMensagem: String): Boolean;
begin
   try
    dm.DBFinanceiro.StartTransaction;
    dm.QUpdate.Close;
    dm.QUpdate.SQL.Clear;
    dm.QUpdate.SQL.Add(' UPDATE SUBCATEGORIAS SET NM_SUBCATEGORIA=:PNM_SUBCATEGORIA, ' +
                       ' CD_CATEGORIA=:PCD_CATEGORIA WHERE CD_SUBCATEGORIA=:PCD_SUBCATEGORIA');
    dm.QUpdate.ParamByName('PCD_SUBCATEGORIA').AsInteger  := FCdSubCategoria;
    dm.QUpdate.ParamByName('PNM_SUBCATEGORIA').AsString := FNmSubCategoria;
    dm.QUpdate.ParamByName('PCD_CATEGORIA').AsInteger := FCdCategoria;
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

function TSubCategorias.Apagar(var PMensagem: String): Boolean;
begin
   try
    dm.DBFinanceiro.StartTransaction;
    dm.QUpdate.Close;
    dm.QUpdate.SQL.Clear;
    dm.QUpdate.SQL.Add(' DELETE FROM SUBCATEGORIAS  WHERE CD_SUBCATEGORIA=:PCD_SUBCATEGORIA');
    dm.QUpdate.ParamByName('PCD_SUBCATEGORIA').AsInteger := FCdSubCategoria ;
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

function TSubCategorias.Localizar(PNome: String;
  var Query: TFDQuery): boolean;
begin
  Query.Close;
  Query.SQL.Clear;
  Query.SQL.Add(' SELECT * FROM SUBCATEGORIAS AS SUBCAT INNER JOIN CATEGORIAS AS CAT ON ' +
                ' SUBCAT.CD_CATEGORIA = CAT.CD_CATEGORIA WHERE 1=1');

  if trim(PNome)<>'' then
  begin
    Query.SQL.Add(' AND SUBCAT.NM_SUBCATEGORIA LIKE :PNOME');
    Query.ParamByName('PNOME').AsString := '%'+PNome+'%';
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
