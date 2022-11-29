package tea.entity.weibo;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import java.text.*;
import tea.entity.*;
import org.json.JSONObject;
import org.json.JSONArray;
import tea.entity.node.*;
import tea.entity.node.*;

public class WVoice
{
    protected static Cache c = new Cache(50);
    public int wvoice; //土豆
    public String community;
    public static String[] TUDOU_TYPE =
            {"--","Historical"};
    public int type; //类型
    public int node; //节点号
    public String code; //视频编号
    public int state; //视频状态
    public String picture; //视频 缩略图
    public int length; //视频长度_秒
    public int hits; //播放次数
    public Date time; //发布时间

    public WVoice(int wvoice)
    {
        this.wvoice = wvoice;
    }

    public static WVoice find(int wvoice) throws SQLException
    {
        WVoice t = (WVoice) c.get(wvoice);
        if(t == null)
        {
            ArrayList al = find(" AND wvoice=" + wvoice,0,1);
            t = al.size() < 1 ? new WVoice(wvoice) : (WVoice) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT wvoice,community,type,node,code,state,picture,length,hits,time FROM wvoice WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                WVoice t = new WVoice(rs.getInt(i++));
                t.community = rs.getString(i++);
                t.type = rs.getInt(i++);
                t.node = rs.getInt(i++);
                t.code = rs.getString(i++);
                t.state = rs.getInt(i++);
                t.picture = rs.getString(i++);
                t.length = rs.getInt(i++);
                t.hits = rs.getInt(i++);
                t.time = db.getDate(i++);
                c.put(t.wvoice,t);
                al.add(t);
            }
            rs.close();
        } finally
        {
            db.close();
        }
        return al;
    }

    public static int count(String sql) throws SQLException
    {
        return DbAdapter.execute("SELECT COUNT(*) FROM wvoice WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        String sql;
        if(wvoice < 1)
        {
            time = new Date();
            sql = "INSERT INTO wvoice(wvoice,community,type,node,code,state,picture,length,hits,time)VALUES(" + (wvoice = Seq.get()) + "," + DbAdapter.cite(community) + "," + type + "," + node + "," + DbAdapter.cite(code) + "," + state + "," + DbAdapter.cite(picture) + "," + length + "," + hits + "," + DbAdapter.cite(time) + ")";
        } else
            sql = "UPDATE wvoice SET community=" + DbAdapter.cite(community) + ",type=" + type + ",node=" + node + ",code=" + DbAdapter.cite(code) + ",state=" + state + ",picture=" + DbAdapter.cite(picture) + ",length=" + length + ",hits=" + hits + ",time=" + DbAdapter.cite(time) + " WHERE wvoice=" + wvoice;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(sql);
        } finally
        {
            db.close();
        }
        c.remove(wvoice);
    }

    public void delete() throws SQLException
    {
        DbAdapter.execute("DELETE FROM wvoice WHERE wvoice=" + wvoice);
        c.remove(wvoice);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter.execute("UPDATE wvoice SET " + f + "=" + DbAdapter.cite(v) + " WHERE wvoice=" + wvoice);
        c.remove(wvoice);
    }

    //
    public String getLength()
    {
        DecimalFormat df = new DecimalFormat("00");
        int t = (int) length;
        int h = t / 3600;
        int m = (t % 3600) / 60;
        int s = t % 60;
        return df.format(h) + ":" + df.format(m) + ":" + df.format(s);
    }

    private static String[] vcode(String sql) throws SQLException
    {
        ArrayList al = find(sql,0,200);
        String[] arr = new String[al.size()];
        for(int i = 0;i < al.size();i++)
        {
            WVoice t = (WVoice) al.get(i);
            arr[i] = t.code;
        }
        return arr;
    }

    public static void ref()
    {
        try
        {
            //刷新状态
            Iterator it = find(" AND state NOT IN(1,5,6)",0,200).iterator();
            while(it.hasNext())
            {
                WVoice wv = (WVoice) it.next();

                ArrayList al = new ArrayList();
                JSONArray a = new Tudou(wv.community).getState(new String[]
                        {wv.code}).getJSONObject("multiResult").getJSONArray("results");
                for(int i = 0;i < a.length();i++)
                {
                    JSONObject o = a.getJSONObject(i);
                    String vcode = o.getString("itemCode");
                    //土豆bug,“转码中”时，会返两次，第二次为“不存在”
                    if(al.contains(vcode))
                        continue;
                    al.add(vcode);

                    wv.set("state",String.valueOf(wv.state = o.getInt("state")));

                    if(wv.type == 1)
                    {
                        Historical h = Historical.find(wv.node,1);
                        NodeFlow nf = NodeFlow.findLast(" AND node=" + wv.node + " AND state IN(3,6)");
                        nf.content = Tudou.STATE_TYPE[wv.state];
                        if(wv.state == 1)
                        {
                            nf.content = h.share();
                        }
                        nf.set();
                    }
                }
            }

            //获得缩略图
            it = find(" AND state=1 AND picture IS NULL",0,200).iterator();
            while(it.hasNext())
            {
                WVoice wv = (WVoice) it.next();

                JSONArray a = new Tudou(wv.community).getInfo(new String[]
                        {wv.code}).getJSONObject("multiResult").getJSONArray("results");
                for(int i = 0;i < a.length();i++)
                {
                    JSONObject o = a.getJSONObject(i);

                    wv.picture = o.getString("picUrl");
                    wv.length = o.getInt("totalTime");
                    wv.hits = o.getInt("playTimes");
                    wv.set();
                }
            }
        } catch(Exception ex)
        {
            ex.printStackTrace();
        }
    }

}
