package tea.service.oasms;

import java.util.*;
import tea.db.DbAdapter;
import tea.entity.*;
import tea.html.Anchor;
import tea.html.Image;
import tea.service.SMS;
import tea.entity.site.SMSScode;
import tea.entity.member.SMSEnterprise;
import java.sql.SQLException;
import java.io.*;

public class SmsServices extends java.lang.Thread
{
    public boolean validFin(int fincode, String password)
    {
        boolean flag = false;
        DbAdapter db = new DbAdapter();
        try
        {
            int i = db.getInt("select count(1) from SMSEnterprise where code=" + (fincode) + " and pwd=" + DbAdapter.cite(password));
            flag = (i > 0);
        } catch (Exception exception)
        {
        } finally
        {
            db.close();
        }
        return flag;
    }

    public boolean validSub(int subcode, String password)
    {
        boolean flag = false;
        DbAdapter db = new DbAdapter();
        try
        {
            int i = db.getInt("select count(1) from sms_subcode where code=" + (subcode) + " and password=" + DbAdapter.cite(password));
            flag = (i > 0);
        } catch (Exception exception)
        {
        } finally
        {
            db.close();
        }
        return flag;
    }

    public int getBalance(int fincode, String password)
    {
        int i = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT code, balance / price AS retain FROM SMSEnterprise where code=" + (fincode) + " and pwd=" + DbAdapter.cite(password));
            if (db.next())
            {
                i = db.getInt(2);
            }
        } catch (Exception exception)
        {
        } finally
        {
            db.close();
        }
        return i;
    }

//    public void send(int fincode, String password) throws SQLException
//    {
//        DbAdapter db = new DbAdapter();
//        try
//        {
//            db.executeUpdate("UPDATE SMSEnterprise SET balance=balance-1*price WHERE code=" + (fincode) + " and pwd=" + DbAdapter.cite(password));
//        } finally
//        {
//            db.close();
//        }
//    }

    public void send1(int fincode, int subcode)
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update  SMSEnterprise set balance=balance-1*price where code=" + (fincode));
            db.executeUpdate("update  sms_subcode set reversecount=reversecount+1 where code=" + (subcode));
        } catch (Exception exception)
        {
        } finally
        {
            db.close();
        }
    }

    public int GetReverseCount(int subcode, String password)
    {
        int count = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            count = db.getInt("select reversecount from sms_subcode where code=" + (subcode));
            db.executeUpdate("update  sms_subcode set reversecount=0 where code=" + (subcode));
        } catch (Exception exception)
        {
        } finally
        {
            db.close();
        }
        return count;
    }

    public void setReverse(String subcode, String password, int autoreverse)
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update  sms_subcode set autoreverse =" + autoreverse + ",reversecount=0 where code=" + DbAdapter.cite(subcode) + " and password=" + DbAdapter.cite(password));
        } catch (Exception exception)
        {
            exception.printStackTrace();
        } finally
        {
            db.close();
        }
    }

    public String getSubNumber(int fincode, String tonumber)
    {
        int subcode = 0;
        String password = "";
        DbAdapter db = new DbAdapter();
        try
        {
            // subcode = db.getInt("SMS_GetSubNumber 'init'");
            subcode = SeqTable.getSeqNo("sms_subcode");
            password = SMS.md5("5" + SMS.md5(String.valueOf(subcode))).substring(1, 6);
            db.executeUpdate("INSERT INTO sms_subcode(code,password,autoreverse,mobileno,reversecount,fincode)VALUES(" + subcode + "," + DbAdapter.cite(password) + ",0," + DbAdapter.cite(tonumber)
                             + " ,0," + fincode + ")");
        } catch (Exception exception)
        {
            exception.printStackTrace();
        } finally
        {
            db.close();
        }
        return subcode + "," + password;
    }

    public String getSubNumber1(int subcode, int fincode, String tonumber)
    {
        String password = "";
        DbAdapter db = new DbAdapter();
        try
        {
            password = SMS.md5("5" + SMS.md5(String.valueOf(subcode))).substring(1, 6);
            db.executeUpdate("update sms_subcode set password='" + password + "',fincode='" + fincode + "',mobileno='" + tonumber + "' where code= " + (subcode));
        } catch (Exception exception)
        {
            exception.printStackTrace();
        } finally
        {
            db.close();
        }
        return subcode + "," + password;
    }

    public String getSubNumber2(int subcode, int fincode, String tonumber)
    {
        // int i;
        String password = "";
        DbAdapter db = new DbAdapter();
        try
        {
            // i = db.getInt("SMS_GetSubNumber2 " + subcode + ",'init'");
            db.executeUpdate("insert into sms_subcode(code,password) values(" + subcode + ",'init')");
            password = SMS.md5("5" + SMS.md5(String.valueOf(subcode))).substring(1, 6);
            db.executeUpdate("update sms_subcode set password='" + password + "',fincode='" + fincode + "',mobileno='" + tonumber + "',autoreverse=0,reversecount=0  where code= " + (subcode));
        } catch (Exception exception)
        {
        } finally
        {
            db.close();
        }
        return subcode + "," + password;
    }

    public boolean existSubNumber(int subcode)
    {
        int i = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            i = db.getInt("select count(1) from  sms_subcode where code= " + (subcode));
        } catch (Exception exception)
        {
        } finally
        {
            db.close();
        }
        return i > 0;
    }

    /*public static void main(String[] args)
    {
        try
        {
            SmsServices ss = new SmsServices();
            
             * System.out.println(ss.getBalance("0001", "test"));
             * System.out.println(ss.validFin("0001", "test"));
             * System.out.println(ss.validSub("1000", "test"));
             * System.out.println(ss.getReverse("1000", "test"));
             * System.out.println(ss.getSubNumber());
             
            ss.start();
        } catch (Exception e)
        {
            e.printStackTrace();
        }
    }*/

    public void run()
    {
        int index = 0;
        while (true)
        {
            try
            {
                tea.service.SMS sms = new tea.service.SMS();
                String s = sms.recv();
                sms.parse(s);
                try
                {
                    this.getAutoReverse();
                } catch (Exception ex)
                {
                    ex.printStackTrace();
                }
                System.out.println(index++);

                this.sleep(1000L);
            } catch (Exception ex)
            {
                ex.printStackTrace();
            }
            // try
            // {
            // java.util.Enumeration e = SMSScode.find();
            // while (e.hasMoreElements())
            // {
            // // 接收短信
            // String s = sms.recv((String) e.nextElement());
            // sms.parse(s);
            // try
            // {
            // this.getAutoReverse();
            // } catch (Exception ex)
            // {
            // ex.printStackTrace();
            // }
            // System.out.println(index++);
            // try
            // {
            // this.sleep(1000L);
            // } catch (InterruptedException ex)
            // {
            // }
            // }
            // } catch (SQLException ex1)
            // {
            // ex1.printStackTrace();
            // }
        }
    }

    public String getReverse(int subcode, String password) throws SQLException
    {
        StringBuilder table = new StringBuilder();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT numeral, message, time, type FROM SMSMessage where type=1 and subnumber='" + subcode + "'");
            while (db.next())
            {
                table.append("<tr>");
                table.append("<td>").append(db.getString(1)).append("</td>");
                table.append("<td>").append(db.getString(2)).append("</td>");
                table.append("<td>").append(db.getString(3)).append("</td>");
                table.append("</tr>");
            }
        } finally
        {
            db.close();
        }
        return table.toString();
    }

    public void getAutoReverse() throws SQLException, IOException
    {
        DbAdapter db = new DbAdapter();
        DbAdapter db1 = new DbAdapter();
        try
        {
            db
                    .executeQuery("SELECT sm.smsmessage,sm.numeral,sm.message,sm.time,sm.type,ss.code FROM SMSMessage sm, sms_subcode ss WHERE type=1 and sm.subnumber=ss.code and ss.autoreverse=1 and sm.reversed=0");
            while (db.next())
            {
                SMS sms = new SMS();
                int id = db.getInt(1);
                String fromnumber = db.getString(2);
                String content = fromnumber + ":" + db.getString(3);
                int subcode = db.getInt(6);
                db1.executeQuery("SELECT fincode,reversecount,mobileno FROM sms_subcode WHERE code=" + subcode);
                if (db1.next())
                {
                    int fincode = db1.getInt(1);
                    String tonumber = db1.getString(3);
                    // SMSEnterprise.find(fincode).getScode(),
                    sms.send(subcode, tonumber, content, "");
                    send1(fincode, subcode);
                }
                db1.executeUpdate("update SMSMessage set reversed=1 where smsmessage=" + id);
            }
        } finally
        {
            db.close();
            db1.close();
        }
    }
}
