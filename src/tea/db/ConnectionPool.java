package tea.db;

import java.io.*;
import java.sql.*;
import java.util.*;
import java.util.Date;
import java.net.*;

import tea.entity.*;
import tea.entity.cluster.*;

//0:本机 1:中心机 8:访问统计 9:MAS短信
public class ConnectionPool
{
    public static final ConnectionPool _instance = new ConnectionPool();
    protected int _nCheckOut;
    private Vector _hFree[];
    public static final String _strUrl[] = new String[10];
    protected static final String _strServer[] = new String[10];
    public static final String _strUserId[] = new String[10];
    public static final String _strPassword[] = new String[10];
    public static int _nType; // 0:mysql 1:mssql 2:oracle 3:odbc
    private static int _nMaxConnections;
    protected static boolean _bDebug;
    public static boolean isHtml5,isStatic;
    public static Hashtable info = new Hashtable();
    static
    {
        _instance._hFree = new Vector[10];
        try
        {
            String name = System.getenv("COMPUTERNAME");
            name = "/" + (name == null ? "db" : name.toLowerCase()) + ".properties";
            Class cl = Class.forName("tea.db.ConnectionPool");
            URL u = cl.getResource(name);
            if(u == null)
            {
                name = "/db.properties";
                u = cl.getResource(name);
            }
            Properties p = new Properties();
            if(u == null)
            {
                p.setProperty("MaxConnections","100");
                p.setProperty("0JdbcDriver","oracle.jdbc.driver.OracleDriver");
                p.setProperty("0Url","jdbc:oracle:thin:@192.168.0.203:1521:edn");
                p.setProperty("0UserId","edn");
                p.setProperty("0Password","v609");
                p.setProperty("1JdbcDriver","oracle.jdbc.driver.OracleDriver");
                p.setProperty("1Url","jdbc:oracle:thin:@192.168.0.203:1521:edn");
                p.setProperty("1UserId","edn");
                p.setProperty("1Password","v609");
            } else
            {
                System.err.println("---------" + name + "----------------------");
                System.err.println(new java.sql.Date(System.currentTimeMillis()));
                InputStream is = u.openStream();
                p.load(is);
                is.close();
            }
            for(int i = 0;i < 10;i++)
            {
                String jd = p.getProperty(i + "JdbcDriver");
                if(jd == null)
                    continue;
                try
                {
                    Class.forName(jd).newInstance();
                } catch(Exception ex)
                {
                    ex.printStackTrace();
                }
                _instance._hFree[i] = new Vector();
                _strUrl[i] = p.getProperty(i + "Url");
                _strUrl[i] = new String(_strUrl[i].getBytes("ISO-8859-1"),"UTF-8");
                int j = _strUrl[i].indexOf("//");
                if(j != -1 || (j = _strUrl[i].indexOf(":@")) != -1)
                {
                    _strServer[i] = _strUrl[i].substring(j + 2);
                }
                _strUserId[i] = p.getProperty(i + "UserId");
                _strPassword[i] = p.getProperty(i + "Password");
                if(i == 0)
                {
                    if(_strUrl[i].startsWith("jdbc:mysql:"))
                    {
                        _nType = 0;
                    } else if(_strUrl[i].startsWith("jdbc:microsoft:sqlserver:") || _strUrl[i].startsWith("jdbc:sqlserver:"))
                    {
                        _nType = 1;
                    } else if(_strUrl[i].startsWith("jdbc:oracle:"))
                    {
                        _nType = 2;
                    } else if(_strUrl[i].startsWith("jdbc:odbc:"))
                    {
                        _nType = 3;
                    }
                }
            }
            _nMaxConnections = Integer.parseInt(p.getProperty("MaxConnections")); //最大连接数
            _bDebug = "true".equals(p.getProperty("Debug")); //调试
            isHtml5 = "true".equals(p.getProperty("html5"));
            isStatic = "true".equals(p.getProperty("static"));

            //Cluster
            Cluster c = Cluster.getInstance();
            String tmp = p.getProperty("no");
            c.no = tmp == null ? 0 : Integer.parseInt(tmp);
            c.host = p.getProperty("host");
        } catch(Throwable ex)
        {
            ex.printStackTrace();
        }
    }

    public synchronized void freeConnection(Connection conn,int remote)
    {
        if(conn == null)
            return;
        _hFree[remote].addElement(conn);
        _nCheckOut--;
        if(info == null)
        {
            System.out.println("109: info 是 null ");
        } else
            info.remove(conn);
        notifyAll();
    }

    public synchronized void release()
    {
        for(int i = 0;i < _hFree.length;i++)
        {
            if(_hFree[i] == null)
                continue;
            for(int j = 0;j < _hFree[i].size();j++)
            {
                Connection conn = (Connection) _hFree[i].elementAt(j);
                try
                {
                    conn.close();
                } catch(SQLException ex)
                {
                }
            }
            _hFree[i].removeAllElements();
        }
        _nCheckOut = 0;
    }

    public synchronized Connection getConnection(int remote) throws SQLException
    {
        Connection c = null;
        if(_hFree[remote].size() > 0)
        {
            c = (Connection) _hFree[remote].remove(0);
        } else
        {
            while(_nCheckOut >= _nMaxConnections)
            {
                try
                {
                    wait();
                } catch(Exception ex)
                {
                }
            }
            long cur = System.currentTimeMillis();
            c = DriverManager.getConnection(_strUrl[remote],_strUserId[remote],_strPassword[remote]);
            //显示连接数
            System.out.println(MT.f(new Date(),1) + " : " + _nCheckOut + " //" + _strServer[remote] + "　" + (System.currentTimeMillis() - cur) + "ms");
            StackTraceElement ste[] = Thread.currentThread().getStackTrace();
            for(int i = 2;i < ste.length;i++)
            {
                String cn = ste[i].getClassName();
                if(cn.equals("javax.servlet.http.HttpServlet") || cn.startsWith("org.apache.catalina."))
                {
                    break;
                }
                System.out.println("  " + ste[i].toString());
            }
            info.put(c,ste);
        }
        _nCheckOut++;
        return c;
    }

    public static synchronized ConnectionPool getInstance()
    {
        return _instance;
    }
}
