package tea.entity.node.access;

import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.TimerTask;
import tea.db.ConnectionPool;
import tea.db.DbAdapter;

/** */
/**
 * 统计任务
 * 
 * @author westd
 * 
 */ 
public class NodeAccessTrans extends TimerTask {
	public NodeAccessTrans() {
	  System.out.println("==启动访问统计进程==");
	}

	public static long fromDateStringToLong(String inVal) { // 此方法计算时间毫秒
		Date date = null; // 定义时间类型
		SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-mm-dd");

		try {
			date = (Date) inputFormat.parse(inVal); // 将字符型转换成日期型
		} catch (Exception e) {
			e.printStackTrace();
		}
		return date.getTime(); // 返回毫秒数
	}

	public void run() {
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date times = new Date(); // 当前时间
		System.out.println("开始更新访问统计时间:" + sdf.format(times));
		try {
			if (cal.get(Calendar.DAY_OF_MONTH) == 1&& cal.get(Calendar.HOUR_OF_DAY) == 1){
				if(!NodeAccess.isTransfered(ConnectionPool._nType)){
					this.NodeAccessTransHotLast();
					this.NodeAccessTransHotByAddTime_Mzb();
					this.NodeAccessTransHot();
					this.NodeAccessRefererTrans();
					NodeAccess.clearmonth(ConnectionPool._nType);
				}
			}else if (cal.get(Calendar.HOUR_OF_DAY) == 1){
				if(!NodeAccess.isTransfered(ConnectionPool._nType)){
					this.NodeAccessTransHot();
					//this.NodeAccessTransHot_Mzb();
					this.NodeAccessRefererTrans();
					NodeAccess.clearday(ConnectionPool._nType);
				}				
				//更新栏目节点总访问点击量
				NodeAccessColumn.updateByNode("");
			}
			
			if (ConnectionPool._nType == 1)
				this.NodeAccessLastTransMssql();
			else if (ConnectionPool._nType == 0)
				this.NodeAccessLastTransMysql();
			else if (ConnectionPool._nType == 2)
				this.NodeAccessLastTransOracle();

		} catch (Exception ex) {
			System.out.println("你没有配置“访问统计”的连接库~");
		}
		times = new Date();
		System.out.println("结束时间:" + sdf.format(times));

	}

	public void NodeAccessLastTransMssql() {
		DbAdapter db = new DbAdapter(8);
		DbAdapter db1 = new DbAdapter(8);
		DbAdapter db2 = new DbAdapter(8);
		System.out.println("==访问统计进程监控数据中。。。==");
		int maxid = 0;
		String community = "", time = "", address = "";
		int count = 0, sum = 0, pv = 0, ip = 0;
		// 取最大id
		try {
			maxid = db.getInt("select max(id) from NodeAccessLast") - 30;
			// 日统计更新
			db.executeQuery("select community,count(1) as pv, "
					+ " count(distinct ip+str(year(time),4)+ltrim(str(month(time)))+ltrim(str(day(time)))+ltrim(str(datepart(hour,time)))) as ip, "
					+ " str(year(time),4)+'-'+ltrim(str(month(time)))+'-'+ltrim(str(day(time))) as time "
					+ " from NodeAccessLast  where community is not null and id <"
					+ maxid
					+ " group by community,str(year(time),4)+'-'+ltrim(str(month(time)))+'-'+ltrim(str(day(time)))");

			while (db.next()) {
				community = db.getString(1);
				pv = db.getInt(2);
				ip = (int) (db.getInt(3) / 1.3);
				time = db.getString(4);
				count = db1
						.getInt("select count(1) from NodeAccessDay where community="
								+ DbAdapter.cite(community)
								+ " and time="
								+ DbAdapter.cite(time));
				if (count == 0)
					db2.executeUpdate("insert into NodeAccessDay(community,pv,ip,time) values("
							+ DbAdapter.cite(community)
							+ ","+ pv
							+ ","+ ip
							+ "," + DbAdapter.cite(time) + ")");
				else

					db2.executeUpdate("update  NodeAccessDay set pv=pv+" + pv
							+ ",ip=ip+" + ip + " where community="
							+ DbAdapter.cite(community) + " and time="
							+ DbAdapter.cite(time));
			}
			// 月统计更新
			db.executeQuery("select community,count(1) as pv, "
					+ "count(distinct ip+str(year(time),4)+ltrim(str(month(time)))+ltrim(str(day(time)))+ltrim(str(datepart(hour,time)))) as ip, "
					+ "str(year(time),4)+'-'+ltrim(str(month(time)))+'-1' as time "
					+ "from NodeAccessLast  where community is not null and id <"
					+ maxid
					+ " group by community,str(year(time),4)+'-'+ltrim(str(month(time)))+'-1'");
			while (db.next()) {
				community = db.getString(1);
				pv = db.getInt(2);
				ip = (int) (db.getInt(3) / 1.3);
				time = db.getString(4);
				count = db1
						.getInt("select count(1) from NodeAccessMonth where community="
								+ DbAdapter.cite(community)
								+ " and time="
								+ DbAdapter.cite(time));
				if (count == 0)
					db2.executeUpdate("insert into NodeAccessMonth(community,pv,ip,time) values("
							+ DbAdapter.cite(community)
							+ ","+ pv
							+ ","+ ip
							+ "," + DbAdapter.cite(time) + ")");
				else

					db2.executeUpdate("update  NodeAccessMonth set pv=pv+" + pv
							+ ",ip=ip+" + ip + " where community="
							+ DbAdapter.cite(community) + " and time="
							+ DbAdapter.cite(time));
			}
			// 小时统计更新
			db.executeQuery("select community,count(1) as pv, "
					+ "count(1) as ip, "
					+ "str(year(time),4)+'-'+ltrim(str(month(time)))+'-'+ltrim(str(day(time)))+' ' +ltrim(str(datepart(hour,time)))+':0:0' as time "
					+ "from NodeAccessLast  where community is not null and id <"
					+ maxid
					+ " group by community,str(year(time),4)+'-'+ltrim(str(month(time)))+'-'+ltrim(str(day(time))) +' ' +ltrim(str(datepart(hour,time)))+':0:0'");

			int cc = 1;
			while (db.next()) {
				//System.out.println("小时统计有记录：" + (cc++));
				community = db.getString(1);
				pv = db.getInt(2);
				ip = (int) (db.getInt(3) / 1.3);
				time = db.getString(4);
				count = db1
						.getInt("select count(1) from NodeAccessHour where community="
								+ DbAdapter.cite(community)
								+ " and time="
								+ DbAdapter.cite(time));
				if (count == 0)
					db2.executeUpdate("insert into NodeAccessHour(community,sum,count,time) values("
							+ DbAdapter.cite(community)
							+ ","+ pv
							+ ","+ pv
							+ "," + DbAdapter.cite(time) + ")");
				else

					db2.executeUpdate("update  NodeAccessHour set sum=sum+"
							+ pv + ",count=count+" + pv + " where community="
							+ DbAdapter.cite(community) + " and time="
							+ DbAdapter.cite(time));
			}

			// 城市统计更新
			db.executeQuery(" select community,count(1) as sum,address,str(year(time),4)+'-'+ltrim(str(month(time)))+'-'+ltrim(str(day(time))) as time "
					+ " from NodeAccessLast where community is not null and id <"
					+ maxid
					+ " group by community,address,str(year(time),4)+'-'+ltrim(str(month(time)))+'-'+ltrim(str(day(time)))");

			while (db.next()) {
				community = db.getString(1);
				sum = db.getInt(2);
				address = db.getVarchar(1, 1, 3);
				time = db.getString(4);
				count = db1
						.getInt("select count(1) from NodeAccessCity where community="
								+ DbAdapter.cite(community)
								+ " and address="
								+ DbAdapter.cite(address)
								+ " and time="
								+ DbAdapter.cite(time));
				if (count == 0)
				  db2.executeUpdate("insert into NodeAccessCity(community,count,sum,address,time) values("
							+ DbAdapter.cite(community)
							+ ","+ 0+ ","+ sum	+ ","+ DbAdapter.cite(address)+ ","+ DbAdapter.cite(time) + ")");
				else
				  db2.executeUpdate("update  NodeAccessCity set sum=sum+"
							+ sum + " where community="
							+ DbAdapter.cite(community) + " and address="
							+ DbAdapter.cite(address) + " and time="
							+ DbAdapter.cite(time));

			}
			/*
			db2.executeUpdate("insert into NodeAccessLastHistory(id,community,node,ip,member,time,address,flag,isnewip,flag1) "
					+ "select id,community,node,ip,member,time,address,flag,isnewip,flag1 from NodeAccessLast"
					+ " where community is not null and id<" + maxid);
					*/
			db2.executeUpdate("delete from  NodeAccessLast where id<"
					+ maxid);

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			db2.close();
			db1.close();
			db.close();
		}

	}

	public void NodeAccessLastTransMysql() {
		DbAdapter db = new DbAdapter(8);
		DbAdapter db1 = new DbAdapter(8);
		DbAdapter db2 = new DbAdapter(8);

		int maxid = 0;
		String community = "", time = "", address = "";

		int count = 0, sum = 0, pv = 0, ip = 0;
		// 取最大id
		try {

			maxid = db.getInt("select max(id) from NodeAccessLast");
			// 日统计更新
			db.executeQuery("SELECT community, count( 1 ) AS pv, count( DISTINCT concat( ip, year( time ) , month( time ) , day( time ) , hour( time ) ) ) AS ip,"
					+ " concat( year( time ) , '-', month( time ) , '-', day( time ) ) AS time "
					+ " FROM NodeAccessLast WHERE community IS NOT NULL AND id <"
					+ maxid
					+ " GROUP BY community, concat( year( time ) , '-', month( time ) , '-', day( time ) ) ");

			while (db.next()) {
				community = db.getString(1);
				pv = db.getInt(2);
				ip = 1 + (int) (db.getInt(3) / 1.3);
				time = db.getString(4);
				count = db1
						.getInt("select count(1) from NodeAccessDay where community="
								+ DbAdapter.cite(community)
								+ " and time="
								+ DbAdapter.cite(time));
				if (count == 0)
					db2.executeUpdate("insert into NodeAccessDay(community,pv,ip,time) values("
							+ DbAdapter.cite(community)
							+ ","
							+ pv
							+ ","
							+ ip
							+ "," + DbAdapter.cite(time) + ")");
				else

					db2.executeUpdate("update  NodeAccessDay set pv=pv+" + pv
							+ ",ip=ip+" + ip + " where community="
							+ DbAdapter.cite(community) + " and time="
							+ DbAdapter.cite(time));
			}
			// 月统计更新
			db.executeQuery("SELECT community, count( 1 ) AS pv, count( DISTINCT concat( ip, year( time ) , month( time ) , day( time ) , hour( time ) ) ) AS ip, "
					+ " concat( year( time ) , '-', month( time ) , '-1' ) AS time"
					+ " FROM NodeAccessLast WHERE community IS NOT NULL AND id <"
					+ maxid
					+ " GROUP BY community, concat( year( time ) , '-', month( time ) , '-1' )");
			while (db.next()) {
				community = db.getString(1);
				pv = db.getInt(2);
				ip = 1 + (int) (db.getInt(3) / 1.3);
				time = db.getString(4);
				count = db1
						.getInt("select count(1) from NodeAccessMonth where community="
								+ DbAdapter.cite(community)
								+ " and time="
								+ DbAdapter.cite(time));
				if (count == 0)
					db2.executeUpdate("insert into NodeAccessMonth(community,pv,ip,time) values("
							+ DbAdapter.cite(community)
							+ ","+ pv
							+ ","+ ip
							+ "," + DbAdapter.cite(time) + ")");
				else

					db2.executeUpdate("update  NodeAccessMonth set pv=pv+" + pv
							+ ",ip=ip+" + ip + " where community="
							+ DbAdapter.cite(community) + " and time="
							+ DbAdapter.cite(time));
			}
			// 小时统计更新
			db.executeQuery("SELECT community, count( 1 ) AS pv, count( 1 ) AS ip, "
					+ " concat( year( time ) , '-', month( time ) , '-', day( time ) , ' ', hour( time ) , ':0:0' ) AS time"
					+ " FROM NodeAccessLast WHERE community IS NOT NULL AND id <"
					+ maxid
					+ " GROUP BY community, concat( year( time ) , '-', month( time ) , '-', day( time ) , ' ', hour( time ) , ':0:0' ) ");
			while (db.next()) {
				community = db.getString(1);
				pv = db.getInt(2);
				ip = 1 + (int) (db.getInt(3) / 1.3);
				time = db.getString(4);
				count = db1
						.getInt("select count(1) from NodeAccessHour where community="
								+ DbAdapter.cite(community)
								+ " and time="
								+ DbAdapter.cite(time));
				if (count == 0)
					db2.executeUpdate("insert into NodeAccessHour(community,sum,count,time) values("
							+ DbAdapter.cite(community)
							+ ","+ pv
							+ ","+ pv
							+ "," + DbAdapter.cite(time) + ")");
				else
              	db2.executeUpdate("update  NodeAccessHour set sum=sum+"
							+ pv + ",count=count+" + pv + " where community="
							+ DbAdapter.cite(community) + " and time="
							+ DbAdapter.cite(time));
			}

			// 城市统计更新
			db.executeQuery(" select community,count(1) as sum,address,concat(year(time),'-',month(time),'-',day(time)) as time"
					+ "  from NodeAccessLast where community is not null and id <"
					+ maxid
					+ " group by community,address,concat(year(time),'-',month(time),'-',day(time))");

			while (db.next()) {
				community = db.getString(1);
				sum = db.getInt(2);
				address = db.getVarchar(1, 1, 3);
				time = db.getString(4);
				count = db1
						.getInt("select count(1) from NodeAccessCity where community="
								+ DbAdapter.cite(community)
								+ " and address="
								+ DbAdapter.cite(address)
								+ " and time="
								+ DbAdapter.cite(time));
				if (count == 0)
					db2.executeUpdate("insert into NodeAccessCity(community,count,sum,address,time) values("
							+ DbAdapter.cite(community)
							+ ","
							+ 0
							+ ","
							+ sum
							+ ","
							+ DbAdapter.cite(address)
							+ ","
							+ DbAdapter.cite(time) + ")");
				else

					db2.executeUpdate("update  NodeAccessCity set sum=sum+"
							+ sum + " where community="
							+ DbAdapter.cite(community) + " and address="
							+ DbAdapter.cite(address) + " and time="
							+ DbAdapter.cite(time));

			}
			/*
			db2.executeUpdate("insert into NodeAccessLastHistory(id,community,node,ip,member,time,address,flag,isnewip,flag1) "
					+ "select id,community,node,ip,member,time,address,flag,isnewip,flag1 from NodeAccessLast"
					+ " where community is not null and id<" + maxid);
					*/
			db2.executeUpdate("delete from  NodeAccessLast where community is not null and id<"
					+ maxid);

			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			db2.close();
			db1.close();
			db.close();
		}

	}

	public void NodeAccessLastTransOracle() {
		DbAdapter db = new DbAdapter(8);
		DbAdapter db1 = new DbAdapter(8);
		DbAdapter db2 = new DbAdapter(8);

		int maxid = 0;
		String community = "", time = "", address = "";
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

		int count = 0, sum = 0, pv = 0, ip = 0;
		// 取最大id
		try {

			maxid = db.getInt("select max(id) from NodeAccessLast");
			// 日统计更新
			db.executeQuery("SELECT community, count( 1 ) AS pv, count( DISTINCT  ip||to_char(time,'yyyy') || to_char(time,'MM') || to_char(time,'dd') || to_char(time,'hh24') ) AS ip,"
					+ " to_char(time,'yyyy') || '-'|| to_char(time,'MM')|| '-'|| to_char(time,'dd') AS time "
					+ " FROM NodeAccessLast WHERE community IS NOT NULL AND id <"
					+ maxid
					+ " GROUP BY community,   to_char(time,'yyyy')|| '-'|| to_char(time,'MM') || '-'|| to_char(time,'dd')  ");

			while (db.next()) {
				community = db.getString(1);
				pv = db.getInt(2);
				ip = 1 + (int) (db.getInt(3) / 1.3);
				time = db.getString(4);
				count = db1
						.getInt("select count(1) from NodeAccessDay where community="
								+ DbAdapter.cite(community)
								+ " and time="
								+ DbAdapter.cite(sdf.parse(time), false));
				if (count == 0)
					db2.executeUpdate("insert into NodeAccessDay(community,pv,ip,time) values("
							+ DbAdapter.cite(community)
							+ ","
							+ pv
							+ ","
							+ ip
							+ ","
							+ DbAdapter.cite(sdf.parse(time), false)
							+ ")");
				else

					db2.executeUpdate("update  NodeAccessDay set pv=pv+" + pv
							+ ",ip=ip+" + ip + " where community="
							+ DbAdapter.cite(community) + " and time="
							+ DbAdapter.cite(sdf.parse(time), false));
			}
			// 月统计更新
			db.executeQuery("SELECT community, count( 1 ) AS pv, count( DISTINCT  ip|| to_char(time,'yyyy') || to_char(time,'MM') || to_char(time,'dd')|| to_char(time,'hh24') ) AS ip, "
					+ "  to_char(time,'yyyy') || '-' || to_char(time,'MM')|| '-1'  AS time"
					+ " FROM NodeAccessLast WHERE community IS NOT NULL AND id <"
					+ maxid
					+ " GROUP BY community,    to_char(time,'yyyy') || '-' ||to_char(time,'MM') || '-1' ");
			while (db.next()) {
				community = db.getString(1);
				pv = db.getInt(2);
				ip = 1 + (int) (db.getInt(3) / 1.3);
				time = db.getString(4);
				count = db1
						.getInt("select count(1) from NodeAccessMonth where community="
								+ DbAdapter.cite(community)
								+ " and time="
								+ DbAdapter.cite(sdf.parse(time), false));
				if (count == 0)
					db2.executeUpdate("insert into NodeAccessMonth(community,pv,ip,time) values("
							+ DbAdapter.cite(community)
							+ ","
							+ pv
							+ ","
							+ ip
							+ ","
							+ DbAdapter.cite(sdf.parse(time), false)
							+ ")");
				else

					db2.executeUpdate("update  NodeAccessMonth set pv=pv+" + pv
							+ ",ip=ip+" + ip + " where community="
							+ DbAdapter.cite(community) + " and time="
							+ DbAdapter.cite(sdf.parse(time), false));
			}
			// 小时统计更新
			db.executeQuery("SELECT community, count( 1 ) AS pv, count( 1 ) AS ip, "
					+ "  to_char(time,'yyyy')|| '-'|| to_char(time,'MM') ||'-'|| to_char(time,'dd') || ' '|| to_char(time,'hh24') || ':0:0'   AS time"
					+ " FROM NodeAccessLast WHERE community IS NOT NULL AND id <"
					+ maxid
					+ " GROUP BY community,  to_char(time,'yyyy') || '-' || to_char(time,'MM') || '-' || to_char(time,'dd') || ' ' || to_char(time,'hh24') || ':0:0'  ");
			while (db.next()) {
				community = db.getString(1);
				pv = db.getInt(2);
				ip = 1 + (int) (db.getInt(3) / 1.3);
				time = db.getString(4);
				count = db1
						.getInt("select count(1) from NodeAccessHour where community="
								+ DbAdapter.cite(community)
								+ " and time="
								+ DbAdapter.cite(sdf1.parse(time), false));
				if (count == 0)
					db2.executeUpdate("insert into NodeAccessHour(community,sum,count,time) values("
							+ DbAdapter.cite(community)
							+ ","
							+ pv
							+ ","
							+ pv
							+ ","
							+ DbAdapter.cite(sdf1.parse(time), false)
							+ ")");
				else

					db2.executeUpdate("update  NodeAccessHour set sum=sum+"
							+ pv + ",count=count+" + pv + " where community="
							+ DbAdapter.cite(community) + " and time="
							+ DbAdapter.cite(sdf1.parse(time), false));
			}

			// 城市统计更新
			db.executeQuery(" select community,count(1) as sum,address, to_char(time,'yyyy')||'-'||to_char(time,'MM')||'-'||to_char(time,'dd')  as time"
					+ "  from NodeAccessLast where community is not null and id <"
					+ maxid
					+ " group by community,address, to_char(time,'yyyy')||'-'||to_char(time,'MM')||'-'||to_char(time,'dd')");

			while (db.next()) {
				community = db.getString(1);
				sum = db.getInt(2);
				address = db.getVarchar(1, 1, 3);
				time = db.getString(4);
				count = db1
						.getInt("select count(1) from NodeAccessCity where community="
								+ DbAdapter.cite(community)
								+ " and address="
								+ DbAdapter.cite(address)
								+ " and time="
								+ DbAdapter.cite(sdf.parse(time), false));
				if (count == 0)
					db2.executeUpdate("insert into NodeAccessCity(community,count,sum,address,time) values("
							+ DbAdapter.cite(community)
							+ ","
							+ 0
							+ ","
							+ sum
							+ ","
							+ DbAdapter.cite(address)
							+ ","
							+ DbAdapter.cite(sdf.parse(time), false) + ")");
				else

					db2.executeUpdate("update  NodeAccessCity set sum=sum+"
							+ sum + " where community="
							+ DbAdapter.cite(community) + " and address="
							+ DbAdapter.cite(address) + " and time="
							+ DbAdapter.cite(sdf.parse(time), false));

			}
			/*
			db2.executeUpdate("insert into NodeAccessLastHistory(id,community,node,ip,member,time,address,flag,isnewip,flag1) "
					+ "select id,community,node,ip,member,time,address,flag,isnewip,flag1 from NodeAccessLast"
					+ " where community is not null and id<" + maxid);
					*/
			db2.executeUpdate("delete from  NodeAccessLast where community is not null and id<"
					+ maxid);

			
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ParseException e) {
			e.printStackTrace();
		} finally {
			db2.close();
			db1.close();
			db.close();
		}

	}

	public void NodeAccessTransHot() {

		DbAdapter db2 = new DbAdapter(8);
       try { 
    	   StringBuffer sb = new StringBuffer("");
			if (ConnectionPool._nType == 1) {// sql 2005
				/*db2.executeUpdate("delete from NodeAccessHot where datediff(day,time,getdate())=1;");
				sb.append("insert into NodeAccessHot(community,node,click,time)");
				sb.append(" select top 100 na.community,na.node,count(na.node) as click ,");
				sb.append(" ltrim(str(year(na.time)))+'-'+ltrim(str(month(na.time)))+'-'+ltrim(str(day(na.time)))");
				sb.append(" from NodeAccessLastHistory na ");
				sb.append(" where datediff(day,na.time,getdate())=1 and  na.isnewip<>0 and na.isnewip<>1");
				sb.append(" group by na.community,na.node,ltrim(str(year(na.time)))+'-'+ltrim(str(month(na.time)))+'-'+ltrim(str(day(na.time)))");
				sb.append(" order by count(na.node) desc;");
				db2.executeUpdate(sb.toString());
			*/
				//this.NodeAccessTransHot_Mzb();
				db2.executeUpdate("delete from NodeAccessHot where datediff(day,time,getdate())=1;");
				sb.append("insert into NodeAccessHot(community,node,click,time)");
				sb.append(" select top 100 na.community,na.node,sum(na.thisday)  as click , ");
				sb.append(" ltrim(str(year(na.transdate)))+'-'+ltrim(str(month(na.transdate)))+'-'+ltrim(str(day(na.transdate)))");
		    	sb.append(" from NodeAccess na ");
				sb.append(" where datediff(day,na.transdate,getdate())=1 and na.type=39"); 
				sb.append(" group by na.community,na.node ,ltrim(str(year(na.transdate)))+'-'+ltrim(str(month(na.transdate)))+'-'+ltrim(str(day(na.transdate)))");
				sb.append(" order by sum(na.thisday) desc;");
				db2.executeUpdate(sb.toString());
				
			} else if (ConnectionPool._nType == 0) {// mysql、
				db2.executeUpdate("delete from NodeAccessHot where  year(time)=year(CURRENT_DATE()) and month(time)=month(CURRENT_DATE()) ;");
				sb.append("insert into NodeAccessHot(community,node,click,time)");
				sb.append(" select na.community,na.node,sum(na.thisday)  as click , ");
				sb.append(" concat(year(na.transdate),'-',month(na.transdate),'-',day(na.transdate))");
		    	sb.append(" from NodeAccess na ");
		    	sb.append(" where year(na.transdate)=year(CURRENT_DATE()) and month(na.transdate)=month(CURRENT_DATE()) and na.type=39 ");
		    	sb.append(" group by na.community,na.node,");
				sb.append(" concat(year(na.transdate),'-',month(na.transdate),'-',day(na.transdate))");
				sb.append(" order by sum(na.thisday) desc limit 0,100;");
				db2.executeUpdate(sb.toString());
			} else if (ConnectionPool._nType == 2) {// oracle
				db2.executeUpdate("delete from NodeAccessHot where  to_char(time,'yyyy')=to_char(sysdate,'yyyy') and to_char(time,'MM')=to_char(sysdate,'MM') ");
				sb.append("insert into NodeAccessHot(community,node,click,time)");
				sb.append(" select na.community,na.node,sum(na.thisday)  as click , ");
				sb.append(" to_date(to_char(na.transdate,'yyyy')||'-'||to_char(na.transdate,'MM')||'-'||to_char(na.transdate,'dd'),'yyyy-MM-dd')");
		    	sb.append(" from NodeAccess na ");
		    	sb.append(" where to_char(na.transdate,'yyyy')=to_char(sysdate,'yyyy') and to_char(na.transdate,'MM')=to_char(sysdate,'MM') and na.type=39 and rownum<100 ");
		    	sb.append(" group by na.community,na.node,");
				sb.append(" to_char(na.transdate,'yyyy')||'-'||to_char(na.transdate,'MM')||'-'||to_char(na.transdate,'dd')");
				sb.append(" order by sum(na.thisday) desc;");
				db2.executeUpdate(sb.toString());
			}
    	} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			db2.close();
		}

	}

	public void NodeAccessTransHotLast() {
		DbAdapter db2 = new DbAdapter(8);
		try {  
			StringBuffer sb = new StringBuffer("");
			if (ConnectionPool._nType == 1) {

				/*sb.append("insert into NodeAccessHot(community,node,click,time)");
				sb.append(" select top 100 na.community,na.node,count(na.node) as click ,");
				sb.append(" ltrim(str(year(na.time)))+'-'+ltrim(str(month(na.time)))+'-1'");
				sb.append(" from NodeAccessLastHistory na ");
				sb.append(" where datediff(month,na.time,getdate())=1 and  na.isnewip<>0 and na.isnewip<>1");
				sb.append(" group by na.community,na.node,ltrim(str(year(na.time)))+'-'+ltrim(str(month(na.time)))+'-1'");
				sb.append(" order by count(na.node) desc;");
        		db2.executeUpdate("delete from NodeAccessHot where datediff(month,time,getdate())=1;");
        		db2.executeUpdate(sb.toString());
        		*/
				//NodeAccessTransHotMonth_Mzb();
				db2.executeUpdate("delete from NodeAccessHot where datediff(month,time,getdate())=1;");
				sb.append("insert into NodeAccessHot(community,node,click,time)");
				sb.append(" select top 100 na.community,na.node,sum(na.thismonth)  as click , ");
				sb.append(" ltrim(str(year(na.transdate)))+'-'+ltrim(str(month(na.transdate)))+'-1'");
		    	sb.append(" from NodeAccess na ");
				sb.append(" where datediff(month,na.transdate,getdate())=1 and na.type=39 "); 
				sb.append(" group by na.community,na.node ,ltrim(str(year(na.transdate)))+'-'+ltrim(str(month(na.transdate)))+'-1'");
				sb.append(" order by sum(na.thismonth) desc;");
				db2.executeUpdate(sb.toString());
			} else if (ConnectionPool._nType == 0) {
				db2.executeUpdate("delete from NodeAccessHot where  year(time)=year(CURRENT_DATE()) and month(time)+1=month(CURRENT_DATE()) ;");
				sb.append("insert into NodeAccessHot(community,node,click,time)");
				sb.append(" select na.community,na.node,sum(na.thismonth)  as click , ");
				sb.append(" concat(year(na.transdate),'-',month(na.transdate),'-1')");
		    	sb.append(" from NodeAccess na ");
		    	sb.append(" where year(na.transdate)=year(CURRENT_DATE()) and month(na.transdate)+1=month(CURRENT_DATE()) and na.type=39 ");
		    	sb.append(" group by na.community,na.node,");
				sb.append(" concat(year(na.transdate),'-',month(na.transdate),'-1')");
				sb.append(" order by sum(na.thismonth) desc limit 0,100;");
				db2.executeUpdate(sb.toString());
			} else if (ConnectionPool._nType == 2) {// oracle
				db2.executeUpdate("delete from NodeAccessHot where to_char(time,'yyyy')=to_char(sysdate,'yyyy') and to_number(to_char(time,'MM'))+1=to_number(to_char(sysdate,'MM'))");
				sb.append("insert into NodeAccessHot(community,node,click,time)");
				sb.append(" select na.community,na.node,sum(na.thismonth)  as click , ");
				sb.append(" to_date(to_char(na.transdate,'yyyy')||'-'||to_char(na.transdate,'MM')||'-1','yyyy-MM-dd')");
		    	sb.append(" from NodeAccess na ");
		    	sb.append(" where to_char(na.transdate,'yyyy')=to_char(sysdate,'yyyy') and to_number(to_char(na.transdate,'MM'))+1=to_number(to_char(sysdate,'MM')) and na.type=39  and rownum<100 ");
		    	sb.append(" group by na.community,na.node,");
				sb.append(" to_char(na.transdate,'yyyy')||'-'||to_char(na.transdate,'MM')||'-1'");
				sb.append(" order by sum(na.thismonth) desc;");
				db2.executeUpdate(sb.toString());
			}
		
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			db2.close();
		}

	}
	public void NodeAccessTransHot_Mzb() {

		DbAdapter db2 = new DbAdapter(8);
       try { 
    	   StringBuffer sb = new StringBuffer("");
		
				db2.executeUpdate("delete from NodeAccessHot where datediff(day,time,getdate())=1;");
				sb.append("insert into NodeAccessHot(community,node,click,time)");
				sb.append(" select top 100 na.community,na.node,sum(na.thisday)  as click , ");
				sb.append(" ltrim(str(year(na.transdate)))+'-'+ltrim(str(month(na.transdate)))+'-'+ltrim(str(day(na.transdate)))");
		    	sb.append(" from NodeAccess na ");
				sb.append(" where datediff(day,na.transdate,getdate())=1 and na.type=39"); 
				sb.append(" group by na.community,na.node ,ltrim(str(year(na.transdate)))+'-'+ltrim(str(month(na.transdate)))+'-'+ltrim(str(day(na.transdate)))");
				sb.append(" order by sum(na.thisday) desc;");
				db2.executeUpdate(sb.toString());
		
    	} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			db2.close();
		}

	}

	public void NodeAccessTransHotMonth_Mzb() {
		DbAdapter db2 = new DbAdapter(8);
		try {  
			StringBuffer sb = new StringBuffer("");
			db2.executeUpdate("delete from NodeAccessHot where datediff(month,time,getdate())=1;");
			sb.append("insert into NodeAccessHot(community,node,click,time)");
			sb.append(" select top 100 na.community,na.node,sum(na.thismonth)  as click , ");
			sb.append(" ltrim(str(year(na.transdate)))+'-'+ltrim(str(month(na.transdate)))+'-1'");
	    	sb.append(" from NodeAccess na ");
			sb.append(" where datediff(month,na.transdate,getdate())=1 and na.type=39 "); 
			sb.append(" group by na.community,na.node ,ltrim(str(year(na.transdate)))+'-'+ltrim(str(month(na.transdate)))+'-1'");
			sb.append(" order by sum(na.thismonth) desc;");
			db2.executeUpdate(sb.toString());

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			db2.close();
		}
	}
	
	public void NodeAccessTransHotByAddTime_Mzb() {
		DbAdapter db2 = new DbAdapter(8);
		try {  
			StringBuffer sb = new StringBuffer("");
			db2.executeUpdate("delete from NodeAccessHot where datediff(month,time,getdate())=1;");
			sb.append("insert into NodeAccessHotByMonth(community,node,click,time)");
			sb.append(" select top 100 na.community,na.node,sum(na.thismonth)  as click , ");
			sb.append(" ltrim(str(year(na.addtime)))+'-'+ltrim(str(month(na.addtime)))+'-1'");
	    	sb.append(" from NodeAccess na ");
			sb.append(" where datediff(month,na.addtime,getdate())=1  and na.type=39 "); 
			sb.append(" group by na.community,na.node,ltrim(str(year(na.addtime)))+'-'+ltrim(str(month(na.addtime)))+'-1' ");
			sb.append(" order by sum(na.thismonth) desc;");
			db2.executeUpdate(sb.toString());

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			db2.close();
		}

	}
	
	public void NodeAccessRefererTrans() {

		// NodeAccessReferer 的统计数据导入 NodeAccessFrom
		DbAdapter db2 = new DbAdapter(8);
		try {
			StringBuffer sb = new StringBuffer("");
			if (ConnectionPool._nType == 1) {
				db2.executeUpdate("delete from  NodeAccessFrom where datediff(day,time,getdate())=1");
				db2.executeUpdate("insert into NodeAccessFrom(community,count,sum,domain,time) "
						+ "select community,sum(sum),sum(sum),domain,str(year(time),4)+'-'+ltrim(str(month(time)))+'-'+ltrim(str(day(time)))"
						+ "from NodeAccessReferer "
						+ "where community is not null and datediff(day,time,getdate())=1"
						+ "group by community,domain,str(year(time),4)+'-'+ltrim(str(month(time)))+'-'+ltrim(str(day(time)))");
				db2.executeUpdate("delete from  NodeAccessReferer where datediff(day,time,getdate())>1");
			
			} else if (ConnectionPool._nType == 0) {
				db2.executeUpdate("delete from  NodeAccessFrom ");
				db2.executeUpdate("insert into NodeAccessFrom(community,count,sum,domain,time) "
						+ "select community,sum(sum),sum(sum),domain,concat(year(time),'-',"
						+ "month(time),'-',day(time))"
						+ "from NodeAccessReferer "
						+ "where community is not null "
						+ "group by community,domain,concat(year(time),'-',month(time),'-',day(time))");
			} else if (ConnectionPool._nType == 2) {
				db2.executeUpdate("delete from  NodeAccessFrom");
				db2.executeUpdate("insert into NodeAccessFrom(community,count,sum,domain,time) "
						+ "select community,sum(sum),sum(sum),domain, to_date(to_char(time,'yyyy')||'-'||to_char(time,'MM')||'-'||"
						+ "to_char(time,'dd'),'yyyy-MM-dd')"
						+ "from NodeAccessReferer "
						+ "where community is not null "
						+ "group by community,domain,to_char(time,'yyyy')||'-'||to_char(time,'MM')||'-'||to_char(time,'dd')");

			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			db2.close();
		}
	}

}
