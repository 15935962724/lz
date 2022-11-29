package tea.entity.node;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;
import tea.ui.*;

public class People
{
    protected static Cache c = new Cache(50);
    public int node; //人物
    public int language;
    public static String[] SEX_TYPE =
            {"--","男","女"};
    public int sex; //性别
    public String org; //单位名称
    public String job; //职务
    public String mobile; //手机
    public String tel; //电话
    public String email; //电子邮箱
    public String nationality; //国籍
    public Date birth; //出生年月
    public String place; //籍贯
    public String degree; //学历
    public String school; //毕业院校

    public People(int node,int language)
    {
        this.node = node;
        this.language = language;
    }

    public static People find(int node,int language) throws SQLException
    {
        People t = (People) c.get(node);
        if(t == null)
        {
            ArrayList al = find(" AND node=" + node + " AND language=" + language,0,1);
            t = al.size() < 1 ? new People(node,language) : (People) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT node,language,sex,org,job,mobile,tel,email,nationality,birth,place,degree,school FROM people WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                People t = new People(rs.getInt(i++),rs.getInt(i++));
                t.sex = rs.getInt(i++);
                t.org = rs.getString(i++);
                t.job = rs.getString(i++);
                t.mobile = rs.getString(i++);
                t.tel = rs.getString(i++);
                t.email = rs.getString(i++);
                t.nationality = rs.getString(i++);
                t.birth = db.getDate(i++);
                t.place = rs.getString(i++);
                t.degree = rs.getString(i++);
                t.school = rs.getString(i++);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM people WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            int i = db.executeUpdate("INSERT INTO people(node,language,sex,org,job,mobile,tel,email,nationality,birth,place,degree,school)VALUES(" + node + "," + language + "," + sex + "," + DbAdapter.cite(org) + "," + DbAdapter.cite(job) + "," + DbAdapter.cite(mobile) + "," + DbAdapter.cite(tel) + "," + DbAdapter.cite(email) + "," + DbAdapter.cite(nationality) + "," + DbAdapter.cite(birth) + "," + DbAdapter.cite(place) + "," + DbAdapter.cite(degree) + "," + DbAdapter.cite(school) + ")");
            if(i < 1)
            {
                db.executeUpdate("UPDATE people SET sex=" + sex + ",org=" + DbAdapter.cite(org) + ",job=" + DbAdapter.cite(job) + ",mobile=" + DbAdapter.cite(mobile) + ",tel=" + DbAdapter.cite(tel) + ",email=" + DbAdapter.cite(email) + ",nationality=" + DbAdapter.cite(nationality) + ",birth=" + DbAdapter.cite(birth) + ",place=" + DbAdapter.cite(place) + ",degree=" + DbAdapter.cite(degree) + ",school=" + DbAdapter.cite(school) + " WHERE node=" + node + " AND language=" + language);
            }
        } finally
        {
            db.close();
        }
        c.remove(node);
    }


    public void set(String f,String v) throws SQLException
    {
        DbAdapter.execute("UPDATE people SET " + f + "=" + DbAdapter.cite(v) + " WHERE node=" + node + " AND language=" + language);
        c.remove(node);
    }

    //
    public String getDetail(Node n,Http h,int listing,String target) throws SQLException
    {
        StringBuilder sb = new StringBuilder();
        String subject = n.getSubject(h.language);
        ListingDetail detail = ListingDetail.find(listing,98,h.language);
        Iterator e = detail.keys();
        while(e.hasNext())
        {
            String name = (String) e.next(),value = null;
            int istype = detail.getIstype(name);
            if(istype == 0)
                continue;

            String url = "/" + (h.status == 1 ? "xhtml" : "html") + "/" + h.community + "/people/" + node + "-" + h.language + ".htm";
            String bi = detail.getBeforeItem(name),ai = detail.getAfterItem(name);
            //int dq = detail.getQuantity(name);
            if(name.equals("subject"))
            {
                value = subject;
            } else if(name.equals("content"))
                value = n.getText(h.language);
            else if(name.equals("picture"))
            {
                String picture = n.getPicture(h.language);
                //value = picture == null&&picture.trim().length()>0 ? null : "<img src='" + picture + "' />";
                value = picture == null||picture.trim().length()==0 ? null : "<img src='" + picture + "' />";
            } else if(name.equals("sex"))
            {
                value = SEX_TYPE[sex];
            } else
            {
                try
                {
                    Object tmp = Class.forName("tea.entity.node.People").getField(name).get(this);
                    if(tmp != null)
                    {
                        if(tmp instanceof Date)
                            value = MT.f((Date) tmp);
                        else
                            value = tmp.toString();
                    }
                } catch(Exception ex)
                {
                }
            }

            if(value == null)
                value = "";
            if(istype == 2 && value.length() < 1)
                continue;

            //限制字数
            value = detail.getOptionsToHtml(name,n,value);

            //显示连接的地方
            if(detail.getAnchor(name) != 0)
            {
                value = "<a href='" + url + "' target='" + target + "' title=\"" + subject.replace('"','\'') + "\">" + value + "</a>";
            }
            sb.append(bi).append("<span id='PeopleID" + name + "'>" + value + "</span>").append(ai);
        }
        return sb.toString();
    }

}
