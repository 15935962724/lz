<%@ page contentType="text/html; charset=GBK" language="java"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.net.*"%>
<%@ page import="tea.entity.member.*"%>
<%@ page import="tea.ui.*"%>
<%@ page import="tea.entity.site.*" %>
<%@ page import="tea.entity.admin.mov.*" %>
<%@ page import="tea.entity.admin.*" %>

<%request.setCharacterEncoding("UTF-8");


TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?Node="+teasession._nNode);
  return;

}
Community communitys=Community.find(teasession._strCommunity);
String  money =null;//���
String email =null;//�û�
String order=null;//����
int idpay=0;
/******************�Լ��ķ�������*************************/

String memberorder = teasession.getParameter("memberorder");
int pay = 0;
if(teasession.getParameter("pay")!=null && teasession.getParameter("pay").length()>0)
{
  pay = Integer.parseInt(teasession.getParameter("pay"));
  idpay=pay;
}
int payid =0;
if(teasession.getParameter("payid")!=null && teasession.getParameter("payid").length()>0)
{
  payid = Integer.parseInt(teasession.getParameter("payid"));
  idpay=payid;
}

 Payinstall piobj = Payinstall.findpay(idpay);//֧����ʽ�����ñ�
if(pay>0){//�û��Ķ���
  MemberOrder moobj = MemberOrder.find(memberorder);//�û�ע��ɹ��Ķ�����
  MemberType mtobj = MemberType.find(moobj.getMembertype()); //��Ա���ͱ�
  MemberPay mpobj = MemberPay.find(moobj.getPayid());//��Աע��Ҫ�ɷѵ� �ɷѱ�
  Profile p = Profile.find(moobj.getMember());
  money=mpobj.getPaymoney().toString();
  email=p.getEmail();
  order=memberorder;
}

if(payid>0)//��Ʒ�Ķ���
{
  String trade = teasession.getParameter("trade");
  order=trade;
  Trade obj=Trade.find(trade);
  Profile p = Profile.find(obj.getCustomer().toString());
  if(p.getEmail()!=null && p.getEmail().length()>0){
    email = p.getEmail();
  }else
  {
    email = "zhang_js521@126.com";
  }
  money=obj.getTotal().toString();
}

/*******************************************************/


//��ʼ���������
String v_mid,key,v_url,v_oid,v_amount,v_moneytype,v_md5info;  //������봫�ݵĲ�������

v_mid  = piobj.getMerchant();	// �̻��ţ�����Ϊ�����̻���20000400���滻Ϊ�Լ����̻��ż���20396914
key    = piobj.getSafety();		// md5.9000.redcome.com
v_url = "http://"+request.getServerName()+":"+request.getServerPort()+piobj.getReturnurl();     // �̻��Զ��巵�ؽ���֧�������ҳ��  /jsp/pay/chinabank/Receive.jsp
// MD5��ԿҪ�������ύҳ��ͬ����Send.asp��� key = "test" ,�޸�""���� test Ϊ������Կ
				  // test �������û������MD5��Կ���½����Ϊ���ṩ�̻���̨����ַ��https://merchant3.chinabank.com.cn/
// ��½��������ĵ�����������ҵ������Ϲ����������Ϲ���Ķ������������С�MD5��Կ���á�
// ����������һ��16λ���ϵ���Կ����ߣ���Կ���64λ��������16λ�Ѿ��㹻��
//****************************************


//����������Ҫ�̻��޸�
v_oid=order;//��Աע��ʱ������Ķ���


//v_oid=request.getParameter("trade");
//if(v_oid==null || v_oid.length()<1)
//{
//  Date currTime = new Date();
//  SimpleDateFormat sf = new SimpleDateFormat("yyyyMMdd-"+v_mid+"-hhmmss",Locale.US);
//  v_oid=sf.format(currTime);                        // �Ƽ������Ź��ɸ�ʽΪ ������-�̻���-Сʱ������
//}

Trade obj=Trade.find(v_oid);
if(obj.getPaystate()>0)
{
  response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode("�ö����Ѿ�֧������","UTF-8"));
  return;
}

v_amount=money;//request.getParameter("v_amount");	// �������obj.getTotal().toString()
v_moneytype ="CNY";	                  				// ����
v_md5info = "";								// ��ƴ�մ�MD5˽Կ���ܺ��ֵ

String text = v_amount+v_moneytype+v_oid+v_mid+v_url+key;   // ƴ�ռ��ܴ�
tea.entity.csvclub.encrypt.MD5 m = new tea.entity.csvclub.encrypt.MD5();
v_md5info =  m.getMD5ofStr(text);                      // ����֧��ƽ̨��MD5ֵֻ�ϴ�д�ַ���������Сд��MD5ֵ��ת��Ϊ��д


//************���¼���������֧�������޹أ����鲻��**************
String v_rcvname,v_rcvaddr,v_rcvtel,v_rcvpost,v_rcvemail,v_rcvmobile;  //����Ǳ������

v_rcvname = obj.getLastName(teasession._nLanguage)+obj.getFirstName(teasession._nLanguage); //request.getParameter("v_rcvname");     // �ջ���
v_rcvaddr = obj.getCity(teasession._nLanguage);// request.getParameter("v_rcvaddr");     // �ջ���ַ
v_rcvtel = obj.getTelephone(teasession._nLanguage);// request.getParameter("v_rcvtel");      // �ջ��˵绰
v_rcvpost = obj.getZip(teasession._nLanguage);//request.getParameter("v_rcvpost");     // �ջ����ʱ�
v_rcvemail =email;// obj.getEmail();//request.getParameter("v_rcvemail");    // �ջ����ʼ�
v_rcvmobile = "";//request.getParameter("v_rcvmobile");   // �ջ����ֻ���

String v_ordername,v_orderaddr,v_ordertel,v_orderpost,v_orderemail,v_ordermobile;

v_ordername = v_rcvname;// request.getParameter("v_ordername");   // ����������
v_orderaddr = v_rcvaddr;//request.getParameter("v_orderaddr");   // �����˵�ַ
v_ordertel = v_rcvtel;//request.getParameter("v_ordertel");    // �����˵绰
v_orderpost = v_rcvpost;//request.getParameter("v_orderpost");   // �������ʱ�
v_orderemail = v_rcvemail;//request.getParameter("v_orderemail");  // �������ʼ�
v_ordermobile = v_rcvmobile;//request.getParameter("v_ordermobile"); // �������ֻ���

String remark1,remark2;

remark1 = request.getParameter("remark1");               //��ע�ֶ�1
remark2 = request.getParameter("remark2");               //��ע�ֶ�2


/*
		StringBuffer param=new StringBuffer("https://pay3.chinabank.com.cn/PayGate");
		param.append("?v_mid=").append(v_mid);
		param.append("&v_md5info=").append(v_md5info);
		param.append("&v_oid=").append(URLEncoder.encode(v_oid,"GBK"));
		param.append("&v_amount=").append(URLEncoder.encode(v_amount,"GBK"));
		param.append("&v_moneytype=").append(URLEncoder.encode(v_moneytype,"GBK"));
		param.append("&v_url=").append(URLEncoder.encode(v_url,"GBK"));

		param.append("&remark1=").append(URLEncoder.encode(remark1,"GBK"));
		param.append("&remark2=").append(URLEncoder.encode(remark2,"GBK"));

		param.append("&v_rcvname=").append(URLEncoder.encode(v_rcvname,"GBK"));
		param.append("&v_rcvaddr=").append(URLEncoder.encode(v_rcvaddr,"GBK"));
		param.append("&v_rcvtel=").append(URLEncoder.encode(v_rcvtel,"GBK"));
		param.append("&v_rcvpost=").append(URLEncoder.encode(v_rcvpost,"GBK"));
		param.append("&v_rcvemail=").append(URLEncoder.encode(v_rcvemail,"GBK"));
		param.append("&v_rcvmobile=").append(URLEncoder.encode(v_rcvmobile,"GBK"));

		param.append("&v_ordername=").append(URLEncoder.encode(v_ordername,"GBK"));
		param.append("&v_orderaddr=").append(URLEncoder.encode(v_orderaddr,"GBK"));
		param.append("&v_ordertel=").append(URLEncoder.encode(v_ordertel,"GBK"));
		param.append("&v_orderpost=").append(URLEncoder.encode(v_orderpost,"GBK"));
		param.append("&v_orderemail=").append(URLEncoder.encode(v_orderemail,"GBK"));
		param.append("&v_ordermobile=").append(URLEncoder.encode(v_ordermobile,"GBK"));

		response.sendRedirect(param.toString());
*/


%>

<!--������ϢΪ��׼�� HTML ��ʽ + JAVA ���� ƴ�ն��ɵ� �������� ֧���ӿڱ�׼��ʾҳ�� -->

<html>


<body onLoad="javascript:document.E_FORM.submit()">




<form action="https://pay3.chinabank.com.cn/PayGate" method="POST" name="E_FORM">

  <!--���¼���Ϊ����֧����Ҫ��Ϣ����Ϣ������ȷ������Ϣ��Ӱ��֧�����У�-->

  <input type="hidden" name="v_md5info"    value="<%=v_md5info%>" size="100">
  <input type="hidden" name="v_mid"        value="<%=v_mid%>">
  <input type="hidden" name="v_oid"        value="<%=v_oid%>">
  <input type="hidden" name="v_amount"     value="<%=v_amount%>">
  <input type="hidden" name="v_moneytype"  value="<%=v_moneytype%>">
  <input type="hidden" name="v_url"        value="<%=v_url%>">


  <!--���¼�����Ϊ����֧����ɺ���֧��������Ϣһͬ������Ϣ����ҳ���ڴ�����������ݲ���ı�,�磺Receive.asp -->

  <input type="hidden"  name="remark1" value="<%=remark1%>">
  <input type="hidden"  name="remark2" value="<%=remark2%>">

  <!--���¼���������֧�������޹أ�ֻ��������¼�ͻ���Ϣ�����Բ��ã�ʹ�úͲ�ʹ�ö���Ӱ��֧�� -->

	<input type="hidden"  name="v_rcvname"      value="<%=v_rcvname%>">
	<input type="hidden"  name="v_rcvaddr"      value="<%=v_rcvaddr%>">
	<input type="hidden"  name="v_rcvtel"       value="<%=v_rcvtel%>">
	<input type="hidden"  name="v_rcvpost"      value="<%=v_rcvpost%>">
	<input type="hidden"  name="v_rcvemail"     value="<%=v_rcvemail%>">
	<input type="hidden"  name="v_rcvmobile"    value="<%=v_rcvmobile%>">

	<input type="hidden"  name="v_ordername"    value="<%=v_ordername%>">
	<input type="hidden"  name="v_orderaddr"    value="<%=v_orderaddr%>">
	<input type="hidden"  name="v_ordertel"     value="<%=v_ordertel%>">
	<input type="hidden"  name="v_orderpost"    value="<%=v_orderpost%>">
	<input type="hidden"  name="v_orderemail"   value="<%=v_orderemail%>">
	<input type="hidden"  name="v_ordermobile"  value="<%=v_ordermobile%>">

  </form>




</body>
</html>
