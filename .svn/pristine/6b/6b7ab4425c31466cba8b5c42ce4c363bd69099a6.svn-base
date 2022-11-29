package tea.db;




import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.Vector;
 
public class MysqlOracle {
 public static Connection conn;
 public static Statement statement;
 public Hashtable<String, Vector<Vector<String>>> hashtable = new Hashtable<String, Vector<Vector<String>>>();
 public static final String filepathCreateTable = "D://mo//CreateTable.txt";
 public static final String filepathCreateSequence = "D://mo//CreateSequence.txt";
 public static final String filepathCreateTrigger = "D://mo//CreateTrigger.txt";
 public static final String filepathCreatePrimarykey = "D://mo//CreatePrimarykey.txt";
 public static final String filepathCreateIndex = "D://mo//CreateIndex.txt";
 
 //只要修改主機名，數據庫名字和user、password
 public static final String DBdriver = "com.mysql.jdbc.Driver";
 public static final String DBURL = "jdbc:mysql://127.0.0.1:3306/edntry?user=root&password=v609";
 public static final String DBSCHEMA = "edntry"; // 
   

/* public static void main(String[] args) {
  new MysqlOracle();
 }*/
 
 public MysqlOracle() {
 
  //刪除文件
  deleteFile();
 
  if (!connectionMethod()) {
   System.out.println("鏈接錯誤");
   return;
  }
 
  Vector<String> table = queryAllTable(DBSCHEMA);
  if (table.size() == 0) 
  {
   System.out.println("沒有找到表");
   return;
  }
 
 
  
  for (int i = 0; i < table.size(); i++)
  { //得到數據
   hashtable.put(table.get(i), handle_table(table.get(i)));
  }
       
  // hashtable.put(table.get(0).toString(),handle_table(table.get(0)));
  System.out.println("操作正在進行中,請耐心等待......");
  generatorString(hashtable); //產生字符串
 
  close();//關閉連接
  System.out.println("finish");
  
 }
 
 public void generatorString(Hashtable hashtable) {
  Iterator iter = hashtable.keySet().iterator();
  while (iter.hasNext()) {
   String tablescript = ""; // 創表語句
   String tablesequence = ""; // 建立sequence
   String tabletrigger = ""; // 建立trigger
   String tableprimarykey = "";// 建立主鍵
   String tableindex = "";// 建立索引
   String primarkeyColumn = "";
   String indexColumn = "";
 
   int primarykey = 0;
   int index = 0;
 
   String tablename = (String) iter.next();
   Vector valall = (Vector) hashtable.get(tablename);
   System.out.println("表生成："+tablename);
   tablescript = "create table " + tablename + "(";
   for (int i = 0; i < valall.size(); i++) {
    Vector<String> val = (Vector) valall.get(i);
    String column_name = val.get(0).toString();// 列名
    String is_nullable = val.get(1).toString();// 是否為空，如果不允許NO,允許為YES
    String data_type = val.get(2).toString();// int,varchar,text,timestamp,date
    String character_maximun_length = val.get(3).toString();// 長度大小
    String column_key = val.get(4).toString();// 是否主鍵 是的話為PRI
               // MUL(index)
               // 有兩個PRI說明是複合index
    String extra = val.get(5).toString(); // 是否自動增長列 是的話
              // auto_increment
    String column_default = val.get(6).toString();// 是否有默認值
 
    if (data_type.equals("varchar") || data_type.equals("char")) { // 驗證是否有中文字符
     if (judge_china(tablename, column_name)) {
      character_maximun_length = Integer
        .parseInt(character_maximun_length)
        * 3 + "";
     }
    }
 
    tablescript = tablescript + column_name + " ";
    if (data_type.equals("int")) {
     tablescript = tablescript + "NUMBER" + " ";
    } else if (data_type.equals("mediumint")) {
     tablescript = tablescript + "NUMBER" + " ";
    } else if (data_type.equals("char")) {
     tablescript = tablescript + "varchar2("
       + character_maximun_length + ")" + " ";
    } else if (data_type.equals("varchar")) {
     tablescript = tablescript + "varchar2("
       + character_maximun_length + ")" + " ";
    } else if (data_type.equals("text")) {
     tablescript = tablescript + "varchar2(4000) ";
    } else if (data_type.equals("timestamp")) {
     tablescript = tablescript + "date" + " ";
    } else if (data_type.equals("date")) {
     tablescript = tablescript + "date" + " ";
    } else if (data_type.equals("float")) {
     tablescript = tablescript + "NUMBER" + " ";
    } else if (data_type.equals("longtext")) {
     tablescript = tablescript + "varchar2(4000) ";
    } else if (data_type.equals("smallint")) {
     tablescript = tablescript + "NUMBER" + " ";
    } else if (data_type.equals("double")) {
     tablescript = tablescript + "NUMBER" + " ";
    } else if (data_type.equals("datetime")) {
     tablescript = tablescript + "date" + " ";
    }
 
    if (column_default.length() > 0) { // 是否有默認值
     if (column_default.equals("CURRENT_TIMESTAMP")) {
      tablescript = tablescript + "default sysdate" + " ";
     } else {
      tablescript = tablescript + "default " + column_default
        + " ";
     }
    }
 
    if (is_nullable.equals("NO")) { // 是否為空值
     tablescript = tablescript + "not null,";
    } else {
     tablescript = tablescript + ",";
    }
 
    if (extra.equals("auto_increment")) { // 是否自動增長列
     int maxid = get_maxId(tablename, column_name);
     tablesequence = "create sequence sq_" + tablename + " "
       + "minvalue " + maxid + " "
       + "maxvalue 9999999999999999 " + "increment by 1 "
       + "start with " + maxid + " " + "cache 20;";
     tabletrigger = "EXECUTE IMMEDIATE  'create trigger tr_"
       + tablename + " " + "before " + "insert on "
       + tablename + " for each row " + "begin "
       + "select sq_" + tablename + ".nextval into:new."
       + column_name + " from dual; " + "end;';";
    }
 
    if (column_key.length() > 0) {
     if (column_key.equals("PRI")) {
      primarykey++;
      primarkeyColumn = primarkeyColumn + column_name + ",";
     } else if (column_key.equals("MUL")) {
      index++;
      indexColumn = indexColumn + column_name + ",";
     }
    }
 
   }
 
   if (primarykey == 1) {
    primarkeyColumn = primarkeyColumn.substring(0, primarkeyColumn
      .length() - 1);
    String key = "pr_" + tablename + "_" + primarkeyColumn;
    if (key.length() > 30) {
     key = "pr_" + primarkeyColumn;
    }
    tableprimarykey = "alter table " + tablename
      + "  add constraint " + key + " primary key ("
      + primarkeyColumn + ");";
   } else {
    primarkeyColumn = primarkeyColumn.substring(0, primarkeyColumn
      .length());
    String indextemp = tablename + "_index";
    if (indextemp.length() > 30)
     indextemp = primarkeyColumn.replace(',', '_') + "_index";
    tableindex = "create index " + indextemp + " on " + tablename
      + " (" + primarkeyColumn + ");";
   }
 
   if (index > 0) {
    indexColumn = indexColumn
      .substring(0, indexColumn.length() - 1);
    String indextemp = tablename + "_index";
    if (indextemp.length() > 30)
     indextemp = indexColumn.replace(',', '_') + "_index";
    tableindex = "create index " + indextemp + " on " + tablename
      + " (" + indexColumn + ");";
   }
 
   tablescript = tablescript.substring(0, tablescript.length() - 1);
   tablescript = tablescript + ");";
 
   if (tablescript.length() > 0)
    write(filepathCreateTable, tablescript);
   if (tablesequence.length() > 0)
    write(filepathCreateSequence, tablesequence);
   if (tabletrigger.length() > 0)
    write(filepathCreateTrigger, tabletrigger);
   if (tableprimarykey.length() > 0)
    write(filepathCreatePrimarykey, tableprimarykey);
   if (tableindex.length() > 0)
    write(filepathCreateIndex, tableindex);
 
  }
 
 }
 
 public void close() {
  try {
   statement.close();
   conn.close();
  } catch (SQLException e) {
   // TODO Auto-generated catch block
   e.printStackTrace();
  }
 }
 
 public Vector<Vector<String>> handle_table(String tablename) {
  Vector<Vector<String>> arg = new Vector<Vector<String>>();
  try {
   String queryDetail = "SELECT * "
     + "FROM `information_schema`.`COLUMNS` "
     + "where `TABLE_SCHEMA`='" + DBSCHEMA + "' "
     + "and `TABLE_NAME`='" + tablename + "' "
     + "order by `ORDINAL_POSITION`";
   // System.out.println("sql= "+queryDetail);
   ResultSet rst = statement.executeQuery(queryDetail);
 
   while (rst.next()) {
    Vector<String> vec = new Vector<String>();
    String column_name = NulltoSpace(rst.getString("COLUMN_NAME"));// 列名
    String is_nullable = NulltoSpace(rst.getString("IS_NULLABLE"));// 是否為空，如果不允許NO,允許為YES
    String data_type = NulltoSpace(rst.getString("DATA_TYPE"));// int,varchar,text,timestamp,date
    String character_maximun_length = NulltoSpace(rst
      .getString("CHARACTER_MAXIMUM_LENGTH"));// 長度大小
    String column_key = NulltoSpace(rst.getString("COLUMN_KEY"));// 是否主鍵
                    // 是的話為PRI
                    // MUL(index)
                    // 有兩個PRI說明是複合index
    String extra = NulltoSpace(rst.getString("EXTRA")); // 是否自動增長列
                 // 是的話
                 // auto_increment
    String column_default = NulltoSpace(rst
      .getString("COLUMN_DEFAULT"));// 是否有默認值
    vec.add(column_name);
    vec.add(is_nullable);
    vec.add(data_type);
    vec.add(character_maximun_length);
    vec.add(column_key);
    vec.add(extra);
    vec.add(column_default);
    arg.add(vec);
   }
   rst.close();
  } catch (SQLException e) {
   e.printStackTrace();
  }
 
  return arg;
 }
 
 public boolean judge_china(String tablename, String columnname) {
  try {
   String querysql = "select count(1) row from " + tablename
     + " where length(" + columnname + ")!=char_length("
     + columnname + ")";
   // System.out.println("sql= "+querysql);
   ResultSet rst = statement.executeQuery(querysql);
   if (rst.next()) {
    if (NulltoSpace(rst.getString("row")).equals("0")) {
     return false;
    } else {
     return true;
    }
   }
    rst.close();
  } catch (SQLException e) {
   // TODO Auto-generated catch block
  }
  return true;
 }
 
 public int get_maxId(String tablename, String columnname) {
  String maxValue = "0";
  try {
   String querysql = "select max(" + columnname + ") maxid from "
     + tablename;
   // System.out.println("sql= "+querysql);
   ResultSet rst = statement.executeQuery(querysql);
   if (rst.next()) {
    maxValue = NulltoSpace(rst.getString("maxid"));
   }
    rst.close();
  } catch (SQLException e) {
  }
  return Integer.parseInt(maxValue + 1);
 }
 
 public Vector<String> queryAllTable(String table_schema) {
  Vector<String> tableName = new Vector<String>();
  try {
   String queryTable = "SELECT `TABLES`.`TABLE_NAME` "
     + "FROM `information_schema`.`TABLES` "
     + "WHERE `TABLES`.`TABLE_TYPE` = 'base table' "
     + "and `TABLES`.`TABLE_SCHEMA`  ='" + table_schema + "'";
   // System.out.println("sql= "+queryTable);
   ResultSet rst = statement.executeQuery(queryTable);
   while (rst.next()) {
    tableName.add(NulltoSpace(rst.getString("TABLE_NAME")));
   }
  } catch (SQLException e) {
   // TODO Auto-generated catch block
  }
  return tableName;
 }
 
 public boolean connectionMethod() {
  try {
   Class.forName(DBdriver).newInstance();
   conn = DriverManager.getConnection(DBURL);
   statement = conn.createStatement();
   return true;
  } catch (Exception e) {
   // TODO Auto-generated catch block
   e.printStackTrace();
   return false;
  }
 }
 
 public static String NulltoSpace(Object o) {
  if (o == null)
   return "";
  else if (o.equals("null")) {
   return "";
  } else {
   return o.toString().trim();
  }
 }
 
 //删除常量文件
 public static void deleteFile(){
  File f;
  f= new File(filepathCreateTable);
  if(f.exists()) f.delete();
  f= new File(filepathCreatePrimarykey);
  if(f.exists()) f.delete();
  f= new File(filepathCreateSequence);
  if(f.exists()) f.delete();
  f= new File(filepathCreateTrigger);
  if(f.exists()) f.delete();
  f= new File(filepathCreateIndex);
  if(f.exists()) f.delete();
 }
 
 public static void write(String path, String content) {
  String s = new String();
  String s1 = new String();
  try {
   File f = new File(path);
   if (f.exists()) {
   } else {
       f.createNewFile();
   }
   BufferedReader input = new BufferedReader(new FileReader(f));
 
   while ((s = input.readLine()) != null) {
    s1 += s + "\r\n";
   }
   input.close();
   s1 += content;
 
   BufferedWriter output = new BufferedWriter(new FileWriter(f));
   output.write(s1);
   output.close();
  } catch (Exception e) {
   e.printStackTrace();
  }
 }
 
}