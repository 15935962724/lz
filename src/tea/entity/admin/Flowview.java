package tea.entity.admin;

import java.io.*;
import java.sql.SQLException;
import java.util.*;
import tea.db.*;
import tea.entity.*;

public class Flowview extends Entity implements Serializable
{
    public static final String STATE_TYPE[] =
            {"未办理","办理中","已完成","已阅毕"};
    private static Cache _cache = new Cache(100);
    private int flowview;
    private int flowbusiness;
    private int flowprocess; //流程中每一步的ID //0:部分会员已转了下一步,并指定了下一步的待办人
    public String previous; //上步办理人
    private String transactor; //待办人
    private String consign; //委托人
    public Date ctime; //委托的有效期，到期自动收回
    private int state; //0:未接收,1:已接收,2:已办理
    private int step; //步骤号,作+1操作
    private int sumprint; //可打印份数
    private int useprint; //已可印份数
    private Date time;
    private boolean exists;

    public Flowview(int flowview) throws SQLException
    {
        this.flowview = flowview;
        load();
    }

    public static Flowview find(int flowview) throws SQLException
    {
        Flowview obj = (Flowview) _cache.get(new Integer(flowview));
        if(obj == null)
        {
            obj = new Flowview(flowview);
            _cache.put(new Integer(flowview),obj);
        }
        return obj;
    }

    public static Flowview find(int flowbusiness,int flowprocess,String transactor) throws SQLException
    {
        int id = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            int j = db.getInt("SELECT MAX(step) FROM Flowview WHERE flowbusiness=" + flowbusiness + " AND flowprocess=" + flowprocess); //{flowprocess}最后一步的序号
            db.executeQuery("SELECT flowview FROM Flowview WHERE flowbusiness=" + flowbusiness + " AND flowprocess=" + flowprocess + " AND step=" + j + " AND(transactor=" + db.cite(transactor) + " OR consign=" + db.cite(transactor) + ")");
            if(db.next())
            {
                id = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return find(id);
    }

    //{flowprocess}步的办理者
    public static Enumeration find(int flowbusiness,int flowprocess) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            int j = db.getInt("SELECT MAX(flowview) FROM Flowview WHERE flowbusiness=" + flowbusiness + " AND flowprocess!=" + flowprocess + " AND flowview <(SELECT MAX(flowview) FROM Flowview WHERE flowbusiness=" + flowbusiness + " AND flowprocess=" + flowprocess + ")");
            db.executeQuery("SELECT flowview FROM Flowview WHERE flowview>" + j + " AND flowbusiness=" + flowbusiness + " AND flowprocess=" + flowprocess);
            while(db.next())
            {
                v.add(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    //{flowprocess}步的办理者人数
    public static int count(int flowbusiness,int flowprocess) throws SQLException
    {
        int c = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            int j = db.getInt("SELECT MAX(flowview) FROM Flowview WHERE flowbusiness=" + flowbusiness + " AND flowprocess!=" + flowprocess + " AND flowview <(SELECT MAX(flowview) FROM Flowview WHERE flowbusiness=" + flowbusiness + " AND flowprocess=" + flowprocess + ")");
            db.executeQuery("SELECT COUNT(flowview) FROM Flowview WHERE flowview>" + j + " AND flowbusiness=" + flowbusiness + " AND flowprocess=" + flowprocess);
            if(db.next())
            {
                c = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return c;
    }

    public static int count(String sql) throws SQLException
    {
        return DbAdapter.execute("SELECT COUNT(flowview) FROM Flowview WHERE 1=1" + sql);
    }

    //最后一次///
    public static Flowview findLast(int flowbusiness) throws SQLException
    {
        int id = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            id = db.getInt("SELECT MAX(flowview) FROM Flowview WHERE flowprocess!=0 AND flowbusiness=" + flowbusiness);
        } finally
        {
            db.close();
        }
        return find(id);
    }

    //{flowprocess}的前一步,最后一次的ID///
    public static int findLast(int flowbusiness,int flowprocess) throws SQLException
    {
        int id = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT MAX(flowview) FROM Flowview WHERE flowbusiness=" + flowbusiness + " AND flowprocess!=" + flowprocess + " AND flowview <(SELECT MAX(flowview) FROM Flowview WHERE flowbusiness=" + flowbusiness + " AND flowprocess=" + flowprocess + ")");
            if(db.next())
            {
                id = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return id;
    }

    //最后一步待办人为{member}的事务列表
//    public static String findLast(String member) throws SQLException
//    {
//        ArrayList al = new ArrayList();
//        DbAdapter db = new DbAdapter();
//        try
//        {
//            db.executeQuery("SELECT MAX(flowview) FROM Flowview WHERE flowprocess!=0 GROUP BY flowbusiness");
//            while(db.next())
//            {
//                al.add(db.getInt(1));
//            }
//        } finally
//        {
//            db.close();
//        }
//        StringBuffer sb = new StringBuffer();
//        Iterator it = al.iterator();
//        while(it.hasNext())
//        {
//            int id = ((Integer) it.next()).intValue();
//            if(sb.length() > 0)
//                sb.append(",");
//            sb.append(id);
//        }
//		StringBuffer s2 = new StringBuffer();
//        db = new DbAdapter();
//        try
//        {
//            db.executeQuery("SELECT flowbusiness FROM Flowview WHERE flowprocess IN(" + sb.toString() + ") AND state<2 AND " + DbAdapter.cite(member) + " IN(transactor,consign)");
//            while(db.next())
//            {
//                al.add(db.getInt(1));
//            }
//        } finally
//        {
//            db.close();
//        }
//        return sb.toString();
//    }

    public static Enumeration findByMember(String community,String transactor,String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT DISTINCT flowbusiness FROM Flowview WHERE community=" + DbAdapter.cite(community) + " AND transactor=" + DbAdapter.cite(transactor) + sql,pos,size);
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

    public static int countByMember(String community,String transactor,String sql) throws SQLException
    {
        int c = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(DISTINCT flowbusiness) FROM Flowview WHERE community=" + DbAdapter.cite(community) + " AND transactor=" + DbAdapter.cite(transactor) + sql);
            if(db.next())
            {
                c = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return c;
    }

    public static Enumeration find(int flowbusiness,String sql) throws SQLException
    {
        if(sql.indexOf("ORDER BY") == -1)
            sql += " ORDER BY flowview";
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT flowview FROM Flowview WHERE flowbusiness=" + flowbusiness + sql);
            while(db.next())
            {
                v.add(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public static void delete(int flowview) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM Flowview WHERE flowview=" + flowview);
            db.executeUpdate("DELETE FROM DynamicCsign WHERE flowview=" + flowview); //删除相关的会签人员
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(flowview));
    }

    public void setConsign(String consign,Date ctime) throws SQLException
    {
        DbAdapter.execute("UPDATE Flowview SET consign=" + DbAdapter.cite(consign) + ",ctime=" + DbAdapter.cite(ctime) + " WHERE flowview=" + flowview);
        this.consign = consign;
        this.ctime = ctime;
    }

    public void setState(int state) throws SQLException
    {
        Date time = new Date();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Flowview SET state=" + state + ",time=" + db.cite(time) + " WHERE flowview=" + flowview);
        } finally
        {
            db.close();
        }
        this.state = state;
        this.time = time;
    }

    //@flowprocess 下一步的步骤ID
    public static void create(int flowbusiness,int flowprocess,String previous,String transactor[],int state,int sumprint) throws SQLException
    {
        //添加会签人员 条件: 当前步没有"设置候选会签部门/人员",上一步必须设置了"设置候选会签部门/人员"
//        Flowbusiness fb = Flowbusiness.find(flowbusiness);
//        int cur = Flowprocess.find(fb.getFlow(),fb.getStep()).getFlowprocess(); //当前步
//        boolean isCsign = !Flowprocess.find(cur).isCsign();
//        if(isCsign)
//        {
//            int pre = Flowview.find(Flowview.findLast(flowbusiness,cur)).getFlowprocess(); //上一步
//            isCsign = Flowprocess.find(pre).isCsign();
//        }
        //
        Date time = new Date();
        DbAdapter db = new DbAdapter();
        try
        {
            int step = 1;
            db.executeQuery("SELECT flowprocess,step FROM Flowview WHERE flowbusiness=" + flowbusiness + " ORDER BY flowview DESC");
            if(db.next())
            {
                int fp = db.getInt(1);
                step = db.getInt(2);
                if(fp != 0) //1->n n->n时fp为0
                    step++;
            }
            //如果是多人待办的话,{step}的值必须是相同的.所以for要放在这里
            for(int i = 0;i < transactor.length;i++)
            {
                db.executeQuery("SELECT flowview,previous FROM Flowview WHERE flowbusiness=" + flowbusiness + " AND (flowprocess=0 OR step=" + step + ") AND transactor=" + DbAdapter.cite(transactor[i])); //传下一步时,有时能会多人传给一个人...  同一步待办人中不能出现两个相同的人
                if(db.next())
                {
                    int fvid = db.getInt(1);
                    db.executeUpdate("UPDATE Flowview SET previous=" + DbAdapter.cite(db.getString(2) + previous + "|") + " WHERE flowview=" + fvid);
                    _cache.remove(fvid);
                } else
                    db.executeUpdate("INSERT INTO Flowview(flowbusiness,flowprocess,step,previous,transactor,state,sumprint,useprint,time)VALUES(" + flowbusiness + "," + flowprocess + "," + step + "," + DbAdapter.cite("|" + previous + "|") + "," + DbAdapter.cite(transactor[i]) + "," + state + "," + sumprint + ",0," + db.cite(time) + ")");
                //int flowview = db.getInt("SELECT MAX(flowview) FROM Flowview WHERE flowbusiness=" + flowbusiness);
//                    if(isCsign)
//                    {
//                        //DynamicCsign.create( -flowbusiness, transactor[i], flowview, time, null, 0, null, null, null);
//                    }
            }
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
            db.executeQuery("SELECT flowbusiness,flowprocess,step,previous,transactor,consign,ctime,state,sumprint,useprint,time FROM Flowview WHERE flowview=" + flowview);
            if(db.next())
            {
                int j = 1;
                flowbusiness = db.getInt(j++);
                flowprocess = db.getInt(j++);
                step = db.getInt(j++);
                previous = db.getString(j++);
                transactor = db.getString(j++);
                consign = db.getString(j++);
                ctime = db.getDate(j++);
                state = db.getInt(j++);
                sumprint = db.getInt(j++);
                useprint = db.getInt(j++);
                time = db.getDate(j++);
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

    public boolean isExists()
    {
        return exists;
    }

    public Date getTime()
    {
        return time;
    }

    public String getTimeToString()
    {
        if(time == null)
        {
            return "";
        }
        return sdf2.format(time);
    }

    public int getFlowprocess()
    {
        return flowprocess;
    }

    public String getTransactor()
    {
        return transactor;
    }

    public int getFlowbusiness()
    {
        return flowbusiness;
    }

    public String getConsign()
    {
        return consign;
    }

    public int getState()
    {
        return state;
    }

    public int getStep()
    {
        return step;
    }

    public int getSumPrint()
    {
        return sumprint;
    }

    public int getUsePrint()
    {
        return useprint;
    }

    public int getFlowview()
    {
        return flowview;
    }

    public void setSumPrint(int sumprint) throws SQLException
    {
        this.sumprint = sumprint;
        DbAdapter.execute("UPDATE Flowview SET sumprint=" + sumprint + " WHERE flowview=" + flowview);
    }

    public void setUsePrint() throws SQLException
    {
        useprint++;
        DbAdapter.execute("UPDATE Flowview SET useprint=" + useprint + " WHERE flowview=" + flowview);
    }


    //自动收回委托
    public static void activate() throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            if(Math.random() > 0.8)
                db.executeUpdate("DELETE FROM Flowbusiness WHERE step=-1 AND ftime<" + DbAdapter.cite(new Date(),true)); //删除临时(未保存)事务
            db.executeQuery("SELECT fb.flowbusiness FROM Flowbusiness fb WHERE step>0");
            while(db.next())
            {
                v.add(db.getInt(1));
            }
        } finally
        {
            db.close();
        }
        Enumeration efb = v.elements();
        while(efb.hasMoreElements())
        {
            int flowbusiness = ((Integer) efb.nextElement()).intValue();
            Flowbusiness fb = Flowbusiness.find(flowbusiness);
            Flowprocess fp = Flowprocess.find(fb.getFlow(),fb.getStep());
            Enumeration efv = Flowview.find(flowbusiness,fp.getFlowprocess());
            while(efv.hasMoreElements())
            {
                int flowview = ((Integer) efv.nextElement()).intValue();
                Flowview fv = Flowview.find(flowview);
                if(fv.consign == null || fv.ctime == null || fv.ctime.getTime() > System.currentTimeMillis())
                    continue;
                System.out.println("收回委托：" + fv.transactor + "=>" + fv.consign);
                fv.setConsign(null,null);
            }
        }
    }
}
