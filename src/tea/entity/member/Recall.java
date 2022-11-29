package tea.entity.member;

import tea.db.DbAdapter;
import tea.entity.*;
import tea.entity.bbs.BBSLevel;
import tea.entity.site.Subscriber;
import tea.entity.westrac.WestracIntegralLog;
import tea.entity.yl.shop.ShopOrder;
import tea.html.Anchor;
import tea.html.Image;
import tea.html.Text;
import tea.service.SMS;

import java.io.UnsupportedEncodingException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.*;

public class Recall extends Entity {


    protected static Cache c = new Cache(50);

	private int id;

	private Date create_date; // 创建时间

	private String sn; // 订单编号

	private String hospital; // 医院名称

	private int quantity ;// 数量

	private String systemDocuments; //制度文件

	private String proveFile; // 证明材料

	private String memberId; // 服务商名称

	private String puId; // 用户名

	private int status;//审核状态

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public String getPuId() {
		return puId;
	}

	public void setPuId(String puId) {
		this.puId = puId;
	}


	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Date getCreate_date() {
		return create_date;
	}

	public void setCreate_date(Date create_date) {
		this.create_date = create_date;
	}

	public String getSn() {
		return sn;
	}

	public void setSn(String sn) {
		this.sn = sn;
	}

	public String getHospital() {
		return hospital;
	}

	public void setHospital(String hospital) {
		this.hospital = hospital;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public String getSystemDocuments() {
		return systemDocuments;
	}

	public void setSystemDocuments(String systemDocuments) {
		this.systemDocuments = systemDocuments;
	}

	public String getProveFile() {
		return proveFile;
	}

	public void setProveFile(String proveFile) {
		this.proveFile = proveFile;
	}





	public static List<Recall> getList(String sql, int pos, int size) throws SQLException {

		List<Recall> recalls = new ArrayList<Recall>();
		DbAdapter db = new DbAdapter();
		try {
			String sqlBuffer = "select * from Recalls where 1 = 1 "+sql ;
			ResultSet resultSet =  db.executeQuery(sqlBuffer, pos, size);
			while (resultSet.next()) {
				Recall recall = new Recall();
				recall.setId(resultSet.getInt("id"));
				recall.setCreate_date(resultSet.getDate("create_date"));
				recall.setSn(resultSet.getString("sn"));
				recall.setHospital(resultSet.getString("hospital"));
				recall.setSystemDocuments(resultSet.getString("system_documents"));
				recall.setProveFile(resultSet.getString("prove_file"));
				recall.setMemberId(resultSet.getString("member_id"));
				recall.setPuId(resultSet.getString("pu_id"));
				recall.setQuantity(resultSet.getInt("quantity"));
				recalls.add(recall);
			}
		} finally {
			db.close();
		}
		return recalls;
	}



	public static List<Map> getlist(String sql, int pos, int size) throws SQLException {



		DbAdapter db = new DbAdapter();
		try {
			String sqlBuffer = "select R.*,P.member,PR.name from  recalls R left join Profile P on R.member_id = P.profile left join procurementunit PR on R.pu_id = PR.puid where 1 = 1 "+sql ;
			List<Map> list = new ArrayList<Map>();
			ResultSet resultSet =  db.executeQuery(sqlBuffer, pos, size);
			while (resultSet.next()) {
				Map map = new HashMap();
				map.put("id",resultSet.getInt("id"));
				map.put("create_date",resultSet.getDate("create_date"));
				map.put("sn",resultSet.getString("sn"));
				map.put("hospital",resultSet.getString("hospital"));
				map.put("system_documents",resultSet.getString("system_documents"));
				map.put("prove_file",resultSet.getString("prove_file"));
				map.put("member_id",resultSet.getString("member_id"));
				map.put("pu_id",resultSet.getString("pu_id"));
				map.put("quantity",resultSet.getInt("quantity"));
				map.put("member",resultSet.getString("member"));
				map.put("name",resultSet.getString("name"));
				list.add(map);
			}
			return list;
		} finally {
			db.close();
		}
	}




	public static String[] getProveFiles(int id) throws SQLException {

		DbAdapter db = new DbAdapter();
		try {
			String sqlBuffer = "select * from Recalls where id = "+id ;
			ResultSet resultSet =  db.executeQuerySql(sqlBuffer);
			resultSet.next();
			String  proveFile = resultSet.getString("prove_file");
			String[] split = proveFile.split(",");
			return split;
		} finally {
			db.close();
		}
	}

	//根据订单编号获取订单数量
	public static int getQuantity(String orderId) throws SQLException {

		DbAdapter db = new DbAdapter();
		try {
			String sqlBuffer = 	"select quantity from shopOrderData where order_id = '"+orderId+"'" ;
			ResultSet resultSet =  db.executeQuerySql(sqlBuffer);
			resultSet.next();
			int  quantity = resultSet.getInt("quantity");
			return quantity;
		} finally {
			db.close();
		}
	}


	public void delete(int id) throws SQLException
	{
		String sql = "delete from recalls where id = "+id;
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate(sql);
		} finally
		{
			db.close();
		}
		c.remove(id);
	}



	public void set(Recall recall) throws SQLException
    {
        String sql = "insert into Recalls (create_date,sn,hospital,quantity,system_documents,prove_file,member_id,pu_id,status)\n" +
                "values (GETDATE(),'"+recall.getSn()+"','"+recall.getHospital()+"','"+recall.getQuantity()+"','"+recall.getSystemDocuments()+"','"+recall.getProveFile()+"','"+recall.getMemberId()+"','"+recall.getPuId()+"',1);";
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(sql);
        } finally
        {
            db.close();
        }
        c.remove(id);
    }


}
