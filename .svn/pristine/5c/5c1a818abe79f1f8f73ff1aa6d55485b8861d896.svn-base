package tea.entity.citybcst;

import java.sql.*;
import java.util.*;

import tea.db.*;
import tea.entity.*;


public class CityBcst extends Entity
{
    /***报名信息包括：姓名（*）、性别（*）、年龄（*）、
     * 身份证号码、所在城区、街道和社区（用列表形式列出，如果列表中没有可以自己填写）（*）、
     * 居住地址（*）、邮政编码（*）、职业、联系电话（*）、email、个人简介“（*）”为必填项
     ***/
    private int id;
    private String firstname;
    private int sex;
    private String age;
    private String card;
    private int city;
    private int street;
    private int community;
    private String addr;
    private String zip;
    private String zhiye;
    private String telephone;
    private String email;
    private String intro;
    private String other;
    private String other2;
    private String other3;

    public static CityBcst find(int id) throws SQLException
    {
        return new CityBcst(id);
    }

    public CityBcst(int id) throws SQLException
    {
        this.id = id;
        load();
    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("Select id,firstname,sex,age,card,city,street,community,addr,zip,zhiye,telephone,email,intro,other,other2,other3 from citybcst where id=" + id);
            if(db.next())
            {
                int j = 1;
                id = db.getInt(j++);
                firstname = db.getString(j++);
                sex = db.getInt(j++);
                age = db.getString(j++);
                card = db.getString(j++);
                city = db.getInt(j++);
                street = db.getInt(j++);
                community = db.getInt(j++);
                addr = db.getString(j++);
                zip = db.getString(j++);
                zhiye = db.getString(j++);
                telephone = db.getString(j++);
                email = db.getString(j++);
                intro = db.getString(j++);
                other = db.getString(j++);
                other2 = db.getString(j++);
                other3 = db.getString(j++);
            }
        } finally
        {
            db.close();
        }
    }

    public static Enumeration findByCommunity2(String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT id FROM Citybcst WHERE 1=1 " + sql,pos,size);
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

    public static void set(int id,String firstname,int sex,String age,String card,int city,int street,int community,String addr,String zip,String zhiye,String telephone,String email,String intro,String other,String other2,String other3) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("Select id from Citybcst where id=" + id);
            if(db.next())
            {
                db.executeUpdate("Update  Citybcst set firstname=" + db.cite(firstname) + ",sex=" + sex + ",age=" + db.cite(age) + ",card=" + db.cite(card) + ",city=" + city + ",street=" + street + ",community=" + community + ",addr=" + db.cite(addr) + ",zip=" + db.cite(zip) + ",zhiye=" + db.cite(zhiye) + ",telephone=" + db.cite(telephone) + ",email=" + db.cite(email) + ",intro=" + db.cite(intro) + ",other=" + db.cite(other) + ",other2=" + db.cite(other2) + ",other3=" + db.cite(other3) + " where id =" + id);
            } else
            {
                db.executeUpdate("insert into Citybcst(firstname,sex,age,card,city,street,community,addr,zip,zhiye,telephone,email,intro,other,other2,other3)values(" + db.cite(firstname) + "," + sex + "," + db.cite(age) + "," + db.cite(card) + "," + city + "," + street + "," + community + "," + db.cite(addr) + "," + db.cite(zip) + "," + db.cite(zhiye) + "," + db.cite(telephone) + "," + db.cite(email) + "," + db.cite(intro) + "," + db.cite(other) + "," + db.cite(other2) + "," + db.cite(other3) + ")");
            }
        } finally
        {
            db.close();
        }
    }

    public static int count(String sql) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        int count = 0;
        try
        {
            db.executeQuery("Select count(id) from CityBcst where 1=1  " + sql);
            if(db.next())
            {
                count = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return count;
    }

    public String getAddr()
    {
        return addr;
    }

    public String getAge()
    {
        return age;
    }

    public String getCard()
    {
        return card;
    }

    public String getEmail()
    {
        return email;
    }

    public int getId()
    {
        return id;
    }

    public String getIntro()
    {
        return intro;
    }

    public String getFirstname()
    {
        return firstname;
    }

    public String getOther()
    {
        return other;
    }

    public int getSex()
    {
        return sex;
    }

    public String getTelephone()
    {
        return telephone;
    }

    public String getZhiye()
    {
        return zhiye;
    }

    public String getZip()
    {
        return zip;
    }

    public int getCommunity()
    {
        return community;
    }

    public int getCity()
    {
        return city;
    }

    public int getStreet()
    {
        return street;
    }

    public String getOther3()
    {
        return other3;
    }

    public String getOther2()
    {
        return other2;
    }


}
