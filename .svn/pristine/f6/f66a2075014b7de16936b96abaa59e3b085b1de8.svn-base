package tea.entity.custom.papc;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;

public class PapcApp
{
    protected static Cache c = new Cache(50);
    public int papcapp; //数据申请
    public int member;
    public String name; //申请人
    public String email; //电子邮件
    public String tel; //电话
    public static String[] POSITION_TYPE =
            {"--","研究生","其他"};
    public int position; //身份
    public int country; //国家
    public String address; //地址
    public String org; //单位
    public String project; //项目或课题名称及来源
    public String leader; //课题负责人
    public String purpost; //数据应用说明
    public String content; //所需数据内容描述（地区、类群或馆别）
    public String commitment; //承诺
    public String ip; //IP地址
    public boolean deleted;
    public Date time; //申请时间

    public PapcApp(int papcapp)
    {
        this.papcapp = papcapp;
    }

    public static PapcApp find(int papcapp) throws SQLException
    {
        PapcApp t = (PapcApp) c.get(papcapp);
        if(t == null)
        {
            ArrayList al = find(" AND papcapp=" + papcapp,0,1);
            t = al.size() < 1 ? new PapcApp(papcapp) : (PapcApp) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT papcapp,member,name,email,tel,position,country,address,org,project,leader,purpost,content,commitment,ip,deleted,time FROM papcapp WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                PapcApp t = new PapcApp(rs.getInt(i++));
                t.member = rs.getInt(i++);
                t.name = rs.getString(i++);
                t.email = rs.getString(i++);
                t.tel = rs.getString(i++);
                t.position = rs.getInt(i++);
                t.country = rs.getInt(i++);
                t.address = rs.getString(i++);
                t.org = rs.getString(i++);
                t.project = rs.getString(i++);
                t.leader = rs.getString(i++);
                t.purpost = rs.getString(i++);
                t.content = rs.getString(i++);
                t.commitment = rs.getString(i++);
                t.ip = rs.getString(i++);
                t.deleted = rs.getBoolean(i++);
                t.time = db.getDate(i++);
                c.put(t.papcapp,t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM papcapp WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            if(papcapp < 1)
                db.executeUpdate("INSERT INTO papcapp(member,name,email,tel,position,country,address,org,project,leader,purpost,content,commitment,ip,deleted,time)VALUES(" + member + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(email) + "," + DbAdapter.cite(tel) + "," + position + "," + country + "," + DbAdapter.cite(address) + "," + DbAdapter.cite(org) + "," + DbAdapter.cite(project) + "," + DbAdapter.cite(leader) + "," + DbAdapter.cite(purpost) + "," + DbAdapter.cite(content) + "," + DbAdapter.cite(commitment) + "," + DbAdapter.cite(ip) + "," + DbAdapter.cite(deleted) + "," + DbAdapter.cite(time) + ")");
            else
                db.executeUpdate("UPDATE papcapp SET member=" + member + ",name=" + DbAdapter.cite(name) + ",email=" + DbAdapter.cite(email) + ",tel=" + DbAdapter.cite(tel) + ",position=" + position + ",country=" + country + ",address=" + DbAdapter.cite(address) + ",org=" + DbAdapter.cite(org) + ",project=" + DbAdapter.cite(project) + ",leader=" + DbAdapter.cite(leader) + ",purpost=" + DbAdapter.cite(purpost) + ",content=" + DbAdapter.cite(content) + ",commitment=" + DbAdapter.cite(commitment) + ",ip=" + DbAdapter.cite(ip) + ",deleted=" + DbAdapter.cite(deleted) + ",time=" + DbAdapter.cite(time) + " WHERE papcapp=" + papcapp);
        } finally
        {
            db.close();
        }
        c.remove(papcapp);
    }

    public void delete() throws SQLException
    {
        //DbAdapter.execute("DELETE FROM papcapp WHERE papcapp=" + papcapp);
        deleted = true;
        set("deleted","1");
        c.remove(papcapp);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter.execute("UPDATE papcapp SET " + f + "=" + DbAdapter.cite(v) + " WHERE papcapp=" + papcapp);
        c.remove(papcapp);
    }
}
