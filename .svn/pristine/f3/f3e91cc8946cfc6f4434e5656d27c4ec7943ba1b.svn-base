package tea.service.version;

import java.io.File;
import java.io.InputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URL;
import java.io.LineNumberReader;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Properties;
import java.sql.Connection;
import java.text.SimpleDateFormat;
import tea.db.DbAdapter;
import javax.servlet.http.HttpSession;
public class DBManager
{

    private static String _strUrl;
    private static String _strServer;
    private static String _strUserId;
    private static String _strPassword;
    private static String _strDriver;

    public Connection getConnection()
    {
        try
        {

            Properties properties = new Properties();
           URL u= this.getClass().getResource("/dbupdate.properties");
            //ȡ����ݿ������
            properties.load(u.openStream());
            _strDriver = properties.getProperty("JdbcDriver");
            _strUrl = properties.getProperty("Url");
            _strUserId = properties.getProperty("UserId");
            _strPassword = properties.getProperty("Password");

            Class.forName(_strDriver);
            //��bl��
            Connection connection = DriverManager.getConnection(_strUrl, _strUserId, _strPassword);
            return connection;
        } catch (Exception e)
        {
            e.printStackTrace();
            return null;
        } finally
        {

        }
    }


    /**
     * ȡ����ݿ�������Schema
     *
     * @return
     */
    public List getTableSchemas()
    {
        List retval = new ArrayList();
        try
        {
            Connection connection = getConnection();
            DatabaseMetaData dbmd = connection.getMetaData();
            ResultSet resultSet = dbmd.getSchemas();

            while (resultSet.next())
            {
                String tableName = resultSet.getString(1);
                retval.add(tableName);
            }
            resultSet.close();
            connection.close();
        } catch (SQLException e)
        {
            e.printStackTrace();
        }

        return retval;
    }

    /**
     * ȡ��ĳSchema�����б���
     *
     * @param schema
     * @return
     */
    public List getTablesInSchema(String schema)
    {
        List retval = new ArrayList();

        try
        {
            Connection connection = getConnection();
            DatabaseMetaData dbmd = connection.getMetaData();

            String[] types =
                             {"TABLE"};
            ResultSet resultSet = dbmd.getTables(null, null, "%", types);

            // Get the table names
            while (resultSet.next())
            {
                // Get the table name
                String tableName = resultSet.getString(3);
                String tableSchema = resultSet.getString(2);

                //   if (tableSchema.equals(schema))
                {
                    retval.add(tableName);
                }
            }
            resultSet.close();
            connection.close();
        } catch (SQLException e)
        {
            e.printStackTrace();
        }

        return retval;
    }


    public void setVersion(String version, String updatetime,
                           String preversion,String introduce,String client)
    {

        try
        {
            DbAdapter db=new DbAdapter();
            db.executeUpdate("insert into version(version,updatetime,preversion,introduce,client)" +
                               " values(" + DbAdapter.cite(version)+ "," + DbAdapter.cite(updatetime)+
                                "," + DbAdapter.cite(preversion) +  "," + DbAdapter.cite(introduce) +
                                "," + DbAdapter.cite(client) +")");
            db.close();

        } catch (SQLException e)
        {
            e.printStackTrace();
        }

    }


    public void excuteSQL(String file)
    {

        try
        {
            Connection connection = getConnection();

            // Create a result set
            Statement stmt = connection.createStatement();
            FileReader fin = new FileReader(file);
            LineNumberReader lnr = new LineNumberReader(fin);
            String str = lnr.readLine();
            while (str != null)
            {
                System.out.println(lnr.getLineNumber() + ":" + str);
                try
                {
                    stmt.executeUpdate(str);
                } catch (SQLException ex)
                {ex.printStackTrace();
                }
                str = lnr.readLine();

            }

            lnr.close();
            fin.close();

            stmt.close();
            connection.close();

        } catch (Exception e)
        {
            e.printStackTrace();
        }

    }

    /**
     * ȡ��ĳ���µ������ֶ���Ϣ
     *
     * @param table
     * @return
     */
    public List getColumnInfoesInTable(String table)
    {
        List retval = new ArrayList();

        try
        {
            Connection connection = getConnection();

            // Create a result set
            Statement stmt = connection.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM " + table);

            // Get result set meta data
            ResultSetMetaData rsmd = rs.getMetaData();
            int numColumns = rsmd.getColumnCount();

            // Get the column names; column indices start from 1
            for (int i = 1; i < numColumns + 1; i++)
            {
                ColumnInfoBean columnInfoBean = new ColumnInfoBean();

                // �ֶ���
                columnInfoBean.setName(rsmd.getColumnName(i));

                // �ֶ�����
                columnInfoBean.setTypeName(rsmd.getColumnTypeName(i));

                // �ֶ����Ͷ�Ӧ��java����
                columnInfoBean.setClassName(rsmd.getColumnClassName(i));

                // ��ʾ�ĳ���
                columnInfoBean.setDisplaySize(String.valueOf(rsmd
                        .getColumnDisplaySize(i)));

                // Precision
                columnInfoBean.setPrecision(String
                                            .valueOf(rsmd.getPrecision(i)));

                // Scale
                columnInfoBean.setScale(String.valueOf(rsmd.getScale(i)));

                retval.add(columnInfoBean);

            }
            rs.close();
                connection.close();
        } catch (SQLException e)
        {
            e.printStackTrace();
        }

        return retval;
    }

    public String CreateSQL()
    {

        DBManager md = new DBManager();
        StringBuilder createsql = new StringBuilder("");
        StringBuilder altersql = new StringBuilder("");
        String sql = "";
        //����ȡ�ֶ���Ϣ
        try
        {
            Connection connection = md.getConnection();
            // Create a result set
            Statement stmt = connection.createStatement();
            ResultSet rs = null;
            SimpleDateFormat dd = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
            Date now = new Date();
            String time = dd.format(now);
            List list = md.getTablesInSchema("test");
            Iterator iterator = list.iterator();
            while (iterator.hasNext())
            {
                String tablename = (String) iterator.next();
                System.out.println(tablename);
                rs = stmt.executeQuery("SELECT count(*) FROM db_struct where tablename like '" + tablename + "'");
                int hastable = 0;

                if (rs.next())
                    hastable = rs.getInt(1);
                if (hastable == 0)
                    createsql.append("create table " + tablename + "(");
                List listcolumn = md.getColumnInfoesInTable(tablename);
                Iterator iteratorcolumn = listcolumn.iterator();
                while (iteratorcolumn.hasNext())
                {
                    //String schemaname=(String)iterator.next();
                    //System.out.println(schemaname);
                    ColumnInfoBean cib = (ColumnInfoBean) iteratorcolumn.next();

                    rs = stmt.executeQuery("SELECT count(*) FROM db_struct where tablename like '" + tablename + "' and columnname like '" + cib.getName() + "'");
                    int hascolumn = 0;
                    if (rs.next())
                        hascolumn = rs.getInt(1);
                    if (hastable == 0)
                    {String typename=cib.getTypeName();
                        if (typename.equalsIgnoreCase("nvarchar") || typename.equalsIgnoreCase("varchar")||typename.equalsIgnoreCase("float"))
                            createsql.append(cib.getName() + " " + cib.getTypeName() + "(" + cib.getDisplaySize() + "),");
                        else if (typename.equalsIgnoreCase("datetime")||typename.indexOf("int")>=0||
                                 typename.equalsIgnoreCase("money")||typename.equalsIgnoreCase("text")||
                                 typename.equalsIgnoreCase("ntext"))
                            createsql.append(cib.getName() + " " + cib.getTypeName() + ",");
                        else
                            createsql.append(cib.getName() + " " + cib.getTypeName() + "(" + cib.getDisplaySize() + "),");

                    }
                    if (hascolumn == 0)
                    {
                        System.out.println("INSERT INTO db_struct (tablename ,columnname ,typename , displaysize ,prec ,updatetime ) VALUES (" +
                                           "'" + tablename +
                                           "','" + cib.getName() +
                                           "','" + cib.getTypeName() +
                                           "','" + cib.getDisplaySize() +
                                           "','" + cib.getPrecision() +
                                           "','" + time +
                                           "');");
                        stmt.executeUpdate("INSERT INTO db_struct (tablename ,columnname ,typename , displaysize ,prec ,updatetime ) VALUES (" +
                                           "'" + tablename +
                                           "','" + cib.getName() +
                                           "','" + cib.getTypeName() +
                                           "','" + cib.getDisplaySize() +
                                           "','" + cib.getPrecision() +
                                           "','" + time +
                                           "');");
                        if (hastable != 0)
                        { String typename=cib.getTypeName();
                            if (typename.equalsIgnoreCase("datetime")||typename.indexOf("int")!=-1||
                                  typename.equalsIgnoreCase("money")||typename.equalsIgnoreCase("text")||
                                  typename.equalsIgnoreCase("ntext"))
                                altersql.append("ALTER TABLE " + tablename + " ADD " + cib.getName() + " " + cib.getTypeName() + ";\n");
                            else
                                altersql.append("ALTER TABLE " + tablename + " ADD " + cib.getName() + " " + cib.getTypeName() + "(" + cib.getDisplaySize() + ");\n");
                        }
                    } // end if has column
                } //end while column
                if (hastable == 0)
                {
                    createsql.setCharAt(createsql.length() - 1, ')');
                    createsql.append(";\n");

                }

            } //end while table
            System.out.println(createsql.toString());
            System.out.println(altersql.toString());
            sql = createsql.append(altersql).toString();
            rs.close();
            stmt.close();
            connection.close();

        } catch (SQLException e)
        {
            e.printStackTrace();
        }

        return sql;
    }
    public String CreateSQL(HttpSession session)
       {

           DBManager md = new DBManager();
           StringBuilder createsql = new StringBuilder("");
           StringBuilder altersql = new StringBuilder("");
           String sql = "";
           //����ȡ�ֶ���Ϣ
           try
           {
               Connection connection = md.getConnection();
               // Create a result set
               Statement stmt = connection.createStatement();
               ResultSet rs = null;
               SimpleDateFormat dd = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
               Date now = new Date();
               String time = dd.format(now);
               List list = md.getTablesInSchema("test");
               Iterator iterator = list.iterator();
               while (iterator.hasNext())
               {
                   String tablename = (String) iterator.next();
                   session.setAttribute("currentjob","Scanning Table:"+tablename);
                   System.out.println(tablename);
                   rs = stmt.executeQuery("SELECT count(*) FROM db_struct where tablename like '" + tablename + "'");
                   int hastable = 0;

                   if (rs.next())
                       hastable = rs.getInt(1);
                   if (hastable == 0)
                       createsql.append("create table " + tablename + "(");
                   List listcolumn = md.getColumnInfoesInTable(tablename);
                   Iterator iteratorcolumn = listcolumn.iterator();
                   while (iteratorcolumn.hasNext())
                   {
                       //String schemaname=(String)iterator.next();
                       //System.out.println(schemaname);
                       ColumnInfoBean cib = (ColumnInfoBean) iteratorcolumn.next();

                       rs = stmt.executeQuery("SELECT count(*) FROM db_struct where tablename like '" + tablename + "' and columnname like '" + cib.getName() + "'");
                       int hascolumn = 0;
                       if (rs.next())
                           hascolumn = rs.getInt(1);
                       if (hastable == 0)
                       {String typename=cib.getTypeName();
                           if (typename.equalsIgnoreCase("nvarchar") || typename.equalsIgnoreCase("varchar")||typename.equalsIgnoreCase("float"))
                               createsql.append(cib.getName() + " " + cib.getTypeName() + "(" + cib.getDisplaySize() + "),");
                           else if (typename.equalsIgnoreCase("datetime")||typename.indexOf("int")>=0||
                                    typename.equalsIgnoreCase("money")||typename.equalsIgnoreCase("text")||
                                    typename.equalsIgnoreCase("ntext"))
                               createsql.append(cib.getName() + " " + cib.getTypeName() + ",");
                           else
                               createsql.append(cib.getName() + " " + cib.getTypeName() + "(" + cib.getDisplaySize() + "),");

                       }
                       if (hascolumn == 0)
                       {
                           System.out.println("INSERT INTO db_struct (tablename ,columnname ,typename , displaysize ,prec ,updatetime ) VALUES (" +
                                              "'" + tablename +
                                              "','" + cib.getName() +
                                              "','" + cib.getTypeName() +
                                              "','" + cib.getDisplaySize() +
                                              "','" + cib.getPrecision() +
                                              "','" + time +
                                              "');");
                           stmt.executeUpdate("INSERT INTO db_struct (tablename ,columnname ,typename , displaysize ,prec ,updatetime ) VALUES (" +
                                              "'" + tablename +
                                              "','" + cib.getName() +
                                              "','" + cib.getTypeName() +
                                              "','" + cib.getDisplaySize() +
                                              "','" + cib.getPrecision() +
                                              "','" + time +
                                              "');");
                           if (hastable != 0)
                           { String typename=cib.getTypeName();
                               if (typename.equalsIgnoreCase("datetime")||typename.indexOf("int")!=-1||
                                     typename.equalsIgnoreCase("money")||typename.equalsIgnoreCase("text")||
                                     typename.equalsIgnoreCase("ntext"))
                                   altersql.append("ALTER TABLE " + tablename + " ADD " + cib.getName() + " " + cib.getTypeName() + ";\n");
                               else
                                   altersql.append("ALTER TABLE " + tablename + " ADD " + cib.getName() + " " + cib.getTypeName() + "(" + cib.getDisplaySize() + ");\n");
                           }
                       } // end if has column
                   } //end while column
                   if (hastable == 0)
                   {
                       createsql.setCharAt(createsql.length() - 1, ')');
                       createsql.append(";\n");

                   }

               } //end while table
               System.out.println(createsql.toString());
               System.out.println(altersql.toString());
               sql = createsql.append(altersql).toString();
               rs.close();
               stmt.close();
               connection.close();

           } catch (SQLException e)
           {
               e.printStackTrace();
           }

           return sql;
       }

    public void initSQL()
       {

           DBManager md = new DBManager();
           String sql = "";
           
           try
           {
               Connection connection = md.getConnection();
               // Create a result set
               Statement stmt = connection.createStatement();
               ResultSet rs = null;
               SimpleDateFormat dd = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
               Date now = new Date();
               String time = dd.format(now);
               List list = md.getTablesInSchema("test");
               Iterator iterator = list.iterator();
               while (iterator.hasNext())
               {
                   String tablename = (String) iterator.next();
                   System.out.println(tablename);
                   rs = stmt.executeQuery("SELECT count(*) FROM db_struct where tablename like '" + tablename + "'");
                   int hastable = 0;

                   if (rs.next())
                       hastable = rs.getInt(1);

                   List listcolumn = md.getColumnInfoesInTable(tablename);
                   Iterator iteratorcolumn = listcolumn.iterator();
                   while (iteratorcolumn.hasNext())
                   {
                       //String schemaname=(String)iterator.next();
                       //System.out.println(schemaname);
                       ColumnInfoBean cib = (ColumnInfoBean) iteratorcolumn.next();

                       rs = stmt.executeQuery("SELECT count(*) FROM db_struct where tablename like '" + tablename + "' and columnname like '" + cib.getName() + "'");
                       int hascolumn = 0;
                       if (rs.next())
                           hascolumn = rs.getInt(1);

                       if (hascolumn == 0)
                       {
                           System.out.println("INSERT INTO db_struct (tablename ,columnname ,typename , displaysize ,prec ,updatetime ) VALUES (" +
                                              "'" + tablename +
                                              "','" + cib.getName() +
                                              "','" + cib.getTypeName() +
                                              "','" + cib.getDisplaySize() +
                                              "','" + cib.getPrecision() +
                                              "','" + time +
                                              "');");
                           stmt.executeUpdate("INSERT INTO db_struct (tablename ,columnname ,typename , displaysize ,prec ,updatetime ) VALUES (" +
                                              "'" + tablename +
                                              "','" + cib.getName() +
                                              "','" + cib.getTypeName() +
                                              "','" + cib.getDisplaySize() +
                                              "','" + cib.getPrecision() +
                                              "','" + time +
                                              "');");

                       } // end if has column
                   } //end while column


               } //end while table

               rs.close();
               stmt.close();
               connection.close();

           } catch (SQLException e)
           {
               
               e.printStackTrace();
           }

          // return sql;
    }

    public void initSQL(HttpSession session)
      {

          DBManager md = new DBManager();
          String sql = "";
          
          try
          {
              Connection connection = md.getConnection();
              // Create a result set
              Statement stmt = connection.createStatement();
              ResultSet rs = null;
              SimpleDateFormat dd = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
              Date now = new Date();
              String time = dd.format(now);
              List list = md.getTablesInSchema("test");
              Iterator iterator = list.iterator();
              while (iterator.hasNext())
              {
                  String tablename = (String) iterator.next();
                  session.setAttribute("currentjob","Scanning Table:"+tablename);
                  System.out.println(tablename);
                  rs = stmt.executeQuery("SELECT count(*) FROM db_struct where tablename like '" + tablename + "'");
                  int hastable = 0;

                  if (rs.next())
                      hastable = rs.getInt(1);

                  List listcolumn = md.getColumnInfoesInTable(tablename);
                  Iterator iteratorcolumn = listcolumn.iterator();
                  while (iteratorcolumn.hasNext())
                  {
                      //String schemaname=(String)iterator.next();
                      //System.out.println(schemaname);
                      ColumnInfoBean cib = (ColumnInfoBean) iteratorcolumn.next();

                      rs = stmt.executeQuery("SELECT count(*) FROM db_struct where tablename like '" + tablename + "' and columnname like '" + cib.getName() + "'");
                      int hascolumn = 0;
                      if (rs.next())
                          hascolumn = rs.getInt(1);

                      if (hascolumn == 0)
                      {
                          System.out.println("INSERT INTO db_struct (tablename ,columnname ,typename , displaysize ,prec ,updatetime ) VALUES (" +
                                             "'" + tablename +
                                             "','" + cib.getName() +
                                             "','" + cib.getTypeName() +
                                             "','" + cib.getDisplaySize() +
                                             "','" + cib.getPrecision() +
                                             "','" + time +
                                             "');");
                          stmt.executeUpdate("INSERT INTO db_struct (tablename ,columnname ,typename , displaysize ,prec ,updatetime ) VALUES (" +
                                             "'" + tablename +
                                             "','" + cib.getName() +
                                             "','" + cib.getTypeName() +
                                             "','" + cib.getDisplaySize() +
                                             "','" + cib.getPrecision() +
                                             "','" + time +
                                             "');");

                      } // end if has column
                  } //end while column


              } //end while table

              rs.close();
              stmt.close();
              connection.close();

          } catch (SQLException e)
          {
              
              e.printStackTrace();
          }

         // return sql;
   }

   /* public static void main(String[] args)
    {

        DBManager md = new DBManager();
         String sql= md.CreateSQL();
       	 FileService fs=new FileService();
         fs.cretesql(sql.getBytes(),"c:\\update","update.sql");
      //  md.excuteSQL("c:\\update\\update.sql");

    }*/

}
