package tea.entity.pm;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;

import tea.db.DbAdapter;
import tea.entity.Seq;

/**
 * 名家银评表
 * @author zcq
 * */
public class PoFamousComment {
	
	private int id;               //id
	private String community;     //社区
	private String title;         //标题
	private String content;       //内容
	private Date applyTime;       //时间
	private int member;           //名家id
	
	public PoFamousComment(){}
	public PoFamousComment(int id){
		this.id = id;
	}
		
	/**
	 * 查询
	 * @param id
	 * @return PoFamousComment
	 * */
	public static PoFamousComment find(int id) throws SQLException
    {
        ArrayList<PoFamousComment> al = find(" AND id=" + id,0,1);
        PoFamousComment famousComment = al.size() < 1 ? new PoFamousComment(id) : al.get(0);
        return famousComment;
    }	
	
	/**
	 * 查询
	 * @param sql
	 * @param pos
	 * @param size
	 * @return arrayList<PoFamousComment>
	 * */
	public static ArrayList<PoFamousComment> find(String sql, int pos, int size) throws SQLException {
		ArrayList<PoFamousComment> al = new ArrayList<PoFamousComment>();
		DbAdapter db = new DbAdapter();
		try {
			String Qsql = "SELECT fc.id,fc.community,fc.title,fc.content,fc.applyTime,fc.member FROM FamousComment fc " + tab(sql) + " WHERE 1=1 " + sql;
			ResultSet rs = db.executeQuery(Qsql, pos, size);
			while (rs.next()) {
				int i = 1;
				PoFamousComment famousComment = new PoFamousComment();
				famousComment.id = rs.getInt(i++);
				famousComment.community = rs.getString(i++);
				famousComment.title = rs.getString(i++);
				famousComment.content = rs.getString(i++);
				famousComment.applyTime = db.getDate(i++);
				famousComment.member = rs.getInt(i++);
				al.add(famousComment);
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
		return DbAdapter.execute("SELECT COUNT(*) FROM FamousComment fc " + tab(sql) + " WHERE 1=1" + sql);
	}
	
	/**
	 * 添加或编辑
	 * @throws SQLException
	 */
	public void set() throws SQLException{
	        String sql;
	        if(id < 1)
	            sql = "INSERT INTO FamousComment(id,community,title,content,applyTime,member)VALUES(" + (id = Seq.get()) + "," + DbAdapter.cite(community) + "," + DbAdapter.cite(title) + "," +DbAdapter.cite(content) + "," +DbAdapter.cite(applyTime) + ","+ member + ")";
	        else
	            sql = "UPDATE FamousComment SET title=" + DbAdapter.cite(title) + ",content="+DbAdapter.cite(content) + " WHERE id=" + id;
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
	public void delete() throws SQLException {
		DbAdapter db = new DbAdapter();
		try {
			db.executeUpdate(id,"DELETE FROM FamousComment WHERE ID= "+ id);
		} finally {
			db.close();
		}
	}
	
	public static String tab(String sql)
    {
        StringBuilder sb = new StringBuilder();
        if(sql.contains(" AND pfl."))
            sb.append(" INNER JOIN ProfileLayer pfl ON fc.member=pfl.profile");
        return sb.toString();
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
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getApplyTime() {
		return applyTime;
	}
	public void setApplyTime(Date applyTime) {
		this.applyTime = applyTime;
	}
	public int getMember() {
		return member;
	}
	public void setMember(int member) {
		this.member = member;
	}
	
}
