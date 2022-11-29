package tea.entity.markplus;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;

import tea.db.DbAdapter;
import tea.entity.Seq;

/**
 * 标记加一表
 * @author zcq
 * */
public class MarkPlus {
	
	private int id;               //id
	private String community;     //社区
	private String name;          //名称
	private int path;             //图片路径
	private int click;            //点击数量
	private String unit;          //单位
	private int sequence;         //顺序
	private Date time;            //时间
	
	public MarkPlus(){}
	public MarkPlus(int id){
		this.id = id;
	}
		
	/**
	 * 查询
	 * @param id
	 * @return MarkPlus
	 * */
	public static MarkPlus find(int id) throws SQLException
    {
        ArrayList<MarkPlus> al = find(" AND id=" + id,0,1);
        MarkPlus markPlus = al.size() < 1 ? new MarkPlus(id) : al.get(0);
        return markPlus;
    }	
	
	/**
	 * 查询
	 * @param sql
	 * @param pos
	 * @param size
	 * @return arrayList<MarkPlus>
	 * */
	public static ArrayList<MarkPlus> find(String sql, int pos, int size) throws SQLException {
		ArrayList<MarkPlus> al = new ArrayList<MarkPlus>();
		DbAdapter db = new DbAdapter();
		try {
			String Qsql = "SELECT id,community,name,path,click,unit,sequence,time FROM MarkPlus WHERE 1=1 " + sql;
			ResultSet rs = db.executeQuery(Qsql, pos, size);
			while (rs.next()) {
				int i = 1;
				MarkPlus markPlus = new MarkPlus();
				markPlus.id = rs.getInt(i++);
				markPlus.community = rs.getString(i++);
				markPlus.name = rs.getString(i++);
				markPlus.path = rs.getInt(i++);
				markPlus.click = rs.getInt(i++);
				markPlus.unit = rs.getString(i++);
				markPlus.sequence = rs.getInt(i++);
				markPlus.time = db.getDate(i++);
				
				al.add(markPlus);
			}
			rs.close();
		} finally {
			db.close();
		}
		return al;
	}
	
	/**
	 * 总条数
	 * @param sql
	 * @throws SQLException
	 */
	public static int count(String sql) throws SQLException
	{
		return DbAdapter.execute("SELECT COUNT(*) FROM MarkPlus WHERE 1=1" + sql);
	}
	
	/**
	 * 添加或编辑
	 * @throws SQLException
	 */
	public void set() throws SQLException{
	        String sql;
	        if(id < 1)
	            sql = "INSERT INTO MarkPlus(id,community,name,path,click,unit,sequence,time)VALUES(" + (id = Seq.get()) + "," + DbAdapter.cite(community) + "," + DbAdapter.cite(name) +","+path +","+click + "," +DbAdapter.cite(unit) +","+sequence + "," +DbAdapter.cite(time) + ")";
	        else
	            sql = "UPDATE MarkPlus SET name=" + DbAdapter.cite(name) + ",path="+path +",click="+click +",unit="+DbAdapter.cite(unit) +",sequence="+sequence + " WHERE id=" + id;
	        DbAdapter db = new DbAdapter();
	        try
	        {
	            db.executeUpdate(id,sql);
	        } finally
	        {
	            db.close();
	        }
	}
	
	/**
	 * 删除
	 * @param id
	 * */
	public static void delete(int id) throws SQLException {
		DbAdapter db = new DbAdapter();
		try {
			db.executeUpdate(id,"DELETE FROM MarkPlus WHERE ID= "+ id);
		} finally {
			db.close();
		}
	}
	
	public static void click(int id) throws SQLException
    {
		DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(id,"UPDATE MarkPlus SET click=click+1 WHERE id=" + id);
        } finally
        {
            db.close();
        }
    }
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getCommunity() {
		return community;
	}
	public void setCommunity(String community) {
		this.community = community;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getPath() {
		return path;
	}
	public void setPath(int path) {
		this.path = path;
	}
	public int getClick() {
		return click;
	}
	public void setClick(int click) {
		this.click = click;
	}
	public String getUnit() {
		return unit;
	}
	public void setUnit(String unit) {
		this.unit = unit;
	}
	public int getSequence() {
		return sequence;
	}
	public void setSequence(int sequence) {
		this.sequence = sequence;
	}
	public Date getTime() {
		return time;
	}
	public void setTime(Date time) {
		this.time = time;
	}
	
}
