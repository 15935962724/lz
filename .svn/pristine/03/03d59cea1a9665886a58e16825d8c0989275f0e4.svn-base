package tea.entity.util;
import tea.db.*;

public class Hide extends tea.entity.Entity
{
   /*   private String fileName;
    private String community;
    private String hideName;
  public String getFileName()
    {
        return fileName;
   }

    public String getCommunity()
    {
        return community;
    }*/

    public String getHideName(String fileName, String community)
    {
        tea.db.DbAdapter dbadapter = new tea.db.DbAdapter();
        try
        {
            fileName = DbAdapter.cite(fileName);
            community = DbAdapter.cite(community);
            dbadapter.executeQuery("select hidename from Hide where filename=" + fileName + " and community=" + community );
            if (dbadapter.next())
                return dbadapter.getString(1);
        } catch (Exception ex)
        {
            ex.printStackTrace();
        } finally
        {
            dbadapter.close();
        }
        return "";
    }

  /*  public void setFileName(String fileName)
    {
        this.fileName = fileName;
    }*/

    /*public void setCommunity(String community)
    {
        this.community = community;
    }*/

    public void delete(String fileName, String community, String hideName)
    {
        tea.db.DbAdapter dbadapter = new tea.db.DbAdapter();
        try
        {
            fileName = DbAdapter.cite(fileName);
            community = DbAdapter.cite(community);
            String hideNameOld = getHideName(fileName, community);
            if (hideNameOld != null && hideNameOld.length() > 0)
            {
                hideNameOld = hideNameOld.replaceAll("/" + hideName, "");
                dbadapter.executeUpdate("update Hide set hidename=" + DbAdapter.cite(hideNameOld) + " where filename=" + fileName + " and community=" + community + ")");
            }
        } catch (Exception ex)
        {
            ex.printStackTrace();
        } finally
        {
            dbadapter.close();
        }
    }

    public static boolean isHide(String fileName, String community, String hideName)
    {
        tea.db.DbAdapter dbadapter = new tea.db.DbAdapter();
        try
        {
            fileName = DbAdapter.cite(fileName);
            community = DbAdapter.cite(community);
            dbadapter.executeQuery("select count(*) from Hide where filename=" + fileName + " and community=" + community + " and (hidename=" + DbAdapter.cite("%/" + hideName + "/%") + " or hidename=" + DbAdapter.cite("%/" + hideName) + ")");
            dbadapter.next();
            if (dbadapter.getInt(1) > 0)
                return true;
        } catch (Exception ex)
        {
            ex.printStackTrace();
        } finally
        {
            dbadapter.close();
        }
        return false;
    }

    public void set(String fileName, String community, String hideName)
    {
        tea.db.DbAdapter dbadapter = new tea.db.DbAdapter();
        try
        {
            fileName = DbAdapter.cite(fileName);
            community = DbAdapter.cite(community);
            dbadapter.executeQuery("select count(*) from Hide where filename=" + fileName + " and community=" + community); // + " and hidename=" + DbAdapter.cite(hideName));
            dbadapter.next();
            if (dbadapter.getInt(1) <= 0)
                dbadapter.executeUpdate("Insert into Hide(filename,community,hidename) values(" + fileName + "," + community + "," + DbAdapter.cite(hideName) + ")");
            else
                dbadapter.executeUpdate("update Hide set hidename=hidename+" + DbAdapter.cite("/" + hideName) + " where filename=" + fileName + " and community=" + community + ")");
        } catch (Exception ex)
        {
            ex.printStackTrace();
        } finally
        {
            dbadapter.close();
        }
    }

   /* public void setHideName(String hideName)
    {
        this.hideName = hideName;
    }*/

}
