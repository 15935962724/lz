package tea.entity.member;

import java.io.*;
import java.net.*;
import java.sql.*;
import java.util.*;

import tea.entity.site.*;
import tea.entity.*;

public class OpenID
{
    private static Cache _cache = new Cache(100);
    private static String host[] = new String[4];
    private static int port;
    private String member;
    private String proxy;
    private OpenID(String member)
    {
        this.member = member;
    }

    public static OpenID find(String member)
    {
        OpenID obj = (OpenID) _cache.get(member);
        if (obj == null)
        {
            obj = new OpenID(member);
            _cache.put(member, obj);
        }
        return obj;
    }

    private boolean conn(Hashtable ht)
    {
        boolean result = false;
        for (int i = 0; i < host.length; i++)
        {
            try
            {
                HttpURLConnection c = (HttpURLConnection)new URL("http://" + host[i] + "/servlet/OpenID").openConnection();
                Enumeration e = ht.keys();
                while (e.hasMoreElements())
                {
                    String name = (String) e.nextElement();
                    String value = (String) ht.get(name);
                    c.setRequestProperty(name, URLEncoder.encode(value, "UTF-8"));
                }
                String tmp = c.getHeaderField("result");
                System.out.println(host[i] + ":" + ht.get("member") + ":" + tmp);
                if (tmp != null)
                {
                    result = "true".equals(tmp);
                    proxy = c.getHeaderField("proxy");
                    break;
                }
            } catch (IOException ex)
            {
                ex.printStackTrace();
            }
        }
        return result;
//  Socket s=new Socket(host[i],80);
//  OutputStream os=s.getOutputStream();
//  String str=("GET /servlet/OpenID HTTP/1.1\r\n");
//  str=str+("act: create\r\n");
//  str=str+("\r\n");
//  os.write(str.getBytes());
//  os.flush();
//  InputStream is=s.getInputStream();
//  int v=0;
//  while((v=is.read())!=-1)
//  {
//    System.out.print((char)v);
//  }

    }

    public static boolean create(String member, String password, String email, String proxy)
    {
        Hashtable ht = new Hashtable();
        ht.put("act", "create");
        ht.put("member", member);
        ht.put("password", password);
        if (email != null)
        {
            ht.put("email", email);
        }
        ht.put("proxy", proxy);
        return find(member).conn(ht);
    }

    public boolean setPassword(String password)
    {
        Hashtable ht = new Hashtable();
        ht.put("act", "setpassword");
        ht.put("member", member);
        ht.put("password", password);
        return conn(ht);
    }

    public boolean setProxy(String proxy)
    {
        Hashtable ht = new Hashtable();
        ht.put("act", "setproxy");
        ht.put("member", member);
        ht.put("proxy", proxy);
        return conn(ht);
    }

    public boolean isExists()
    {
        Hashtable ht = new Hashtable();
        ht.put("act", "isexists");
        ht.put("member", member);
        return conn(ht);
    }

    public boolean isExists(String password)
    {
        Hashtable ht = new Hashtable();
        ht.put("act", "equals");
        ht.put("member", member);
        ht.put("password", password);
        return conn(ht);
    }

    public static boolean isOpen() throws SQLException
    {
        CommunityOption co = CommunityOption.find("[SYSTEM]");
        host[0] = co.get("openidhost0");
        host[1] = co.get("openidhost1");
        host[2] = co.get("openidhost2");
        host[3] = co.get("openidhost3");
        return host[0] != null;
    }

    public String getProxy() throws SQLException
    {
        if (proxy == null && isOpen())
        {
            Hashtable ht = new Hashtable();
            ht.put("act", "getproxy");
            ht.put("member", member);
            conn(ht);
        }
        return proxy;
    }
}
