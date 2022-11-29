// Decompiled by Jad v1.5.7g. Copyright 2000 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/SiliconValley/Bridge/8617/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   UpdateTrade.java

package tea;

import java.io.PrintStream;
import tea.db.DbAdapter;
import tea.entity.member.Shipping;

public class UpdateTrade
{

    public static String citeSql(String s)
    {
        if(s == null)
            return "null";
        if(s.indexOf(ACSQL[0]) != -1)
            s = replace(s, ACSQL, ASTRSQL);
        return "'" + s + "'";
    }

    public UpdateTrade()
    {
    }

    public static String replace(String s, char ac[], String astr[])
    {
        StringBuilder sb = new StringBuilder();
        for(int i = 0; i < s.length(); i++)
        {
            char c = s.charAt(i);
            boolean blReplaced = false;
            for(int j = 0; j < ac.length; j++)
            {
                if(c != ac[j])
                    continue;
                sb.append(astr[j]);
                blReplaced = true;
                break;
            }

            if(!blReplaced)
                sb.append(c);
        }

        return sb.toString();
    }

    /*public static void main(String argv[])
    {
        DbAdapter db1 = new DbAdapter();
        DbAdapter db2 = new DbAdapter();
        DbAdapter db3 = new DbAdapter();
        try
        {
            db1.executeQuery("SELECT trade, shipping, blanguage FROM Trade  WHERE shipping<>0 ");
            int nTrade;
            for(; db1.next(); System.err.print(nTrade + "\r"))
            {
                nTrade = db1.getInt(1);
                int nShipping = db1.getInt(2);
                int nLanguage = db1.getInt(3);
                Shipping shipping = Shipping.find(nShipping);
                db3.executeUpdate("UPDATE Trade  SET shippingtext=" + citeSql(shipping.getText(nLanguage)) + " WHERE trade=" + nTrade);
            }

        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        finally
        {
            db1.close();
            db2.close();
            db3.close();
        }
    }*/

    static final char ACSQL[] = {
        '\''
    };
    static final String ASTRSQL[] = {
        "''"
    };

}
