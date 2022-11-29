// Decompiled by Jad v1.5.7g. Copyright 2000 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/SiliconValley/Bridge/8617/jad.html
// Decompiler options: packimports(3)
// Source File Name:   UpdateNode.java

package tea;

import java.io.PrintStream;
import tea.db.DbAdapter;
import java.sql.SQLException;

public class UpdateNode
{

    public UpdateNode()
    {
    }

    /*public static void main(String argv[])
    {
        if (argv.length == 0)
        {
            System.err.println("JAVA UpdateNode [-a] [#node]");
            return;
        }
        DbAdapter db1 = new DbAdapter();
        DbAdapter db2 = new DbAdapter();
        DbAdapter db3 = new DbAdapter();
        try
        {
            if (argv[0].equals("-a"))
            {
                db1.executeQuery("SELECT node FROM Node ORDER BY node");
                while (db1.next())
                {
                    int nNode = db1.getInt(1);
                    db2.executeUpdate("UPDATE Node SET path=" + DbAdapter.cite(getPath(db3, nNode)) + " WHERE node=" + nNode);
                    System.err.print(nNode + "\r");
                }
            } else
            {
                int nNode = Integer.parseInt(argv[0]);
                String strPath = getPath(db3, nNode);
                System.err.print("Reset path of " + nNode + " to : " + strPath);
                db2.executeUpdate("UPDATE Node  SET path=" + DbAdapter.cite(strPath) + " WHERE node=" + nNode);
            }
        } catch (Exception e)
        {
            e.printStackTrace();
        } finally
        {
            db1.close();
            db2.close();
            db3.close();
        }
    }*/

    public static String getPath(DbAdapter db, int nNode) throws SQLException
    {
        int nFather = 0;
        db.executeQuery("SELECT father FROM Node WHERE node=" + nNode);
        if (db.next())
        {
            nFather = db.getInt(1);
        }
        if (nFather == 0)
        {
            return "/" + nNode + "/";
        } else
        {
            return getPath(db, nFather) + nNode + "/";
        }
    }
}
