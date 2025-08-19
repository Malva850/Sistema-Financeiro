unit UCriptografia;

interface

type
  TCripografia = class
  private

  protected

  public
    function Criptografar(valor: string): string;
  end;

implementation

{ TCripografia }

function TCripografia.Criptografar(valor: string): string;
var
  I: Integer;
begin
  for I := 1 to Length(valor) do
    Result := Result + Chr((Ord(valor[I]) + 57));
end;

end.
