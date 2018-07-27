unit Data_Module_U;

interface

uses
  SysUtils, Classes, DB, ADODB, Logger_U;

type
  Tdata_module = class(TDataModule)
    connection: TADOConnection;
    qry: TADOQuery;
    tblUsers: TADOTable;
  private
    { Private declarations }
    const
      TAG: string = 'DATA_MODULE';


  public
    { Public declarations }
    class function queryDatabase(query: string; var qry: TADOQuery): TADOQuery;
    class function modifyDatabase(sql: string; var qry: TADOQuery): boolean;
    class function getEntityByID(table, id: string; var qry: TADOQuery): boolean;
    class function getLastInsertedID(var query: TADOQuery): Integer;
    procedure test;
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
      TLogger.logException(TAG, 'modifyDatabase ' + sql, e);
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

//    TLogger.log(TAG, debug, 'Query: ' + query);
    result := qry;
  except
    on E: Exception do
    begin
      TLogger.logException(TAG, 'queryDatabase ' + query, e);
      Exit;
    end;
  end;
end;

// http://www.swissdelphicenter.com/en/showcode.php?id=1749
class function Tdata_module.getLastInsertedID(var query: TADOQuery): Integer;
begin
  result := -1;
  try
    query.sql.clear;
    query.sql.Add('SELECT @@IDENTITY');
    query.Active := true;
    query.First;
    result := query.Fields.Fields[0].AsInteger;
  finally
    query.Active := false;
    query.sql.clear;
  end;
end;

procedure Tdata_module.test;
begin
  Tdata_module.getEntityByID('Items', '1', qry);
  TLogger.log(TAG, debug, qry.Fields[1].asstring);
end;

end.
