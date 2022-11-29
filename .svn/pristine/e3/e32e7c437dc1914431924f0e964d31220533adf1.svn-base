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
 * 下单、退货、改变已开票和未开票的粒子数
 * @author yantong
 * */
public class ChangeLiziData {

	protected static Cache c = new Cache(50);
	
	private int id;				
	private int hospitalid;		//医院id
	private int isback;		    //改变原因   0：后台设置  1：下单
	public static String[] ISBACK={"后台设置","下单","退货","开具发票","退票"};//前3种都是后台改变的，后4种都是下单或者开具发票或者回款时改变的。
	private int noinvoice;	    //未开票数量
	private int isinvoice;      //已开票数量 
	private Date timespot;	    //未开票粒子数日期节点
	private int member;         //创建人
	private Date createdate;    //创建日期
	private int ordernum;       //自动增长（每个医院从1开始）
	private String orderid;     //订单id
	private int exchangedid;    //退货id
	private int invoiceid;      //发票id
	
	public ChangeLiziData(int id){
		this.id = id;
	}
	
	public static ArrayList<ChangeLiziData> find(String sql,int pos,int size){
		ArrayList<ChangeLiziData> list = new ArrayList<ChangeLiziData>();
		DbAdapter db = new DbAdapter();
		String QSql = "select cl.id,cl.hospitalid,cl.isback,cl.noinvoice,cl.isinvoice,cl.timespot,cl.member,cl.createdate,cl.ordernum,cl.orderid,cl.exchangedid,cl.invoiceid from ChangeLiziData cl "+tab(sql)+" where 1=1 " + sql;
		try {
			ResultSet rs = db.executeQuery(QSql, pos, size);
			while(rs.next()){
				int i = 1;
				ChangeLiziData s = new ChangeLiziData(rs.getInt(i++));
				s.setHospitalid(rs.getInt(i++));
				s.setIsback(rs.getInt(i++));
				s.setNoinvoice(rs.getInt(i++));
				s.setIsinvoice(rs.getInt(i++));
				s.setTimespot(db.getDate(i++));
				s.setMember(rs.getInt(i++));
				s.setCreatedate(db.getDate(i++));
				s.setOrdernum(rs.getInt(i++));
				s.setOrderid(rs.getString(i++));
				s.setExchangedid(rs.getInt(i++));
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
	
	public static ArrayList<Integer> findhid(String sql,int pos,int size){
		ArrayList<Integer> list = new ArrayList<Integer>();
		DbAdapter db = new DbAdapter();
		String QSql = "select hospitalid from ChangeLiziData  where 1=1 " + sql;
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
		return DbAdapter.execute("select count(0) from ChangeLiziData cl "+tab(sql)+" where 1=1 " + sql);
	}
	
	public void set() throws SQLException{
		String sql = "";
		if(this.id < 1){
			sql = "insert into ChangeLiziData(id,hospitalid,isback,noinvoice,isinvoice,timespot,member,createdate,ordernum,orderid,exchangedid,invoiceid) values(" + (this.id = Seq.get()) + "," + this.hospitalid + "," + this.isback + "," + this.noinvoice + "," +this.isinvoice+"," + DbAdapter.cite(this.timespot)+ "," +this.member + ","+DbAdapter.cite(this.createdate)+","+this.ordernum+","+DbAdapter.cite(this.orderid)+","+this.exchangedid+","+this.invoiceid+")";
		}else{
			sql = "update ChangeLiziData set hospitalid =" + this.hospitalid + ",isback = " + this.isback + ",noinvoice = " + this.noinvoice+",isinvoice="+this.isinvoice  + ",timespot = " + DbAdapter.cite(this.timespot)+ ",member = "+this.member+",createdate = " + DbAdapter.cite(this.createdate)+",ordernum="+this.ordernum+",orderid="+DbAdapter.cite(this.orderid)+",exchangedid="+this.exchangedid+",invoiceid="+this.invoiceid+" where id=" + this.id;
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


	private static String tab(String sql)
	{
		StringBuilder sb = new StringBuilder();
		if (sql.contains(" AND sho."))
			sb.append(" INNER JOIN ShopHospital sho ON sho.id=cl.hospitalid");
		return sb.toString();
	}

	public static void delete(int id){
		DbAdapter db = new DbAdapter();
		try {
			db.executeUpdate(id,"delete from ChangeLiziData where id= " + id);
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
			db.executeUpdate(this.id, "update ChangeLiziData set " + column + "=" + DbAdapter.cite(value) + " where id=" + this.id);
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			db.close();
		}
		c.remove(this.id);
	}
	
	/**
	 * 下单导致未开票粒子数增加
	 * @param hid 医院id
	 * @param quantity 订单数量
	 * @param timespot 下单时间
	 * @param member 操作人
	 * @param orderid 订单id
	 */
	public static void addnoinvoice(int hid,int quantity,Date timespot,int member,String orderid){
		try {
			ChangeLiziData ldata=new ChangeLiziData(0);
			//查询最后一次记录的未开票粒子数
			List<ChangeLiziData> lstc=ChangeLiziData.find(" and hospitalid = "+hid+" order by ordernum desc ", 0, Integer.MAX_VALUE);
			int quantity3=0;//changelizidata中记录的该医院的最后一条记录的未开票粒子数
			int quantity4=0;//changelizidata中记录的该医院的最后一条记录的已开票粒子数
			int ordernum=0;
			if(lstc.size()>0){
				ChangeLiziData cdata=lstc.get(0);
				quantity3=cdata.getNoinvoice();
				quantity4=cdata.getIsinvoice();
				ordernum=cdata.getOrdernum();
			}
			
			int quantity2=quantity+quantity3;//未开票数量增加
			ldata.setHospitalid(hid);//医院id
			ldata.setIsback(1);//下单改变
			ldata.setNoinvoice(quantity2);//未开票粒子数
			ldata.setIsinvoice(quantity4);//已开票数量
			ldata.setTimespot(timespot);//日期节点
			ldata.setMember(member);
			ldata.setCreatedate(new Date());
			ldata.setOrdernum(ordernum+1);
			ldata.setOrderid(orderid);
		    ldata.set();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	/**
	 * 退货导致未开票粒子数减少
	 * @param hid 医院id
	 * @param quantity 退货数量
	 * @param timespot 退货时间
	 * @param member 操作人
	 * @param exid 退货id
	 */
	public static void jiannoinvoice(int hid,int quantity,Date timespot,int member,int exid){
		try {
			ChangeLiziData ldata=new ChangeLiziData(0);
			//查询最后一次记录的未开票粒子数
			List<ChangeLiziData> lstc=ChangeLiziData.find(" and hospitalid = "+hid+" order by ordernum desc ", 0, Integer.MAX_VALUE);
			int quantity3=0;//changelizidata中记录的该医院的最后一条记录的未开票粒子数
			int quantity4=0;//changelizidata中记录的该医院的最后一条记录的已开票粒子数
			int ordernum=0;
			if(lstc.size()>0){
				ChangeLiziData cdata=lstc.get(0);
				quantity3=cdata.getNoinvoice();
				quantity4=cdata.getIsinvoice();
				ordernum=cdata.getOrdernum();
			}
			
			int quantity2=quantity3-quantity;//未开票数量减少
			ldata.setHospitalid(hid);//医院id
			ldata.setIsback(2);//退货
			ldata.setNoinvoice(quantity2);//未开票粒子数
			ldata.setIsinvoice(quantity4);//已开票数量
			ldata.setTimespot(timespot);//日期节点
			ldata.setMember(member);
			ldata.setCreatedate(new Date());
			ldata.setOrdernum(ordernum+1);
			ldata.setExchangedid(exid);//退货id
			ldata.set();
		} catch (Exception e) {
			// TODO: handle exception
		}
		
	}
	
	/**
	 * 开票导致未开票粒子数减少，已开票粒子数增加
	 * @param hid 医院id
	 * @param num 开票数量
	 * @param timespot 时间节点
	 * @param member 操作人
	 * @param invoid 发票id
	 */
	public static void makenoinvoice(int hid,int num,Date timespot,int member,int invoid){
		try {
			ChangeLiziData ldata=new ChangeLiziData(0);
			//查询最后一次记录的未开票粒子数
			List<ChangeLiziData> lstc=ChangeLiziData.find(" and hospitalid = "+hid+" order by ordernum desc ", 0, Integer.MAX_VALUE);
			int quantity4=0;//changelizidata中记录的该医院的最后一条记录的未开票粒子数
			int quantity5=0;//changelizidata中记录的该医院的最后一条记录的已开票粒子数
			int ordernum=0;
			if(lstc.size()>0){
				ChangeLiziData cdata=lstc.get(0);
				quantity4=cdata.getNoinvoice();
				quantity5=cdata.getIsinvoice();
				ordernum=cdata.getOrdernum();
			}
			
			int quantity2=quantity4-num;//未开票数量减少
			int quantity3=quantity5+num;//已开票数量增加
			ldata.setHospitalid(hid);//医院id
			ldata.setIsback(3);//后台设置
			ldata.setNoinvoice(quantity2);//未开票粒子数
			ldata.setIsinvoice(quantity3);//已开票数量
			ldata.setTimespot(timespot);//日期节点
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
	 * 退票导致未开票粒子数增加，已开票粒子数减少
	 * @param hid 医院id
	 * @param num 开票数量
	 * @param timespot 时间节点
	 * @param member 操作人
	 * @param invoid 发票id
	 */
	public static void makenoinvoice2(int hid,int num,Date timespot,int member,int invoid){
		try {
			ChangeLiziData ldata=new ChangeLiziData(0);
			//查询最后一次记录的未开票粒子数
			List<ChangeLiziData> lstc=ChangeLiziData.find(" and hospitalid = "+hid+" order by ordernum desc ", 0, Integer.MAX_VALUE);
			int quantity4=0;//changelizidata中记录的该医院的最后一条记录的未开票粒子数
			int quantity5=0;//changelizidata中记录的该医院的最后一条记录的已开票粒子数
			int ordernum=0;
			if(lstc.size()>0){
				ChangeLiziData cdata=lstc.get(0);
				quantity4=cdata.getNoinvoice();
				quantity5=cdata.getIsinvoice();
				ordernum=cdata.getOrdernum();
			}
			
			int quantity2=quantity4+num;//未开票数量增加
			int quantity3=quantity5-num;//已开票数量减少
			ldata.setHospitalid(hid);//医院id
			ldata.setIsback(4);//后台设置
			ldata.setNoinvoice(quantity2);//未开票粒子数
			ldata.setIsinvoice(quantity3);//已开票数量
			ldata.setTimespot(timespot);//日期节点
			ldata.setMember(member);
			ldata.setCreatedate(new Date());
			ldata.setOrdernum(ordernum+1);
			ldata.setInvoiceid(invoid);//发票id
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

	public int getNoinvoice() {
		return noinvoice;
	}

	public void setNoinvoice(int noinvoice) {
		this.noinvoice = noinvoice;
	}

	public int getIsinvoice() {
		return isinvoice;
	}

	public void setIsinvoice(int isinvoice) {
		this.isinvoice = isinvoice;
	}

	public Date getTimespot() {
		return timespot;
	}

	public void setTimespot(Date timespot) {
		this.timespot = timespot;
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

	public int getOrdernum() {
		return ordernum;
	}

	public void setOrdernum(int ordernum) {
		this.ordernum = ordernum;
	}

	public String getOrderid() {
		return orderid;
	}

	public void setOrderid(String orderid) {
		this.orderid = orderid;
	}

	public int getExchangedid() {
		return exchangedid;
	}

	public void setExchangedid(int exchangedid) {
		this.exchangedid = exchangedid;
	}

	public int getInvoiceid() {
		return invoiceid;
	}

	public void setInvoiceid(int invoiceid) {
		this.invoiceid = invoiceid;
	}
	
	

	
	
	
	
	

}
