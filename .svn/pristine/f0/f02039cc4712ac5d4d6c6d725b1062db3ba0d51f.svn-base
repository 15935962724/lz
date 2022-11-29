package tea.entity.eon;

import java.io.*;
import java.math.*;
import java.net.*;
import java.sql.*;
import java.text.*;
import java.util.*;
import java.util.Date;
import tea.db.*;
import tea.entity.*;
import tea.entity.site.*;

//用户通话记录
public class EonRecord extends Entity
{
    private static Cache _cache = new Cache(100);
    public static String STATUS_TYPE[] =
            {"未呼通","只呼通主叫","双方通","用户留言","自动语音服务"};
    public static String PROCESS_TYPE[] =
            {"双方通话","自动语音服务","用户留言","服务方留言"};
    private int eonrecord;
    private int node; //在哪个节点点击的呼叫
    private String member; //主叫
    private String callmember; //被叫,当前用户
    private String calltel; //被叫
    private boolean side; //false:被叫方收费,true:主叫方收费
    private int processnum; //0双方通话 1服务方自动语音服务 2提示用户留言 3提示服务方留言
    private Date time; //呼叫时间
    private int result;
    /////
    private Date starttime; //呼叫时间
    private Date endtime; //停止时间
    private int talktime; //通话时长
    private int status; //通话状态:0未呼通 1只呼通主叫  2双方通 3主叫留言
    private BigDecimal consume; //消费金额
    private boolean exists;

    public EonRecord(int eonrecord) throws SQLException
    {
        this.eonrecord = eonrecord;
        load();
    }

    public static EonRecord find(int eonrecord) throws SQLException
    {
        EonRecord obj = (EonRecord) _cache.get(new Integer(eonrecord));
        if(obj == null)
        {
            obj = new EonRecord(eonrecord);
            _cache.put(new Integer(eonrecord),obj);
        }
        return obj;
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT node,member,callmember,calltel,side,processnum,time,result,  starttime,endtime,talktime,status,consume FROM EonRecord WHERE eonrecord=" + eonrecord);
            if(db.next())
            {
                node = db.getInt(1);
                member = db.getString(2);
                callmember = db.getString(3);
                calltel = db.getString(4);
                side = db.getInt(5) != 0;
                processnum = db.getInt(6);
                time = db.getDate(7);
                result = db.getInt(8);
                ///
                starttime = db.getDate(9);
                endtime = db.getDate(10);
                talktime = db.getInt(11);
                status = db.getInt(12);
                consume = db.getBigDecimal(13,2);
                exists = true;
            } else
            {
                exists = false;
            }
            if(consume == null)
            {
                consume = BigDecimal.ZERO;
            }
        } finally
        {
            db.close();
        }
    }

    public static int create(int node,String member,String callmember,String calltel,boolean side,int processnum) throws SQLException
    {
        int id = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO EonRecord( node, member,callmember,calltel,side,processnum,time,result) VALUES (" + node + "," + DbAdapter.cite(member) + "," + DbAdapter.cite(callmember) + "," + DbAdapter.cite(calltel) + "," + DbAdapter.cite(side) + "," + processnum + "," + db.citeCurTime() + ",0 )");
            id = db.getInt("SELECT MAX(eonrecord) FROM EonRecord");
        } finally
        {
            db.close();
        }
        return id;
    }

    public void setResult(int result) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE EonRecord SET result=" + result + " WHERE eonrecord=" + eonrecord);
        } finally
        {
            db.close();
        }
        this.result = result;
    }

    public void set(Date starttime,Date endtime,int status) throws SQLException
    {
        if(starttime != null && endtime != null)
        {
            EonNode en = EonNode.find(node);
            int mm = talktime = (int) ((endtime.getTime() - starttime.getTime()) / 1000);
            mm = mm / 60;
            if(talktime % 60 != 0)
            {
                mm++;
            }
            BigDecimal minute = new BigDecimal(mm);
            consume = minute.multiply(en.getPrice());
        }
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE EonRecord SET starttime=" + db.cite(starttime) + ",endtime=" + db.cite(endtime) + ",talktime=" + talktime + ",status=" + status + ",consume=" + consume + " WHERE eonrecord=" + eonrecord);
        } finally
        {
            db.close();
        }
        this.starttime = starttime;
        this.endtime = endtime;
        this.status = status;
        this.exists = true;
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM EonRecord WHERE eonrecord=" + eonrecord);
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(eonrecord));
    }

    public static int count(String community,String sql) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(*) FROM EonRecord er INNER JOIN Node n ON er.node=n.node WHERE n.community=" + DbAdapter.cite(community) + sql);
            if(db.next())
            {
                j = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return j;
    }

    public static Enumeration find(String community,String sql,int pos,int size) throws SQLException
    {
        String str;
        if(community == null)
        {
            str = "SELECT er.eonrecord FROM EonRecord er WHERE 1=1" + sql;
        } else
        {
            str = "SELECT er.eonrecord FROM EonRecord er INNER JOIN Node n ON er.node=n.node WHERE n.community=" + DbAdapter.cite(community) + sql;
        }
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery(str,pos,size);
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

    public String getMember()
    {
        return member;
    }

    public boolean isExists()
    {
        return exists;
    }

    public BigDecimal getConsume()
    {
        return consume;
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

    public int getTalkTime()
    {
        return talktime;
    }

    public String getTalkTimeToString()
    {
        DecimalFormat df = new DecimalFormat("00");
        int m = talktime / 60;
        int s = talktime % 60;
        return df.format(m) + ":" + df.format(s);
    }

    public int getStatus()
    {
        return status;
    }

    public Date getStartTime()
    {
        return starttime;
    }

    public String getStartTimeToString()
    {
        if(starttime == null)
        {
            return "";
        }
        return sdf2.format(starttime);
    }

    public boolean isSide()
    {
        return side;
    }

    public int getNode()
    {
        return node;
    }

    public int getProcessnum()
    {
        return processnum;
    }

    public int getResult()
    {
        return result;
    }

    public String getCallTel()
    {
        return calltel;
    }

    public int getEonRecord()
    {
        return eonrecord;
    }

    public Date getEndTime()
    {
        return endtime;
    }

    public String getEndTimeToString()
    {
        if(endtime == null)
        {
            return "";
        }
        return sdf2.format(endtime);
    }

    public String getCallMember()
    {
        return callmember;
    }

    public String getConsumeToString()
    {
        return df.format(consume);
    }


    ///////////////////////
    public static String conn(String host,String function,String param) throws IOException
    {
        HttpURLConnection huc = (HttpURLConnection)new URL("http://" + host + "/OutTask/servlet/" + function + "?" + param).openConnection(); //http://eon.redcome.com/OutTask/servlet/OutboundServlet
        huc.setReadTimeout(10000);
        huc.setConnectTimeout(10000);
        huc.setRequestMethod("POST");
        //
        int i = 0;
        StringBuilder sb = new StringBuilder();
        byte by[] = new byte[8192];
        InputStream is = huc.getInputStream();
        while((i = is.read(by)) != -1)
        {
            sb.append(new String(by,0,i,"GBK"));
        }
        is.close();
        String rs = sb.toString();
        System.out.println("连接:" + function + ":" + param);
        System.out.println("返回:" + function + ":" + rs);
        return rs;
    }

    //EDN提供的接收通话信息接口
    public static void refresh(String community) throws IOException,SQLException
    {
        CommunityOption co = CommunityOption.find(community);
        String eonip = co.get("eonip");
        //
        Enumeration e = EonRecord.find(community," AND status IS NULL",0,Integer.MAX_VALUE);
        while(e.hasMoreElements())
        {
            StringBuilder par = new StringBuilder();
            for(int i = 0;e.hasMoreElements() && i < 20;i++)
            {
                int eonrecord = ((Integer) e.nextElement()).intValue();
                par.append("&SessionId=").append(eonrecord);
            }
            String r1[] = conn(eonip,"GetResultServlet",par.toString()).split(";");
            for(int i = 0;i < r1.length;i++)
            {
                String r2[] = r1[i].split("/");
                if(r2.length > 1)
                {
                    int eonrecord = Integer.parseInt(r2[1]);
                    Date starttime = null,endtime = null;
                    try
                    {
                        if(!r2[4].equals("null"))
                        {
                            starttime = EonRecord.sdf3.parse(r2[4]);
                        }
                        if(!r2[5].equals("null"))
                        {
                            endtime = EonRecord.sdf3.parse(r2[5]);
                        }
                    } catch(ParseException ex)
                    {
                        ex.printStackTrace();
                    }
                    int status = Integer.parseInt(r2[6]);
                    EonRecord er = EonRecord.find(eonrecord);
                    er.set(starttime,endtime,status);
                }
            }
        }
    }
}
