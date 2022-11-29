<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.resource.Common"%>
<%@page import="dzews.tomcat"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.IOException"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="tea.entity.Entity"%>
<%@page import="tea.entity.westrac.WestracIntegralLog"%>
<%@ page import="tea.db.DbAdapter" %>
<%@ page  import="tea.resource.Resource"  %>
<%@ page  import="tea.entity.csvclub.*" %>
<%@ page import="tea.entity.member.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="tea.entity.integral.*"%>
<%!

public void deleteall(String member) throws SQLException
{
    DbAdapter db = new DbAdapter();
    try
    {
    	db.executeUpdate("DELETE FROM ProfileLayer WHERE member=" + DbAdapter.cite(member) );
        db.executeUpdate("DELETE FROM Profile WHERE member=" + DbAdapter.cite(member));
        db.executeUpdate("DELETE FROM ProfileBBS WHERE member=" + DbAdapter.cite(member));
        db.executeUpdate("DELETE FROM ProfileBBSLayer WHERE member=" + DbAdapter.cite(member));
        db.executeUpdate("DELETE FROM ProfileGolf WHERE member=" + DbAdapter.cite(member));
        db.executeUpdate("DELETE FROM ProfileGrant WHERE member=" + DbAdapter.cite(member));
        db.executeUpdate("DELETE FROM ProfileJob WHERE member=" + DbAdapter.cite(member));
        
        
        
        
        
        WestracIntegralLog.delete(member);//日志表
        db.executeUpdate("DELETE FROM Logs WHERE rmember=" + DbAdapter.cite(member) + " AND vmember=" + DbAdapter.cite(member));
        
        //删除新闻表
        db.executeUpdate("DELETE from ReportLayer WHERE node IN ( select node from Node where rcreator="+db.cite(member)+" or vcreator = "+db.cite(member)+")");
        db.executeUpdate("DELETE from Report WHERE node IN ( select node from Node where rcreator="+db.cite(member)+" or vcreator = "+db.cite(member)+")");
        
        //删除权限表
        db.executeUpdate("DELETE from AdminUsrRole WHERE member="+db.cite(member));
        //删除论坛表
        db.executeUpdate("DELETE from BBS WHERE node IN ( select node from Node where rcreator="+db.cite(member)+" or vcreator = "+db.cite(member)+")");
        
        db.executeUpdate("DELETE from BBSReplyLayer WHERE bbsreply IN ( select id from BBSReply where member="+db.cite(member)+")");
        db.executeUpdate("DELETE from BBSReply WHERE member= "+db.cite(member));
        
        // 删除商品表
        db.executeUpdate("DELETE from Goods WHERE node IN ( select node from Node where rcreator="+db.cite(member)+" or vcreator = "+db.cite(member)+")");
        // 简历表
        db.executeUpdate("DELETE from Job WHERE node IN ( select node from Node where rcreator="+db.cite(member)+" or vcreator = "+db.cite(member)+")");
        
      //考勤表
        db.executeUpdate("DELETE from Manage WHERE member = "+db.cite(member));
        db.executeUpdate("DELETE from Outs WHERE member = "+db.cite(member));
        db.executeUpdate("DELETE from Leavec WHERE member = "+db.cite(member));
        
        
        
        
        //信箱
        db.executeUpdate("DELETE from Message WHERE fmember = "+db.cite(member));
        db.executeUpdate("DELETE from MessageTo WHERE rmember = "+db.cite(member)+" OR vmember="+db.cite(member));
        
        //加盟店相关
        db.executeUpdate("DELETE from Orders WHERE member = "+db.cite(member));
        
        //活动
        db.executeUpdate("DELETE from Event WHERE node IN ( select node from Node where rcreator="+db.cite(member)+" or vcreator = "+db.cite(member)+")");
      
        //文件
        db.executeUpdate("DELETE from Files WHERE node IN ( select node from Node where rcreator="+db.cite(member)+" or vcreator = "+db.cite(member)+")");
        //球场
        db.executeUpdate("DELETE from Golf WHERE node IN ( select node from Node where rcreator="+db.cite(member)+" or vcreator = "+db.cite(member)+")");
        
        
        
        
      //node表
        db.executeUpdate("DELETE from NodeLayer WHERE node IN ( select node from Node where rcreator="+db.cite(member)+" or vcreator = "+db.cite(member)+")");
        db.executeUpdate("DELETE from Node WHERE rcreator="+db.cite(member)+" OR vcreator = "+db.cite(member));
        
        
    	
        
    } finally
    {
        db.close();
    }
  
}
%>


<%

String filePath = Common.REAL_PATH+"/b.txt";

BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(filePath)));
int i=1;
for (String line = br.readLine(); line != null; line = br.readLine()) {

	String member = line;
	if(member!=null && member.length()>0)
	{
		member = member.trim();
		Profile pobj =Profile.find(member);
		this.deleteall(member);
		out.print(i+":"+member);
		i++;
	}
	
	

}
br.close();

out.print("删除完毕");
%>



