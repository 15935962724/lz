package tea.entity.member;

import tea.db.DbAdapter;
import tea.entity.Cache;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;

//短消息
public class Message
{
    protected static Cache c = new Cache(50);
    public static final String[] FOLDER_TYPE =
            {"收件箱","发件箱","草稿箱","废纸箱"}; //9:彻底删除
    public int message;
    public String community;
    public int member; //发件人
    public String tmember = "|"; //收件人
    public String tdept = "|"; //收件部门
    public String tinvite = "|"; //收件人_学者
    public String tmeeting = "|"; //收件人_论坛
    public String tzone = "|"; //收件人_地域
    public String zmeeting = "|"; //地域 区分 论坛
    public String[] tname = new String[2]; //收件人姓名
    public String reader = "|"; //已读会员
    public String subject; //主题
    public String content; //内容
    public String url; //网址
    public String attch = "|"; //附件
    public boolean receipt; //回执
    public Date time; //发送时间

    public Message(int message)
    {
        this.message = message;
    }

    public static Message find(int message) throws SQLException
    {
        Message t = (Message) c.get(message);
        if(t == null)
        {
            ArrayList al = find(" AND message=" + message,0,1);
            t = al.size() < 1 ? new Message(message) : (Message) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT message,community,member,tmember,tdept,tinvite,tmeeting,tzone,zmeeting,tname0,tname1,reader,subject,content,url,attch,receipt,time FROM message m WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                Message t = new Message(rs.getInt(i++));
                t.community = rs.getString(i++);
                t.member = rs.getInt(i++);
                t.tmember = rs.getString(i++);
                t.tdept = rs.getString(i++);
                t.tinvite = rs.getString(i++);
                t.tmeeting = rs.getString(i++);
                t.tzone = rs.getString(i++);
                t.zmeeting = rs.getString(i++);
                t.tname[0] = rs.getString(i++);
                t.tname[1] = rs.getString(i++);
                t.reader = rs.getString(i++);
                t.subject = rs.getString(i++);
                t.content = rs.getString(i++);
                t.url = rs.getString(i++);
                t.attch = rs.getString(i++);
                t.receipt = rs.getBoolean(i++);
                t.time = db.getDate(i++);
                c.put(t.message,t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM message m WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            if(message < 1)
            {
                db.executeUpdate("INSERT INTO message(member,community,tmember,tdept,tinvite,tmeeting,tzone,zmeeting,tname0,tname1,reader,subject,content,url,attch,receipt,time)VALUES(" + member + "," + DbAdapter.cite(community) + "," + DbAdapter.cite(tmember) + "," + DbAdapter.cite(tdept) + "," + DbAdapter.cite(tinvite) + "," + DbAdapter.cite(tmeeting) + "," + DbAdapter.cite(tzone) + "," + DbAdapter.cite(zmeeting) + "," + DbAdapter.cite(tname[0]) + "," + DbAdapter.cite(tname[1]) + "," + DbAdapter.cite(reader) + "," + DbAdapter.cite(subject) + "," + DbAdapter.cite(content) + "," + DbAdapter.cite(url) + "," + DbAdapter.cite(attch) + "," + DbAdapter.cite(receipt) + "," + DbAdapter.cite(time) + ")");
                java.sql.ResultSet rs = db.executeQuery("SELECT MAX(message) FROM message WHERE member=" + member,0,1);
                message = rs.next() ? rs.getInt(1) : 0;
                rs.close();
            } else
                db.executeUpdate("UPDATE message SET tmember=" + DbAdapter.cite(tmember) + ",tdept=" + DbAdapter.cite(tdept) + ",tinvite=" + DbAdapter.cite(tinvite) + ",tmeeting=" + DbAdapter.cite(tmeeting) + ",tzone=" + DbAdapter.cite(tzone) + ",zmeeting=" + DbAdapter.cite(zmeeting) + ",tname0=" + DbAdapter.cite(tname[0]) + ",tname1=" + DbAdapter.cite(tname[1]) + ",reader=" + DbAdapter.cite(reader) + ",subject=" + DbAdapter.cite(subject) + ",content=" + DbAdapter.cite(content) + ",url=" + DbAdapter.cite(url) + ",attch=" + DbAdapter.cite(attch) + ",receipt=" + DbAdapter.cite(receipt) + ",time=" + DbAdapter.cite(time) + " WHERE message=" + message);
        } finally
        {
            db.close();
        }
        c.remove(message);
    }

    public void delete() throws SQLException
    {
        DbAdapter.execute("DELETE FROM message WHERE message=" + message);
        c.remove(message);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter.execute("UPDATE message SET " + f + "=" + DbAdapter.cite(v) + " WHERE message=" + message);
        c.remove(message);
    }

    //
    public static String sql(int folder,int member) throws SQLException
    {
        StringBuffer sql = new StringBuffer();
        if(folder == 0)
        { //member 是收件人 && messagefolder表中不存在此条记录
            sql.append(" AND time>" + DbAdapter.cite(Profile.find(member).getTime()) + " AND( ( (tmember='|' AND tdept='|' AND tinvite='|' AND tmeeting='|' AND tzone='|') OR tdept LIKE " + DbAdapter.cite("%|" + "Member.find(member).unit" + "|%") + " OR tmember LIKE " + DbAdapter.cite("%|" + member + "|%") + ") AND NOT EXISTS(SELECT mf.message FROM messagefolder mf WHERE mf.message=m.message AND mf.member=" + member + ") OR");
        } else
        {
            sql.append(" AND(");
        }
        sql.append(" EXISTS(SELECT mf.message FROM messagefolder mf WHERE mf.message=m.message AND mf.member=" + member + " AND mf.folder=" + folder + "))");
        return sql.toString();
    }

//	public static String sql(int folder, int invite) throws SQLException
//	{
//		StringBuffer sql = new StringBuffer();
//		if (folder == 0)
//		{ //member 是收件人 && messagefolder表中不存在此条记录
//			Invite in = Invite.find(invite);
//			sql.append(" AND time>" + DbAdapter.cite(in.time) + " AND( ( (tmember='|' AND tdept='|' AND tinvite='|' AND tmeeting='|' AND tzone='|')");
//			if (in.state == 7)
//				sql.append(" OR tmeeting LIKE " + DbAdapter.cite("%|" + in.meeting + "|%"));
//
//			sql.append(" OR((tzone LIKE '%|0|%' OR tzone LIKE '%|" + in.zone + "|%')AND(zmeeting='|' OR zmeeting LIKE '%|" + in.meeting + "|%'))");
//			sql.append(" OR tinvite LIKE " + DbAdapter.cite("%|" + invite + "|%") + ") AND NOT EXISTS(SELECT mf.message FROM messagefolder mf WHERE mf.message=m.message AND mf.member='" + invite + "') OR");
//		} else
//		{
//			sql.append(" AND(");
//		}
//		sql.append(" EXISTS(SELECT mf.message FROM messagefolder mf WHERE mf.message=m.message AND mf.member='" + invite + "' AND mf.folder=" + folder + "))");
//		return sql.toString();
//	}

    public void setReader(int member) throws SQLException
    {
        if(member > 0)
            reader += member + "|";
        set("reader",reader);
        if(receipt)
        {
            Message m = new Message(0);
            m.member = member;
            m.tmember = "|" + this.member + "|";
            m.subject = "回执：" + subject;
            m.content = "本消息是<a href='/jsp/message/MessageView.jsp?message=" + message + "'>" + subject + "</a>的回执，由系统发出!";
            m.time = new Date();
            m.set();
        }
    }

    public boolean isReader(int member)
    {
        return reader.indexOf("|" + member + "|") != -1;
    }

    public String getFrName(int lang) throws SQLException
    {
        return Profile.find(member).getName(lang);
    }

    public String getToName(int lang) throws SQLException
    {
        StringBuffer sb = new StringBuffer();
        String[] arr = tdept.split("[|]");
//        for(int i = 1;i < arr.length;i++)
//        {
//            sb.append(Member.UNIT_TYPE[Integer.parseInt(arr[i])]).append("；");
//        }
        arr = tmember.split("[|]");
        for(int i = 1;i < arr.length;i++)
        {
            String name = Profile.find(Integer.parseInt(arr[i])).getMember();
            sb.append(name).append("；");
        }
        return sb.length() < 1 ? "所有人员" : sb.toString();
    }

    //兼容 旧版本
    public static int create(String community,String fmember,String tmember,int language,String subject,String content) throws SQLException
    {
        return create(community,5,fmember,tmember,"/","/",0,"",language,subject,content);
    }

    public static int create(String community,int folder,String fmember,String tmember,String trole,String tunit,int hint,String url,int language,String subject,String content) throws SQLException
    {
        Message t = new Message(0);
        t.community = community;
        t.member = Profile.find(fmember).getProfile();
        t.tmember = tmember;
        t.tzone = trole;
        t.tdept = tunit;
        t.url = url;
        t.subject = subject;
        t.content = subject;
        t.time = new Date();
        t.set();
        return t.member;
    }

}
