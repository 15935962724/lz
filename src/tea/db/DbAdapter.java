package tea.db;

import java.io.*;
import java.math.*;
import java.sql.*;
import java.text.*;
import java.net.*;
import java.util.Date;
import tea.translator.Translator;
import tea.entity.*;
import oracle.sql.*;
import java.util.*;
import java.util.regex.*;
import tea.entity.cluster.*;

public class DbAdapter
{
    private int _nNo;
    public Connection _con;
    private Statement _stmt;
	PreparedStatement ps;
    public ResultSet _rs;
    private static String BYTEMAP[];
    static final char ACSQL[] =
            {'\''};
    static final String ASTRSQL[] =
            {"''"};
    static
    {
        BYTEMAP = new String[256];
        int i = 0;
        do
        {
            BYTEMAP[i] = new StringBuffer(Integer.toHexString(i / 16)).append(Integer.toHexString(i % 16)).toString();
        } while(++i < 256);
    }

    public DbAdapter()
    {
        this(0);
    }

    public DbAdapter(int _nNo)
    {
        try
        {
            _con = ConnectionPool.getInstance().getConnection(_nNo);
            _stmt = _con.createStatement();
        } catch(SQLException ex)
        {
            String code = ex.getSQLState();
            if("08S01".equals(code) || "08003".equals(code))
            {
                System.out.println("不能连接到数据库..." + ConnectionPool._strUrl[_nNo]);
                throw new NullPointerException(ex.toString());
            } else
            {
                System.out.println("错误号:" + code);
                ex.printStackTrace();
            }
        }
        this._nNo = _nNo;
    }

    public int executeUpdate(int opid,String sql) throws SQLException
    {
        int j = executeUpdate(sql);
        if(Cluster.getInstance().no > 0)
        {
            DML t = new DML(0);
            t.opid = opid;
            t.content = sql;
            //t.trace = "";
            t.set(this);
        }
        return j;
    }

    public int executeUpdate(String sql) throws SQLException
    {
        try
        {
            if(_rs != null)
            {
                _rs.close();
                _rs = null;
            }
            long cur = System.currentTimeMillis();
            int j = _stmt.executeUpdate(sql);
            logs(cur,sql);
            return j;
        } catch(SQLException ex)
        {
            String err = ex.getMessage();
            //ex.printStackTrace();
            //[Microsoft][SQLServer 2000 Driver for JDBC][SQLServer]不能在具有唯一索引 'IX_Listed_node' 的对象 'dbo.Listed' 中插入重复键的行。	State:23000	Code:2601
            //[Microsoft][SQLServer 2000 Driver for JDBC][SQLServer]违反了 PRIMARY KEY 约束 'PK_Node'。不能在对象 'dbo.node' 中插入重复键。	State:23000	Code:2627
            //java.sql.SQLException: ORA-00001: 违反唯一约束条件 (EDN.SYS_C003530)
            //Duplicate entry '#rocky.usamilab.ise.shibaura-it.ac.jp' for key 1   State:23000     Code:1062
            //[Microsoft][SQLServer 2000 Driver for JDBC][SQLServer]当 IDENTITY_INSERT 设置为 OFF 时，不能为表 'Node' 中的标识列插入显式值。	State:23000	Code:544
            //[Microsoft][SQLServer 2000 Driver for JDBC][SQLServer]对象名 'node1' 无效。	State:42S02	Code:208
            //[Microsoft][SQLServer 2000 Driver for JDBC][SQLServer]在将 varchar 值 'ff' 转换成数据类型 int 时失败。	State:22018	Code:245
            int ec = ex.getErrorCode();
            if(ec == 1062 || ec == 2601 || ec == 2627 || err.indexOf("ORA-00001:") != -1) //主键重复不让报错,返回0
                return 0;
            reset(ex,sql);
            return executeUpdate(sql);
        }
    }

    public static String[] split(String table,String field,String val,String where)
    {
        if(ConnectionPool._nType != 2)
        {
            return new String[]
                    {val};
        }
        int j = val.length() / 1333;
        if(val.length() == 0 || val.length() % 1333 != 0)
            j++;
        String[] arr = new String[j];
        if(j == 1)
            arr[0] = val;
        else
        {
            for(int i = 1;i < j;i++) //1333
            {
                int s = i * 1333;
                arr[i] = "DECLARE c NCLOB;s VARCHAR2(4000);" +
                         "BEGIN" +
                         " s:=" + DbAdapter.cite(val.substring(s,Math.min(s + 1333,val.length()))) + ";" +
                         " SELECT " + field + " INTO c FROM " + table + " WHERE " + where + " FOR UPDATE;" +
                         " DBMS_LOB.WRITE(c,LENGTH(s)," + (s + 1) + ",s);" +
                         "END;";
            }
            arr[0] = val.substring(0,1333);
        }
        return arr;
    }

    private static boolean isE(String err)
    {
        return err.indexOf(" PRIMARY KEY ") != -1 || err.indexOf("ORA-00001:") != -1 || err.startsWith("Duplicate entry ") || err.indexOf("' 中插入重复键") != -1;
    }

    public static int execute(String sql) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            long cur = System.currentTimeMillis();
            db._stmt.execute(sql);
            ResultSet rs = db._stmt.getResultSet();
            if(rs != null)
            {
                j = rs.next() ? rs.getInt(1) : 0;
                rs.close();
            } else
            {
                j = db._stmt.getUpdateCount();
            }
            logs(cur,sql);
        } catch(SQLException ex)
        {
            if(isE(ex.getMessage()))
            {
                return 0;
            }
            System.out.println(sql);
            throw ex;
        } finally
        {
            db.close();
        }
        return j;
    }

    public ResultSet executeQuery(String sql,int page,int size) throws SQLException
    {
        boolean flag = false;
        if(size != Integer.MAX_VALUE)
        {
            switch(ConnectionPool._nType)
            {
            case 0:
                sql += " LIMIT " + page + "," + size;
                break;
            case 1:
            case 3:
                flag = true;
                sql = sql.substring(0,6) + " TOP " + (page + size) + sql.substring(6);
                break;
            case 2:
                sql = "SELECT * FROM (SELECT T2.*,ROWNUM RN FROM (" + sql + ") T2 WHERE ROWNUM<=" + (page + size) + ") WHERE RN>" + page;
                break;
            }
        }
        try
        {
            if(_rs != null)
            {
                _rs.close();
                _rs = null;
            }
            long cur = System.currentTimeMillis();
            _rs = _stmt.executeQuery(sql);
            logs(cur,sql);
        } catch(SQLException ex)
        {
            reset(ex,sql);
            executeQuery(sql);
        }
        if(flag)
        {
            for(int i = 0;i < page && _rs.next();i++)
                ;
        }
        return _rs;
    }

    public static ArrayList execute(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery(sql,pos,size);
            while(db.next())
            {
                al.add(db.getObject(1));
            }
        } finally
        {
            db.close();
        }
        return al;
    }

    static StringBuilder SB = new StringBuilder();
    static synchronized void logs(long cur,String sql)
    {
        if(!ConnectionPool._bDebug)
            return;
        SB.append(cur + "," + (System.currentTimeMillis() - cur) + "," + sql + "\r\n");
        if(SB.length() > 10000) //10000
        {
            try
            {
//                StackTraceElement[] ste = Thread.currentThread().getStackTrace();
//                for(int i = 2;i < ste.length && i < 9;i++)
//                {
//                    SB.append("　　" + ste[i].toString() + "\r\n");
//                }
                FileWriter fw = new FileWriter("DbAdapter.log",true);
                fw.write(SB.toString());
                fw.close();
                SB.setLength(0);
            } catch(Throwable ex)
            {
                ex.printStackTrace();
            }
        }
    }

    public void executeQuery(String sql) throws SQLException
    {
        executeQuery(sql,0,Integer.MAX_VALUE);
    }

    public void executeQuery(String sql,Object[] par) throws SQLException
    {
        if(_rs != null)
            _rs.close();
        if(ps != null)
        {
            ps.close();
            ps = null;
        }
        ps = _con.prepareStatement(sql);
        for(int i = 0;i < par.length;i++)
            ps.setObject(i + 1,par[i]);
        _rs = ps.executeQuery();
    }

    public void close()
    {
        try
        {
            if(_rs != null)
                _rs.close();
            if(ps != null)
                ps.close();
        } catch(Exception ex)
        {
            ex.printStackTrace();
        }
        try
        {
            _stmt.close();
        } catch(Exception ex1)
        {
            ex1.printStackTrace();
        }
        try
        {
            ConnectionPool.getInstance().freeConnection(_con,_nNo);
        } catch(Exception ex2)
        {
            ex2.printStackTrace();
        }
        _rs = null;
        _stmt = null;
        _con = null;
    }

    private void reset(SQLException ex,String sql) throws SQLException
    {
        System.out.println(ConnectionPool._strServer[_nNo] + "\tSQL:" + sql);
        String err = ex.getMessage();
        Matcher m = Pattern.compile("列名 '(\\w+)' 无效|Unknown column '(\\w+)' in 'field list'|ORA-00904: \"(\\w+)\": ").matcher(err);
        if(m.find())
        {
            String field = m.group(1);
            if(field == null)
            {
                field = m.group(2);
                if(field == null)
                    field = m.group(3);
            }
            m = Pattern.compile(" FROM (\\w+) |INSERT INTO (\\w+)\\(",Pattern.CASE_INSENSITIVE).matcher(sql);
            if(m.find())
            {
                String tab = m.group(1);
                if(tab == null)
                    tab = m.group(2);
                System.out.println("添加字段：" + tab + "." + field);
                executeUpdate("ALTER TABLE " + tab + " ADD " + field + " VARCHAR(" + ("trace".equals(field) ? "2000" : "200") + ")");
                return;
            }
        }
        //
        if(err.startsWith("[Microsoft][ODBC SQL Server Driver][DBNETLIB]ConnectionWrite")
           || err.startsWith("[Microsoft][SQLServer 2000 Driver for JDBC]Connection reset by peer: socket write error"))
            _con.close(); //ODBC和2000 不自动关闭
        System.out.println("ERR:" + err + "\tState:" + ex.getSQLState() + "\tCode:" + ex.getErrorCode() + "\tClosed:" + _con.isClosed());
        if(_con.isClosed())
        {
            try
            {
                Thread.sleep(1000L);
            } catch(Exception exx)
            {
                exx.printStackTrace();
            }
            ConnectionPool c = ConnectionPool.getInstance();
            c._nCheckOut--;
            _con = c.getConnection(_nNo);
            _stmt = _con.createStatement();
        } else
        {
            throw ex;
        }
    }

    public byte getByte(int columnIndex) throws SQLException
    {
        return _rs.getByte(columnIndex);
    }

    public int getInt(int i) throws SQLException
    {
        return _rs.getInt(i);
    }

    // System.out.println(rsmd.getColumnName(i) + ":" + type + ":" + rsmd.getColumnTypeName(i));
    // oracle 1:CHAR,12:VARCHAR2,2:NUMBER,91:DATE,-1:LONG,-3:RAW,2005:CLOB,2:NUMBER
    // mssql -6:tinyint,12:nvarchar,-1:ntext,-5:bigint,93:datetime,3:decimal,6:float,-4:image,4:int,3:money,2:numeric,7:real,-3:varbinary,
    public String get(int j,ArrayList al_name,ArrayList al_value) throws SQLException
    {
        ResultSetMetaData md = _rs.getMetaData();
        String name = md.getColumnName(j);
        int type = md.getColumnType(j);
        if(type == 4 || type == -6 || type == -7 || type == 2)
            return String.valueOf(getInt(j));
        if(type == 3 || type == 6 || type == 7)
            return String.valueOf(getFloat(j));
        if(type == 91 || type == 93)
            return DbAdapter.cite(getDate(j));
        if(type == -1 || type == 2005)
        {
            String tmp = getText(j);
            if(tmp == null)
                tmp = " ";
            else if(tmp.length() > 2000)
            {
                al_name.add(name);
                al_value.add(tmp);
                tmp = " ";
            }
            return DbAdapter.cite(tmp);
        }
        return DbAdapter.cite(getString(j));
    }

    public long getLong(int i) throws SQLException
    {
        return _rs.getLong(i);
    }

    public String getString(int i) throws SQLException
    {
        return _rs.getString(i);
//        if (s == null || s.equals("null"))
//        {
//            return "";
//        } else
//        {
//            return s;
//        }
    }

    public Date getDate(int i) throws SQLException
    {
        Timestamp ts = _rs.getTimestamp(i);
        if(ts == null)
        {
            return null;
        }
        return new Date(ts.getTime()); // (Date)
        // _rs.getObject(i);
    }

    public Object getObject(int columnIndex) throws SQLException
    {
        return _rs.getObject(columnIndex);
    }

    public int getInt(String s) throws SQLException
    {
        int j = 0;
        executeQuery(s);
        if(_rs.next())
        {
            j = _rs.getInt(1);
        }
        return j;
    }

    public float getFloat(int columnIndex) throws SQLException
    {
        return _rs.getFloat(columnIndex);
    }

    public String getString(String s) throws SQLException
    {
        executeQuery(s);
        if(_rs.next())
        {
            String s1 = _rs.getString(1);
            if(s1 != null)
            {
                String s2 = s1.trim();
                return s2;
            }
        }
        return "";
    }

    public Date getDate(String s) throws SQLException
    {
        executeQuery(s);
        if(_rs.next())
        {
            return getDate(1);
        }
        return null;
    }

    public static String cite(byte abyte0[])
    {
        if(abyte0 == null)
        {
            return "null";
        }
        StringBuffer sb = new StringBuffer("0x");
        for(int i = 0;i < abyte0.length;i++)
        {
            sb.append(BYTEMAP[0xff & abyte0[i]]);
        }
        return sb.toString();
    }

    public static String cite(Date date,boolean bool)
    {
        if(date == null)
            return "null";
        String str = "'" + new SimpleDateFormat(bool ? "yyyy-MM-dd" : "yyyy-MM-dd HH:mm:ss").format(date) + "'";
        if(ConnectionPool._nType == 2)
            str = "TO_DATE(" + str + ",'" + (bool ? "YYYY-MM-DD" : "YYYY-MM-DD HH24:MI:SS") + "')";
        return str;
    }

    public static String cite(Date date)
    {
        return cite(date,false);
    }

    public static String cite(boolean bool)
    {
        return bool ? "1" : "0";
    }

    public static String cite(String s)
    {
        if(s == null)
        {
            return "null";
        }
        s = s.replaceAll("'","''");
        switch(ConnectionPool._nType)
        {
        case 0:
            s = "'" + s.replaceAll("\\\\","\\\\\\\\") + "'";
            break;
        case 3:
        case 1:
            s = "N'" + s.replace((char) 160,' ') + "'";
            break;
        case 2:
            s = "'" + s + "'";
            break;
        }
        return s;
    }

    private static String replace(String s,char ac[],String as[])
    {
        StringBuffer stringbuffer = new StringBuffer();
        for(int i = 0;i < s.length();i++)
        {
            char c = s.charAt(i);
            boolean flag = false;
            int j = 0;
            do
            {
                if(j >= ac.length)
                {
                    break;
                }
                if(c == ac[j])
                {
                    stringbuffer.append(as[j]);
                    flag = true;
                    break;
                }
                j++;
            } while(true);
            if(!flag)
            {
                stringbuffer.append(c);
            }
        }
        return stringbuffer.toString();
    }

    public void rollback() throws SQLException
    {
        try
        {
            _con.rollback();
        } catch(Exception ex)
        {
            throw new SQLException(ex.toString());
        }
    }

    public void setQueryTimeout(int i) throws SQLException
    {
        try
        {
            _stmt.setQueryTimeout(i);
        } catch(Exception ex)
        {
            throw new SQLException(ex.toString());
        }
    }

    public void setAutoCommit(boolean flag) throws SQLException
    {
        if(flag) //ORACLE不自动提交
            _con.commit();
        _con.setAutoCommit(flag);
    }

    public boolean next() throws SQLException
    {
        return _rs.next();
    }

    public static void runFile(String s)
    {
        BufferedReader bufferedreader = null;
        StringBuffer stringbuffer = new StringBuffer();
        DbAdapter db = new DbAdapter();
        try
        {
            bufferedreader = new BufferedReader(new FileReader(s));
            String s1;
            while((s1 = bufferedreader.readLine()) != null)
            {
                if(s1.startsWith("GO"))
                {
                    db.executeUpdate(stringbuffer.toString());
                    stringbuffer.setLength(0);
                } else
                {
                    stringbuffer.append(" ").append(s1);
                }
            }
        } catch(Exception ex)
        {
            ex.printStackTrace();
        } finally
        {
            db.close();
            if(bufferedreader != null)
            {
                try
                {
                    bufferedreader.close();
                } catch(Exception ex2)
                {
                }
            }
        }
    }

    public String citeCurTime()
    {
        return cite(new Date(System.currentTimeMillis()));
    }

    public static String citeTab(String tablename)
    {
        if(ConnectionPool._strUrl[0].equals(ConnectionPool._strUrl[1]))
        {
            return tablename;
        }
        return "center.center.dbo." + tablename;
    }

    public byte[] getBytes(int index) throws SQLException
    {
        return _rs.getBytes(index);
    }

    public byte[] getImage(int index) throws SQLException
    {
        byte abyte0[] = null;

        int j = _rs.getInt(index);
        if(j != 0)
        {
            abyte0 = new byte[j];
            try
            {
                InputStream inputstream = _rs.getBinaryStream(index + 1);
                inputstream.read(abyte0);
                inputstream.close();
            } catch(IOException ex)
            {
                ex.printStackTrace();
            }
        }
        return abyte0;
    }

    public String getVarchar(int inLanguage,int outLanguage,int columnIndex) throws SQLException
    {
        String s = _rs.getString(columnIndex);
        if(s != null)
        {
            return Translator.getInstance().translate(s,inLanguage,outLanguage);
        }
        return "";
    }

    public String getVarchar(int i,String sql) throws SQLException
    {
        try
        {
            executeQuery(sql);
            if(_rs.next())
            {
                int j = _rs.getInt(1);
                byte abyte0[] = _rs.getBytes(2);
                if(abyte0 != null)
                {
                    String s1 = Translator.getInstance().translate(abyte0,j,i);
                    return s1;
                }
            }
        } catch(Exception ex)
        {
            throw new SQLException(String.valueOf(String.valueOf((new StringBuffer(String.valueOf(String.valueOf(ex.toString())))).append(": getVarchar: ").append(sql))));
        }
        return "";
    }

    public byte[] getImage(String s) throws SQLException
    {
        byte abyte0[] = null;
        try
        {
            executeQuery(s);
            if(_rs.next())
            {
                int i = _rs.getInt(1);
                abyte0 = new byte[i];
                if(i > 0)
                {
                    InputStream inputstream = _rs.getBinaryStream(2);
                    inputstream.read(abyte0);
                    inputstream.close();
                }
            }
        } catch(Exception ex)
        {
            throw new SQLException(String.valueOf(String.valueOf((new StringBuffer(String.valueOf(String.valueOf(ex.toString())))).append(": getImage: ").append(s))));
        }
        return abyte0;
    }

    public void commit() throws SQLException
    {
        try
        {
            _con.commit();
        } catch(Exception ex)
        {
            throw new SQLException(ex.toString());
        }
    }

    public BigDecimal getBigDecimal(int i,int j) throws SQLException
    {
        BigDecimal bd = _rs.getBigDecimal(i);
        if(bd == null)
        {
            bd = BigDecimal.ZERO;
        }
        return bd.setScale(j,4);
    }

    public BigDecimal getBigDecimal(String s,int j) throws SQLException
    {
        try
        {
            executeQuery(s);
            if(_rs.next())
            {
                BigDecimal bigdecimal = _rs.getBigDecimal(1);
                if(bigdecimal != null)
                {
                    bigdecimal = bigdecimal.setScale(j,4);
                }
                return bigdecimal;
            }
        } catch(Exception ex)
        {
            throw new SQLException(String.valueOf(String.valueOf((new StringBuffer(String.valueOf(String.valueOf(ex.toString())))).append(": getBigDecimal: ").append(s))));
        }
        return null;
    }

    public String getText(int column) throws SQLException
    {
        String str = null;
        switch(ConnectionPool._nType)
        {
        case 0:
        case 1:
            str = _rs.getString(column);
            break;
        case 2:
            CLOB c = (CLOB) _rs.getClob(column);
            if(c != null)
            {
                str = c.getSubString(1L,(int) c.length());
            }
            break;
        case 3:
            StringBuffer s = new StringBuffer();
            try
            {
                int x = 0;
                InputStreamReader isr = new InputStreamReader(_rs.getBinaryStream(column),"UnicodeLittle");
                while((x = isr.read()) != -1)
                {
                    s.append((char) x);
                }
                isr.close();
            } catch(IOException ex)
            {}
            str = s.toString();
        }

//                InputStream inputstream = _rs.getAsciiStream(column);
//                byte by[] = new byte[inputstream.available()];
//                inputstream.read(by);
//                inputstream.close();
//                str = new String(by, "UnicodeLittle");
        return str;
    }

    public String getText(int column,int _type) throws SQLException
    {
        String str = null;
        switch(_type)
        {
        case 0:
        case 1:
            str = _rs.getString(column);
            break;
        case 2:
            CLOB c = (CLOB) _rs.getClob(column);
            if(c != null)
            {
                str = c.getSubString(1L,(int) c.length());
            }
            break;
        case 3:
            StringBuffer s = new StringBuffer();
            try
            {
                int x = 0;
                InputStreamReader isr = new InputStreamReader(_rs.getBinaryStream(column),"UnicodeLittle");
                while((x = isr.read()) != -1)
                {
                    s.append((char) x);
                }
                isr.close();
            } catch(IOException ex)
            {}
            str = s.toString();
        }

//                InputStream inputstream = _rs.getAsciiStream(column);
//                byte by[] = new byte[inputstream.available()];
//                inputstream.read(by);
//                inputstream.close();
//                str = new String(by, "UnicodeLittle");
        return str;
    }


    public String getText(int i,int j,int column) throws SQLException
    {
        return Translator.getInstance().translate(getText(column),i,j);
    }

    public ResultSetMetaData getMetaData() throws SQLException
    {
        return _rs.getMetaData();
    }

    public int setText(String table,String column,String text,String where) throws SQLException
    {
        return setText(table,new String[]
                       {column},new String[]
                       {text},where);
    }

    public int setText2(String table,String column,String text,String where) throws SQLException
    {
        return setText2(table,new String[]
                        {column},new String[]
                        {text},where);
    }

    public int setText2(String table,String column[],String text[],String where) throws SQLException
    {
        StringBuffer sql = new StringBuffer();

        sql.append("UPDATE ").append(table).append(" SET ");
        for(int i = 0;i < column.length;i++)
        {
            if(i > 0)
            {
                sql.append(",");
            }
            sql.append(column[i]).append("=").append(cite(text[i]));
        }
        sql.append(" WHERE ").append(where);
        try
        {
            FileWriter fw = new FileWriter("copy.sql",true);
            fw.write(sql.toString());
            fw.write(";\r\n\r\n\r\n");
            fw.close();
        } catch(Exception ex)
        {
            ex.printStackTrace();
        }
        return 0;
    }

    public int setText(String table,String column[],String text[],String where) throws SQLException
    {
        int j = 0;
        StringBuffer sql = new StringBuffer();
        try
        {
            switch(ConnectionPool._nType)
            {
            case 0:
            case 1:
            case 3:
                sql.append("UPDATE ").append(table).append(" SET ");
                for(int i = 0;i < column.length;i++)
                {
                    if(i > 0)
                    {
                        sql.append(",");
                    }
                    sql.append(column[i]).append("=").append(cite(text[i]));
                }
                sql.append(" WHERE ").append(where);
                j = executeUpdate(sql.toString());
                break;
            case 2:
                sql.append("SELECT ");
                for(int i = 0;i < column.length;i++)
                {
                    if(i > 0)
                    {
                        sql.append(",");
                    }
                    sql.append(column[i]);
                }
                sql.append(" FROM ").append(table);
                sql.append(" WHERE ").append(where).append(" FOR UPDATE");
                this.setAutoCommit(false);
                this.executeQuery(sql.toString());
                if(this.next())
                {
                    for(int i = 0;i < text.length;i++)
                    {
                        if(text[i] == null || text[i].length() == 0)
                        {
                            text[i] = " ";
                        }
                        CLOB c = (CLOB) _rs.getClob(i + 1);
                        BufferedWriter out = new BufferedWriter(c.getCharacterOutputStream());
                        out.write(text[i]);
                        out.close();
                    }
                    j = 1;
                }
                this.commit();
                this.setAutoCommit(true);
            }
        } catch(Exception ex)
        {
            this.rollback();
            this.setAutoCommit(true);
            System.out.println("SQL:" + sql.toString());
            ex.printStackTrace();
            throw new SQLException(ex.toString());
        }
        return j;
    }

    // ///////////////符号/////////////////////////////http://www.phpv.net/article.php/1443
    public static String concat(String v1,String v2)
    {
        switch(ConnectionPool._nType)
        {
        case 0:
        case 2:
            v1 = "CONCAT(" + v1 + "," + v2 + ")";
            break;
        case 1:
        case 3:
            v1 = v1 + "+" + v2;
            break;
        }
        return v1;
    }


    public static String concat(String v1,String v2,String v3)
    {
        switch(ConnectionPool._nType)
        {
        case 0:
            v1 = "CONCAT(" + v1 + "," + v2 + "," + v3 + ")";
            break;
        case 1:
        case 3:
            v1 = v1 + "+" + v2 + "+" + v3;
            break;
        case 2:
            v1 = v1 + "||" + v2 + "||" + v3;
            break;
        }
        return v1;
    }

    //取模
    public static String mod(String v1,String v2)
    {
        switch(ConnectionPool._nType)
        {
        case 2:
            v1 = "MOD(" + v1 + "," + v2 + ")";
            break;
        default:
            v1 = v1 + "%" + v2;
        }
        return v1;
    }

    public static String format(String date,int len)
    {
        String str = null;
        switch(ConnectionPool._nType)
        {
        case 0:
            str = "DATE_FORMAT(" + date + ",'" + "%Y-%m-%d %H:%i:%s".substring(0,len - 2) + "')";
            break;
        case 1:
        case 3:
            str = "CONVERT(VARCHAR(" + len + ")," + date + ",120)";
            break;
        case 2:
            if(len > 10)
                len -= 2;
            str = "TO_CHAR(" + date + ",'" + "YYYY-MM-DD HH24".substring(0,len) + "')";
            break;
        }
        return str;
    }


    public static String cast(String field,String type)
    {
        switch(ConnectionPool._nType)
        {
        case 0:
            break;
        case 1:
        case 3:
            field = "CAST(" + field + " AS " + type + ")";
            break;
        }
        return field;
    }

    public static String length(String field)
    {
        switch(ConnectionPool._nType)
        {
        case 2:
        case 0:
            field = "LENGTH(" + field + ")";
            break;
        case 1:
        case 3:
            field = "DATALENGTH(" + field + ")";
            break;
        }
        return field;
    }

    public static String bitand(String v1,int v2)
    {
        switch(ConnectionPool._nType)
        {
        case 0:
        case 1:
        case 3:
            v1 = v1 + "&" + v2;
            break;
        case 2:
            v1 = "BITAND(" + v1 + "," + v2 + ")";
            break;
        }
        return v1;
    }

    public static void conf(String type,String database) throws Exception
    {
        Properties p = new Properties();
        p.setProperty("MaxConnections","100");
        HashMap hm = new HashMap();
        hm.put("oracle_driver","oracle.jdbc.driver.OracleDriver");
        hm.put("oracle_url","jdbc:oracle:thin:@192.168.0.203:1521:" + database);
        hm.put("mysql_driver","com.mysql.jdbc.Driver");
        hm.put("mysql_url","jdbc:mysql://127.0.0.1:3306/" + database + "?useUnicode=true&characterEncoding=utf8");
        hm.put("mssql_driver","com.microsoft.jdbc.sqlserver.SQLServerDriver");
        hm.put("mssql_url","jdbc:microsoft:sqlserver://127.0.0.1:1433;DatabaseName=" + database);
        for(int i = 0;i < 2;i++)
        {
            p.setProperty(i + "JdbcDriver",(String) hm.get(type + "_driver"));
            p.setProperty(i + "Url",(String) hm.get(type + "_url"));
            p.setProperty(i + "UserId","root");
            p.setProperty(i + "Password","123");
        }
        p.setProperty("0driver",(String) hm.get(type + "_driver"));
        p.setProperty("0url",(String) hm.get(type + "_url"));
        p.setProperty("0user","root");
        p.setProperty("0password","123");
        File f = new File(Class.forName("tea.db.DbAdapter").getResource("/").toURI());
        f = new File(f,InetAddress.getLocalHost().getHostName() + ".properties");
        System.out.println("重写:" + f);
        p.store(new FileOutputStream(f),"MT");
    }

    public ResultSet executeQuerySql(String sql) throws SQLException
    {
        try
        {
            if(_rs != null)
            {
                _rs.close();
                _rs = null;
            }
            long cur = System.currentTimeMillis();
            _rs = _stmt.executeQuery(sql);
            logs(cur,sql);
        } catch(SQLException ex)
        {
            reset(ex,sql);
            executeQuery(sql);
        }

        return _rs;
    }


}
//mssql
//nvarchar:1个字符
// varchar:1个字节
/*
//mssql
 -5	bigint
 -2	binary
 -7	bit
 1	char
 12	nvarchar
 93	datetime
 12	nvarchar
 12	nvarchar
 3	decimal
 6	float
 -4	geography
 -4	geometry
 -3	hierarchyid
 -4	image
 4	int
 3	money
 1	nchar
 -1	ntext
 -1	ntext
 2	numeric
 12	nvarchar
 -1	ntext
 7	real
 93	smalldatetime
 5	smallint
 3	smallmoney
 12	sql_variant
 -1	text
 12	nvarchar
 -2	timestamp
 -6	tinyint
 1	uniqueidentifier
 -3	varbinary
 -4	varbinary(MAX)
 12	varchar
 -1	varchar(MAX)
 -1	xml

//oracle
 2	NUMBER
 2	NUMBER
 12	VARCHAR2
 12	VARCHAR2
 2005	CLOB
 12	VARCHAR2
 2	NUMBER
 12	VARCHAR2
 12	VARCHAR2
 12	VARCHAR2
 2	NUMBER
 12	VARCHAR2
 2005	CLOB
 12	VARCHAR2
 12	VARCHAR2
 12	VARCHAR2
 12	VARCHAR2
 2005	CLOB
 2004	BLOB
 91	DATE
 -1	LONG
 */
