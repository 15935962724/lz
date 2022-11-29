package tea.entity.yl.shop;

import java.sql.SQLException;
import java.util.ArrayList;

import tea.db.DbAdapter;
import tea.entity.Cache;
import tea.entity.Database;
import tea.entity.Seq;

/**
 * 资质审核
 * @author Administrator
 *
 */
public class ShopQualification {
	
	protected static Cache c = new Cache(50);
	public int id;
	public int member;//用户id
	public String realname;//真实姓名
	public int hospital_id;//医院id
	public int area;//地区
	public String address;//详细地址
	public String telphone;//电话
	public int qualification;//附件
	public int status;//0未提交，1已提交，未审核，2同过，3未通过  4 资质过期 5资质过期提交审核 6 资质过期审核未通过
	public static final String STATUS_ARR[] =
        {"未提交","已提交","通过","未通过","资质过期","过期提交审核","过期审核未通过"};
	public String returnv;//退回原因
	
	public int department;//科室
	public static final String DEPARTMENT_ARR[] =
        {"","核医学科","介入科","泌尿外科","放射科","CT室","磁共振室","超声室","肿瘤放疗科","肿瘤化疗与放射病科","心血管内科","呼吸内科","内分泌科","肾内科","血液内科","消化科","风湿免疫科","神经内科","急诊科","皮肤科","职业病科",
			"儿科","普通外科","骨科","胸外科","心脏外科","神经外科","运动医学研究所","生殖医学中心","眼科","耳鼻喉科","口腔科","疼痛医学中心",
			"超声诊断科","检验科","药剂科","手术室","采购供应科"};
	
	public String mobile;//手机
	
	public ShopQualification(int id)
    {
        this.id = id;
    }
	
	public static ShopQualification find(int id) throws SQLException
    {
		ShopQualification t = (ShopQualification) c.get(id);
        {
            ArrayList al = find(" AND id=" + id, 0, 1);
            t = al.size() < 1 ? new ShopQualification(id) : (ShopQualification) al.get(0);
        }
        return t;
    }
	
	public static ArrayList find(String sql, int pos, int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT sq.id,sq.member,sq.realname,sq.hospital_id,sq.area,sq.address,sq.telphone,sq.qualification,sq.status,sq.returnv,sq.department,sq.mobile FROM ShopQualification sq "+tab(sql)+" WHERE 1=1" + sql, pos, size);
            while (rs.next())
            {
                int i = 1;
                ShopQualification t = new ShopQualification(rs.getInt(i++));
                t.member = rs.getInt(i++);
                t.realname = db.getString(i++);
                t.hospital_id = rs.getInt(i++);
                t.area = rs.getInt(i++);
                t.address = db.getString(i++);
                t.telphone = db.getString(i++);
                t.qualification = rs.getInt(i++);
                t.status = rs.getInt(i++);
                t.returnv = db.getString(i++);
                t.department = rs.getInt(i++);
                t.mobile = db.getString(i++);
                c.put(t.id, t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM ShopQualification sq "+tab(sql)+" WHERE 1=1" + sql);
    }
	
	public void set() throws SQLException
    {
        String sql;
        if (id < 1)
            sql = "INSERT INTO ShopQualification(id,member,realname,hospital_id,area,address,telphone,qualification,status,returnv,department,mobile)VALUES(" + (id = Seq.get()) +","+member+","+Database.cite(realname)+","+hospital_id+","+area+","+Database.cite(address)+","+Database.cite(telphone)+","+qualification+","+status+","+Database.cite(returnv)+","+department+","+Database.cite(mobile)+")";
        else
            sql = "UPDATE ShopQualification SET member="+member+",realname="+Database.cite(realname)+",hospital_id="+hospital_id+",area="+area+",address="+Database.cite(address)+",telphone="+Database.cite(telphone)+",qualification="+qualification+",status="+status+",returnv="+Database.cite(returnv)+",department="+department+",mobile="+Database.cite(mobile)+" WHERE id=" + id;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(id, sql);
        } finally
        {
            db.close();
        }
        c.remove(id);
    }
	
	public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(id, "DELETE FROM ShopQualification WHERE id=" + id);
        } finally
        {
            db.close();
        }
        c.remove(id);
    }

    public void set(String f, String v) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(id, "UPDATE ShopQualification SET " + f + "=" + DbAdapter.cite(v) + " WHERE id=" + id);
        } finally
        {
            db.close();
        }
        c.remove(id);
    }
    
    public static ShopQualification findByMember(int id) throws SQLException
    {
		ShopQualification t = null;
            ArrayList al = find(" AND member=" + id, 0, 1);
            t = al.size() < 1 ? new ShopQualification(0) : (ShopQualification) al.get(0);
        return t;
    }
    
    static String tab(String sql)
    {
        StringBuilder sb = new StringBuilder();
        if(sql.contains(" AND p."))
            sb.append(" INNER JOIN Profile p ON sq.member=p.profile");
        return sb.toString();
    }
    /**
     * 更新资质
     */
    public static void updateUserQua(){
    	DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update profile set qualification = 0 where DATEDIFF(d,getdate(),validity) = 0");
            db.executeUpdate("update shopqualification set status = 4 where member in (select profile from profile where DATEDIFF(d,getdate(),validity) = 0)");
        } catch (SQLException e) {
			e.printStackTrace();
		} finally
        {
            db.close();
        }
    }
    
}
