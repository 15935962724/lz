package tea.entity.cluster;

import java.io.*;
import java.sql.*;
import java.net.*;
import java.util.*;
import tea.db.*;
import tea.entity.*;
import org.json.*;
import tea.entity.node.*;
import tea.entity.node.Page;
import tea.ui.TeaServlet;
import tea.entity.admin.*;
import tea.entity.member.*;
import tea.entity.util.*;

public class Cluster extends Thread
{
    public int no;
    public String host;
    static Cluster c = new Cluster();
    public static Cluster getInstance()
    {
        return c;
    }

    public void run()
    {
        if(host == null)
            return;
        int wait = 5;
        StringBuilder dmls = new StringBuilder(),atts = new StringBuilder(),errs = new StringBuilder();
        while(true)
        {
            try
            {
                Thread.sleep(wait * 1000);
                Filex.logs("Cluster.log","间隔：" + wait + "s　开始同步：");
                StringBuilder url = new StringBuilder("http://" + host + "/Clusters.do?act=sync&session=false&no=" + no);
                if(dmls.length() > 1)
                    url.append("&dmls=").append(dmls.substring(1));
                if(atts.length() > 1)
                    url.append("&attchs=").append(atts.substring(1));
                if(errs.length() > 1)
                    url.append("&errs=").append(errs.substring(1));
                String str = (String) Http.open(url.toString(),null);
                if(str == null || str.charAt(0) != '{')
                {
                    wait = 30;
                    continue;
                }
                Filex.logs("Cluster.log","长度：" + str.length() / 1024 + "k　" + str);
                boolean next = false;
                dmls.setLength(0);
                atts.setLength(0);
                errs.setLength(0);
                JSONObject o = new JSONObject(str);
                DbAdapter db = new DbAdapter();
                try
                {
                    JSONArray arr = o.getJSONArray("dml");
                    next = next || arr.length() == 20;
                    for(int i = 0;i < arr.length();i++)
                    {
                        JSONObject t = arr.getJSONObject(i);
                        int dml = t.getInt("dml");
                        int opid = t.getInt("opid");
                        Filex.logs("Cluster.log",dml + ":" + t.get("content"));
                        try
                        {
                            if(!t.isNull("content"))
                                db.executeUpdate(t.getString("content"));
                            dmls.append(",").append(dml);
                        } catch(SQLException ex)
                        {
                            //SQLState:02000　　java.sql.SQLException: ORA-01403: 未找到任何数据
                            if(ex.getErrorCode() == 1403)
                            {
                                dmls.append(",").append(dml);
                            }
                            //SQLState:21000　　java.sql.SQLException: ORA-01422: 实际返回的行数超出请求的行数
                            Filex.logs("Cluster.log",ex.getErrorCode() + ":" + ex.getSQLState() + " / 错误：" + ex.toString());
                            ex.printStackTrace();
                        }
                        if(opid < 1)
                            continue;
                        Cache[] c =
                                {Entity._cache,Category._cache,Page._cache,Report._cache,MessageBoard._cache,Album._cache,Link._cache,Media._cache,
                                Talkback._cache,TalkbackReply._cache,
                                Node._cache,AccessMember._cache,
                                Listing._cache,PickFrom._cache,PickNode._cache,PickManual._cache,PickNews._cache,
                                Section._cache,CssJs._cache,
                                Profile._cache,AdminRole._cache,AdminFunction._cache,AdminUnit._cache,
                                LuceneList._cache,Lucene._cache,Lucenechoice._cache
                        };
                        for(int j = 0;j < c.length;j++)
                        {
                            c[j].remove(opid);
                            c[j].remove(opid + ":1");
                        }
                        if(Node.isExisted(opid))
                        {
                            Entity._cache.remove(opid + ":1");
                            TeaServlet.delete(Node.find(opid));
                        } else
                        {
                            //Listing listing = Listing.find(opid);
                            //if(listing.getTime() != null)
                            {
                                ListingDetail._cache.remove(opid + ":-1:1");
                                for(int j = 0;j < Node.NODE_TYPE.length;j++)
                                {
                                    ListingDetail._cache.remove(opid + ":" + j + ":1");
                                }
                                //TeaServlet.delete(Node.find(listing.getNode()));
                            } //else
                            {
                                //Section section = Section.find(opid);
                                //if(section.getTime() != null)
                                {
                                    // TeaServlet.delete(Node.find(section.getNode()));
                                } //else
                                {
                                    AdminUsrRole._cache.clear();
                                }
                            }
                        }
                    }
                } finally
                {
                    db.close();
                }
                JSONArray arr = o.getJSONArray("attch");
                next = next || arr.length() == 20;
                for(int i = 0;i < arr.length();i++)
                {
                    JSONObject t = arr.getJSONObject(i);
                    int attch = t.getInt("attch");
                    JSONArray ja = t.getJSONArray("path");
                    for(int j = 0;j < ja.length();j++)
                    {
                        if(ja.isNull(j))
                            continue;
                        String path = ja.getString(j);
                        Filex.logs("Cluster.log",attch + "：" + path);
                        File f = new File(Http.REAL_PATH + path);
                        f.getParentFile().mkdirs();
                        try
                        {
                            HttpURLConnection conn = (HttpURLConnection)new URL("http://" + host + path).openConnection();
                            Filex.piped(conn.getInputStream(),new FileOutputStream(f));
                            atts.append(",").append(attch);
                        } catch(FileNotFoundException ex)
                        {
                            errs.append(",").append(attch);
                        } catch(Throwable ex)
                        {
                            Filex.logs("Cluster.log",ex);
                        }
                    }
                }
                if(next)
                    wait = 1;
                else if(str.length() > 25 && wait > 1)
                    wait--;
                else if(wait < 30)
                    wait++;
            } catch(Throwable ex)
            {
                Filex.logs("Cluster.log",ex);
            }
        }
    }

}
