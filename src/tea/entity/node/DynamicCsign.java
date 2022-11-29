package tea.entity.node;

import java.sql.SQLException;
import java.util.*;
import tea.db.*;
import tea.entity.*;
import tea.entity.admin.*;

public class DynamicCsign extends Entity
{
    private static Cache _cache = new Cache(100);
    public static final String COMMENT_TYPE[] =
            {"无","有，详见文件标注","有，详见附页说明。"};
    private int node;
    public int dynamictype; //会签类型， 用于区别一个流程中多次会签或传阅
    public String member;
    private int flowview;
    private Date starttime;
    private String unit;
    private int comments;
    private String content;
    private String sign;
    private Date endtime;
    private boolean exists;
    private DynamicCsign(int node,int dynamictype,String member) throws SQLException
    {
        this.node = node;
        this.dynamictype = dynamictype;
        this.member = member;
    }

    public static DynamicCsign find(int node,int dynamictype,String member) throws SQLException
    {
        Enumeration e = find(Flowbusiness.find(Math.abs(node)).getCommunity()," AND dc.node=" + node + " AND dc.dynamictype=" + dynamictype + " AND dc.member=" + DbAdapter.cite(member));
        return e.hasMoreElements() ? (DynamicCsign) e.nextElement() : new DynamicCsign(node,dynamictype,member);
    }

//  public static DynamicCsign findByFlowview(int flowview) throws SQLException
//  {
//    DbAdapter db = new DbAdapter();
//    try
//    {
//      db.executeQuery("SELECT node,member FROM DynamicCsign WHERE flowview=" + flowview);
//      if (db.next())
//      {
//        int node = db.getInt(1);
//        String member = db.getString(2);
//        return DynamicCsign.find(node, member);
//      }
//    } finally
//    {
//      db.close();
//    }
//    return null;
//  }

    public static void create(int node,int dynamictype,String member,int flowview,Date starttime,String unit,int comments,String content,String sign,Date endtime) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO DynamicCsign (node,dynamictype,member,flowview,starttime,unit,comments,content,sign,endtime)VALUES(" + node + "," + dynamictype + "," + db.cite(member) + "," + flowview + ", " + db.cite(starttime) + ", " + db.cite(unit) + ", " + comments + ", " + db.cite(content) + ", " + db.cite(sign) + ", " + db.cite(endtime) + ")");
        } finally
        {
            db.close();
        }
    }

    public void set(Date starttime,String unit,int comments,String content,String sign,Date endtime) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            j = db.executeUpdate("UPDATE DynamicCsign SET starttime=" + db.cite(starttime) + ",unit=" + db.cite(unit) + ",comments=" + comments + ",content=" + db.cite(content) + ",sign=" + db.cite(sign) + ",endtime=" + db.cite(endtime) + " WHERE node=" + node + " AND dynamictype=" + dynamictype + " AND member=" + db.cite(member));
        } finally
        {
            db.close();
        }
        if(j < 1)
        {
            create(node,dynamictype,member,flowview,starttime,unit,comments,content,sign,endtime);
            this.exists = true;
        }
        this.starttime = starttime;
        this.unit = unit;
        this.comments = comments;
        this.content = content;
        this.sign = sign;
        this.endtime = endtime;
    }

    public void delete() throws SQLException
    {
        DbAdapter.execute("DELETE FROM DynamicCsign WHERE node=" + node + " AND dynamictype=" + dynamictype + " AND member=" + DbAdapter.cite(member));
    }

    public static Enumeration find(int node,int dynamictype) throws SQLException
    {
        return find(Flowbusiness.find(Math.abs(node)).getCommunity()," AND node=" + node + (dynamictype > 0 ? " AND dynamictype=" + dynamictype : ""));
    }

    public static Enumeration find(String community,String sql) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT dc.node,dc.dynamictype,dc.member,dc.flowview,dc.starttime,dc.unit,dc.comments,dc.content,dc.sign,dc.endtime FROM DynamicCsign dc LEFT JOIN AdminUsrRole aur ON dc.member=aur.member AND community=" + DbAdapter.cite(community) + " WHERE 1=1" + sql + " ORDER BY aur.classes DESC");
            while(db.next())
            {
                DynamicCsign t = new DynamicCsign(db.getInt(1),db.getInt(2),db.getString(3));
                t.flowview = db.getInt(4);
                t.starttime = db.getDate(5);
                t.unit = db.getString(6);
                t.comments = db.getInt(7);
                t.content = db.getText(8);
                t.sign = db.getString(9);
                t.endtime = db.getDate(10);
                t.exists = true;
                v.addElement(t);
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public int getNode()
    {
        return node;
    }

    public String getUnit()
    {
        return unit;
    }

    public Date getStartTime() throws SQLException
    {
        if(starttime == null)
        {
            int fbid = Math.abs(node);
            Flowbusiness fb = Flowbusiness.find(fbid);
            Flowprocess fp = Flowprocess.find(fb.getFlow(),fb.getStep());
            int flowview = Flowview.findLast(fbid,fp.getFlowprocess());
            starttime = Flowview.find(flowview).getTime();
        }
        return starttime;
    }

    public String getStartTimeToString() throws SQLException
    {
        return MT.f(getStartTime(),3);
    }

    public String getSign()
    {
        return sign;
    }

    public boolean isExists()
    {
        return exists;
    }

    public Date getEndTime()
    {
        return endtime;
    }

    public String getEndTimeToString()
    {
        return MT.f(endtime,3);
    }

    public String getContent()
    {
        return content;
    }

    public int getComment()
    {
        return comments;
    }

}
