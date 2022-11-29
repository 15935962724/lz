package tea.entity.member;

import java.sql.SQLException;
import tea.db.DbAdapter;
import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.OutputFormat;
import org.dom4j.io.XMLWriter;
import java.security.MessageDigest;
import java.util.Calendar;

public class SynRegMethod
{
    private final static String[] hexDigits =
            {
            "0", "1", "2", "3", "4", "5", "6", "7",
            "8", "9", "a", "b", "c", "d", "e", "f"};

    public static String findUserId(String userId) throws SQLException
    {
        //创建DbAdapter实例
        String userInfo = "无";
        DbAdapter db = new DbAdapter();
        try
        {

            //返回一条SQL语句：根据USERID查询出表中是否存在此ID
            db.executeQuery("SELECT member FROM profile WHERE member = " + db.cite(userId));
            if (db.next())
            {
                userInfo = db.getString(1);
            }

        } finally
        {
            //关闭数据库连接
            db.close();
        }
        //返回结果
        return userInfo;
    }

    public static String findPassword(String userId) throws SQLException
    {
        //创建DbAdapter实例
        String userInfo = "无";
        DbAdapter db = new DbAdapter();
        try
        {

            //返回一条SQL语句：根据USERID查询出表中是否存在此ID
            db.executeQuery("SELECT password FROM profile WHERE member = " + db.cite(userId));
            if (db.next())
            {
                userInfo = db.getString(1);
            }

        } finally
        {
            //关闭数据库连接
            db.close();
        }
        //返回结果
        return userInfo;
    }

    public static String getSysDate() throws SQLException
    {
        String date = null;
        Calendar cal = Calendar.getInstance();
        int year = cal.get(cal.YEAR);
        int month = (cal.get(cal.MONTH) + 1);
        int day = cal.get(cal.DATE);
        if (month < 10 && day > 9)
        {
            date = year + "0" + month + "" + day;
            System.out.println(date);
        } else if (month > 9 && day < 10)
        {
            date = year + "" + month + "0" + day;
        } else if (month < 10 && day < 10)
        {
            date = year + "0" + month + "0" + day;
        } else
        {
            date = year + "" + month + "" + day;
        }

        return date;
    }

    public static int registerUser(String userId, String userName, String password, String email, String mobile, int cardType, String cardNumber, int sex) throws SQLException
    {
        int i = 0;
        //创建DbAdapter实例
        DbAdapter db = new DbAdapter();
        try
        {
            //返回一条SQL语句为插入注册信息
            db.executeUpdate("INSERT INTO profile(member, community, password, email, mobile, cardtype, card, sex) VALUES(" + db.cite(userId) + ", 'jiudian', " + db.cite(password) + ", " + db.cite(email) + ", " + db.cite(mobile) + ", " + cardType + ", " + db.cite(cardNumber) + ", " + sex + ")");
            i = db.executeUpdate("INSERT INTO profilelayer(member, language, firstname) VALUES(" + db.cite(userId) + ", 1," + db.cite(userName) + ")");
            return i;
        } finally
        {
            //关闭数据库连接
            db.close();
        }
    }


    public static int deleteUser(String userId) throws SQLException
    {
        int i = 0;
        //创建DbAdapter实例
        DbAdapter db = new DbAdapter();
        try
        {
            //返回一条SQL语句为删除用户
            db.executeUpdate("DELETE FROM profile WHERE member=" + db.cite(userId));
            i = db.executeUpdate("DELETE FROM profilelayer WHERE member=" + db.cite(userId));
            return i;
        } finally
        {
            //关闭数据库连接
            db.close();
        }
    }

    public String writeXML(String utValue, String userId, String userName, String password, String email, String mobile, String cardType, String cardNumber, String sex, String resultValue)
    {
        Document doc = org.dom4j.DocumentHelper.createDocument(); //创建节点操作对象

        Element rootElement = doc.addElement("Check"); //创建根节点对象rootElement,标签名为Check

        Element updateType = rootElement.addElement("UpdateType"); //添加子节点Check
        updateType.setText(utValue);

        Element checkContent = rootElement.addElement("CheckContent"); //添加子节点CheckContent

        /*
         *以下添加XML中用户注册的各项信息
         */
        Element user_Id = checkContent.addElement("UserId");
        user_Id.setText(userId);

        Element user_Name = checkContent.addElement("UserName");
        user_Name.setText(userName);

        Element user_Password = checkContent.addElement("Password");
        user_Password.setText(password);

        Element user_Email = checkContent.addElement("Email");
        user_Email.setText(email);

        Element user_Mobile = checkContent.addElement("Mobile");
        user_Mobile.setText(mobile);

        Element user_CardType = checkContent.addElement("CardType");
        user_CardType.setText(cardType);

        Element user_CardNumber = checkContent.addElement("CardNumber");
        user_CardNumber.setText(cardNumber);

        Element user_sex = checkContent.addElement("Sex");
        user_sex.setText(sex);

        Element result = rootElement.addElement("Result"); //添加子节点Result
        result.setText(resultValue);

        try
        {
            OutputFormat fmt = new OutputFormat(); //创建输出格式对象
            fmt.setEncoding("UTF-8");
            XMLWriter writer = new XMLWriter(fmt); //以输出格式为参数,创建XML文件输出对象
            writer.write(doc); //输出doc对象,即形成XML文件

        } catch (Exception e)
        {

            e.printStackTrace();
        }
        return doc.asXML();
    }

    public static String byteArrayToHexString(byte[] b)
    {
        StringBuilder resultSb = new StringBuilder();
        for (int i = 0; i < b.length; i++)
        {
            resultSb.append(byteToHexString(b[i]));
        }
        return resultSb.toString();
    }

    private static String byteToHexString(byte b)
    {
        int n = b;
        if (n < 0)
        {
            n = 256 + n;
        }
        int d1 = n / 16;
        int d2 = n % 16;
        return hexDigits[d1] + hexDigits[d2];
    }

    public static String MD5Encode(String origin)
    {
        String resultString = null;

        try
        {
            resultString = new String(origin);
            MessageDigest md = MessageDigest.getInstance("MD5");
            resultString = byteArrayToHexString(md.digest(resultString.getBytes()));
        } catch (Exception ex)
        {

        }
        return resultString;
    }


    public String landWriteXML(String verification, String userId, String loginType, String result)
    {
        Document doc = org.dom4j.DocumentHelper.createDocument(); //创建节点操作对象

        Element rootElement = doc.addElement("Check"); //创建根节点对象rootElement,标签名为Check

        /*
         *以下修改XML中用户注册的各项信息
         */

        Element user_verification = rootElement.addElement("Verification");
        user_verification.setText(verification);

        Element user_id = rootElement.addElement("UserID");
        user_id.setText(userId);

        Element user_loginType = rootElement.addElement("LoginType");
        user_loginType.setText(loginType);

        Element user_result = rootElement.addElement("Result");
        user_result.setText(result);

        try
        {
            OutputFormat fmt = new OutputFormat(); //创建输出格式对象
            fmt.setEncoding("UTF-8");
            XMLWriter writer = new XMLWriter(fmt); //以输出格式为参数,创建XML文件输出对象
            writer.write(doc); //输出doc对象,即形成XML文件

        } catch (Exception e)
        {

            e.printStackTrace();
        }
        return doc.asXML();
    }

    public String UWriteXML(String userId)
    {
        Document doc = org.dom4j.DocumentHelper.createDocument(); //创建节点操作对象

        Element rootElement = doc.addElement("CheckExist"); //创建根节点对象rootElement,标签名为Check

        /*
         *以下修改XML中用户注册的各项信息
         */

        Element user_ID = rootElement.addElement("UserID");
        user_ID.setText(userId);

        Element user_Result = rootElement.addElement("Result");
        user_Result.setText("-1");

        try
        {
            OutputFormat fmt = new OutputFormat(); //创建输出格式对象
            fmt.setEncoding("UTF-8");
            XMLWriter writer = new XMLWriter(fmt); //以输出格式为参数,创建XML文件输出对象
            writer.write(doc); //输出doc对象,即形成XML文件

        } catch (Exception e)
        {

            e.printStackTrace();
        }
        return doc.asXML();
    }

}
