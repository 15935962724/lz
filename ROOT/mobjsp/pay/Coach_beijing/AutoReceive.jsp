<%@page contentType="text/html; charset=GBK" language="java"%><%@page import="tea.ui.*" %><%@page import="tea.entity.member.*"%><%@page import="com.capinfo.crypt.*"%><%@ page import="tea.entity.subscribe.*" %>
<%@ page import="tea.entity.admin.*" %><%@page import="java.util.Date" %><%
request.setCharacterEncoding("GBK");
TeaSession teasession=new TeaSession(request);

//��ȡ����
int v_count = Integer.parseInt(request.getParameter("v_count"));
String v_oid = request.getParameter("v_oid"); // ������
String v_pmode = request.getParameter("v_pmode");
String v_pstatus = request.getParameter("v_pstatus");
String v_pstring = request.getParameter("v_pstring");
String v_amount = request.getParameter("v_amount");
String v_moneytype = request.getParameter("v_moneytype");

String v_mac = request.getParameter("v_mac");
String v_md5money = request.getParameter("v_md5money");
String v_sign = request.getParameter("v_sign");

String text = v_oid + v_pstatus + v_amount + v_moneytype + v_count; //ƴ�ռ��ܴ�

//���Ź�Կ�ļ�
String publicKey = application.getRealPath("/WEB-INF/lib/Public1024.key");

//��Կ��֤
RSA_MD5 rsaMD5 = new RSA_MD5();
int k = rsaMD5.PublicVerifyMD5(publicKey, v_sign, text);

System.out.println("������: ����:"+v_oid+"\t��֤:"+(k==0));//������: ����: \t��֤
if (k == 0)
{
	String a_oid[]=v_oid.split("\\|_\\|");
	String a_pmode[]=v_pmode.split("\\|_\\|");
	String a_pstatus[]=v_pstatus.split("\\|_\\|");
	String a_pstring[]=v_pstring.split("\\|_\\|");
	for(int i=0;i<v_count;i++)
    {
		 int poid = 0;
		  if(v_oid.substring(14,v_oid.length()-2)!=null && v_oid.substring(14,v_oid.length()-2).length()>0)
		  {
			  poid = Integer.parseInt(v_oid.substring(14,v_oid.length()-2));
		  }
		  PayOrder pobj = PayOrder.find(poid);
		
		

       
    
       System.out.println("�ӳٽ��׶���:;"+pobj.getPayorder());//�ӳٽ��׶���:
		if("1".equals(a_pstatus[i]))
		{
			if(pobj.getType()==3)//���ӱ��ײ�֧��
			{
				 
				  PackageOrder pkobj = PackageOrder.find(pobj.getPayorder());
				
				  
				  pobj.setPotype(1);
				  pobj.setPaytime(new Date());
					pkobj.set("type",1); 
					//�޸�֧����ʽ
					pkobj.set("paymanner",2);//	����֧�� 2
					//�޸�֧������
					pkobj.setPayname(pkobj.PAYNAME_TYPE[2]);
					//�޸ĸ���ʱ��
					pkobj.setPaytime(new Date());
					
					pkobj.set("effect",1);//�޸���Ч״̬ 
					pkobj.setActivatimet(new Date());//�޸ļ���ʱ��
					pkobj.setSubtime(pobj.getPayorder());//�޸��ײ��Ķ���Ч��
					System.out.println("���ӱ��ײ�֧������:"+pobj.getPayorder());
				  
			}else if(pobj.getType()==4)//�ֻ�֧��
			{
				
				MobileOrder  mobj = MobileOrder.find(pobj.getPayorder());
				  pobj.setPotype(1);
				  pobj.setPaytime(new Date());
					//
				//���� ����
				mobj.setType(1);
				mobj.setPaytime(new Date());
	 

				Cookie cookie=new Cookie(String.valueOf(mobj.getNode()),"/"+mobj.getMobile()+"/"+mobj.getMobilecode()+"/"+mobj.getNode()+"/"+mobj.getCommunity()+"/");
				cookie.setMaxAge(60*60*24);//60*60*24һ��
				cookie.setPath("/");
				response.addCookie(cookie);
				 out.println("���Ķ���֧���ɹ����������ǣ�<font color=red>"+pobj.getPayorder()+"</font>,֧���� "+pobj.getAmount()); 
				 System.out.println("shoujizhif:"+pobj.getPayorder());
			}
		}else
		{
          System.out.println("֧��ʧ��");
		}
	}
	out.print("sent");
}else
{
	out.print("error");
}
%>
