package tea.entity.admin.orthonline;

import java.sql.*;
import java.util.*;

import tea.db.*;
import tea.entity.*;
public class Hospital extends Entity
{
    private int hoid;
    private String honame; //医院名称
    private String provincial; //省
    private String city; //市
    private String grade; //等级
    private String hotype; //类型
    private String baoding; //是否医保定点
    private String equipment; //主要设备
    private String specialist; //特色专科
    private String bedseveral; //病床数
    private String outpatient; //门诊量
    private String dean; //院长
    private String address; //地址
    private String zip; //邮编
    private String telephone; //联系电话
    private String email; //医院邮箱
    private String weburl; //网址
    private String busline; //乘车路线
    private String introduce; //医院介绍
    private String picaddress; //图片地址
    private String thumbnail; //缩略图
    private int quantity; //报名人数数量

    private boolean exists;


    public Hospital(int hoid) throws SQLException
    {
        this.hoid = hoid;
        load();
    }

    public static Hospital find(int hoid) throws SQLException
    {
        return new Hospital(hoid);
    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT honame,provincial,city,grade,hotype,baoding,equipment,specialist,bedseveral,outpatient,dean,address,zip,telephone,email,weburl,busline,introduce,picaddress, thumbnail,quantity FROM Hospital WHERE hoid =" + hoid);
            if(db.next())
            {
                honame = db.getString(1);
                provincial = db.getString(2);
                city = db.getString(3);
                grade = db.getString(4);
                hotype = db.getString(5);
                baoding = db.getString(6);
                equipment = db.getString(7);
                specialist = db.getString(8);
                bedseveral = db.getString(9);
                outpatient = db.getString(10);
                dean = db.getString(11);
                address = db.getString(12);
                zip = db.getString(13);
                telephone = db.getString(14);
                email = db.getString(15);
                weburl = db.getString(16);
                busline = db.getString(17);
                introduce = db.getString(18);
                picaddress = db.getString(19);
                thumbnail = db.getString(20);
                quantity = db.getInt(21);

                exists = true;
            } else
            {
                exists = false;
            }
        } finally
        {
            db.close();
        }
    }
	public static int create(String honame,String provincial,String city,String grade,String hotype,String telephone,String email,String zip,String weburl,String address,String introduce) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		//Date times = new Date();
		int i = 0;
		try
		{
			db.executeUpdate("INSERT INTO Hospital ( honame, provincial, city, grade, hotype, telephone, email, zip, weburl, address, introduce)" +
							 " VALUES (" + db.cite(honame) + "," + db.cite(provincial) + "," + db.cite(city) + "," + db.cite(grade) + "," + db.cite(hotype) + "," + db.cite(telephone) + "," + db.cite(email) + "," +
							 " " + db.cite(zip) + " ," + db.cite(weburl) + "," + db.cite(address) + "," + db.cite(introduce) + " " +
						     "  )");
			  i = db.getInt("SELECT MAX(hoid) FROM Hospital");
		} finally
		{
			db.close();
		}
		return i;
	}


    public void set(String honame,String provincial,String city,String grade,String hotype,String baoding,String equipment,String specialist,String bedseveral,String outpatient,
                    String dean,String address,String zip,String telephone,String email,String weburl,String busline,String introduce,
                    String picaddress,String thumbnail,int quantity) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update Hospital set honame=" + db.cite(honame) + ",provincial=" + db.cite(provincial) + ",city=" + db.cite(city) + ",grade=" + db.cite(grade) + ",hotype=" + db.cite(hotype) + ","
                             + "  baoding=" + db.cite(baoding) + " ,equipment=" + db.cite(equipment) + ",specialist=" + db.cite(specialist) + ",bedseveral=" + db.cite(bedseveral) + ",outpatient=" + db.cite(outpatient) + ",dean=" + db.cite(dean) + ","
                             + " address=" + db.cite(address) + ",zip=" + db.cite(zip) + ",telephone=" + db.cite(telephone) + ",email=" + db.cite(email) + ",weburl=" + db.cite(weburl) + ",busline=" + db.cite(busline) + ","
                             + "introduce=" + db.cite(introduce) + ",picaddress=" + db.cite(picaddress) + ",thumbnail=" + db.cite(thumbnail) + ",quantity=" + quantity + " where hoid="+hoid);

        } finally
        {
            db.close();
        }

    }

    public static Enumeration find(String sql)
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT hoid FROM Hospital WHERE 1=1 " + sql);

            while(db.next())
            {
                vector.add(new Integer(db.getInt(1)));
            }
        } catch(Exception exception3)
        {
            System.out.print(exception3);
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public static Enumeration find(String sql,int pos,int size)
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT hoid FROM Hospital WHERE 1=1 " + sql,pos,size);

            while(db.next())
            {
                vector.add(new Integer(db.getInt(1)));
            }
        } catch(Exception exception3)
        {
            System.out.print(exception3);
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public static int count(String sql) throws SQLException
    {
        int count = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(hoid) FROM Hospital  WHERE 1=1" + sql);
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

    public void setQuantity(int quantity) throws SQLException
    {
        int count = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Hospital SET quantity =" + quantity + " WHERE hoid= " + hoid);
        } finally
        {
            db.close();
        }
    }

    //判断是否有医院
    public static int isHoname(String honame,String provincial,String city) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        int f = 0;
        try
        {
            db.executeQuery("select hoid from Hospital where honame=" + db.cite(honame) + "  AND provincial =" + db.cite(provincial) + " AND city=" + db.cite(city) + " ");
            if(db.next())
            {
                f = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return f;
    }


    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM Hospital WHERE hoid=" + hoid);
        } finally
        {
            db.close();
        }

    }

    public String getAddress()
    {
        return address;
    }

    public String getBaoding()
    {
        return baoding;
    }

    public String getBedseveral()
    {
        return bedseveral;
    }

    public String getBusline()
    {
        return busline;
    }

    public String getCity()
    {
        return city;
    }

    public String getDean()
    {
        return dean;
    }

    public String getEmail()
    {
        return email;
    }

    public String getEquipment()
    {
        return equipment;
    }

    public boolean isExists()
    {
        return exists;
    }

    public String getGrade()
    {
        return grade;
    }

    public String getHoname()
    {
        return honame;
    }

    public String getHotype()
    {
        return hotype;
    }

    public String getIntroduce()
    {
        return introduce;
    }

    public String getOutpatient()
    {
        return outpatient;
    }

    public String getPicaddress()
    {
        return picaddress;
    }

    public String getProvincial()
    {
        return provincial;
    }

    public String getSpecialist()
    {
        return specialist;
    }

    public String getTelephone()
    {
        return telephone;
    }

    public String getThumbnail()
    {
        return thumbnail;
    }

    public String getZip()
    {
        return zip;
    }

    public String getWeburl()
    {
        return weburl;
    }

    public int getQuantity()
    {
        return quantity;
    }


}
