<%@ page contentType="text/html; charset=GBK" language="java"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.security.*"%>
<%@ page import="encrypt.MD5"%>
<%@ page import="tea.entity.member.*"%>
<%
request.setCharacterEncoding("GBK");

	String c_mid			= request.getParameter("c_mid")		;
	String c_order			= request.getParameter("c_order")	;
	String c_orderamount	= request.getParameter("c_orderamount");
	String c_ymd			= request.getParameter("c_ymd")		;
	String c_transnum		= request.getParameter("c_transnum");
	String c_succmark		= request.getParameter("c_succmark");
	String c_moneytype		= request.getParameter("c_moneytype");
	String c_cause			= request.getParameter("c_cause")	;
	String c_memo1			= request.getParameter("c_memo1")	;
	String c_memo2			= request.getParameter("c_memo2")	;
	String c_signstr		= request.getParameter("c_signstr")	;

	String c_pass		= "gouwuxiang89";		//�̻��Լ���֧����Կ


	//---��֧��֪ͨ��Ϣ����MD5����
	MD5 md5 = new MD5();
	String srcStr = c_mid + c_order + c_orderamount + c_ymd + c_transnum + c_succmark + c_moneytype + c_memo1 + c_memo2 + c_pass;
	String r_signstr = md5.getMD5ofStr(srcStr).toLowerCase();



	//String cncardIP=request.getRemoteAddr();
	//�ڴ˿ɶ�����IP��ַ����У�ԡ�

	//---У���̻���վ��֪ͨ��Ϣ��MD5���ܵĽ��������֧�������ṩ��MD5���ܽ���Ƿ�һ��
	//---�ڴ�Ҳ���Խ����̻��ţ�֧��������Ϣ����У�ԣ����ɿ������Լ�������


%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title></title>
</head>
	<body style="background-color:#DCF4DE">
<style>
*{font-size:14px}
img{border:0px}
#zhifuok{margin-left:20px}
#zhifuok td{padding:3px 10px;color:#000;margin-left:40px}
#zhifuleft{background-image: url(http://www.gouwuxiang.com/res/9000gw/u/0708/070812054.jpg);
	background-position: left middle;
	background-repeat: no-repeat;border-right:1px solid #ccc}
</style>
		<div align="center" style="margin-top;100px">

		<table width="700" border="0" align="center" cellpadding="0" cellspacing="0">
		  <tr>
		  <td width="300" id="zhifuleft"> <div align="center">��������������ϲ��,�����ύ�ɹ�!<br>
            <br>
            <br>
		  </div>
	      <div style="text-align:center; margin:2px 0px;">����<a  onclick="javascript:window.close(); return false;" href="#"><img src="http://www.gouwuxiang.com/res/9000gw/u/0708/070812055.jpg"></a></div></td>
		  <td width="250">
		<table width="250" border="0" cellpadding="0" cellspacing="0" id="zhifuok">
<tr><td>������:</td><td><%=c_order%></td>
<tr><td>���:</td><td><%=c_orderamount%></td>
<tr><td>����:</td><td><%=c_moneytype%></td>
<tr><td>��ˮ��:</td><td><%=c_transnum%></td>
<tr><td>�ɹ���־:</td><td><%

	if (!r_signstr.equals(c_signstr))
	{
		out.print("ǩ����֤ʧ��");
	}else
	{
		if("Y".equals(c_succmark))
		{
			out.print("֧���ɹ�");
			//�ڴ˽������ݲ�����
		}else
        {
          out.print("֧��ʧ��,"+c_cause);
        }
	}

%></td>
</table>
 </td></tr></table>
	</div>

	</body>
</html>
