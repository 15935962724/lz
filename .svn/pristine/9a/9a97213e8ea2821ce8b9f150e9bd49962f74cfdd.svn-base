<%@page import="tea.entity.Http"%>
<%@page import="tea.entity.member.Profile"%>
<%@page import="java.io.CharArrayWriter"%>
<%@page import="tea.entity.member.SMessage"%>
<%@page import="java.util.Date"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.member.SMSMessage"%>
<%@page import="jxl.Sheet"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="jxl.Cell"%>
<%@page import="jxl.Workbook"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>
</head>
<style>
	div{
	font-weight: bold;
	}
</style>
<body>
<%
request.setCharacterEncoding("UTF-8");
Http h = new Http(request,response);
TeaSession teasession = new TeaSession(request);
String c = "test";
//int[] rs = SMessage.send(1,"|","|13661124082|","参会代表您好 请登录 http://www.papc.cn/html/category/14080433-1.htm 下载与会资料  用户名为手机号 密码为手机号后六位 【中国林业科学研究院】",new CharArrayWriter());
//System.out.print(rs == null || rs[0] == 0 ? "发送失败！" : "验证码已发送，请注意查收。");
//String result = SMSMessage.create(teasession._strCommunity,"webmaster","13661124082",teasession._nLanguage,"test1【中国林业科学研究院】");
//SMSMessage.create(teasession._strCommunity,"13661124082","13661124082",teasession._nLanguage,c);
//System.out.println(result);
//out.print("<script>alert('"+rs == null || rs[0] == 0 ? "发送失败！" : "验证码已发送，请注意查收。"+"');</script>");
List list = new ArrayList();
Workbook rwb = null;
Cell cell = null;

//创建输入流
//InputStream stream = new FileInputStream("D:\\已导入\\txl1.xls");
InputStream stream = new FileInputStream("E:\\my\\822\\txl1.xls");
//获取Excel文件对象
rwb = Workbook.getWorkbook(stream);

//获取文件的指定工作表 默认的第一个
Sheet sheet = rwb.getSheet(0); 

//行数(表头的目录不需要，从1开始)
for(int i=1; i<sheet.getRows(); i++){

 //创建一个数组 用来存储每一列的值
 String[] str = new String[sheet.getColumns()];
 //列数
 for(int j=0; j<sheet.getColumns(); j++){

  //获取第i行，第j列的值
  cell = sheet.getCell(j,i);   
  str[j] = cell.getContents();
 
 }
 //把刚获取的列存入list
 list.add(str);
}
//String[] str2 = (String[])list.get(1);


for(int i=1;i<list.size();i++){
    String[] str = (String[])list.get(i);
    if(!str[6].equals("")){//手机号不为空则发送
    	//String pwd = str[6].substring(5);
    	//System.out.println(str[6]+"--"+str[0]);
    	//int[] rs = SMessage.send(1,"|","|"+str[6]+"|","参会代表您好 请登录 http://www.papc.cn/xhtml/category/14080433-1.htm 下载与会资料  用户名为手机号 密码为手机号后六位 【中国林业科学研究院】",new CharArrayWriter());
    	//System.out.print(rs == null || rs[0] == 0 ? "发送失败！" : "验证码已发送，请注意查收。");
    	//Profile.create(str[6], pwd, h.community, str[7], new Date(), 1, h.language, str[0], "", "", "", "", "", "", "", "", "", "",str[6]);
    }
    //for(int j=0;j<str.length;j++){
     //System.out.println(str[0]+"=="+str[6]);
    //}
   }
%>
</body>
</html>