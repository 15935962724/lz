<%@page contentType="text/html; charset=GBK" language="java"%><%@page import="com.capinfo.crypt.*"%><%@ page import="tea.resource.Resource" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.ui.TeaSession" %><%@page import="tea.entity.*"%><%@page import="tea.entity.ocean.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.resource.*" %><%@page import="java.io.*" %><%@page import="java.util.*" %><%@page import="java.util.Date" %><%
request.setCharacterEncoding("GBK");
TeaSession teasession = new TeaSession(request);

String v_oid =request.getParameter("v_oid");
String v_count = request.getParameter("v_count");
String v_pstatus = request.getParameter("v_pstatus");
String v_pstring =request.getParameter("v_pstring");
String v_pmode =request.getParameter("v_pmode");
String v_md5info = request.getParameter("v_md5info");
String v_amount = request.getParameter("v_amount");
String v_moneytype = request.getParameter("v_moneytype");
String v_md5money = request.getParameter("v_md5money");
String v_sign = request.getParameter("v_sign");
String v_mac =request.getParameter("v_mac");
String v_oid_s[] = v_oid.split("\\|_\\|");
String v_pstatus_s[] = v_pstatus.split("\\|_\\|");
String text =v_oid+v_pmode+v_pstatus+v_pstring+v_count;
String publicKey = application.getRealPath("/WEB-INF/lib/Public1024.key");
Md5beijing md5 = new Md5beijing ( "" ) ;
md5.hmac_Md5beijing(text , publicKey);
byte b[]= md5.getDigest();
String digestString = md5.stringify(b) ;


if(v_oid_s.length > 0)
{
  for(int i = 0;i < v_oid_s.length;i++)
  {
    v_oid = v_oid_s[i];
    v_pstatus = v_pstatus_s[i];
    int ids = Ocean.getIdtoBeijingorder(v_oid);
    Ocean oce = Ocean.find(ids);

    StringBuffer str1 = new StringBuffer();
    if(oce.getOrderstatic() == 0)
    {
      try
      {
        tea.service.SendEmaily se = new tea.service.SendEmaily(teasession._strCommunity);
        if("1".equals(v_pstatus))
        {
          str1.append("���ã�").append("<br>");
          str1.append("��������֧���ɹ��������ȴ�������Ա�ƿ���Ԥ���߸������գ������Ķ������Ϊ"+oce.getOceanorder()).append("<br>");
          str1.append("�����ƿ���ɺ󣬹�����Ա�Ὣ�쿨֪ͨ�������ĵ������䣬�����հ�����̼������Ϣ�ɲ�ѯ�����������վwww.bj-sea.com ��").append("<br>");
          str1.append("������л������2011�꺣���գ���ϲ����Ϊ�������������Ա��").append("<br>");
          str1.append("����ƾ2011�꺣���տ���2012��4��30��ǰ���޴βι۱�������ݡ���������԰������è�ݣ��������Ʒ��ר����Ա����֪ͨ�����ֻ����ŵ���ʽ���͸����������������վ��Աר��Ҳ��ͬʱ���л���ݹ����������������������ʳ�������Żݣ�9���Żݡ�������Ʒ���⣩��").append("<br>");
          str1.append("������ܰ��ʾ�������ս��ޱ���ʹ�ã���ݼ����������Ż�ʱ��������ʾ�����ڷǱ���ʹ�ã���������ݽ��ջش˿���ͬʱ�����ǻ�Ҫ�ٴ����������˿��۳��󣬲����˻�����ʧ������").append("<br>");
          str1.append("������������ݻ�Ա�����Ժ��󻷱���ҵ���ذ�������������㹫�񡣱�������ݷḻ��ʵĺ�������չʾ�����ʵ����������벻����������Ա���ѹ�ͬ�İ��ĺǻ����������Եظ�л���Ա�������ݵ�֧����񰮡�ף��������죡").append("<br>");
          str1.append("���������������Զ�����������").append("<br>");
          str1.append("�����ٷ���վ��www.bj-sea.com").append("<br>");
          str1.append("������ϵ�绰��010-62176655-6738��6799��6792��6771").append("<br>");
          if(oce.getOrderstatic()>0)
          {
          }
          else
          {
            Ocean.updatetypebeijing(v_oid,1);
          }
        }else if("3".equals(v_pstatus))
        {
          Ocean.updatetypebeijing(v_oid,0);
          str1.append("���ã�").append("<br>");
          str1.append("��������ʧ�ܣ����������룡").append("<br>");
        }
        else if("0".equals(v_pstatus))
        {
          Ocean.updatetypebeijing(v_oid,0);
          str1.append("���ã�").append("<br>");
          str1.append("�������������룡").append("<br>");
        }
        se.sendEmail(oce.getEmail(),"������֧����Ϣ��",str1.toString());

      } catch(Exception ex)
      {
        System.out.print(ex.toString());
        out.print("error");
        return;
      }
    }
  }
}
out.print("sent");

%>
