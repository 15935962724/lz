package tea.entity.lms;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;

//TM_ORG_PEOPLE_TAB
public class LmsPeople
{
    protected static Cache _cache = new Cache(50);
    public int lmspeople;
    public int lmsorg; //省助学发展机构
    public String name; //姓名
    public static String[] SEX_TYPE =
            {"--","男","女"};
    public int sex; //性别
    public int age; //年龄
    public String nation; //民族
    public Date brithday; //出生日期
    public static String[] LMSPEOPLE_TYPE =
            {"--","法定代表人","项目负责人","主要工作人员"};
    public int type; //类型
    public String address; //联系地址
    public String telphone; //办公电话
    public String cellphone; //手机
    public String fax; //传真,remark1
    public String mail; //Email,remark2
    public String duty;
    public String remark1;
    public String remark2;
    public String remark3;
    public String remark4;
    public String remark5;

    public LmsPeople(int lmspeople)
    {
        this.lmspeople = lmspeople;
    }

    public static LmsPeople find(int lmspeople) throws SQLException
    {
        LmsPeople t = (LmsPeople) _cache.get(lmspeople);
        if(t == null)
        {
            ArrayList al = find(" AND lmspeople=" + lmspeople,0,1);
            t = al.size() < 1 ? new LmsPeople(lmspeople) : (LmsPeople) al.get(0);
        }
        return t;
    }

    public static LmsPeople find(int lmsorg,int type) throws SQLException
    {
        ArrayList al = find(" AND lmsorg=" + lmsorg + " AND type=" + type,0,1);
        return al.size() < 1 ? new LmsPeople(0) : (LmsPeople) al.get(0);
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT lmspeople,lmsorg,name,sex,age,nation,brithday,type,address,telphone,cellphone,fax,mail,duty,remark1,remark2,remark3,remark4,remark5 FROM lmspeople WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                LmsPeople t = new LmsPeople(rs.getInt(i++));
                t.lmsorg = rs.getInt(i++);
                t.name = rs.getString(i++);
                t.sex = rs.getInt(i++);
                t.age = rs.getInt(i++);
                t.nation = rs.getString(i++);
                t.brithday = db.getDate(i++);
                t.type = rs.getInt(i++);
                t.address = rs.getString(i++);
                t.telphone = rs.getString(i++);
                t.cellphone = rs.getString(i++);
                t.fax = rs.getString(i++);
                t.mail = rs.getString(i++);
                t.duty = rs.getString(i++);
                t.remark1 = rs.getString(i++);
                t.remark2 = rs.getString(i++);
                t.remark3 = rs.getString(i++);
                t.remark4 = rs.getString(i++);
                t.remark5 = rs.getString(i++);
                _cache.put(t.lmspeople,t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM lmspeople WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        String sql;
        if(lmspeople < 1)
            sql = "INSERT INTO lmspeople(lmspeople,lmsorg,name,sex,age,nation,brithday,type,address,telphone,cellphone,fax,mail,duty,remark1,remark2,remark3,remark4,remark5)VALUES(" + (lmspeople = Seq.get()) + "," + lmsorg + "," + DbAdapter.cite(name) + "," + sex + "," + age + "," + DbAdapter.cite(nation) + "," + DbAdapter.cite(brithday) + "," + type + "," + DbAdapter.cite(address) + "," + DbAdapter.cite(telphone) + "," + DbAdapter.cite(cellphone) + "," + DbAdapter.cite(fax) + "," + DbAdapter.cite(mail) + "," + DbAdapter.cite(duty) + "," + DbAdapter.cite(remark1) + "," + DbAdapter.cite(remark2) + "," + DbAdapter.cite(remark3) + "," + DbAdapter.cite(remark4) + "," + DbAdapter.cite(remark5) + ")";
        else
            sql = "UPDATE lmspeople SET lmsorg=" + lmsorg + ",name=" + DbAdapter.cite(name) + ",sex=" + sex + ",age=" + age + ",nation=" + DbAdapter.cite(nation) + ",brithday=" + DbAdapter.cite(brithday) + ",type=" + type + ",address=" + DbAdapter.cite(address) + ",telphone=" + DbAdapter.cite(telphone) + ",cellphone=" + DbAdapter.cite(cellphone) + ",fax=" + DbAdapter.cite(fax) + ",mail=" + DbAdapter.cite(mail) + ",duty=" + DbAdapter.cite(duty) + ",remark1=" + DbAdapter.cite(remark1) + ",remark2=" + DbAdapter.cite(remark2) + ",remark3=" + DbAdapter.cite(remark3) + ",remark4=" + DbAdapter.cite(remark4) + ",remark5=" + DbAdapter.cite(remark5) + " WHERE lmspeople=" + lmspeople;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(sql);
        } finally
        {
            db.close();
        }
        _cache.remove(lmspeople);
    }

    public void delete() throws SQLException
    {
        DbAdapter.execute("DELETE FROM lmspeople WHERE lmspeople=" + lmspeople);
        _cache.remove(lmspeople);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter.execute("UPDATE lmspeople SET " + f + "=" + DbAdapter.cite(v) + " WHERE lmspeople=" + lmspeople);
        _cache.remove(lmspeople);
    }
}
