<%@page import="tea.entity.westrac.Teamtregistration"%>
<%@page import="tea.entity.westrac.Eventregistration"%>
<%@ page contentType="text/html; charset=GBK" language="java"%>
<%@ page import="java.net.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.security.*"%>
<%@ page import="com.capinfo.crypt.*"%>
<%@ page import="tea.entity.member.*"%>
<%@ page import="tea.ui.*"%>
<%@ page import="java.math.*"%>
<%@ page import="tea.entity.ocean.*" %>
<%@ page import="tea.entity.admin.mov.*" %>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.entity.node.*" %>

<%request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);


//������֧��///////////////////////////////////////////////

int regid = Integer.parseInt(teasession.getParameter("regid"));

boolean f = false;
boolean f2 = false;
//��ȡ֧�� �����е���ֵ
//�ж��Ƿ���������֧������

Payinstall pobj = Payinstall.findpay(teasession._strCommunity,5);
float totalprices = 0f;//�����ܼ۸�
String goodname = "";// ��Ʒ����
String membername="";//����
String phone = "";//�ֻ���
Date times = new Date();
if(pobj.isExists())
{
	
	Eventregistration erobj = Eventregistration.find(regid);
	Teamtregistration tobj = Teamtregistration.find(regid);
	GolfOrder goobj = GolfOrder.find(regid);//�����򳡺ͽ���������Ϣ
	
	
	//�жϻ���͵�֧��
	if(pobj.getUsename()!=null && pobj.getUsename().indexOf("/1/")!=-1 && erobj.getOrdering()!=null && erobj.getOrdering().indexOf("AC")!=-1)
	{
		membername = erobj.getMembername();
		phone = erobj.getPhone();
		totalprices = erobj.getTotalprices();
		if(!erobj.isExists())
		{
			f = true;
		}else if(erobj.getPatypeis()==1)
		{
			f2 = true;
		}
		goodname = "ʱ�и߷�����";
		times = erobj.getTimes();
	}else if (pobj.getUsename()!=null && pobj.getUsename().indexOf("/2/")!=-1 && tobj.getOrdering()!=null && tobj.getOrdering().indexOf("TE")!=-1)
	{
		//�ж���ӵ�֧��
		
		membername = tobj.getMembername();
		phone = tobj.getPhone();
	    totalprices = tobj.getTotalprices();
		if(!tobj.isExists())
		{
			f = true;
		}else if(tobj.getPatypeis()==1)
		{
			f2 = true;
		}
		goodname = "Ԥ��ʱ�и߶������";
		times = tobj.getTimes();
	}else if (pobj.getUsename()!=null && pobj.getUsename().indexOf("/3/")!=-1 && goobj.getOrderno()!=null && goobj.getOrderno().indexOf("GO")!=-1)
	{
		//�ж� ��Ԥ��
		
		membername = goobj.getMembername();
		phone = goobj.getPhone();
	    totalprices = goobj.getTotalprice();
		if(!goobj.isExists())
		{
			f = true;
		}else if(goobj.getIspay()==1)
		{
			f2 = true;
		}
		goodname = "Ԥ��ʱ�и߶�����";
		times = goobj.getOrdertime();
	}else if (pobj.getUsename()!=null && pobj.getUsename().indexOf("/4/")!=-1 && goobj.getOrderno()!=null && goobj.getOrderno().indexOf("CR")!=-1)
	{
		//�ж� ����Ԥ��
		
		membername = goobj.getMembername();
		phone = goobj.getPhone();
	    totalprices = goobj.getTotalprice();
		if(!goobj.isExists())
		{
			f = true;
		}else if(goobj.getIspay()==1)
		{
			f2 = true;
		}
		goodname = "Ԥ��ʱ�и߶������";
		times = goobj.getOrdertime();
	}
} 

if(f)//������ 
{
	out.print("<script>alert('��֧���Ķ���������!');window.close();</script>");
	return;
}else if(f2)//�Ѿ�֧����
{
	out.print("<script>alert('��֧���Ķ����Ѿ�֧����!');window.close();</script>");
	return;
} 
String url = "http://"+request.getServerName()+":"+request.getServerPort();


//��������
int mailarea = 0;//�����


java.text.SimpleDateFormat sdf1 = new  java.text.SimpleDateFormat("yyyyMMdd");//-MM-dd HH:mm:ss
String
		v_mid		= pobj.getMerchant().trim(),	//�̻��ţ���ע������
		key         =pobj.getSafety().trim(),
		v_rcvname	=  membername,//�ջ�������
		v_rcvaddr	=  "",//�ջ��˵�ַ
		v_rcvtel	=  phone,//�ջ��˵绰 
		v_rcvpost	= "",//�ջ����ʱ�
		v_amount	=String.valueOf(totalprices),//���� ��� v_to
		v_ymd		=  sdf1.format(times),//String.valueOf(poobj.getTimes()),//��������
		v_ordername	=  "",//����������
		v_orderstatus	= "1",//���״̬
		v_moneytype	= String.valueOf(mailarea),//���� 0 Ϊ�����
		v_url	=url+pobj.getReturnurl(),  //֧����ɺ󷵻ص�ַ���˵�ַ��֧����ɺ󣬶�����Ϣʵʱ���������ַ�����ء����ز�������ӿ��ĵ��ڶ����֡�
		v_md5info= "",
		v_oid	= v_ymd+"-"+v_mid+"-"+regid;//������

		//�ַ���������
		Md5beijing md5 = new Md5beijing ( "" ) ;
		md5.hmac_Md5beijing(v_moneytype+v_ymd+v_amount+v_rcvname+v_oid+v_mid+v_url,key);
		byte b[]= md5.getDigest();
		String digestString = md5.stringify(b) ;
		v_md5info = digestString;
  //onload="form1.submit();"
 
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title></title>
</head>
<body onload="form1.submit();">
<form action="http://pay.beijing.com.cn/prs/user_payment.checkit" method="POST" name="form1" target="">
	<input type="hidden" name="v_mid" value="<%=v_mid%>">
	<input type="hidden" name="v_oid" value="<%=v_oid%>">
	<input type="hidden" name="v_rcvname" value="<%=v_rcvname%>">
	<input type="hidden" name="v_rcvaddr" value="<%=v_rcvaddr%>">
	<input type="hidden" name="v_rcvtel" value="<%=v_rcvtel%>">
	<input type="hidden" name="v_rcvpost" value="<%=v_rcvpost%>">
	<input type="hidden" name="v_amount" value="<%=v_amount%>">
	<input type="hidden" name="v_ymd" value="<%=v_ymd%>">
	<input type="hidden" name="v_orderstatus" value="<%=v_orderstatus%>">
	<input type="hidden" name="v_moneytype" value="<%=v_moneytype%>">
	<input type="hidden" name="v_url" value="<%=v_url%>">
	<input type="hidden" name="v_md5info" value="<%=v_md5info%>">
	<input type="hidden" value="֧��">
</form>



</body>
</html>

