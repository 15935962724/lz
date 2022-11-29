package tea.entity.bbs;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;
import tea.entity.member.*;
import tea.entity.admin.*;
import java.util.regex.*;

public class BBSForum
{
    protected static Cache c = new Cache(50);
    public int node;
    //积分相关
    public int topic = 5; //发帖加分
    public int reply = 2; //回复加分
    public int del = 1000; //版主删贴扣分
    public int move = 2; //版主移贴扣分
    public int parktop = 10; //置顶加分
    public int qui = 10; //精华加分
    public int hot = 10; //热帖加分
    public int attach = 10; //附件加分
    public int down = 15; //下载附件扣分
    public int activity = 8; //发起活动
    public int ajoin = 3; //参加活动

    //等级的权限
    public int lview;
    public int lreply;
    public int ltopic;
    public int levent;
    public int lpoll;
    public int lactivity;
    public int lrec;
    public int ljob;
    public String lattach;
    //角色的权限
    public String rview = "|";
    public String rreply = "|";
    public String rtopic = "|";
    public String revent = "|";
    public String rpoll = "|";
    public String ractivity = "|";
    public String rrec = "|";
    public String rjob = "|";
    public String rattach;
    //统计
    public int ctopic;
    public int creply;
    public int chits;

    public BBSForum(int node)
    {
        this.node = node;
    }

    public static BBSForum find(int node) throws SQLException
    {
        BBSForum t = (BBSForum) c.get(node);
        if(t == null)
        {
            ArrayList al = find(" AND node=" + node,0,1);
            t = al.size() < 1 ? new BBSForum(node) : (BBSForum) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT node,topic,reply,del,move,parktop,qui,hot,attach,down,activity,ajoin,lview,lreply,ltopic,levent,lattach,lpoll,lactivity,lrec,ljob,rview,rreply,rtopic,revent,rpoll,ractivity,rrec,rjob,rattach,ctopic,creply,chits FROM BBSForum WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                BBSForum t = new BBSForum(rs.getInt(i++));
                t.topic = rs.getInt(i++);
                t.reply = rs.getInt(i++);
                t.del = rs.getInt(i++);
                t.move = rs.getInt(i++);
                t.parktop = rs.getInt(i++);
                t.qui = rs.getInt(i++);
                t.hot = rs.getInt(i++);
                t.attach = rs.getInt(i++);
                t.down = rs.getInt(i++);
                t.activity = rs.getInt(i++);
                t.ajoin = rs.getInt(i++);
                //
                t.lview = rs.getInt(i++);
                t.lreply = rs.getInt(i++);
                t.ltopic = rs.getInt(i++);
                t.levent = rs.getInt(i++);
                t.lattach = rs.getString(i++);
                t.lpoll = rs.getInt(i++);
                t.lactivity = rs.getInt(i++);
                t.lrec = rs.getInt(i++);
                t.ljob = rs.getInt(i++);
                //
                t.rview = rs.getString(i++);
                t.rreply = rs.getString(i++);
                t.rtopic = rs.getString(i++);
                t.revent = rs.getString(i++);
                t.rpoll = rs.getString(i++);
                t.ractivity = rs.getString(i++);
                t.rrec = rs.getString(i++);
                t.rjob = rs.getString(i++);
                t.rattach = rs.getString(i++);
                //
                t.ctopic = rs.getInt(i++);
                t.creply = rs.getInt(i++);
                t.chits = rs.getInt(i++);
                c.put(t.node,t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM BBSForum WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            int i = db.executeUpdate("INSERT INTO BBSForum(node,topic,reply,del,move,parktop,qui,hot,attach,down,activity,ajoin,lview,lreply,ltopic,levent,lattach,lpoll,lactivity,lrec,ljob,rview,rreply,rtopic,revent,rpoll,ractivity,rrec,rjob,rattach,ctopic,creply,chits)VALUES(" + node + "," + topic + "," + reply + "," + del + "," + move + "," + parktop + "," + qui + "," + hot + "," + attach + "," + down + "," + activity + "," + ajoin + "," + lview + "," + lreply + "," + ltopic + "," + levent + "," + DbAdapter.cite(lattach) + "," + lpoll + "," + lactivity + "," + lrec + "," + ljob + "," + DbAdapter.cite(rview) + "," + DbAdapter.cite(rreply) + "," + DbAdapter.cite(rtopic) + "," + DbAdapter.cite(revent) + "," + DbAdapter.cite(rpoll) + "," + DbAdapter.cite(ractivity) + "," +
                                     DbAdapter.cite(rrec) + "," + DbAdapter.cite(rjob) + "," + DbAdapter.cite(rattach) + "," + ctopic + "," + creply + "," + chits + ")");
            if(i < 1)
            {
                db.executeUpdate("UPDATE BBSForum SET topic=" + topic + ",reply=" + reply + ",del=" + del + ",move=" + move + ",parktop=" + parktop + ",qui=" + qui + ",hot=" + hot + ",attach=" + attach + ",down=" + down + ",activity=" + activity + ",ajoin=" + ajoin + ",lview=" + lview + ",lreply=" + lreply + ",ltopic=" + ltopic + ",levent=" + levent + ",lattach=" + DbAdapter.cite(lattach) + ",lpoll=" + lpoll + ",lactivity=" + lactivity + ",lrec=" + lrec + ",ljob=" + ljob + ",rview=" + DbAdapter.cite(rview) + ",rreply=" + DbAdapter.cite(rreply) + ",rtopic=" + DbAdapter.cite(rtopic) + ",revent=" + DbAdapter.cite(revent) + ",rpoll=" + DbAdapter.cite(rpoll) + ",ractivity=" + DbAdapter.cite(ractivity) + ",rrec=" + DbAdapter.cite(rrec) + ",rjob=" + DbAdapter.cite(rjob) + ",rattach=" +
                                 DbAdapter.cite(rattach) + ",ctopic=" + ctopic + ",creply=" + creply + ",chits=" + chits + " WHERE node=" + node);
            }
        } finally
        {
            db.close();
        }
        c.remove(node);
    }

    public void delete() throws SQLException
    {
        DbAdapter.execute("DELETE FROM BBSForum WHERE node=" + node);
        c.remove(node);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter.execute("UPDATE BBSForum SET " + f + "=" + DbAdapter.cite(v) + " WHERE node=" + node);
        c.remove(node);
    }

    //
    public static Enumeration findByCommunity(String community) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT n.node FROM Node n,Category c WHERE n.node=c.node AND n.type=1 AND c.category=57 AND n.finished=1 AND n.community=" + DbAdapter.cite(community));
            while(db.next())
            {
                v.addElement(db.getInt(1));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public int getLAttach(int bbslevel)
    {
        if(lattach == null)
            return 10;
        int j = 0;
        Matcher m = Pattern.compile("/" + bbslevel + ":(\\d+)/").matcher(lattach);
        if(m.find())
            j = Integer.parseInt(m.group(1));
        return j;
    }

    public boolean isAuth(String community,String member,int l,String r) throws SQLException
    {
        if(l != 0 && member == null)
            return false;
        // 游客 || 等级 || 角色
        return l == 0 || (l != -1 && Profile.find(member).getIntegral() >= BBSLevel.find(l).getPoint()) || (r.length() > 2 && isE(AdminUsrRole.find(community,member).getRole(),r));
    }

    private boolean isE(String role,String s)
    {
        String[] a = s.split("[|]");
        for(int i = 1;i < a.length;i++)
        {
            if(role.indexOf("/" + a[i] + "/") != -1)
                return true;
        }
        return false;
    }


    //历史保留
    public int getTopic()
    {
        return topic;
    }

    public int getReply()
    {
        return reply;
    }

    public int getDel()
    {
        return del;
    }

    public int getMove()
    {
        return move;
    }

    public int getQui()
    {
        return qui;
    }

    public int getHot()
    {
        return hot;
    }

    public int getAttach()
    {
        return attach;
    }

    public int getDown()
    {
        return down;
    }

    public int getNode()
    {
        return node;
    }

    public String getLAttach()
    {
        return lattach;
    }


    public int getLReply()
    {
        return lreply;
    }

    public int getLTopic()
    {
        return ltopic;
    }

    public int getLView()
    {
        return lview;
    }

}
