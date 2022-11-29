package tea.entity.member;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;
import tea.entity.member.*;
import tea.entity.node.*;

public class FriendList
{
    protected static Cache c = new Cache(50);
    public String member; //用户
    public String friend; //好友
    public static String[] TYPE_NAME =
            {"---默认---","未见过面","认识而已","一般朋友","好朋友","挚友"};
    public int type; //朋友分类
    public int groups; //好友分组
    public String remark; //备注
    public Date time; //添加时间

    public FriendList(String member,String friend)
    {
        this.member = member;
        this.friend = friend;
    }

    public static FriendList find(String member,String friend) throws SQLException
    {
        FriendList t = (FriendList) c.get(member + ":" + friend);
        if(t == null)
        {
            ArrayList al = find(" AND member=" + DbAdapter.cite(member) + " AND friend=" + DbAdapter.cite(friend),0,1);
            t = al.size() < 1 ? new FriendList(member,friend) : (FriendList) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
		System.out.println("SELECT member,friend,type,groups,remark,time FROM FriendList WHERE 1=1" + sql);
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT member,friend,type,groups,remark,time FROM FriendList WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                FriendList t = new FriendList(rs.getString(i++),rs.getString(i++));
                t.type = rs.getInt(i++);
                t.groups = rs.getInt(i++);
                t.remark = rs.getString(i++);
                t.time = db.getDate(i++);
                c.put(t.member,t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM FriendList WHERE 1=1" + sql);
    }

    public boolean set() throws SQLException
    {
        int i = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            i = db.executeUpdate("INSERT INTO FriendList(member,friend,type,groups,remark,time)VALUES(" + DbAdapter.cite(member) + "," + DbAdapter.cite(friend) + "," + type + "," + groups + "," + DbAdapter.cite(remark) + "," + DbAdapter.cite(time) + ")");
            if(i < 1)
            {
                db.executeUpdate("UPDATE FriendList SET type=" + type + ",groups=" + groups + ",remark=" + DbAdapter.cite(remark) + ",time=" + DbAdapter.cite(time) + " WHERE member=" + DbAdapter.cite(member) + " AND friend=" + DbAdapter.cite(friend));
            }
        } finally
        {
            db.close();
        }
        c.remove(member);
        return i == 1;
    }

    public void delete() throws SQLException
    {
        DbAdapter.execute("DELETE FROM FriendList WHERE member=" + DbAdapter.cite(member) + " AND friend=" + DbAdapter.cite(friend));
        c.remove(member);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter.execute("UPDATE FriendList SET " + f + "=" + DbAdapter.cite(v) + " WHERE member=" + DbAdapter.cite(member) + " AND friend=" + DbAdapter.cite(friend));
        c.remove(member);
    }

    //好友最新动态
    public static String dynamic(Http h,String member,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        Enumeration e = Node.find(" AND type=57 AND community=" + DbAdapter.cite(h.community) + " AND vcreator IN(SELECT friend FROM FriendList WHERE member=" + DbAdapter.cite(member) + ") ORDER BY node DESC",0,size);
        while(e.hasMoreElements())
        {
            int nid = ((Integer) e.nextElement()).intValue();
            Node n = Node.find(nid);
            String tmp = n.getCreator()._strR;
            al.add(new Arrayx("<tr><td><a href='###' onclick=\"f_act('home','" + tmp + "')\" class='member'>" + tmp + "</a>发表了<a href='/html/"+h.community+"/bbs/" + nid + "-" + h.language + ".htm' class='bbs' target='_blank'>" + n.getSubject(h.language) + "</a><td class='time'>" + MT.f(n.getTime(),1),n.getTime().getTime()));
        }
        e = BBSReply.find(" AND member IN(SELECT friend FROM FriendList WHERE member=" + DbAdapter.cite(member) + ") ORDER BY id DESC",0,size);
        while(e.hasMoreElements())
        {
            int rid = ((Integer) e.nextElement()).intValue();
            BBSReply r = BBSReply.find(rid);
            Node n = Node.find(r.getNode());
            String tmp = r.getMember();
            al.add(new Arrayx("<tr><td><a href='###' onclick=\"f_act('home','" + tmp + "')\" class='member'>" + tmp + "</a>回复了<a href='/html/"+h.community+"/bbs/" + n._nNode + "-" + h.language + ".htm' class='bbs' target='_blank'>" + n.getSubject(h.language) + "</a><td class='time'>" + MT.f(r.getTime(),1),r.getTime().getTime()));
        }
        Iterator it = FriendList.find(" AND member IN(SELECT friend FROM FriendList WHERE member=" + DbAdapter.cite(member) + ") ORDER BY time DESC",0,size).iterator();
        while(it.hasNext())
        {
            FriendList fl = (FriendList) it.next();
            al.add(new Arrayx("<tr><td><a href='###' onclick=\"f_act('home','" + fl.member + "')\" class='member'>" + fl.member + "</a>将<a href='###' onclick=\"f_act('home','" + fl.friend + "')\" class='friend'>" + fl.friend + "</a>加为好友<td class='time'>" + MT.f(fl.time,1),fl.time.getTime()));
        }
        StringBuilder sb = new StringBuilder();
        Arrayx[] ax = Arrayx.sort(al);
        for(int i = ax.length - 1;i > -1 && size > 0;i--,size--)
        {
            sb.append(ax[i].key);
        }
        return sb.toString();
    }
}
