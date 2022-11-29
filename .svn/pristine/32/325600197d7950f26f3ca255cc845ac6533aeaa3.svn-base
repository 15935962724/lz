package tea.update;

import java.util.*;
import tea.entity.node.*;
import tea.entity.util.*;
import tea.db.*;
import java.sql.SQLException;

//address 和 city编号 相比,去掉adress重复的部分
public class Address
{
    public Address()
    {
    }

    public static String addr(int city, String addr) throws SQLException
    {
        addr = addr.replace('·', ' ').trim();
        if (addr.startsWith("中国"))
        {
            addr = addr.substring(2).trim();
        }
        String str = String.valueOf(city);
        for (int i = 2; i <= str.length(); i = i + 2)
        {
            String a = Card.find(Integer.parseInt(str.substring(0, i))).getAddress();
            for (int j = 0; j < 2; j++)
            {
                if (addr.startsWith(a) || addr.startsWith(a.substring(0, a.length() - 1) + " "))
                {
                    addr = addr.substring(a.length()).trim();
                }
            }
        }
        return addr;
    }

    public static String tel(int city, String tel) throws SQLException
    {
        tel = tel.trim().replaceAll("－", "-").replaceAll("--", "-");
        char ch = tel.charAt(0);
        if (ch == '*' || ch == '(' || ch == '+')
        {
            tel = tel.substring(1);
        }
        tel = tel.replaceAll("\\(|\\)", "-");
        if (tel.startsWith("86-") || tel.startsWith("86 "))
        {
            tel = tel.substring(3).trim();
        }
        if (!tel.startsWith("13")&&tel.length()>6)
        {
            if (tel.charAt(3) == ' ')
            {
                tel = tel.substring(0, 3) + "-" + tel.substring(4);
            }
            if (tel.charAt(4) == ' ')
            {
                tel = tel.substring(0, 4) + "-" + tel.substring(5);
            }
//            if (tel.charAt(0) != '0' && tel.charAt(3) == '-')
//            {
//                tel = "0" + tel;
//            }
//            if (tel.indexOf('-') == -1)
//            {
//                //"010","020","021",022,023,024,025,027,028,029
//                if (tel.startsWith("010") || tel.startsWith("02"))
//                {
//                    tel = tel.substring(0, 3) + "-" + tel.substring(4);
//                } else
//                {
//                    tel = tel.substring(0, 4) + "-" + tel.substring(5);
//                }
//            }
        }
//        String str = String.valueOf(city);
//        for (int i = 2; i <= str.length(); i = i + 2)
//        {
//            String a = Card.find(Integer.parseInt(str.substring(0, i))).getAddress();
//            for (int j = 0; j < 2; j++)
//            {
//                if (addr.startsWith(a) || addr.startsWith(a.substring(0, a.length() - 1) + " "))
//                {
//                    addr = addr.substring(a.length()).trim();
//                }
//            }
//        }
        return tel;
    }


    public static int count = 0;
    public static void main(String[] args) throws SQLException
    {
        //System.out.println(tel(000, "86 0311 88048888"));
        while (true)
        {
            Enumeration e = Company.find2(" AND state1 IS NULL", 0, 1000);
            if (!e.hasMoreElements())
            {
                return;
            } while (e.hasMoreElements())
            {
                //int id=((Integer)e.nextElement()).intValue();
                //Company obj=Company.find(id);
                Object obj[] = (Object[]) e.nextElement();
                int node = ((Integer) obj[0]).intValue();
                int lang = ((Integer) obj[1]).intValue();
                String addr = (String) obj[2];
                int city = ((Integer) obj[3]).intValue();
                count++;
                if (count % 200 == 0)
                {
                    System.out.print(count + ":" + node + ":" + addr + "\r");
                }
                ///////
                try
                {
                    String newstr = tel(city, addr);
                    StringBuilder sql = new StringBuilder();
                    sql.append("UPDATE Company SET state1=1");
                    if (!addr.equals(newstr))
                    {
                        //sql.append(",address=" + DbAdapter.cite(addr));
                        sql.append(",telephone=" + DbAdapter.cite(newstr));
                    }
                    sql.append(" WHERE node=" + node + " AND language=" + lang);
                    DbAdapter db = new DbAdapter();
                    try
                    {
                        db.executeUpdate(sql.toString());
                    } finally
                    {
                        db.close();
                    }
                } catch (Exception ex)
                {
                    System.out.println(node);
                    //ex.printStackTrace();
                    //return;
                }
            }
        }
    }
}
