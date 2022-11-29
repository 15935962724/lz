package tea.entity.textlive;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;

import tea.db.DbAdapter;
import tea.entity.Seq;

/**
 * 文字直播表
 * @author zcq
 * */
public class TextLive {
	
	private int id;               //id
	private String community;     //社区
	private String author;        //发布人
	private String content;       //内容
	private Date time;            //10:19
	
	public TextLive(){}
	public TextLive(int id){
		this.id = id;
	}
		
	/**
	 * 查询
	 * @param id
	 * @return TextLive
	 * */
	public static TextLive find(int id) throws SQLException
    {
        ArrayList<TextLive> al = find(" AND id=" + id,0,1);
        TextLive textLive = al.size() < 1 ? new TextLive(id) : al.get(0);
        return textLive;
    }
	
	/**
	 * 查询
	 * @param sql
	 * @param pos
	 * @param size
	 * @return arrayList<TextLive>
	 * */
	public static ArrayList<TextLive> find(String sql, int pos, int size) throws SQLException {
		ArrayList<TextLive> al = new ArrayList<TextLive>();
		DbAdapter db = new DbAdapter();
		try {
			String Qsql = "SELECT id,community,author,content,time FROM TextLive WHERE 1=1 " + sql;
			ResultSet rs = db.executeQuery(Qsql, pos, size);
			while (rs.next()) {
				int i = 1;
				TextLive textLive = new TextLive();
				textLive.id = rs.getInt(i++);
				textLive.community = rs.getString(i++);
				textLive.author = rs.getString(i++);
				textLive.content = rs.getString(i++);
				textLive.time = db.getDate(i++);
				
				al.add(textLive);
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
		return DbAdapter.execute("SELECT COUNT(*) FROM TextLive WHERE 1=1" + sql);
	}
	
	/**
	 * 添加或编辑
	 * @throws SQLException
	 */
	public void set() throws SQLException{
	        String sql;
	        if(id < 1)
	            sql = "INSERT INTO TextLive(id,community,author,content,time)VALUES(" + (id = Seq.get()) + "," + DbAdapter.cite(community) + "," + DbAdapter.cite(author) + "," +DbAdapter.cite(content) + "," +DbAdapter.cite(time) + ")";
	        else
	            sql = "UPDATE TextLive SET author=" + DbAdapter.cite(author) + ",content="+DbAdapter.cite(content) + " WHERE id=" + id;
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
			db.executeUpdate(id,"DELETE FROM TextLive WHERE ID= "+ id);
		} finally {
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
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getTime() {
		return time;
	}
	public void setTime(Date time) {
		this.time = time;
	}
	
}
