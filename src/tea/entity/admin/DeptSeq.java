package tea.entity.admin;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;
import tea.entity.member.*;

public class DeptSeq
{
    protected static Cache c = new Cache(50);
    public int dept; //部门
    public int member; //用户
    public int sequence; //顺序
    public Date time;

    public DeptSeq(int dept,int member)
    {
        this.dept = dept;
        this.member = member;
    }

    public static DeptSeq find(int dept,int member) throws SQLException
    {
        DeptSeq t = (DeptSeq) c.get(dept + ":" + member);
        if(t == null)
        {
            ArrayList al = find(" AND dept=" + dept + " AND member=" + member,0,1);
            t = al.size() < 1 ? new DeptSeq(dept,member) : (DeptSeq) al.get(0);
        }
        return t;
    }


    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
//        	select dept,member,sequence,time from
//        	(
//        	SELECT dept,member,sequence,time FROM deptseq WHERE 1=1 and member  in (select p.profile from profile p inner join AdminUsrRole aur on p.profile=aur.member where aur.role like '%/34/%'  and p.member !='webmaster' and p.recycle=0) and dept in (select d.dept from dept d ,(select dept from Dept where sname like N'%水电九局%') d1 where d.father=d1.dept or d.dept=d1.dept and d.deleted=0)
//        	) d where not exists(select 1 from deptseq where member=d.member and dept<d.dept)

//        	StringBuffer sb = new StringBuffer();
//        	sb.append("select dept,member,sequence,time from (");
//        	sb.append("SELECT dept,member,sequence,time FROM deptseq WHERE 1=1 " + sql);
//        	sb.append(") d where not exists(select 1 from deptseq where member=d.member and dept<d.dept)");
//			java.sql.ResultSet rs = db.executeQuery(sb.toString() + " ORDER BY sequence",pos,size);
            java.sql.ResultSet rs = db.executeQuery("SELECT dept,member,sequence,time FROM deptseq WHERE 1=1" + sql + " ORDER BY sequence",pos,size);
            while(rs.next())
            {
                int i = 1;
                DeptSeq t = new DeptSeq(rs.getInt(i++),rs.getInt(i++));
                t.sequence = rs.getInt(i++);
                t.time = db.getDate(i++);
                c.put(t.dept + ":" + t.member,t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM deptseq WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        String sql;
        if(time == null)
            sql = "INSERT INTO deptseq(dept,member,sequence,time)VALUES(" + dept + "," + member + "," + sequence + "," + DbAdapter.cite(time = new Date()) + ")";
        else
            sql = "UPDATE deptseq SET sequence=" + sequence + ",time=" + DbAdapter.cite(time) + " WHERE dept=" + dept + " AND member=" + member;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(member,sql);
        } finally
        {
            db.close();
        }
        c.remove(dept);
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(member,"DELETE FROM deptseq WHERE dept=" + dept + " AND member=" + member);
        } finally
        {
            db.close();
        }
        c.remove(dept + ":" + member);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(member,"UPDATE deptseq SET " + f + "=" + DbAdapter.cite(v) + " WHERE dept=" + dept + " AND member=" + member);
        } finally
        {
            db.close();
        }
        c.remove(dept + ":" + member);
    }

    //
    public static void ref(String community) throws SQLException
    {
        int seq = (int) (System.currentTimeMillis() / 1000);
        StringBuilder sql = new StringBuilder();
        Iterator it = AdminUsrRole.find(" AND community=" + DbAdapter.cite(community),0,Integer.MAX_VALUE).iterator();
        while(it.hasNext())
        {
            AdminUsrRole aur = (AdminUsrRole) it.next();
            //Profile p = Profile.find(aur.member);
            //if(p.getTime() == null)
            //    continue;

            sql.append(" OR (dept NOT IN(");
            String[] arr = (aur.getUnit() + aur.getDept()).split("/");
            for(int i = 0;i < arr.length;i++)
            {
                int dept = Integer.parseInt(arr[i]);
                sql.append(dept).append(",");
                DeptSeq t = DeptSeq.find(dept,aur.member);
                if(t.time != null)
                    continue;
                t.sequence = seq++;
                t.set();
            }
            sql.append("0) AND member=" + aur.member + ")");
        }
        DbAdapter.execute("DELETE FROM deptseq WHERE" + sql.substring(3));
        c.clear();
    }

}
