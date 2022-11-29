package tea.entity;

import tea.db.DbAdapter;
import tea.entity.Entity;
import java.sql.SQLException;

public class SeqTable extends Entity
{ 
    private String name;

    private int seqno;

    public static int getSeqNo(String name) throws SQLException
    {
        int seqno = 0;
        boolean bool = true;
        DbAdapter db = new DbAdapter();
        try
        {
            while (bool)
            {
                db.executeQuery("SELECT seqno FROM seqtable WHERE name=" + DbAdapter.cite(name));
                if (db.next())
                {
                    seqno = db.getInt(1);
                    db.executeUpdate("UPDATE seqtable SET seqno=seqno+1 WHERE name=" + DbAdapter.cite(name));
                } else
                {
                    db.executeUpdate("INSERT INTO seqtable(name,seqno)VALUES(" + DbAdapter.cite(name) + ",1)");
                }
                seqno++;
                if ("sms_subcode".equals(name))
                {
                    db.executeQuery("SELECT code FROM sms_subcode WHERE code=" + seqno);
                    bool = db.next();
                } else
                {
                    bool = false;
                }
            }
        }  finally
        {
            db.close();
        }
        return seqno;
    }
}


/*
CREATE TABLE [seqtable] (
    [name] [varchar] (50) COLLATE Latin1_General_BIN NOT NULL ,
    [seqno] [int] NULL ,
    CONSTRAINT [PK_seqtable] PRIMARY KEY  CLUSTERED
    (
        [name]
    )  ON [PRIMARY]
) ON [PRIMARY]
GO
*/
