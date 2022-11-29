package tea.entity.admin;

import java.sql.*;
import java.util.*;

import tea.db.*;
import tea.entity.*;

/*
 1.创建动态表单,创建流程并关链表单,定义流程步骤及经办人
 2.创建事务,并关链项目.
 */
public class Flow
{
    private static Cache _cache = new Cache(100);
    private Hashtable _htLayer;
    private String community;
    private int flow;
    private int prev; //上级流程
    private int type;
    public static String FLOW_TYPE[] =
            {"固定流程","自由流程","可控流程"};
    private int dynamic;
    private int itemtype;
    private boolean hiddenconsign; //是否隐掉经办人的委托功能
    private int mainprocess; //主控流程
    private int filecenter; //归案到文件中心///
    private int distprocess; //分发步
    public int stampprocess; //盖章

    private boolean exists;
    class Layer
    {
        String name;
        String template;
    }


    public Flow(int flow) throws SQLException
    {
        this.flow = flow;
        this._htLayer = new Hashtable();
        load();
    }

    public static Flow find(int id) throws SQLException
    {
        Flow obj = (Flow) _cache.get(new Integer(id));
        if(obj == null)
        {
            obj = new Flow(id);
            _cache.put(new Integer(id),obj);
        }
        return obj;
    }

    public static Enumeration find(String community,String sql) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT flow FROM Flow WHERE community=" + DbAdapter.cite(community) + sql);
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

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM Flow WHERE flow=" + flow);
            db.executeUpdate("DELETE FROM Flowbusiness WHERE flow=" + flow); //工作事务
            db.executeUpdate("DELETE FROM Flowprocess WHERE flow=" + flow); //事务的执行步骤
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(flow));
    }

    public void set(int prev,int type,int dynamic,int itemtype,boolean hiddenconsign,int filecenter,int language,String name,String template) throws SQLException
    {
        StringBuilder sql = new StringBuilder();
        sql.append("UPDATE FlowLayer SET name=").append(DbAdapter.cite(name));
        if(template != null)
        {
            sql.append(",template=").append(DbAdapter.cite(template));
        }
        sql.append(" WHERE flow=").append(flow).append(" AND language=").append(language);
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Flow SET prev=" + prev + ",type=" + type + ",dynamic =" + dynamic + ",itemtype=" + itemtype + ",hiddenconsign=" + DbAdapter.cite(hiddenconsign) + ",filecenter=" + filecenter + " WHERE flow=" + flow);
            int j = db.executeUpdate(sql.toString());
            if(j < 1)
            {
                db.executeUpdate("INSERT INTO FlowLayer(flow,language,name,template)VALUES(" + flow + "," + language + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(template) + ")");
            }
        } finally
        {
            db.close();
        }
        this.prev = prev;
        this.type = type;
        this.dynamic = dynamic;
        this.itemtype = itemtype;
        this.hiddenconsign = hiddenconsign;
        this.filecenter = filecenter;
        _htLayer.clear();
        // _cache.remove(new Integer(flow));
    }

    public static int create(String community,int prev,int type,int dynamic,int itemtype,boolean hiddenconsign,int filecenter,int language,String name,String template) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO Flow(community,prev,type,dynamic,itemtype,hiddenconsign,filecenter)VALUES(" + DbAdapter.cite(community) + "," + prev + "," + type + "," + dynamic + "," + itemtype + "," + DbAdapter.cite(hiddenconsign) + "," + filecenter + ")");
            int flow = db.getInt("SELECT MAX(flow) FROM Flow");
            db.executeUpdate("INSERT INTO FlowLayer(flow,language,name,template)VALUES(" + flow + "," + language + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(template) + ")");
            return flow;
        } finally
        {
            db.close();
        }
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT community,prev,type,dynamic,itemtype,hiddenconsign,mainprocess,distprocess,stampprocess,filecenter FROM Flow WHERE flow=" + flow);
            if(db.next())
            {
                int j = 1;
                community = db.getString(j++);
                prev = db.getInt(j++);
                type = db.getInt(j++);
                dynamic = db.getInt(j++);
                itemtype = db.getInt(j++);
                hiddenconsign = db.getInt(j++) != 0;
                mainprocess = db.getInt(j++);
                distprocess = db.getInt(j++);
                stampprocess = db.getInt(j++);
                filecenter = db.getInt(j++);
                exists = true;
            } else
            {
                exists = false;
            }
        } finally
        {
            db.close();
        }
    }

    public void setMainProcess(int mainprocess) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Flow SET mainprocess=" + mainprocess + " WHERE flow=" + flow);
        } finally
        {
            db.close();
        }
        this.mainprocess = mainprocess;
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter.execute("UPDATE Flow SET " + f + "=" + DbAdapter.cite(v) + " WHERE flow=" + flow);
        _cache.remove(flow);
    }

    //是否存在运行的事务
    public boolean isRun() throws SQLException
    {
        boolean run = false;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT flow FROM Flowbusiness WHERE flow=" + flow + " AND step!=0");
            run = db.next();
        } finally
        {
            db.close();
        }
        return run;
    }

    public void clone(int language) throws SQLException
    {
        int newid = Flow.create(community,prev,type,dynamic,itemtype,hiddenconsign,filecenter,language,"『复件』 " + getName(language),getTemplate(language));
        Enumeration e = Flowprocess.find(flow,"");
        while(e.hasMoreElements())
        {
            int fp = ((Integer) e.nextElement()).intValue();
            Flowprocess t = Flowprocess.find(fp);
            Flowprocess.create(newid,t.getStep(),t.getMember(),t.getDTWrite(),t.getDTRead(),t.isCheckbox(),t.isSerial(),t.isCsign(),language,getName(language));
        }
    }


    public int getType()
    {
        return type;
    }

    public int getFlow()
    {
        return flow;
    }

    public boolean isExists()
    {
        return exists;
    }

    public int getDynamic()
    {
        return dynamic;
    }

    public String getCommunity()
    {
        return community;
    }

    public String getName(int language) throws SQLException
    {
        return getLayer(language).name;
    }

    public String getTemplate(int language) throws SQLException
    {
        return getLayer(language).template;
    }

    public int getItemtype()
    {
        return itemtype;
    }

    public int getFilecenter()
    {
        return filecenter;
    }

    public int getPrev()
    {
        return prev;
    }

    public boolean isHiddenConsign()
    {
        return hiddenconsign;
    }

    public int getMainProcess()
    {
        return mainprocess;
    }

    public int getDistProcess()
    {
        return distprocess;
    }

    public void setDistProcess(int distprocess) throws SQLException
    {
        DbAdapter.execute("UPDATE Flow SET distprocess=" + distprocess + " WHERE flow=" + flow);
        this.distprocess = distprocess;
    }

    public void set(int flowprocess,boolean isMP,boolean isDP,boolean isSP) throws SQLException
    {
        if(isMP)
            mainprocess = flowprocess;
        else if(mainprocess == flowprocess)
            mainprocess = 0;
        if(isDP)
            distprocess = flowprocess;
        else if(distprocess == flowprocess)
            distprocess = 0;
        if(isSP)
            stampprocess = flowprocess;
        else if(stampprocess == flowprocess)
            stampprocess = 0;
        DbAdapter.execute("UPDATE Flow SET mainprocess=" + mainprocess + ",distprocess=" + distprocess + ",stampprocess=" + stampprocess + " WHERE flow=" + flow);
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
                db.executeQuery("SELECT name,template FROM FlowLayer WHERE flow=" + flow + " AND language=" + j);
                if(db.next())
                {
                    layer.name = db.getVarchar(j,language,1);
                    layer.template = db.getString(2);
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
            db.executeQuery("SELECT language FROM FlowLayer WHERE flow=" + flow);
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
}
