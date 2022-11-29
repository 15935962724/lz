package tea.ui.util;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;
import javax.servlet.*;
import javax.servlet.http.*;
import tea.entity.util.*;
import tea.ui.TeaSession;
import tea.entity.site.*;
import tea.entity.node.*;
import tea.resource.*;

public class Lucenes extends HttpServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        response.setContentType("text/html; charset=UTF-8");
        response.setHeader("Content-Encoding","nogzip");
        Http h = new Http(request,response);
        String act = h.get("act"),nexturl = h.get("nexturl","");
        ServletContext application = this.getServletContext();
        PrintWriter out = response.getWriter();
        try
        {
            out.println("<script>var mt=parent.mt;</script>");
            if(h.member < 1)
            {
                out.print("<script>top.location.replace('/servlet/StartLogin?node=" + h.node + "');</script>");
                return;
            }
            if("ntype".equals(act))
            {
                int ntype = h.getInt("ntype");
                if(ntype != 255)
                {
                    String sql = null;
                    if(ntype > 65535)
                    {
                        ntype = TypeAlias.find(ntype).getType();
                    }
                    if(ntype < 1024)
                    {
                        String column = "information_schema.COLUMNS",tab = DbAdapter.cite(Node.NODE_TYPE[ntype]) + "," + DbAdapter.cite(Node.NODE_TYPE[ntype] + "Layer");
                        if(ConnectionPool._nType == 2) //oracle
                        {
                            column = "user_tab_columns";
                            tab = tab.toUpperCase();
                        }
                        sql = "SELECT COLUMN_NAME FROM " + column + " WHERE TABLE_NAME IN(" + tab + ") AND COLUMN_NAME NOT IN('language','picture') GROUP BY COLUMN_NAME";
                    } else
                    {
                        sql = "SELECT dynamictype FROM DynamicType WHERE dynamic=" + ntype;
                    }
                    Resource r = new Resource("/tea/resource/Lucene");
                    DbAdapter db = new DbAdapter();
                    try
                    {
                        db.executeQuery(sql);
                        while(db.next())
                        {
                            String label = db.getString(1);
                            String name;
                            if(ntype < 1024)
                            {
                                name = r.getString(h.language,Node.NODE_TYPE[ntype] + "." + label.toLowerCase());
                            } else
                            {
                                DynamicType dt = DynamicType.find(Integer.parseInt(label));
                                name = dt.getName(h.language);
                            }
                            out.print("op[op.length]=new Option('" + name + "','" + label + "');");
                        }
                    } finally
                    {
                        db.close();
                    }
                }
                return;
            }
            if("sequence".equals(act))
            {
                int sequence = h.getInt("sequence");
                if(sequence > 0)
                {
                    Lucene t = Lucene.find(h.getInt("lucene"));
                    t.set("sequence",String.valueOf(t.sequence = sequence));
                } else
                {
                    int pos = h.getInt("pos");
                    String[] arr = h.get("lucenes").split("[|]");
                    for(int i = 1;i < arr.length;i++)
                    {
                        Lucene t = Lucene.find(Integer.parseInt(arr[i]));
                        t.set("sequence",String.valueOf(t.sequence = i + pos));
                    }
                    return;
                }
            }
            String info = null;
            LuceneList ll = LuceneList.find(h.getInt("lucenelist"));
            if("ldel".equals(act)) //删除
            {
                ll.delete();
            } else if("ledit".equals(act)) //编辑
            {
                ll.community = h.community;
                ll.name = h.get("name");
                ll.type = h.getInt("type");
                ll.sorttype = h.getInt("sorttype");
                ll.node_not = h.get("node_not");
                if(ll.lucenelist < 1)
                    ll.time = new Date();
                ll.set();
            } else if("edit".equals(act))
            {
                int lucene = h.getInt("lucene");
                Lucene t = Lucene.find(lucene);
                t.lucenelist = ll.lucenelist;
                t.qtype = h.getInt("qtype");
                t.itype = h.getInt("itype");
                t.ntype = h.getInt("type");
                t.field = h.get("field");
                t.set();
                //
                String subject = h.get("subject");
                String before = h.get("before");
                String after = h.get("after");
                t.setLayer(h.language,subject,before,after);
            } else if("del".equals(act))
            {
                int lucene = h.getInt("lucene");
                Lucene obj = Lucene.find(lucene);
                obj.delete(h.language);
            } else if("index".equals(act))
            {
                for(int j = 0;j < 20;j++)
                    out.write("// 显示进度条  \n");
                info = ll.index(h.language,h.getBool("create"),out);
            } else if("cedit".equals(act))
            {
                int lucene = h.getInt("lucene");
                if(h.getBool("media"))
                {
                    ArrayList e = Media.find(" AND m.community=" + DbAdapter.cite(h.community) + " AND m.type=39",0,Integer.MAX_VALUE);
                    for(int i = 0;i < e.size();i++)
                    {
                        Media obj = (Media) e.get(i);
                        Lucenechoice lc = new Lucenechoice(0);
                        lc.lucene = lucene;
                        lc.sequence = i * 10;
                        lc.set();
                        lc.setLayer(h.language,String.valueOf(obj.media),obj.getName(h.language));
                    }
                } else if(h.getBool("class"))
                {
                    Enumeration e = Classes.findByCommunity(h.community,h.language);
                    for(int i = 0;e.hasMoreElements();i = i + 10)
                    {
                        int class_id = ((Integer) e.nextElement()).intValue();
                        Classes obj = Classes.find(class_id);
                        Lucenechoice lc = new Lucenechoice(0);
                        lc.lucene = lucene;
                        lc.sequence = i;
                        lc.set();
                        lc.setLayer(h.language,String.valueOf(class_id),obj.getName());
                    }
                } else
                {
                    Lucenechoice lc = Lucenechoice.find(h.getInt("lucenechoice"));
                    lc.lucene = lucene;
                    lc.sequence = h.getInt("sequence");
                    lc.set();
                    lc.setLayer(h.language,h.get("value"),h.get("label"));
                }
            } else if("cdel".equals(act))
            {
                Lucenechoice lc = Lucenechoice.find(h.getInt("lucenechoice"));
                lc.delete(h.language);
            }
            out.print("<script>mt.show('" + (info == null ? "操作执行成功！" : info) + "',1,'" + nexturl + "');</script>");
        } catch(Throwable ex)
        {
            out.print("<textarea id='ta'>" + ex.toString() + "</textarea><script>mt.show(document.getElementById('ta').value,1,'出现未知错误！');</script>");
            ex.printStackTrace();
        } finally
        {
            out.close();
        }
    }
}
