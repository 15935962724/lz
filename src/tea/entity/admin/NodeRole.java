package tea.entity.admin;

import java.sql.SQLException;
import java.util.Date;
import java.util.Enumeration;
import java.util.Vector;

import tea.db.DbAdapter;
import tea.entity.Entity;
import tea.entity.node.Node;
import tea.entity.subscribe.Tactics;

public class NodeRole extends Entity
{
	private int nrid;
	private int arid;//角色id
	private int node;
	private String nrname;
	private Date times;
	private String community;
	private String member;//设置权限的用户
	private String memberrole;//有权限的用户

	private boolean exists;

	public NodeRole(int nrid) throws SQLException
	{
		this.nrid = nrid;
		load();
	}

	public static NodeRole find(int nrid) throws SQLException
	{
		return new NodeRole(nrid);
	}


    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT arid,node,nrname,times,community,member,memberrole FROM NodeRole WHERE nrid =  " + nrid);
            if(db.next())
            {
				arid = db.getInt(1);
				node = db.getInt(2);
				nrname = db.getString(3);
				times = db.getDate(4);
				community = db.getString(5);
				member = db.getString(6);
				memberrole=db.getString(7);
				exists = true;
            } else
            {
                exists = false;
            }
        } finally
        {
            db.close();
        }
    }
    public static int create(int arid,int node,String nrname,Date times,String community,String member) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        int i = 0;
        try
        {
            db.executeUpdate("INSERT INTO NodeRole (arid,node,nrname,times,community,member) " +
                             " VALUES ("+arid+","+node+"," + db.cite(nrname) + " , " + db.cite(new Date()) + "," + db.cite(community) + "," + db.cite(member) + "   )");
            i = db.getInt("SELECT MAX(nrid) FROM NodeRole");
        } finally
        {
            db.close();
        }
        return i;
    }
    public static int create(String memberrole ,int node,String nrname,Date times,String community,String member) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        int i = 0;
        try
        {
            db.executeUpdate("INSERT INTO NodeRole (memberrole,node,nrname,times,community,member,arid) " +
                             " VALUES ("+db.cite(memberrole)+","+node+"," + db.cite(nrname) + " , " + db.cite(new Date()) + "," + db.cite(community) + "," + db.cite(member) + ",0   )");
            i = db.getInt("SELECT MAX(nrid) FROM NodeRole");
        } finally
        {
            db.close();
        }
        return i;
    }
    public void set(int arid,int node,String nrname,Date times,String community,String member) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE NodeRole SET arid="+arid+",node="+node+",  nrname =" + db.cite(nrname) + ",times=" + db.cite(new Date()) + ",community=" + db.cite(community) + "," +
            		"member=" + db.cite(member) + "  WHERE nrid=" + nrid);
        } finally
        {
            db.close();
        }
    }
    public void set(String memberrole,int node,String nrname,Date times,String community,String member) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE NodeRole SET memberrole="+db.cite(memberrole)+",node="+node+",  nrname =" + db.cite(nrname) + ",times=" + db.cite(new Date()) + ",community=" + db.cite(community) + "," +
            		"member=" + db.cite(member) + "  WHERE nrid=" + nrid);
        } finally
        {
            db.close();
        }
    }
    public void setMemberrole(String memberrole)throws SQLException
    {
    	 DbAdapter db = new DbAdapter();
         try
         {
             db.executeUpdate("UPDATE NodeRole SET memberrole =" + db.cite(memberrole) + " WHERE nrid=" + nrid);
         } finally
         {
             db.close();
         }
    }

    public static Enumeration find(String community,String sql,int pos,int size)
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT arid FROM NodeRole WHERE community= " + db.cite(community) + sql,pos,size);
            while(db.next())
            {
                vector.add(new Integer(db.getInt(1)));
            }
        } catch(Exception exception3)
        {
            System.out.print(exception3);
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM  NodeRole WHERE arid = " + arid);
        } finally
        {
            db.close();
        }
    }

    //通过node和角色id arid 获取主键
    public static int getNrid(int node,int arid)throws SQLException
    {
    	int id = 0;
    	 DbAdapter db = new DbAdapter();
         try
         {
             db.executeQuery("SELECT nrid FROM NodeRole WHERE node="+node+" AND arid="+arid);
             if(db.next())
             {
            	 id = db.getInt(1);
             }
         } finally
         {
             db.close();
         }
         return id;
    }
    //通过node和用户获取主键
    public static int getNrid(int node,String member)throws SQLException
    {
    	int id = 0;
   	 DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT nrid FROM NodeRole WHERE node="+node+" AND memberrole="+db.cite(member));
            if(db.next())
            {
           	 id = db.getInt(1);
            }
        } finally
        {
            db.close();
        }

        return id;
    }
    public int getArid()
    {
    	return arid;
    }
    public int getNode()
    {
    	return node;
    }
	public String getNrname()
	{
		if(nrname==null)
		{
			nrname = "/";
		}
		return nrname;
	}

	public Date getTimes()
	{
		return times;
	}

	public String getCommunity()
	{
		return community;
	}

	public String getMember()
	{
		return member;
	}
	public String getMemberrole()
	{
		return memberrole;
	}

	public boolean isExists()
	{
		return exists;
	}
    public boolean isNr(int nr)
    {

    	if(this.getNrname()!=null && this.getNrname().indexOf("/"+nr+"/")!=-1)
    	{
    		return true;
    	}
    	return false;
    }
    //通过登录用户 判断是否有权限
    public static boolean isRole(String community,String member,int node,int nr)throws SQLException
    {
    	boolean f = false;
    	if(Node.find(node).getType()==0){
    		f = true;
    	}else{
	    	AdminUsrRole ruobj = AdminUsrRole.find(community,member);
	    	if(ruobj.getRole()!=null && ruobj.getRole().length()>0)
	    	{
	    		for(int i=1;i<ruobj.getRole().split("/").length;i++)
	    		{
	    			int r = Integer.parseInt(ruobj.getRole().split("/")[i]);


	    			  NodeRole nrobj = NodeRole.find(NodeRole.getNrid(node, r));
	    			  NodeRole nrobj2 = NodeRole.find(NodeRole.getNrid(node, member));
	    			  if(nrobj.isNr(nr))
	    			  {
	    				  f = true;
	    				  break;
	    			  }else if(nrobj2.isNr(nr))
	    			  {
	    				  f = true;
	    				  break;
	    			  }
	    		}
	    	}
    	}

    	return f;
    }
    public static boolean isRole2(String community,String member,int node,int nr)throws SQLException
    {
    	boolean f = false;

	    	AdminUsrRole ruobj = AdminUsrRole.find(community,member);
	    	if(ruobj.getRole()!=null && ruobj.getRole().length()>0)
	    	{
	    		for(int i=1;i<ruobj.getRole().split("/").length;i++)
	    		{
	    			int r = Integer.parseInt(ruobj.getRole().split("/")[i]);


	    			  NodeRole nrobj = NodeRole.find(NodeRole.getNrid(node, r));
	    			  NodeRole nrobj2 = NodeRole.find(NodeRole.getNrid(node, member));

	    			  if(nrobj.isNr(nr))
	    			  {
	    				  f = true;
	    				  break;
	    			  }else if(nrobj2.isNr(nr))
	    			  {
	    				  f = true;
	    				  break;
	    			  }
	    		}
	    	}


    	return f;
    }
    //只能管理下级用户的新闻
    public static boolean isRole3(String community,String member,int node,int nr,int nodeid)throws SQLException
    {
    	boolean f = false;

	    	AdminUsrRole ruobj = AdminUsrRole.find(community,member);
	    	Node nobj = Node.find(nodeid);
	    	AdminUsrRole ruobj2 = AdminUsrRole.find(community,nobj.getCreator()._strR);

	    	if(ruobj.getRole()!=null && ruobj.getRole().length()>0)
	    	{
	    		for(int i=1;i<ruobj.getRole().split("/").length;i++)
	    		{
	    			int r = Integer.parseInt(ruobj.getRole().split("/")[i]);
	    			  NodeRole nrobj = NodeRole.find(NodeRole.getNrid(node, r));

	    			  AdminRole arobj = AdminRole.find(r);
	    			  NodeRole nrobj2 = NodeRole.find(NodeRole.getNrid(node, member));

	    			  if(nrobj.isNr(nr)&& nrobj.isR(r, ruobj2.getRole()))
	    			  {
	    				  f = true;
	    				  break;
	    			  }else if(nrobj2.isNr(nr)&& nrobj.isR(r, ruobj2.getRole()))
	    			  {
	    				  f = true;
	    				  break;
	    			  }
	    		}
	    	}

    	return f;
    }

    public static String getRole3(String community,String member,int nr,String websql)throws SQLException
    {

    	    StringBuffer sql = new StringBuffer();
    	    String sp = "";
    	    DbAdapter db = new DbAdapter();

    	    try
    	    {
	    	    db.executeQuery("SELECT n.node FROM Node n,Report r WHERE n.node=r.node  AND  community=" + db.cite(community) + websql);
	    	    while(db.next())
	    	    {
	    	    	int nodeid = db.getInt(1);
	    	    	Node nobj = Node.find(nodeid);
	    	    	int node = nobj.getFather();
			    	AdminUsrRole ruobj = AdminUsrRole.find(community,member);

			    	AdminUsrRole ruobj2 = AdminUsrRole.find(community,nobj.getCreator()._strR);

			    	if(ruobj.getRole()!=null && ruobj.getRole().length()>0)
			    	{
			    		for(int i=1;i<ruobj.getRole().split("/").length;i++)
			    		{
			    			int r = Integer.parseInt(ruobj.getRole().split("/")[i]);
			    			  NodeRole nrobj = NodeRole.find(NodeRole.getNrid(node, r));

			    			  AdminRole arobj = AdminRole.find(r);
			    			  NodeRole nrobj2 = NodeRole.find(NodeRole.getNrid(node, member));

			    			  if(nrobj.isNr(nr)&& nrobj.isR(r, ruobj2.getRole()))
			    			  {
			    				 sql.append(" n.node = ");
			    				  sql.append(nodeid).append(" or ");

			    			  }else if(nrobj2.isNr(nr)&& nrobj.isR(r, ruobj2.getRole()))
			    			  {
			    				  sql.append(" n.node = ");
			    				  sql.append(nodeid).append(" or ");
			    			  }
			    		}
			    	}
		    	}


	    	    if(sql!=null &&sql.length()>0)
	    		{

	    			 sp = sql.toString();
	    			 sp = sp.substring(0,sp.length()-3);
	    			 sp = "("+sp+")";

	    		}else
	    		{
	    			sp = "(1=-1)";
	    		}
    	    }finally
    	    {
    	    	db.close();
    	    }

    	return sp;
    }
    public static boolean isR(int r,String role)throws SQLException
    {
    	boolean f = false;
    	//System.out.println(r+"--"+role);
    	if(role!=null && role.length()>0)
    	{
    		for(int i=1;i<role.split("/").length;i++)
    		{
    			int r2 = Integer.parseInt(role.split("/")[i]);//获取新闻的添加人的角色
    			AdminRole ar = AdminRole.find(r);//登陆用户的角色
    			AdminRole ar2 = AdminRole.find(r2);
    			//System.out.println(ar.getLevels()+"--"+ar2.getLevels());
    			if(ar.getLevels()<=ar2.getLevels())//登陆用户级别比新闻添加用户级别高，可以操作
    			{
    				f = true;
    				break;
    			}

    		}
    	}

    	return f;

    }





}
