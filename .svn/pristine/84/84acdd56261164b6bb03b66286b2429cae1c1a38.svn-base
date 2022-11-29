<%@page contentType="text/html;charset=UTF-8" %><%@page import="java.util.*"%><%@page import="java.io.*"%><%@page import="tea.db.DbAdapter"%><%@page import="tea.entity.node.*"%><%@page import="tea.entity.admin.*"%><%@page import="tea.entity.util.*"%><%@page import="tea.entity.member.*"%><%

Map m=null;
try
{
	InputStream is=request.getInputStream();
	ObjectInputStream ois = new ObjectInputStream(is);
	m=(Map)ois.readObject();
	ois.close();
	
	String trade_no=(String)m.get("trade_no");
	
	//企业用户身份验证
	if("8001".equals(trade_no))
	{
		String code=(String)m.get("code");
		String user=(String)m.get("user");
		String psword=(String)m.get("psword");
		if("webmaster".equals(code)&&"webmaster".equals(user))
		{
			m.put("error_code","0000");
		}else
		{
			m.put("error_code","0001");
		}
		ArrayList al=new ArrayList();
		HashMap map=new HashMap();
		map.put("plan_kind",Integer.valueOf(1));
		map.put("if_tip","1");
		al.add(map);
		m.put("result",al);
	}else
	if("8002".equals(trade_no))
	{
		String code=(String)m.get("code");
		String psword=(String)m.get("psword");
		if("webmaster".equals(code)&&"123".equals(psword))
		{
			m.put("error_code","0000");
		}else
		{
			m.put("error_code","0001");
		}
		ArrayList al=new ArrayList();
		Map map=new HashMap();
		map.put("code",code);
		map.put("name","ff");	
		al.add(map);
		m.put("result",al);
	
	}else
	if("8005".equals(trade_no))//企业用户身份验证
	{
		ArrayList al=new ArrayList();
		Map map=new HashMap();
		map.put("trade_code","0001");
		map.put("trade_name","基本信息查询");	
		al.add(map);
		
		map=new HashMap();
		map.put("trade_code","0002");
		map.put("trade_name","企业计划信息查询");	
		al.add(map);
		
		map=new HashMap();
		map.put("trade_code","0003");
		map.put("trade_name","企业账户权益查询");	
		al.add(map);
		
		map=new HashMap();
		map.put("trade_code","0004");
		map.put("trade_name","企业投资查询");	
		al.add(map);
		
		map=new HashMap();
		map.put("trade_code","0005");
		map.put("trade_name","2.10	企业缴费信息查询");	
		al.add(map);
		
		map=new HashMap();
		map.put("trade_code","0006");
		map.put("trade_name","2.11	企业支付信息查询");	
		al.add(map);
		
		map=new HashMap();
		map.put("trade_code","5001");
		map.put("trade_name","员工基本信息查询");	
		al.add(map);
		m.put("result",al);
		
		map=new HashMap();
		map.put("trade_code","5003");
		map.put("trade_name","员工计划信息查询");	
		al.add(map);
		m.put("result",al);
		
		
		map=new HashMap();
		map.put("trade_no","5005");
		map.put("trade_name","员工缴费信息查询");	
		al.add(map);
		m.put("result",al);
		
		m.put("error_code","0000");
	}else
	if("0007".equals(trade_no))//
	{
		ArrayList al=new ArrayList();
		Map map=new HashMap();
		map.put("plan_code","0001");
		map.put("plan_name","A计划");	
		al.add(map);
		
		map=new HashMap();
		map.put("plan_code","0002");
		map.put("plan_name","B计划");	
		al.add(map);
		
		m.put("result",al);
		m.put("error_code","0000");
	}else if("0008".equals(trade_no))//集团企业组织结构
	{
		ArrayList al=new ArrayList();
		Map map=new HashMap();
		map.put("pk_corporation","125417");
		map.put("pk_parent","null");	
		map.put("parent_corp_name","ssssss");
		map.put("corp_no","125417");	
		map.put("corp_name","我的世界");
		map.put("if_tip","1");	
		al.add(map);
	
		map=new HashMap();
		map.put("pk_corporation","125479");
		map.put("pk_parent","null");	
		map.put("parent_corp_name","ssssss");
		map.put("corp_no","125479");	
		map.put("corp_name","系统管理");
		map.put("if_tip","1");	
		al.add(map);
		
		map=new HashMap();
		map.put("pk_corporation","125452");
		map.put("pk_parent","125417");	
		map.put("parent_corp_name","ssssss");
		map.put("corp_no","125452");	
		map.put("corp_name","我的社区");
		map.put("if_tip","1");	
		al.add(map);
		
		map=new HashMap();
		map.put("pk_corporation","125455");
		map.put("pk_parent","125452");	
		map.put("parent_corp_name","ssssss");
		map.put("corp_no","125455");	
		map.put("corp_name","组织的社区");
		map.put("if_tip","0");	
		al.add(map);
		
		map=new HashMap();
		map.put("pk_corporation","125477");
		map.put("pk_parent","125417");	
		map.put("parent_corp_name","ssssss");
		map.put("corp_no","125477");	
		map.put("corp_name","我的通讯录");
		map.put("if_tip","0");	
		al.add(map);
		
		map=new HashMap();
		map.put("pk_corporation","125480");
		map.put("pk_parent","125479");	
		map.put("parent_corp_name","ssssss");
		map.put("corp_no","125480");	
		map.put("corp_name","菜单管理");
		map.put("if_tip","0");	
		al.add(map);
		
		map=new HashMap();
		map.put("pk_corporation","125482");
		map.put("pk_parent","125479");	
		map.put("parent_corp_name","ssssss");
		map.put("corp_no","125482");	
		map.put("corp_name","角色管理");
		map.put("if_tip","0");	
		al.add(map);
		
		map=new HashMap();
		map.put("pk_corporation","125484");
		map.put("pk_parent","125479");	
		map.put("parent_corp_name","ssssss");
		map.put("corp_no","125484");	
		map.put("corp_name","部门管理");
		map.put("if_tip","0");	
		al.add(map);
		
		m.put("result",al);
		m.put("error_code","0000");
	}else
	if("0009".equals(trade_no))//企业汇总信息查询
	{
		ArrayList al=new ArrayList();
		Map map=new HashMap();
		map.put("corp_no","0001");
		map.put("corp_name","A企业");	
		map.put("plan_num","200");
		map.put("fund_num","300");	
		map.put("assets","1000.30");
		map.put("person_num","30");	
		al.add(map);
	
		m.put("result",al);
		m.put("error_code","0000");
	}else
	if("1007".equals(trade_no))//
	{
		ArrayList al=new ArrayList();
		Map map=new HashMap();
		map.put("plan_code","1001");
		map.put("plan_name","A-1计划");	
		al.add(map);
	
		map=new HashMap();
		map.put("plan_code","1002");
		map.put("plan_name","B-1计划");	
		al.add(map);
	
		m.put("result",al);
		m.put("error_code","0000");
	}else
	{
		ArrayList al=new ArrayList();
		Map map=new HashMap();
		map.put("trade_no","0001");
		map.put("trade_name","基本信息查询");	
		al.add(map);
		m.put("result",al);
		m.put("error_code","0000");
	}
	//System.out.println(m.toString());
	
}catch(Exception ex)
{
	ex.printStackTrace();
	
	m=new HashMap();
	m.put("error_code","0000");
}

OutputStream os=response.getOutputStream();
ObjectOutputStream oos=new ObjectOutputStream(os);
oos.writeObject(m);
oos.close();

if(true)
	return;
%>


