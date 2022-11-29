package tea.ui.lzInterface;

import tea.db.DbAdapter;
import tea.entity.Cache;
import tea.entity.Entity;
import tea.entity.Seq;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 订单推送记录Entity
 * @author Liuzq
 * @version 2020-11-25
 */
public class SendCrmLog extends Entity {

	protected static Cache c = new Cache(500);
	private int id;
	private String	order_id	;//	 订单ID
	private int status;         //  无意义
	private String	content	;   //	描述
	private Date modifyTime	;//	     时间

	public SendCrmLog(int id){
		this.id = id;
	}
	
	public static SendCrmLog find(int id) throws SQLException{
        SendCrmLog t = (SendCrmLog) c.get(id);
        if (t == null){
            List<SendCrmLog> al = find(" AND id=" + id, 0, 1);
            t = al.size() < 1 ? new SendCrmLog(id) : al.get(0);
        }
        return t;
    }

	public static List<SendCrmLog> find(String sql, int pos, int size) throws SQLException{
		List<SendCrmLog> al = new ArrayList<SendCrmLog>();
		DbAdapter db = new DbAdapter();
		try
		{
		    java.sql.ResultSet rs = db.executeQuery("SELECT m.id,m.order_id,m.status,m.content,m.modifyTime FROM tb_sendlog m  WHERE 1=1" + sql, pos, size);
		    while (rs.next()){
		        int i = 1;
		        SendCrmLog obj = new SendCrmLog(rs.getInt(i++));
		        obj.setOrder_id(rs.getString(i++));
		        obj.setStatus(rs.getInt(i++));
		        obj.setContent(rs.getString(i++));
		        obj.setModifyTime(db.getDate(i++));
		        c.put(obj.id, obj);
		        al.add(obj);
		    }
		    rs.close();
		} finally{
		    db.close();
		}
		return al;
	}
	
	public static int count(String sql) throws SQLException{
		return DbAdapter.execute("SELECT COUNT(*) from tb_sendlog  WHERE 1=1" + sql);
	}

	public int set() throws SQLException{
		String sql;
		if (id < 1){
		    sql = "INSERT INTO tb_sendlog(id,order_id,status,content,modifyTime)VALUES("
		    		+ (id = Seq.get()) + ","
		    		+ DbAdapter.cite(order_id)+","
		    		+ status+","
                    + DbAdapter.cite(content)+","
		    		+ DbAdapter.cite(modifyTime)
		    		+ ")";
		} else {
            sql = " WHERE id=" + id;
        }
		DbAdapter db = new DbAdapter();
		try{
		    db.executeUpdate(id, sql);
		} finally{
		    db.close();
		}
		c.remove(id);
		return id;
	}

	public void set(String f, String v) throws SQLException{
	    DbAdapter db = new DbAdapter();
	    try{
	        db.executeUpdate(id, "UPDATE tb_sendlog SET " + f + "=" + DbAdapter.cite(v) + " WHERE id=" + id);
	    } finally{
	        db.close();
	    }
	    c.remove(id);
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getOrder_id() {
		return order_id;
	}

	public void setOrder_id(String order_id) {
		this.order_id = order_id;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getModifyTime() {
		return modifyTime;
	}

	public void setModifyTime(Date modifyTime) {
		this.modifyTime = modifyTime;
	}

}