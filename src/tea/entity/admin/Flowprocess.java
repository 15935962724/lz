package tea.entity.admin;

import java.sql.*;
import java.util.*;

import tea.db.*;
import tea.entity.*;
import tea.entity.site.*;
import java.io.*;

//事务的执行步骤
public class Flowprocess extends Entity
{
    private static Cache _cache = new Cache(100);
    private int flowprocess;
    private int flow;
    private int step; //序号
    private String member; //经办人,用/分隔
    private String dtwrite; //可写
    private String dtread; //只读
    private boolean checkbox; //是否多选
    private int extend; //同那步经办人
    private boolean serial; //true:在可控步骤中,不回主控步骤.
    private boolean csign; //true:设置会签候选人员
    private String maindtwrite; //回主控步骤是可写
    private String maindtread; //回主控步骤是只读
    private boolean exists;
    private Hashtable _htLayer;
    class Layer
    {
        String name;
    }


    public Flowprocess(int flowprocess) throws SQLException
    {
        this.flowprocess = flowprocess;
        _htLayer = new Hashtable();
        load();
    }

    public static Flowprocess find(int flowprocess) throws SQLException
    {
        Flowprocess obj = (Flowprocess) _cache.get(new Integer(flowprocess));
        if(obj == null)
        {
            obj = new Flowprocess(flowprocess);
            _cache.put(new Integer(flowprocess),obj);
        }
        return obj;
    }

    //step： 负数就是倒数
    public static Flowprocess find(int flow,int step) throws SQLException
    {
        int flowprocess = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            if(step < 0)
                db.executeQuery("SELECT flowprocess FROM Flowprocess WHERE flow=" + flow + " ORDER BY step DESC",0, -step);
            else
                db.executeQuery("SELECT flowprocess FROM Flowprocess WHERE flow=" + flow + " AND step=" + step);
            while(db.next())
            {
                flowprocess = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return find(flowprocess);
    }

    public static Enumeration find(int flow,String sql) throws SQLException
    {
        Vector v = new Vector();
        StringBuffer sb = new StringBuffer("SELECT flowprocess FROM Flowprocess WHERE 1=1");
        if(flow > 0)
        {
            sb.append(" AND flow=").append(flow);
        }
        sb.append(sql);
        sb.append(" ORDER BY step");
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery(sb.toString());
            while(db.next())
            {
                v.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    //调整序号//
    private static void seq(int flow,int step,int flowprocess) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT flowprocess,step FROM Flowprocess WHERE flow=" + flow + " AND step>=" + step + " AND flowprocess!=" + flowprocess + " ORDER BY step");
            for(int i = 1;db.next();i++)
            {
                int fp = db.getInt(1);
                int s = db.getInt(2);
                if(i == 1 && s != step) //如果第一次，没有出现重复的步骤，则跳出
                {
                    break;
                }
                find(fp).setStep(step + i);
            }
        } finally
        {
            db.close();
        }
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM Flowprocess WHERE flowprocess=" + flowprocess);
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(flow));
    }

    public void set(int step,boolean checkbox,boolean serial,boolean csign,int language,String name) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Flowprocess SET step=" + step + ",checkbox=" + DbAdapter.cite(checkbox) + ",serial=" + DbAdapter.cite(serial) + ",csign=" + DbAdapter.cite(csign) + " WHERE flowprocess=" + flowprocess);
            int j = db.executeUpdate("UPDATE FlowprocessLayer SET name=" + DbAdapter.cite(name) + " WHERE flowprocess=" + flowprocess + " AND language=" + language);
            if(j < 1)
            {
                db.executeUpdate("INSERT INTO FlowprocessLayer(flowprocess,language,name)VALUES(" + flowprocess + "," + language + "," + DbAdapter.cite(name) + ")");
            }
        } finally
        {
            db.close();
        }
        this.step = step;
        this.checkbox = checkbox;
        this.serial = serial;
        this.csign = csign;
        _htLayer.clear();
        seq(flow,step,flowprocess);
    }

    public void setStep(int step) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Flowprocess SET step=" + step + " WHERE flowprocess=" + flowprocess);
        } finally
        {
            db.close();
        }
        this.step = step;
    }

    public static int create(int flow,int step,String member,String dtwrite,String dtread,boolean checkbox,boolean serial,boolean csign,int language,String name) throws SQLException
    {
        int flowprocess;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO Flowprocess(flow,step,member,dtwrite,dtread,checkbox,serial,csign,maindtwrite,maindtread) VALUES (" + flow + "," + step + "," + DbAdapter.cite(member) + "," + DbAdapter.cite(dtwrite) + "," + DbAdapter.cite(dtread) + "," + DbAdapter.cite(checkbox) + "," + DbAdapter.cite(serial) + "," + DbAdapter.cite(csign) + ",'/','/'" + ")");
            flowprocess = db.getInt("SELECT MAX(flowprocess) FROM Flowprocess");
            db.executeUpdate("INSERT INTO FlowprocessLayer(flowprocess,language,name)VALUES(" + flowprocess + "," + language + "," + DbAdapter.cite(name) + ")");
        } finally
        {
            db.close();
        }
        seq(flow,step,flowprocess);
        return flowprocess;
    }

    public static int getMaxSequenceByFlow(int flow) throws SQLException
    {
        int step = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT MAX(step) FROM Flowprocess WHERE flow=" + flow);
            if(db.next())
            {
                step = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return step;
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT flow,step,member,dtwrite,dtread,checkbox,extend,serial,csign,maindtwrite,maindtread FROM Flowprocess WHERE flowprocess=" + flowprocess);
            if(db.next())
            {
                int j = 1;
                flow = db.getInt(j++);
                step = db.getInt(j++);
                member = db.getString(j++);
                dtwrite = db.getString(j++);
                dtread = db.getString(j++);
                checkbox = db.getInt(j++) != 0;
                extend = db.getInt(j++);
                serial = db.getInt(j++) != 0;
                csign = db.getInt(j++) != 0;
                maindtwrite = db.getString(j++);
                maindtread = db.getString(j++);
                exists = true;
            } else
            {
                step = 1; // 当前步骤,默认为:第1步
                exists = false;
            }
        } finally
        {
            db.close();
        }
        if((maindtread == null || maindtread.length() == 0) && flow > 0) //默认值,所有项可看//
        {
            StringBuffer sb = new StringBuffer();
            sb.append("/");
            Enumeration e = DynamicType.findByDynamic(Flow.find(flow).getDynamic()," AND type IN('office','csign')",0,Integer.MAX_VALUE);
            while(e.hasMoreElements())
            {
                int dt = ((Integer) e.nextElement()).intValue();
                sb.append(dt).append("/");
            }
            maindtread = sb.toString();
        }
    }

    public int getFlowprocess()
    {
        return flowprocess;
    }

    public boolean isExists()
    {
        return exists;
    }

    public int getStep()
    {
        return step;
    }

    public String getMember()
    {
        return member;
    }

    public String getMemberToHtml(int flowbusiness) throws SQLException
    {
        StringBuffer sb = new StringBuffer();
        if(extend > 0) //同上一步
        {
            Enumeration e = Flowview.find(flowbusiness,extend);
            if(e.hasMoreElements())
            {
                while(e.hasMoreElements())
                {
                    int flowview = ((Integer) e.nextElement()).intValue();
                    Flowview fv = Flowview.find(flowview);
                    sb.append("<input name=members type=checkbox style=display:none checked value=").append(fv.getTransactor()).append(">").append(fv.getTransactor()).append("<br>");
                }
                return sb.toString();
            } else //没有走过....
            {
                member = Flowprocess.find(extend).getMember();
            }
        }
        //member = "/webmaster/";
        String ms[] = member.split("/");
        if(ms.length == 2) //如果只有一个备选
        {
            sb.append("<input name='members' type='").append((checkbox ? "checkbox" : "radio")).append("' onclick=checked=true; value='").append(ms[1]).append("' checked").append(">").append(ms[1]);
        } else
        {
            sb.append("<input type='hidden' name='enabled' value='" + member + "'><input type='hidden' name='to' value='/'><input type='hidden' name='tunit' value='/'><textarea name='name' readonly cols='50' rows='2'></textarea> "); //readonly
            sb.append("<input type='button' value='添加' onClick=f_add('" + (checkbox ? Integer.MAX_VALUE : 1) + "','" + member + "'); /> <input type='button' value='清空' onClick=form1.to.value='/';form1.tunit.value='/';form1.name.value=''; />");
//      StringBuffer js = new StringBuffer();
//      js.append(" case 0:");
//      for (int i = 1; i < ms.length; i++)
//      {
//        js.append("op[op.length]=new Option('" + ms[i] + "','" + ms[i] + "');");
//      }
//      js.append("break;");
//      sb.append("<table><tr><td colspan='3'><select name='member0'><option value='0'>-----------------------------------------");
//      String community = Flow.find(flow).getCommunity();
//      Enumeration e = AdminUnit.findByCommunity(community, "");
//      while (e.hasMoreElements())
//      {
//        int id = ( (Integer) e.nextElement()).intValue();
//        AdminUnit au = AdminUnit.find(id);
//        int j = 0;
//        Enumeration eaur = AdminUsrRole.find(community, " AND member IN('" + member.substring(1, member.length() - 1).replaceAll("/", "','") + "') AND (unit=" + id + " OR classes LIKE '%/" + id + "/%')", 0, Integer.MAX_VALUE);
//        if (eaur.hasMoreElements())
//        {
//          js.append("case ").append(id).append(":");
//          while (eaur.hasMoreElements())
//          {
//            String m = (String) eaur.nextElement();
//            js.append("op[op.length]=new Option('" + m + "','" + m + "');");
//            j++;
//          }
//          js.append("break;");
//        }
//        String str = au.getPrefix() + au.getName();
//        if (j > 0)
//        {
//          for (int x = str.length(); x < 13; x++)
//          {
//            str = str + "　";
//          }
//          if (j < 10)
//          {
//            str = str + "&nbsp; ";
//          }
//          str = str + j;
//        }
//        sb.append("<option value=" + id + ">").append(str);
//      }
//      sb.append("</select></td></tr><tr><td><select name='member1' size='10' style='width:150px' ondblclick=");
//      if (!checkbox) //如果是单选,把上一个移回
//      {
//        sb.append("document.all('member2').selectedIndex=0;document.all('member2').ondblclick();");
//      }
//      sb.append("move(this,document.all('member2'),true);></select></td><td><input type='button' value=' &gt;&gt; ' onclick=document.all('member1').ondblclick(); ><br><input type='button' value=' &lt;&lt; ' onclick=document.all('member2').ondblclick(); ></td><td><select name='member2' size='10' multiple='multiple' style='width:150px' ondblclick=move(this,document.all('member1'),true);></select></td></tr></table>");
//      sb.append("<script>");
//      sb.append("function f_m_change()");
//      sb.append("{");
//      sb.append("  var m0=document.all('member0'); var m1=document.all('member1');");
//      sb.append("  var op=m1.options; while(op.length>0)op[0]=null;");
//      sb.append("  var id=m0.value; id=parseInt(id); switch(id){").append(js).append("}");
//      sb.append("}");
//      sb.append("f_m_change();  document.all('member0').onchange=f_m_change;");
//      sb.append("</script>");
        }
        return sb.toString();
    }

    public int getFlow()
    {
        return flow;
    }

    public String getDTRead()
    {
        return dtread;
    }

    public String getDTWrite()
    {
        return dtwrite;
    }

    public boolean isCheckbox()
    {
        return checkbox;
    }

    public int getExtend()
    {
        return extend;
    }

    public boolean isSerial()
    {
        return serial;
    }

    public boolean isCsign()
    {
        return csign;
    }

    public String getMainDTRead()
    {
        return maindtread;
    }

    public String getMainDTWrite()
    {
        return maindtwrite;
    }

    public String getName(int language) throws SQLException
    {
        return getLayer(language).name;
    }

    private Layer getLayer(int language) throws SQLException
    {
        Layer layer = (Layer) _htLayer.get(new Integer(language));
        if(layer == null)
        {
            layer = new Layer();
            int j = this.getLanguage(language);
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery("SELECT name FROM FlowprocessLayer WHERE flowprocess=" + flowprocess + " AND language=" + j);
                if(db.next())
                {
                    layer.name = db.getVarchar(j,language,1);
                }
            } finally
            {
                db.close();
            }
            _htLayer.put(new Integer(language),layer);
        }
        return layer;
    }

    private int getLanguage(int language) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT language FROM FlowprocessLayer WHERE flowprocess=" + flowprocess);
            while(db.next())
            {
                v.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        if(v.indexOf(new Integer(language)) != -1)
        {
            return language;
        } else
        {
            if(language == 1)
            {
                if(v.indexOf(new Integer(2)) != -1)
                {
                    return 2;
                }
            } else if(language == 2)
            {
                if(v.indexOf(new Integer(1)) != -1)
                {
                    return 1;
                }
            }
            if(v.size() < 1)
            {
                return 0;
            }
        }
        return((Integer) v.elementAt(0)).intValue();
    }

    public void setMember(String member,int extend) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Flowprocess SET member=" + DbAdapter.cite(member) + ",extend=" + extend + " WHERE flowprocess=" + flowprocess);
        } finally
        {
            db.close();
        }
        this.member = member;
        this.extend = extend;
    }

    public void setDT(String dtwrite,String dtread) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Flowprocess SET dtwrite=" + DbAdapter.cite(dtwrite) + ",dtread=" + DbAdapter.cite(dtread) + " WHERE flowprocess=" + flowprocess);
        } finally
        {
            db.close();
        }
        this.dtwrite = dtwrite;
        this.dtread = dtread;
    }

    public void setMainDT(String maindtwrite,String maindtread) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Flowprocess SET maindtwrite=" + DbAdapter.cite(maindtwrite) + ",maindtread=" + DbAdapter.cite(maindtread) + " WHERE flowprocess=" + flowprocess);
        } finally
        {
            db.close();
        }
        this.maindtwrite = maindtwrite;
        this.maindtread = maindtread;
    }

    //发送站内信和邮件通知的消息内容
//  public String getMessage(TeaSession teasession, int flowbusiness)
//  {
//    Flowbusiness fb = Flowbusiness.find(flowbusiness);
//    StringBuffer sb = new StringBuffer();
//    sb.append("事务名:").append(fb.getName(teasession._nLanguage));
//    sb.append("<br>提交人:").append(teasession._rv);
//    sb.append("<br>第").append(fb.getStep()).append("步");
//    if (f.getType() != 1) //如果不是自由流程
//    {
//      sb.append(fb.getName(teasession._nLanguage));
//    }
//    sb.append("<br><br><a href=http://" + request.getServerName() + ":" + request.getRemotePort() + "/jsp/admin/flow/Flowbusiness3.jsp?community=" + teasession._strCommunity + "&flow=" + flow + " target=m>点这里进行办理</a>");
////
//  }
}
