package tea.entity.yl.shop;

import java.io.InputStream;
import java.math.BigDecimal;
import java.net.URL;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
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
 * 医院名称变更记录
 * @author yantong
 * */
public class HospitalNameChange {

	protected static Cache c = new Cache(50);
	
	private int id;				
	private int hospitalid;		//医院id
	
	private String oldname;		//旧的医院名称
	private String newname;	    //新的医院名称
	private int member;//变更人
	private Date createdate;//变更日期
	private String orderId;//订单id，用，分隔
	private String invoiceid;//发票id，用，分隔
	
	public HospitalNameChange(int id){
		this.id = id;
	}
	
	public static HospitalNameChange find(int id){
		HospitalNameChange aHospital = (HospitalNameChange)c.get(id);
		if(aHospital == null){
			ArrayList<HospitalNameChange> list = find(" AND id = " + id, 0, 1);
			aHospital = list.size() < 1 ? new HospitalNameChange(id):list.get(0);
		}
		return aHospital;
	}
	
	
	
	public static ArrayList<HospitalNameChange> find(String sql,int pos,int size){
		ArrayList<HospitalNameChange> list = new ArrayList<HospitalNameChange>();
		DbAdapter db = new DbAdapter();
		String QSql = "select id,hospitalid,oldname,newname,member,createdate,orderId,invoiceid from HospitalNameChange where 1=1 " + sql;
		try {
			ResultSet rs = db.executeQuery(QSql, pos, size);
			while(rs.next()){
				int i = 1;
				HospitalNameChange h = new HospitalNameChange(rs.getInt(i++));
				h.setHospitalid(rs.getInt(i++));
				h.setOldname(rs.getString(i++));
				h.setNewname(rs.getString(i++));
				h.setMember(rs.getInt(i++));
				h.setCreatedate(rs.getDate(i++));
				h.setOrderId(rs.getString(i++));
				h.setInvoiceid(rs.getString(i++));
				c.put(h.id, h);
				list.add(h);
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
		return DbAdapter.execute("select count(0) from HospitalNameChange where 1=1 " + sql);
	}
	
	public void set() throws SQLException{
		String sql = "";
		if(this.id < 1){
			sql = "insert into HospitalNameChange(id,hospitalid,oldname,newname,member,createdate,orderId,invoiceid) values(" + (this.id = Seq.get()) + "," + this.hospitalid + "," + DbAdapter.cite(this.oldname) + "," + DbAdapter.cite(this.newname) + "," + this.member + "," + DbAdapter.cite(this.createdate)+","+DbAdapter.cite(this.orderId)+","+DbAdapter.cite(invoiceid) +")";
		}else{
			sql = "update HospitalNameChange set hospitalid =" + this.hospitalid + ",oldname = " + DbAdapter.cite(this.oldname) + ",newname = " + DbAdapter.cite(this.newname) + ",member = " + this.member + ",createdate = " + DbAdapter.cite(this.createdate) +",orderId="+DbAdapter.cite(this.orderId)+",invoiceid="+DbAdapter.cite(this.invoiceid)+" where id=" + this.id;
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
			db.executeUpdate(id,"delete from HospitalNameChange where id= " + id);
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
			db.executeUpdate(this.id, "update HospitalNameChange set " + column + "=" + DbAdapter.cite(value) + " where id=" + this.id);
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			db.close();
		}
		c.remove(this.id);
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

	public String getOldname() {
		return oldname;
	}

	public void setOldname(String oldname) {
		this.oldname = oldname;
	}

	public String getNewname() {
		return newname;
	}

	public void setNewname(String newname) {
		this.newname = newname;
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

	public String getOrderId() {
		return orderId;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}

	public String getInvoiceid() {
		return invoiceid;
	}

	public void setInvoiceid(String invoiceid) {
		this.invoiceid = invoiceid;
	}
	
	
	
	
	
	
	

}
