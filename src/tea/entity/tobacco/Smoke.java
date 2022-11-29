package tea.entity.tobacco;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;
import net.mietian.convert.*;

public class Smoke
{
    protected static Cache c = new Cache(50);
    public int smoke; //无烟北京
    public String code; //编号
    public String name; //姓名
    public String idcard; //身份证号
    public String address; //地址
    public String mobile; //手机号
    public static String[] SMOKE_TYPE =
            {"--","文字","图片","视频"};
    public int type; //类型
    public String content; //内容
    public static String[][] MATTER_TYPE =
            {
            {"--"},
            {"--","宣传语","幽默劝导语","笑话","顺口溜","快板","小故事","脱口秀","歌词","其它"},
            {"--","海报","照片","创意图画","动态图画","其它"},
            {"--","公益广告","动漫","MV","微电影","微视频","随手拍","其它"}
    };
    public int matter; //题材
    public int attch; //附件/图片或视频
    public int positive; //赞
    public int derogatory; //踩
    public static String[] STATE_TYPE =
            {"--","未审核","通过","拒绝"};
    public int state; //状态
    public int smember; //操作人
    public Date stime; //操作时间
    public String ip; //IP地址
    public String useragent;
    public Date time; //时间

    public Smoke(int smoke)
    {
        this.smoke = smoke;
    }

    public static Smoke find(int smoke) throws SQLException
    {
        Smoke t = (Smoke) c.get(smoke);
        if(t == null)
        {
            ArrayList al = find(" AND smoke=" + smoke,0,1);
            t = al.size() < 1 ? new Smoke(smoke) : (Smoke) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT smoke,code,name,idcard,address,mobile,type,content,matter,attch,positive,derogatory,state,smember,stime,ip,useragent,time FROM smoke WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                Smoke t = new Smoke(rs.getInt(i++));
                t.code = rs.getString(i++);
                t.name = rs.getString(i++);
                t.idcard = rs.getString(i++);
                t.address = rs.getString(i++);
                t.mobile = rs.getString(i++);
                t.type = rs.getInt(i++);
                t.content = rs.getString(i++);
                t.matter = rs.getInt(i++);
                t.attch = rs.getInt(i++);
                t.positive = rs.getInt(i++);
                t.derogatory = rs.getInt(i++);
                t.state = rs.getInt(i++);
                t.smember = rs.getInt(i++);
                t.stime = db.getDate(i++);
                t.ip = rs.getString(i++);
                t.useragent = rs.getString(i++);
                t.time = db.getDate(i++);
                c.put(t.smoke,t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM smoke WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        String sql;
        if(smoke < 1)
            sql = "INSERT INTO smoke(smoke,code,name,idcard,address,mobile,type,content,matter,attch,positive,derogatory,state,smember,stime,ip,useragent,time)VALUES(" + (smoke = Seq.get()) + "," + DbAdapter.cite(code) + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(idcard) + "," + DbAdapter.cite(address) + "," + DbAdapter.cite(mobile) + "," + type + "," + DbAdapter.cite(content) + "," + matter + "," + attch + "," + positive + "," + derogatory + "," + state + "," + smember + "," + DbAdapter.cite(stime) + "," + DbAdapter.cite(ip) + "," + DbAdapter.cite(useragent) + "," + DbAdapter.cite(time) + ")";
        else
            sql = "UPDATE smoke SET code=" + DbAdapter.cite(code) + ",name=" + DbAdapter.cite(name) + ",idcard=" + DbAdapter.cite(idcard) + ",address=" + DbAdapter.cite(address) + ",mobile=" + DbAdapter.cite(mobile) + ",type=" + type + ",content=" + DbAdapter.cite(content) + ",matter=" + matter + ",attch=" + attch + ",positive=" + positive + ",derogatory=" + derogatory + ",state=" + state + ",smember=" + smember + ",stime=" + DbAdapter.cite(stime) + ",ip=" + DbAdapter.cite(ip) + ",useragent=" + DbAdapter.cite(useragent) + ",time=" + DbAdapter.cite(time) + " WHERE smoke=" + smoke;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(smoke,sql);
        } finally
        {
            db.close();
        }
        c.remove(smoke);
    }

    public void delete() throws SQLException
    {
        DbAdapter.execute("DELETE FROM smoke WHERE smoke=" + smoke);
        c.remove(smoke);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter.execute("UPDATE smoke SET " + f + "=" + DbAdapter.cite(v) + " WHERE smoke=" + smoke);
        c.remove(smoke);
    }

    //
    public static void conv() throws SQLException
    {
        if(!Http.REAL_PATH.contains("webapps_tobacco"))
            return;
        ArrayList al = Attch.find(" AND path4 IS NULL AND attch IN(SELECT attch FROM smoke WHERE type=3) ORDER BY attch",0,100);
        for(int i = 0;i < al.size();i++)
        {
            Attch a = (Attch) al.get(i);
            Filex.logs("Smoke.txt","视频：" + a.attch + "　转换开始...");
            try
            {
                Video v = new Video(Http.REAL_PATH + a.content);
                a.width = v.width;
                a.height = v.height;
                a.numbers = v.duration;
                String prefix = "/res/tobacco/smoke/" + a.attch / 10000 + "/" + a.attch;
                //视频
                v.width = 0; //960
                v.height = 720;
                a.path = prefix + "_2.mp4";
                v.start(Http.REAL_PATH + a.path);
                a.content = v.error;
                //标清
                v = new Video(Http.REAL_PATH + a.path);
                v.width = 0; //640
                v.height = 480;
                a.path2 = prefix + "_3.mp4";
                v.start(Http.REAL_PATH + a.path2);
                //
                v = new Video(Http.REAL_PATH + a.path2);
                v.width = 0; //320
                v.height = 240;
                a.path3 = prefix + "_4.mp4";
                v.start(Http.REAL_PATH + a.path3);
                //缩略图
                a.path4 = prefix + "_5.jpg";
                v.pic(5,Http.REAL_PATH + a.path4);
                a.set();
            } catch(Throwable ex)
            {
                Filex.logs("Smoke.txt",ex);
            }
        }
    }

    public String getMobile()
    {
        if(mobile == null)
            return "";
        if(mobile.length() == 11)
        {
            StringBuilder sb = new StringBuilder(mobile);
            sb.insert(7,'-');
            sb.insert(3,'-');
            return sb.toString();
        }
        return mobile;
    }
}
