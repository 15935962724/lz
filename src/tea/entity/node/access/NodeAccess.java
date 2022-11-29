package tea.entity.node.access;

import java.sql.SQLException;
import java.util.*;
import tea.db.ConnectionPool;
import tea.db.DbAdapter;
import tea.entity.*;
import tea.entity.node.Node;
import javax.servlet.http.*;
import tea.entity.member.*;
import tea.ui.*;

public class NodeAccess extends Entity
{
	private int id;
	private int node;
	private int thismonth;
	private int thisday;
	private Date addtime;
	private Date trandate;
	private String community;
	private int type;
    long daytotal,alltotal;
    
    public static void set(Node node) 
	{       
		   int count=0;
			DbAdapter db = new DbAdapter(8);
			try {
				count = db.getInt("select count(1) from NodeAccess where node="+ node._nNode );
				if (count == 0)
					db.executeUpdate("insert into NodeAccess(community,node,thismonth,thisday,addtime,transdate,type) values("
							+ DbAdapter.cite(node.getCommunity())
							+","+node._nNode + ","+ 1+ ","+ 1
							+ ","+ DbAdapter.cite(node.getTimeToString())
							+ ","+ DbAdapter.cite(sdf.format(new Date()))+ "," +node.getType()+ ")");
				else
    	db.executeUpdate("update  NodeAccess set thismonth=thismonth+1,thisday=thisday+1 where node="+node._nNode);
			} catch (SQLException e) {
			 
				e.printStackTrace();
			}finally
	        {
	            db.close();
	        }
 		 
	}
    
    public static void clearday(int ntype) 
    {
    	DbAdapter db = new DbAdapter(8);
		try {
			if(ntype==0){
				db.executeUpdate("update  NodeAccess set  thisday=0,transdate=getdate() where TIMESTAMPDIFF(day, transdate,NOW())>0");
			}else if(ntype==1){
				db.executeUpdate("update  NodeAccess set  thisday=0,transdate=getdate() where datediff(day, transdate,getdate())>0");
			}else if(ntype==2){
				db.executeUpdate("update  NodeAccess set  thisday=0,transdate=getdate() where to_date(to_char(sysdate,'yyyy-mm-dd'),'yyyy-mm-dd')-to_date(to_char(transdate,'yyyy-mm-dd'),'yyyy-mm-dd')>0");
			}
		} catch (SQLException e) {
		 
			e.printStackTrace();
		}finally
        {
            db.close();
        }	
    	
    }
    public static void clearmonth(int ntype) 
    {
    	DbAdapter db = new DbAdapter(8);
		try {
			if(ntype==0){
				db.executeUpdate("update  NodeAccess set   thisday=0,thismonth=0,transdate=NOW() where TIMESTAMPDIFF(month,transdate,NOW())>0");
			}else if(ntype==1){
				db.executeUpdate("update  NodeAccess set   thisday=0,thismonth=0,transdate=getdate() where datediff(month, transdate,getdate())>0");
			}else if(ntype==2){
				db.executeUpdate("update  NodeAccess set   thisday=0,thismonth=0,transdate=sysdate where months_between(to_date(to_char(sysdate,'yyyy-mm'),'yyyy-mm'),to_date(to_char(transdate,'yyyy-mm'),'yyyy-mm'))>0");
			}
		} catch (SQLException e) {
		 
			e.printStackTrace();
		}finally
        {
            db.close();
        }	
    	
    }
    
    public static boolean isTransfered(int ntype) throws SQLException
    {  int count=0;
    	DbAdapter db = new DbAdapter(8);
		try {
			if(ntype==0){
				count = db.getInt("select count(1) from NodeAccess where TIMESTAMPDIFF(day, transdate,NOW())>0");
			}else if(ntype==1){
				count = db.getInt("select count(1) from NodeAccess where datediff(day, transdate,getdate())>0");
			}else if(ntype==2){
				count = db.getInt("select count(1) from NodeAccess where to_date(to_char(sysdate,'yyyy-mm-dd'),'yyyy-mm-dd')-to_date(to_char(transdate,'yyyy-mm-dd'),'yyyy-mm-dd')>0");
			}
		}catch (SQLException e) {
			 
				e.printStackTrace();
			}finally
	        {
	            db.close();
	        }
		return count==0;
		
    }

    
    public static void Access(Node node,HttpServletRequest request,HttpSession session)
    {
        String addr = request.getRemoteAddr();
        //HttpSession session = request.getSession(true);
        try
        {
            TeaSession teasession = new TeaSession(request); 
            String community = node.getCommunity();
            // /////////
            if(community != null && community.length() > 0)
            {} else
            {
                community = teasession._strCommunity;
            }
            if(session.isNew())
            {
                OnlineList.create(session.getId(),community,null,addr);
            }
            // 最后二十位
            RV rv = ((RV) session.getAttribute("tea.RV"));
            String member = null;
            if(rv != null)
            {
                member = rv._strV;
            }
            // NodeAccessLast.create(community,node._nNode,addr,member);
            NodeAccessLast.create(community,node._nNode,addr,member,node.getType());
            NodeAccess.set(node);
            // 天统计
            String referer = request.getHeader("referer"); // 来源统计
            NodeAccessReferer.set(community,referer,request.getServerName());
        } catch(Exception ex)
        {
            System.out.println("NodeAccess:行100:" + ex.getMessage());
        }
    }

    
    private NodeAccess(String community)
    {
        this.community = community;
    }

    public static NodeAccess find(String community)
    {
        return new NodeAccess(community);
    }

    public int getDayTotal() throws SQLException
    {
        Calendar c = Calendar.getInstance();
        c.setTimeInMillis(System.currentTimeMillis());
        int day = c.get(Calendar.DAY_OF_MONTH);
        return NodeAccessDay.find(community,c.getTime()).getPv()[day - 1];
    }

    public int getDayTotal1() throws SQLException
    {
        int i = 0;
        DbAdapter db = new DbAdapter(8);
        try
        {
        	if (ConnectionPool._nType ==1)
            db.executeQuery("SELECT sum(pv) FROM NodeAccessDay WHERE community=" + DbAdapter.cite(community)
                            + " and datediff(day,time,getdate())=0");
        	else if (ConnectionPool._nType ==0)
        		  db.executeQuery("SELECT sum(pv) FROM NodeAccessDay WHERE community=" + DbAdapter.cite(community)
                          + " and TO_DayS( NOW( ) ) - TO_DayS( time )=0");
        	else if (ConnectionPool._nType ==2)
                db.executeQuery("SELECT sum(pv) FROM NodeAccessDay WHERE community=" + DbAdapter.cite(community)
                        + " and to_char(time,'yyyy')=to_char(sysdate,'yyyy') and to_char(time,'MM')=to_char(sysdate,'MM') and to_char(time,'dd')=to_char(sysdate,'dd')");
  
        	if(db.next())
            {
                i = db.getInt(1);
            }
        } catch(Exception e)
        {
            e.printStackTrace();
        } finally
        {
            db.close();
        }
        return i;
    }


    public long getAllTotal() throws SQLException
    {
        DbAdapter db = new DbAdapter(8);
        try
        {
            db.executeQuery("SELECT SUM(pv) FROM NodeAccessMonth WHERE community=" + DbAdapter.cite(community));
            if(db.next())
            {
                alltotal = db.getLong(1);
            }
        } finally
        {
            db.close();
        }
        return alltotal;

    }

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getNode() {
		return node;
	}

	public void setNode(int node) {
		this.node = node;
	}

	public int getThismonth() {
		return thismonth;
	}

	public void setThismonth(int thismonth) {
		this.thismonth = thismonth;
	}

	public int getThisday() {
		return thisday;
	}

	public void setThisday(int thisday) {
		this.thisday = thisday;
	}

	public Date getAddtime() {
		return addtime;
	}

	public void setAddtime(Date addtime) {
		this.addtime = addtime;
	}

	public Date getTrandate() {
		return trandate;
	}

	public void setTrandate(Date trandate) {
		this.trandate = trandate;
	}

	public String getCommunity() {
		return community;
	}

	public void setCommunity(String community) {
		this.community = community;
	}

	public long getDaytotal() {
		return daytotal;
	}

	public void setDaytotal(long daytotal) {
		this.daytotal = daytotal;
	}

	public long getAlltotal() {
		return alltotal;
	}

	public void setAlltotal(long alltotal) {
		this.alltotal = alltotal;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

}
