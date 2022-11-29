package tea.entity.lms;

import java.io.*;
import java.util.*;
import java.math.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;
import tea.entity.member.*;

//T_USER_MAST_USIGSJ_TAB
public class LmsMemberCourse
{
    protected static Cache _cache = new Cache(50);
    public int lmsmembercourse; //学员报考
    public int member; //用户ID
    public int lmsplan; //考试计划
    public String lmscourse0 = "|"; //实践课程信息
    public String lmscourse1 = "|"; //考机课程信息
    public float price; //报考费用
    public int lmspay; //缴费单
    public Date time; //报考时间

    public LmsMemberCourse(int lmsmembercourse)
    {
        this.lmsmembercourse = lmsmembercourse;
    }

    LmsMemberCourse(int member,int lmsplan)
    {
        this.member = member;
        this.lmsplan = lmsplan;
    }

    public static LmsMemberCourse find(int lmsmembercourse) throws SQLException
    {
        LmsMemberCourse t = (LmsMemberCourse) _cache.get(lmsmembercourse);
        if(t == null)
        {
            ArrayList al = find(" AND lmsmembercourse=" + lmsmembercourse,0,1);
            t = al.size() < 1 ? new LmsMemberCourse(lmsmembercourse) : (LmsMemberCourse) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT lmc.lmsmembercourse,lmc.member,lmc.lmsplan,lmc.lmscourse0,lmc.lmscourse1,lmc.price,lmc.lmspay,lmc.time FROM lmsmembercourse lmc" + tab(sql) + " WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                LmsMemberCourse t = new LmsMemberCourse(rs.getInt(i++));
                t.member = rs.getInt(i++);
                t.lmsplan = rs.getInt(i++);
                t.lmscourse0 = rs.getString(i++);
                t.lmscourse1 = rs.getString(i++);
                t.price = rs.getFloat(i++);
                t.lmspay = rs.getInt(i++);
                t.time = db.getDate(i++);
                _cache.put(t.lmsmembercourse,t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM lmsmembercourse lmc" + tab(sql) + " WHERE 1=1" + sql);
    }

    public static float sum(String sql) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT SUM(price) FROM lmsmembercourse lmc" + tab(sql.toString()) + " WHERE 1=1" + sql);
            return db.next() ? db.getFloat(1) : 0F;
        } finally
        {
            db.close();
        }
    }

    public static String tab(String sql)
    {
        StringBuilder sb = new StringBuilder();
        if(sql.contains(" AND p."))
            sb.append(" INNER JOIN Profile p ON p.profile=lmc.member");
        if(sql.contains(" AND pl."))
            sb.append(" INNER JOIN ProfileLayer pl ON pl.profile=p.profile");
        if(sql.contains(" AND lo.") || sql.contains(" ORDER BY lo."))
            sb.append(" INNER JOIN lmsorg lo ON lo.lmsorg=p.agent");
        if(sql.contains(" AND lc.") || sql.contains(" ORDER BY lc."))
            sb.append(" LEFT JOIN lmscert lc ON lc.lmscert=p.leveltype");
        return sb.toString();
    }

    public void set(DbAdapter db) throws SQLException
    {
        int j = db.executeUpdate("INSERT INTO lmsmembercourse(lmsmembercourse,member,lmsplan,lmscourse0,lmscourse1,time)VALUES(" + lmsmembercourse + "," + member + "," + lmsplan + "," + DbAdapter.cite(lmscourse0) + "," + DbAdapter.cite(lmscourse1) + "," + DbAdapter.cite(time) + ")");
        if(j < 1)
            db.executeUpdate("UPDATE lmsmembercourse SET member=" + member + ",lmsplan=" + lmsplan + ",lmscourse0=" + DbAdapter.cite(lmscourse0) + ",lmscourse1=" + DbAdapter.cite(lmscourse1) + ",time=" + DbAdapter.cite(time) + " WHERE lmsmembercourse=" + lmsmembercourse);
    }

    public void set() throws SQLException
    {
        String sql;
        if(lmsmembercourse < 1)
            sql = "INSERT INTO lmsmembercourse(lmsmembercourse,member,lmsplan,lmscourse0,lmscourse1,price,lmspay,time)VALUES(" + (lmsmembercourse = Seq.get()) + "," + member + "," + lmsplan + "," + DbAdapter.cite(lmscourse0) + "," + DbAdapter.cite(lmscourse1) + "," + price + "," + lmspay + "," + DbAdapter.cite(time) + ")";
        else
            sql = "UPDATE lmsmembercourse SET member=" + member + ",lmsplan=" + lmsplan + ",lmscourse0=" + DbAdapter.cite(lmscourse0) + ",lmscourse1=" + DbAdapter.cite(lmscourse1) + ",price=" + price + ",lmspay=" + lmspay + ",time=" + DbAdapter.cite(time) + " WHERE lmsmembercourse=" + lmsmembercourse;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(sql);
        } finally
        {
            db.close();
        }
        _cache.remove(lmsmembercourse);
    }

    public void delete() throws SQLException
    {
        DbAdapter.execute("DELETE FROM lmsmembercourse WHERE lmsmembercourse=" + lmsmembercourse);
        _cache.remove(lmsmembercourse);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter.execute("UPDATE lmsmembercourse SET " + f + "=" + DbAdapter.cite(v) + " WHERE lmsmembercourse=" + lmsmembercourse);
        _cache.remove(lmsmembercourse);
    }

    //
    public static LmsMemberCourse find(int member,int lmsplan) throws SQLException
    {
        ArrayList al = find(" AND member=" + member + " AND lmsplan=" + lmsplan,0,1);
        return al.size() < 1 ? new LmsMemberCourse(member,lmsplan) : (LmsMemberCourse) al.get(0);
    }

    public String getPrice() throws SQLException
    {
        Profile p = Profile.find(member);
        LmsOrg lo = LmsOrg.find(p.getAgent());
        int city = Integer.parseInt(String.valueOf(lo.city).substring(0,2));
        BigDecimal total = BigDecimal.ZERO;
        StringBuilder sb = new StringBuilder();
        LmsPrice pr = LmsPrice.find(lmsplan,city);

        //考试费(含实践费、机考费)
        String[] arr = lmscourse0.split("[|]");
        int count = Math.max(0,arr.length - 1);
        BigDecimal bd = new BigDecimal(String.valueOf(pr.price[5])).multiply(new BigDecimal(count));
        sb.append("<tr><td>考试：" + MT.f(bd.floatValue()));
        total = total.add(bd);
        //
        String str = lmscourse1;
        for(int i = 1;i < arr.length;i++)
        {
            str = str.replaceFirst("\\|" + arr[i] + "\\|","|");
            count -= LmsMemberCourse.count(" AND member=" + member + " AND lmsplan<" + lmsplan + " AND lmscourse0 LIKE " + DbAdapter.cite("%|" + arr[i] + "|%"));
        }
        //机考费(单独机考费用)
        bd = new BigDecimal(String.valueOf(pr.price[2])).multiply(new BigDecimal(Math.max(0,str.split("[|]").length - 1)));
        sb.append("<td>机考：" + MT.f(bd.floatValue()));
        total = total.add(bd);

        //管理费
        bd = new BigDecimal(String.valueOf(pr.price[6])).add(new BigDecimal(String.valueOf(pr.price[7]))).multiply(new BigDecimal(count));
        sb.append("<tr><td>管理：" + MT.f(bd.floatValue()));
        total = total.add(bd);
        //培训费
        bd = new BigDecimal(String.valueOf(pr.price[4])).multiply(new BigDecimal(count));
        sb.append("<td>培训：" + MT.f(bd.floatValue()));
        total = total.add(bd);
        this.price = total.floatValue();
        return sb.toString();
    }

}
