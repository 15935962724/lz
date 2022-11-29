package tea.entity.weixin;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;
import org.json.*;
import tea.entity.site.*;

public class WxMessenger
{
    protected static Cache c = new Cache(50);
    public long wxmessenger; //微信消息
    public String community; //社区
    public static String[] TYPE_CODE =
            {"--","text","image","voice","video","location","link","news"};//verify
    public static String[] TYPE_NAME =
            {"--","文本","图片","声音","视频","地图","链接","新闻","扫一扫"};
    public int type; //类型
    public long fuser; //发送方
    public long tuser; //接收方
    public String title; //标题
    public String content; //内容
    public String url; //网址
    public double x; //地理位置纬度
    public double y; //地理位置经度
    public int scale; //地图缩放大小
    public String source; //来源
    public int status; //状态 2:发送 4:收到
    public int seq; //微信后台的ID号
    public Date star; //星标
    public Date time; //创建时间

    public WxMessenger(long wxmessenger)
    {
        this.wxmessenger = wxmessenger;
    }

    public static WxMessenger find(long wxmessenger) throws SQLException
    {
        WxMessenger t = (WxMessenger) c.get(wxmessenger);
        if(t == null)
        {
            ArrayList al = find(" AND wxmessenger=" + wxmessenger,0,1);
            t = al.size() < 1 ? new WxMessenger(wxmessenger) : (WxMessenger) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT wm.wxmessenger,wm.community,wm.type,wm.fuser,wm.tuser,wm.title,wm.content,wm.url,wm.x,wm.y,wm.scale,wm.source,wm.status,wm.seq,wm.star,wm.time FROM WxMessenger wm" + tab(sql) + " WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                WxMessenger t = new WxMessenger(rs.getLong(i++));
                t.community = rs.getString(i++);
                t.type = rs.getInt(i++);
                t.fuser = rs.getLong(i++);
                t.tuser = rs.getLong(i++);
                t.title = rs.getString(i++);
                t.content = rs.getString(i++);
                t.url = rs.getString(i++);
                t.x = rs.getDouble(i++);
                t.y = rs.getDouble(i++);
                t.scale = rs.getInt(i++);
                t.source = rs.getString(i++);
                t.status = rs.getInt(i++);
                t.seq = rs.getInt(i++);
                t.star = db.getDate(i++);
                t.time = db.getDate(i++);
                c.put(t.wxmessenger,t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM WxMessenger wm" + tab(sql) + " WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            int j = db.executeUpdate(0,"INSERT INTO WxMessenger(wxmessenger,community,type,fuser,tuser,title,content,url,x,y,scale,source,status,seq,star,time)VALUES(" + wxmessenger + "," + DbAdapter.cite(community) + "," + type + "," + fuser + "," + tuser + "," + DbAdapter.cite(title) + "," + DbAdapter.cite(content) + "," + DbAdapter.cite(url) + "," + x + "," + y + "," + scale + "," + DbAdapter.cite(source) + "," + status + "," + seq + "," + DbAdapter.cite(star) + "," + DbAdapter.cite(time) + ")");
            if(j < 1)
                db.executeUpdate(0,"UPDATE WxMessenger SET community=" + DbAdapter.cite(community) + ",type=" + type + ",fuser=" + fuser + ",tuser=" + tuser + ",title=" + DbAdapter.cite(title) + ",content=" + DbAdapter.cite(content) + ",url=" + DbAdapter.cite(url) + ",x=" + x + ",y=" + y + ",scale=" + scale + ",source=" + DbAdapter.cite(source) + ",status=" + status + ",seq=" + seq + ",star=" + DbAdapter.cite(star) + ",time=" + DbAdapter.cite(time) + " WHERE wxmessenger=" + wxmessenger);
        } finally
        {
            db.close();
        }
        c.remove(wxmessenger);
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(0,"DELETE FROM WxMessenger WHERE wxmessenger=" + wxmessenger);
        } finally
        {
            db.close();
        }
        c.remove(wxmessenger);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(0,"UPDATE WxMessenger SET " + f + "=" + DbAdapter.cite(v) + " WHERE wxmessenger=" + wxmessenger);
        } finally
        {
            db.close();
        }
        c.remove(wxmessenger);
    }

    public void set(String f,Date v) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(0,"UPDATE WxMessenger SET " + f + "=" + DbAdapter.cite(v) + " WHERE wxmessenger=" + wxmessenger);
        } finally
        {
            db.close();
        }
        c.remove(wxmessenger);
    }

    //
    private static String tab(String sql)
    {
        StringBuilder sb = new StringBuilder();
        if(sql.contains(" AND wu."))
            sb.append(" INNER JOIN WxUser fu ON fu.wxuser=wm.fuser");
        return sb.toString();
    }

    public String getContent()
    {
        if(type == 2)
            return "<a href=javascript:mt.img('" + url + "')><img src='" + url + "' width='100' /></a>";
        else if(type == 3)
        {
            String str = "/tea/mt/audio.swf?soundFile=" + url + "&bg=0x97B7C8&leftbg=0x8C0000&lefticon=0xF2F2F2&rightbg=0x3E5F7D&rightbghover=0xF9BC00&righticon=0xF2F2F2&righticonhover=0xFFFFFF&text=0x333333&slider=0x8C0000&track=0x97B7C8&border=0x97B7C8&loader=0x3E5F7D&autostart=0&loop=no";
            return "<object type='application/x-shockwave-flash' data='" + str + "' codebase='#version=1' width='290' height='24'>"
                    + "<param name='movie' value='" + str + "' />"
                    //+ "<param name='quality' value='high' />"
                    + "<param name='wmode' value='transparent' />"
                    //+ "<embed src='" + str + "' quality='high' pluginspage='http://www.macromedia.com/go/getflashplayer' type='application/x-shockwave-flash' width='290' height='24'></embed>"
                    + "</object>";
        } else if(type == 4)
        {
            return "<object type='application/x-shockwave-flash' data='/tea/image/flv/CuPlayer.swf' codebase='#version=1' width='200' height='110'>"
                    + "<param name='movie' value='/tea/image/flv/CuPlayer.swf' />"
                    + "<param name='allowfullscreen' value='true' />"
                    + "<param name='flashvars' value='CuPlayerFile=" + url + "&CuPlayerImage_=<%=t.path3%>&CuPlayerLogo_=/res/Home/structure/logo_60.png&CuPlayerShowImage=true&CuPlayerWidth=200&CuPlayerHeight=110&CuPlayerAutoPlay=false&CuPlayerAutoRepeat=false&CuPlayerShowControl=true&CuPlayerAutoHideControl=false&CuPlayerAutoHideTime=6&CuPlayerVolume=80&CuPlayerGetNext=false' />"
                    + "</object>";
        }
        return WxUser.f(content);
    }
}
