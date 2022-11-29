// Decompiled by Jad v1.5.7g. Copyright 2000 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/SiliconValley/Bridge/8617/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   UpdateListing.java

package tea;

import java.io.PrintStream;
import tea.db.DbAdapter;

public class UpdateListing
{

    public UpdateListing()
    {
    }

    /*public static void main(String argv[])
    {
        DbAdapter db1 = new DbAdapter();
        DbAdapter db2 = new DbAdapter();
        DbAdapter db3 = new DbAdapter();
        try
        {
            db1.executeQuery("SELECT listing, options FROM Listing  ORDER BY listing ");
            int nListing;
            for(; db1.next(); System.err.print(nListing + "\r"))
            {
                nListing = db1.getInt(1);
                int nOptions = db1.getInt(2);
                int nNewOptions = 0;
                if((nOptions & 0x1) != 0)
                    nNewOptions |= 0x800;
                if((nOptions & 0x2) != 0)
                    nNewOptions |= 0x100;
                if((nOptions & 0x4) != 0)
                    nNewOptions |= 0x8;
                if((nOptions & 0x8) != 0)
                    nNewOptions |= 0x80000;
                if((nOptions & 0x10) != 0)
                    nNewOptions |= 0x1;
                if((nOptions & 0x20) != 0)
                    nNewOptions |= 0x2;
                if((nOptions & 0x40) == 0)
                    nNewOptions |= 0x200;
                if((nOptions & 0x80) != 0)
                    nNewOptions |= 0x4;
                if((nOptions & 0x100) != 0)
                    nNewOptions |= 0x400;
                db2.executeUpdate("UPDATE Listing  SET options=" + nNewOptions + " WHERE listing=" + nListing);
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
}
