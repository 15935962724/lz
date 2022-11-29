package tea.entity.yl.shopnew;

import java.io.InputStream;
import java.net.URL;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Timer;
import java.util.TimerTask;

import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;
import org.springframework.jdbc.object.RdbmsOperation;

import tea.db.DbAdapter;
import tea.entity.Cache;
import tea.entity.Filex;
import tea.entity.Seq;
import tea.entity.yl.shopnew.Invoice;
import tea.entity.yl.shop.*;

/**
 * 开票、退票、回款改变的粒子数和回款数
 * @author yantong
 * */
public class ChangeYingshouData {

	protected static Cache c = new Cache(50);
	
	private int id;				
	private int hospitalid;		//医院id
	private int isback;		    // 0：后台设置
	public static String[] ISBACK={"后台设置","开具发票","退票","回款"};//前3种都是后台改变的，后4种都是下单或者开具发票或者回款时改变的。
	private Double noreply;		//未回款金额
	private Date timespot2;	    //应收账款日期节点
	private int member;         //创建人
	private Date createdate;    //创建日期
	private int replyid;        //回款id
	private int ordernum;       //自动增长（每个医院从1开始）
	private int invoiceid;      //发票号
	
	public ChangeYingshouData(int id){
		this.id = id;
	}
	
	public static ArrayList<ChangeYingshouData> find(String sql,int pos,int size){
		ArrayList<ChangeYingshouData> list = new ArrayList<ChangeYingshouData>();
		DbAdapter db = new DbAdapter();
		String QSql = "select cyd.id,cyd.hospitalid,cyd.isback,cyd.noreply,cyd.timespot2,cyd.member,cyd.createdate,cyd.replyid,cyd.ordernum,cyd.invoiceid from ChangeYingshouData cyd "+tab(sql)+" where 1=1 " + sql;
		try {
			ResultSet rs = db.executeQuery(QSql, pos, size);
			while(rs.next()){
				int i = 1;
				ChangeYingshouData s = new ChangeYingshouData(rs.getInt(i++));
				s.setHospitalid(rs.getInt(i++));
				s.setIsback(rs.getInt(i++));
				s.setNoreply(rs.getDouble(i++));
				s.setTimespot2(db.getDate(i++));
				s.setMember(rs.getInt(i++));
				s.setCreatedate(db.getDate(i++));
				s.setReplyid(rs.getInt(i++));
				s.setOrdernum(rs.getInt(i++));
				s.setInvoiceid(rs.getInt(i++));
				c.put(s.id, s);
				list.add(s);
			}
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			db.close();
		}
		return list;
	}

	private static String tab(String sql)
	{
		StringBuilder sb = new StringBuilder();
		if (sql.contains(" AND sho."))
			sb.append(" INNER JOIN ShopHospital sho ON sho.id=cyd.hospitalid");
		return sb.toString();
	}
	
	public static ArrayList<Integer> findhid(String sql,int pos,int size){
		ArrayList<Integer> list = new ArrayList<Integer>();
		DbAdapter db = new DbAdapter();
		String QSql = "select hospitalid from ChangeYingshouData where 1=1 " + sql;
		try {
			ResultSet rs = db.executeQuery(QSql, pos, size);
			while(rs.next()){
				
				list.add(rs.getInt(1));
			}
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			db.close();
		}
		return list;
	}
	
	public static int count(String sql) throws SQLException{
		return DbAdapter.execute("select count(0) from ChangeYingshouData cyd "+tab(sql)+" where 1=1 " + sql);
	}
	
	public void set() throws SQLException{
		String sql = "";
		if(this.id < 1){
			sql = "insert into ChangeYingshouData(id,hospitalid,isback,noreply,timespot2,member,createdate,replyid,ordernum,invoiceid) values(" + (this.id = Seq.get()) + "," + this.hospitalid + "," + this.isback +","+ this.noreply + "," +DbAdapter.cite(this.timespot2) + "," +this.member + ","+DbAdapter.cite(this.createdate)+","+this.replyid+","+this.ordernum+","+this.invoiceid+")";
		}else{
			sql = "update ChangeYingshouData set hospitalid =" + this.hospitalid + ",isback = " + this.isback  + ",noreply = " + this.noreply +",timespot2="+DbAdapter.cite(this.timespot2) + ",member = "+this.member+",createdate = " + DbAdapter.cite(this.createdate)+",replyid="+this.replyid+",ordernum="+this.ordernum+",invoiceid="+this.invoiceid+" where id=" + this.id;
		}
		DbAdapter db = new DbAdapter();
		try {
			db.executeUpdate(this.id, sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			db.close();
		}
		c.remove(this.id);
	}
	
	public static void delete(int id){
		DbAdapter db = new DbAdapter();
		try {
			db.executeUpdate(id,"delete from ChangeYingshouData where id= " + id);
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			db.close();
		}
		c.remove(id);
	}
	
	public void set(String column,String value){
		DbAdapter db = new DbAdapter();
		try {
			db.executeUpdate(this.id, "update ChangeYingshouData set " + column + "=" + DbAdapter.cite(value) + " where id=" + this.id);
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			db.close();
		}
		c.remove(this.id);
	}
	/**
	 * 开票导致应收账款增加
	 * @param hid 医院id
	 * @param amount 开票金额
	 * @param timespot 时间节点
	 * @param member 操作人
	 * @param invoid 发票id
	 */
	public static void addyingshou(int hid,double amount,Date timespot,int member,int invoid){
		try {
			ChangeYingshouData ldata=new ChangeYingshouData(0);
			//查询最后一次记录的应收账款
			List<ChangeYingshouData> lstc=ChangeYingshouData.find(" and hospitalid = "+hid+" order by ordernum desc ", 0, Integer.MAX_VALUE);
			double noreply3=0;
			int ordernum=0;
			if(lstc.size()>0){
				ChangeYingshouData cdata=lstc.get(0);
				noreply3=cdata.getNoreply();
				ordernum=cdata.getOrdernum();
			}
			
			double noreply2=noreply3+amount;//应收账款增加
			ldata.setHospitalid(hid);//医院id
			ldata.setIsback(1);//开票
			ldata.setNoreply(noreply2);//应收账款
			ldata.setTimespot2(timespot);//日期节点
			ldata.setMember(member);
			ldata.setCreatedate(new Date());
			ldata.setOrdernum(ordernum+1);
			ldata.setInvoiceid(invoid);//发票id
			ldata.set();
		} catch (Exception e) {
			// TODO: handle exception
		}
		
	}
	
	/**
	 * 退票导致应收账款减少
	 * @param hid 医院id
	 * @param amount 开票金额
	 * @param timespot 时间节点
	 * @param member 操作人
	 * @param invoid 发票id
	 */
	public static void jianyingshou(int hid,double amount,Date timespot,int member,int invoid){
		try {
			ChangeYingshouData ldata=new ChangeYingshouData(0);
			//查询最后一次记录的应收账款
			List<ChangeYingshouData> lstc=ChangeYingshouData.find(" and hospitalid = "+hid+" order by ordernum desc ", 0, Integer.MAX_VALUE);
			double noreply3=0;
			int ordernum=0;
			if(lstc.size()>0){
				ChangeYingshouData cdata=lstc.get(0);
				noreply3=cdata.getNoreply();
				ordernum=cdata.getOrdernum();
			}
			
			double noreply2=noreply3-amount;//应收账款减少
			ldata.setHospitalid(hid);//医院id
			ldata.setIsback(2);//退票
			ldata.setNoreply(noreply2);//应收账款
			ldata.setTimespot2(timespot);//日期节点
			ldata.setMember(member);
			ldata.setCreatedate(new Date());
			ldata.setOrdernum(ordernum+1);
			ldata.setInvoiceid(invoid);//发票id
			ldata.set();
		} catch (Exception e) {
			// TODO: handle exception
		}
		
	}
	
	/**
	 * 回款导致应收账款减少
	 * @param hid 医院id
	 * @param replyprice 回款金额
	 * @param timespot 时间节点
	 * @param member 操作人
	 * @param replyid 回款id
	 */
	public static void jianyingshou2(int hid,double replyprice,Date timespot,int member,int replyid){
		try {
			ChangeYingshouData ldata=new ChangeYingshouData(0);
			//查询最后一次记录的应收账款
			List<ChangeYingshouData> lstc=ChangeYingshouData.find(" and hospitalid = "+hid+" order by ordernum desc ", 0, Integer.MAX_VALUE);
			double noreply3=0;
			int ordernum=0;
			if(lstc.size()>0){
				ChangeYingshouData cdata=lstc.get(0);
				noreply3=cdata.getNoreply();
				ordernum=cdata.getOrdernum();
			}
			double noreply2=noreply3-replyprice;//应收账款减少
			ldata.setHospitalid(hid);//医院id
			ldata.setIsback(3);//回款
			ldata.setNoreply(noreply2);//应收账款
			ldata.setTimespot2(timespot);//日期节点
			ldata.setMember(member);
			ldata.setCreatedate(new Date());
			ldata.setOrdernum(ordernum+1);
			ldata.setReplyid(replyid);//回款id
			ldata.set();
		} catch (Exception e) {
			// TODO: handle exception
		}
		
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getHospitalid() {
		return hospitalid;
	}

	public void setHospitalid(int hospitalid) {
		this.hospitalid = hospitalid;
	}

	public int getIsback() {
		return isback;
	}

	public void setIsback(int isback) {
		this.isback = isback;
	}

	public Double getNoreply() {
		return noreply;
	}

	public void setNoreply(Double noreply) {
		this.noreply = noreply;
	}

	public Date getTimespot2() {
		return timespot2;
	}

	public void setTimespot2(Date timespot2) {
		this.timespot2 = timespot2;
	}

	public int getMember() {
		return member;
	}

	public void setMember(int member) {
		this.member = member;
	}

	public Date getCreatedate() {
		return createdate;
	}

	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}

	public int getReplyid() {
		return replyid;
	}

	public void setReplyid(int replyid) {
		this.replyid = replyid;
	}

	public int getOrdernum() {
		return ordernum;
	}

	public void setOrdernum(int ordernum) {
		this.ordernum = ordernum;
	}

	public int getInvoiceid() {
		return invoiceid;
	}

	public void setInvoiceid(int invoiceid) {
		this.invoiceid = invoiceid;
	}
	
	

}
