package tea.entity.admin.mov;

import java.sql.*;
import java.util.*;

import tea.db.*;
import tea.entity.*;

public class Describes extends Entity
{
    private int membertype; //会员类型
    private String member; //用户名
    private String password; //密码
    private String confirmpassword; //确认密码
    private String email; //邮箱
    private String firstname; //姓名
    private String sex; //性别
    private String card; //身份证号
    private String birthyear; //出生日期
    private String state; //省份
    private String address; //通信地址
    private String phonenumber; //手机号
    private String zip; //邮编
    private String telephone; //电话
    private String fax; //传真
    private String position; //职称
    private String organization; //单位
    private String section; //科室 部门
    private String degree; //学历
    private String country;//国籍
    private String identitys;//目前身份
    

    private String vertify; //验  证  码

    public Describes(int membertype) throws SQLException
    {
        this.membertype = membertype;
        load();
    }

    public static Describes find(int membertype) throws SQLException
    {
        return new Describes(membertype);
    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT member,password,confirmpassword,email,firstname,sex,card,birthyear,state,address,phonenumber,zip,telephone,fax,vertify,position," +
            		"organization,section,degree,country,identitys FROM Describes WHERE membertype=" + membertype);
            if(db.next())
            {
                member = db.getString(1);
                password = db.getString(2);
                confirmpassword = db.getString(3);
                email = db.getString(4);
                firstname = db.getString(5);
                sex = db.getString(6);
                card = db.getString(7);
                birthyear = db.getString(8);
                state = db.getString(9);
                address = db.getString(10);
                phonenumber = db.getString(11);
                zip = db.getString(12);
                telephone = db.getString(13);
                fax = db.getString(14);
                vertify = db.getString(15);
                position = db.getString(16);
                organization = db.getString(17);
                section = db.getString(18);
                degree = db.getString(19);
                country=db.getString(20);
                identitys=db.getString(21);
            }
        } finally
        {
            db.close();
        }
    }

    public static void create(int membertype,String member,String password,String confirmpassword,String email,String firstname,
                              String sex,String card,String birthyear,String state,String address,String phonenumber,String zip,
                              String telephone,String fax,String vertify,String position,String organization,String section,String degree,String country,String identitys) throws SQLException
    {
        DbAdapter db = new DbAdapter();

        try
        {
            db.executeUpdate("INSERT INTO Describes(membertype,member,password,confirmpassword,email,firstname,"
                             + " sex,card,birthyear,state,address,phonenumber,zip,telephone,fax,vertify,"
                             + " position,organization,section,degree,country,identitys) "
                             + " VALUES(" + membertype + "," + db.cite(member) + "," + db.cite(password) + "," + db.cite(confirmpassword) + "," + db.cite(email) + "," + db.cite(firstname) + ","
                             + db.cite(sex) + "," + db.cite(card) + "," + db.cite(birthyear) + "," + db.cite(state) + "," + db.cite(address) + "," + db.cite(phonenumber) + "," + db.cite(zip) + ","
                             + db.cite(telephone) + " ," + db.cite(fax) + "," + db.cite(vertify) + "," + db.cite(position) + "," + db.cite(organization) + "," + db.cite(section) + "," +
                             		"" + db.cite(degree) + ","+db.cite(country)+","+db.cite(identitys)+" )");
        } finally
        {
            db.close();
        }
    }

    public void set(String member,String password,String confirmpassword,String email,String firstname,String sex,String card,String birthyear,String state,String address,String phonenumber,
                    String zip,String telephone,String fax,String vertify,String position,String organization,String section,String degree,String country,String identitys) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Describes SET member=" + db.cite(member) + ", password=" + db.cite(password) + " , confirmpassword=" + db.cite(confirmpassword) + " , email=" + db.cite(email) + " ,"
                             + " firstname=" + db.cite(firstname) + " , sex=" + db.cite(sex) + " , card=" + db.cite(card) + " , birthyear=" + db.cite(birthyear) + " , state=" + db.cite(state) + " ,"
                             + " address=" + db.cite(address) + " , phonenumber=" + db.cite(phonenumber) + " , zip=" + db.cite(zip) + " , telephone=" + db.cite(telephone) + " , fax=" + db.cite(fax) + " ,"
                             + " vertify=" + db.cite(vertify) + ",position=" + db.cite(position) + ",organization=" + db.cite(organization) + ",section=" + db.cite(section) + "," +
                             		"degree=" + db.cite(degree) + ",country="+db.cite(country)+",identitys="+db.cite(identitys)+"    WHERE membertype=" + membertype);
        } finally
        {
            db.close();
        }
    }


    public static Enumeration find(String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT membertype FROM Describes WHERE 1=1 " + sql,pos,size);
            while(db.next())
            {
                v.addElement(new String(db.getString(1)));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM Describes WHERE membertype=" + membertype);
        } finally
        {
            db.close();
        }
    }

    public static boolean isMembertype(int membertype) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        boolean fa = false;
        try
        {
            db.executeQuery("SELECT membertype FROM Describes WHERE membertype=" + membertype);
            if(db.next())
            {
                fa = true;
            }
        } finally
        {
            db.close();
        }
        return fa;
    }

    public String getAddress()
    {
        return address;
    }

    public String getBirthyear()
    {
        return birthyear;
    }

    public String getCard()
    {
        return card;
    }

    public String getConfirmpassword()
    {
        return confirmpassword;
    }

    public String getEmail()
    {
        return email;
    }

    public String getFax()
    {
        return fax;
    }

    public String getFirstname()
    {
        return firstname;
    }

    public String getMember()
    {
        return member;
    }

    public String getPassword()
    {
        return password;
    }

    public String getPhonenumber()
    {
        return phonenumber;
    }

    public String getSex()
    {
        return sex;
    }

    public String getState()
    {
        return state;
    }

    public String getTelephone()
    {
        return telephone;
    }

    public String getVertify()
    {
        return vertify;
    }

    public String getZip()
    {
        return zip;
    }

    public String getPosition()
    {
        return position;
    }

    public String getOrganization()
    {
        return organization;
    }

    public String getSection()
    {
        return section;
    }

    public String getDegree()
    {
        return degree;
    }
    public String getCountry()
    {
    	return country;
    }
    public String getIdentitys()
    {
    	return identitys;
    }
    
}
