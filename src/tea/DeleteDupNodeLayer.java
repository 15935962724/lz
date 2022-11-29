// Decompiled by Jad v1.5.7g. Copyright 2000 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/SiliconValley/Bridge/8617/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   DeleteDupNodeLayer.java

package tea;

import java.io.PrintStream;
import tea.db.DbAdapter;

public class DeleteDupNodeLayer
{

    public DeleteDupNodeLayer()
    {
    }

    /*public static void main(String argv[])
    {
        DbAdapter db1 = new DbAdapter();
        DbAdapter db2 = new DbAdapter();
        DbAdapter db3 = new DbAdapter();
        try
        {
            db1.executeQuery("SELECT DISTINCT node FROM TempNodeLayer ");
            while(db1.next()) 
            {
                int nNode = db1.getInt(1);
                db2.executeQuery("SELECT language, subject, keywords,  DATALENGTH(text), text,  DATALENGTH(picture), picture,  alt, align,  DATALENGTH(voice), voice  FROM TempNodeLayer  WHERE node=" + nNode);
                if(db2.next())
                {
                    int nLangauge = db2.getInt(1);
                    String strSubject = db2.getString(2);
                    String strKeywords = db2.getString(3);
                    String strText = db2.getText(4);
                    byte abPicture[] = db2.getImage(6);
                    String strAlt = db2.getString(8);
                    int nAlign = db2.getInt(9);
                    byte abVoice[] = db2.getImage(10);
                    db3.executeUpdate("INSERT INTO NodeLayer(node, language, subject, keywords, text, picture, alt, align, voice) VALUES(" + nNode + ", " + nLangauge + ", " + DbAdapter.cite(strSubject) + ", " + DbAdapter.cite(strKeywords) + ", " + DbAdapter.cite(strText) + ", " + DbAdapter.cite(abPicture) + ", " + DbAdapter.cite(strAlt) + ", " + nAlign + ", " + DbAdapter.cite(abVoice) + ") ");
                    System.err.print(nNode + "\r");
                }
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
