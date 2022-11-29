package tea.entity.util;

import tea.db.*;
import java.sql.SQLException;
import java.util.*;

public class Phrase
{
    public Phrase()
    {
    }

    public static String findKey(String str) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT keywords FROM Phrase WHERE " + db.cite(str) + " LIKE " + db.concat("'%'","keywords","'%'"));
            while(db.next())
            {
                al.add(db.getString(1));
            }
        } finally
        {
            db.close();
        }
        //去重，删除最短的词
        for(int i = 0;i < al.size();i++)
        {
            String key = (String) al.get(i);
            for(int j = 0;j < al.size();j++)
            {
                if(i == j)
                {
                    continue;
                }
                if(((String) al.get(j)).indexOf(key) != -1)
                {
                    al.remove(i);
                    i--;
                    break;
                }
            }
        }
        //按原字符串排序
        String[] arr = new String[str.length()];
        for(int i = 0;i < al.size();i++)
        {
            String key = (String) al.get(i);
            arr[str.indexOf(key)] = key;
        }
        StringBuilder sb = new StringBuilder();
        for(int i = 0;i < str.length();i++)
        {
            if(arr[i] == null)
                continue;
            sb.append(arr[i]).append(" ");
        }
        return sb.toString();
    }

}
