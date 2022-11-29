package tea.entity.admin;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;
import tea.entity.member.*;
import tea.entity.util.*;
import jxl.*;

public class SupExpert
{
    public static Cache c = new Cache(50);
    public int expert; //专家==Profile.profile
    public int dept; //所属部门
    public static String[] EXPERT_TYPE =
            {"--","内部专家","外部专家"};
    public static String[] EXPERT_AUDIT =
        {"--","未审核","已通过","未通过"};
    public int type; //类型
    public String resume; //主要专业技术简历
    public String qualification = "|"; //所精通的产品分类
    public boolean deleted; //是否已删除
    public Date time;
    private int audit;

    public SupExpert(int expert)
    {
        this.expert = expert;
    }

    public static SupExpert find(int expert) throws SQLException
    {
        SupExpert t = (SupExpert) c.get(expert);
        if(t == null)
        {
            ArrayList al = find(" AND expert=" + expert,0,1);
            t = al.size() < 1 ? new SupExpert(expert) : (SupExpert) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT se.expert,se.dept,se.type,se.resume,se.qualification,se.deleted,se.time,se.audit FROM supexpert se" + tab(sql) + " WHERE se.deleted=0" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                SupExpert t = new SupExpert(rs.getInt(i++));
                t.dept = rs.getInt(i++);
                t.type = rs.getInt(i++);
                t.resume = rs.getString(i++);
                t.qualification = rs.getString(i++);
                t.deleted = rs.getBoolean(i++);
                t.time = db.getDate(i++);
                t.audit = db.getInt(i++);
                c.put(t.expert,t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM supexpert se" + tab(sql) + " WHERE se.deleted=0" + sql);
    }

    public void set() throws SQLException
    {
        String sql;
        if(time == null)
        {
            time = new Date();
            sql = "INSERT INTO supexpert(expert,dept,type,resume,qualification,deleted,time,audit)VALUES(" + expert + "," + dept + "," + type + "," + DbAdapter.cite(resume) + "," + DbAdapter.cite(qualification) + "," + DbAdapter.cite(deleted) + "," + DbAdapter.cite(time) + ","+audit+")";
        } else
            sql = "UPDATE supexpert SET dept=" + dept + ",type=" + type + ",resume=" + DbAdapter.cite(resume) + ",qualification=" + DbAdapter.cite(qualification) + ",deleted=" + DbAdapter.cite(deleted) + ",time=" + DbAdapter.cite(time) + " WHERE expert=" + expert;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(expert,sql);
        } finally
        {
            db.close();
        }
        c.remove(expert);
    }

    public void delete() throws SQLException
    {
        //DbAdapter.execute("DELETE FROM supexpert WHERE expert=" + expert);
        set("deleted","1");
        c.remove(expert);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(expert,"UPDATE supexpert SET " + f + "=" + DbAdapter.cite(v) + " WHERE expert=" + expert);
        } finally
        {
            db.close();
        }
        c.remove(expert);
    }

    //职务
    public String getJob() throws SQLException
    {
        Profile m = Profile.find(expert);
        return m.getJob(1);
//        if(m.getJob() < 1)
//            return "--";
//        String name = SubType.find(m.getJob()).name;
//        if("其他".equals(name))
//            name += m.getJob(1);
//        return name;
    }

    //职称
    public String getTitle() throws SQLException
    {
        Profile m = Profile.find(expert);
        return m.getTitle(1);
//        if(m.title < 1)
//            return "--";
//        String name = SubType.find(m.title).name;
//        if("其他".equals(name))
//            name = m.getTitle(1);
//        return name;
    }

    private static String tab(String sql)
    {
        StringBuilder sb = new StringBuilder();
        if(sql.contains(" AND sbe."))
            sb.append(" INNER JOIN SupBiddingExpert sbe ON se.expert=sbe.expert");
        if(sql.contains(" AND m."))
            sb.append(" INNER JOIN Profile m ON m.profile=se.expert");
        if(sql.contains(" AND ml."))
            sb.append(" INNER JOIN ProfileLayer ml ON m.member=ml.member");
        if(sql.contains(" AND aur."))
            sb.append(" INNER JOIN AdminUsrRole aur ON aur.member=m.member");
        if(sql.contains(" AND eh."))
            sb.append(" INNER JOIN ExpertHistory eh ON eh.zjid=se.expert");
        //子公司
        if(sql.contains(" AND sse."))
            sb.append(" INNER JOIN SidBiddingExpert sse ON se.expert=sse.expert");
        return sb.toString();
    }

   /* public boolean getIntegrity() throws SQLException
    {
        Profile p = Profile.find(expert);
        String[] arr =
                {p.getName(1),MT.f(p.getBirth()),p.getOrganization(1),p.getJob(1),p.getTitle(1),MT.f(p.jtime),p.getSchool(1),p.getDegree(1),p.getFunctions(1),p.getTelephone(1),p.getMobile(),p.getEmail(),p.pcity < 1 ? "" : "pcity",p.city < 1 ? "" : "city",p.getAddress(1),this.resume,this.qualification};
        for(int i = 0;i < arr.length;i++)
        {
            if(arr[i] == null || arr[i].length() < 1 || "|".equals(arr[i]))
            {
                return false;
            }
        }
        return true;
    }*/

    /*public static void imp(String file) throws SQLException
    {
        Workbook wb;
        try
        {
            wb = Workbook.getWorkbook(new File(file));
        } catch(Exception ex)
        {
            return;
        }
        Sheet ws = wb.getSheet(0);
        for(int i = 2;i < ws.getRows();i++)
        {
            int j = 1;
            String name = ws.getCell(j++,i).getContents().trim();
            String sex = ws.getCell(j++,i).getContents().trim(); //性别
            ws.getCell(j++,i).getContents(); //年龄
            String org = ws.getCell(j++,i).getContents();
            String job = ws.getCell(j++,i).getContents();
            String title = ws.getCell(j++,i).getContents();
            String tel = ws.getCell(j++,i).getContents();
            String resume = ws.getCell(j++,i).getContents();
            String introduce = ws.getCell(j++,i).getContents();
            if(name.length() < 1)
                continue;
            for(int x = 0;Profile.isExisted(name);x++)
            {
                name += Spell.getSpell(name).charAt(x);
            }
            System.out.println("导入专家：" + name);
            Profile p = Profile.create(name,"111111","GYS",null,null);
            p.setFirstName(name,1);
            p.setSex(!"女".equals(sex));
            p.setOrganization(org,1);
            p.setType(1);
            //职务
            if(job.length() > 0)
            {
                int type = SubType.find(3,job).subtype;
                if(type == 0)
                    type = SubType.find(3,"其他").subtype;
                p.setJob(type);
                p.setJob(job,1);
            }
            //职称
            if(job.length() > 0)
            {
                int type = SubType.find(2,job).subtype;
                if(type == 0)
                    type = SubType.find(2,"其他").subtype;
                p.set("title",type);
                p.setTitle(title,1);
            }
            p.setMobile(tel);

            SupExpert t = SupExpert.find(p.getProfile());
            t.type = 2;
            t.resume = resume + "\r\n\r\n" + introduce;
            t.set();
        }
        wb.close();
    }*/

	public int getAudit() {
		return audit;
	}

	public void setAudit(int audit) {
		this.audit = audit;
	}
    
}
