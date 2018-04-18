unit Data_Module_U;

interface

uses
  SysUtils, Classes, DB, ADODB;

type
  Tdata_module = class(TDataModule)
    connection: TADOConnection;
    qry: TADOQuery;
  private
    { Private declarations }
    class function queryDatabase(query: string; var qry: TADOQuery): TADOQuery;
    class function modifyDatabase(sql: string; var qry: TADOQuery): boolean;
    class function getEntityByID(table, id: string; var qry: TADOQuery): boolean;
  public
    { Public declarations }

  end;

var
  data_module: Tdata_module;

implementation

{$R *.dfm}

{ Tdata_module }

class function Tdata_module.getEntityByID(table, id: string;
  var qry: TADOQuery): boolean;
begin
  self.queryDatabase
    ('SELECT * FROM ' + table + ' WHERE ID = ' + id, data_module.qry);

  if qry.Eof then
  begin
    result := false;
    Exit;
  end;

  result := true;
end;

class function Tdata_module.modifyDatabase(sql: string;
  var qry: TADOQuery): boolean;
begin
  try
    qry.Close;
    qry.sql.clear;
    qry.sql.Add(sql);
    qry.ExecSQL;
    result := true;
  except
    on E: Exception do
    begin
//      Showmessage('Something went wrong... Check logs for more information.');
//      TLogger.logException(TAG, 'modifyDatabase ' + sql, e);
      result := false;
      Exit;
    end;
  end;

end;

class function Tdata_module.queryDatabase(query: string;
  var qry: TADOQuery): TADOQuery;
begin
  try
    qry.Close;
    qry.sql.clear;
    qry.sql.Add(query);
    qry.Open;

    result := qry;
  except
    on E: Exception do
    begin
//      Showmessage('Something went wrong... Check logs for more information.');
//      TLogger.logException(TAG, 'queryDatabase ' + query, e);
      Exit;
    end;
  end;
end;



end.
