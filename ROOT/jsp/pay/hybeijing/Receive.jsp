<%@page contentType="text/html; charset=GBK" language="java"%><%@ page import="tea.resource.Resource" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.*"%><%@page import="tea.entity.ocean.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.resource.*" %><%@page import="java.io.*" %>
<%@page import="java.util.*" %><%@page import="java.util.Date" %>
<%
request.setCharacterEncoding("GBK");
TeaSession teasession = new TeaSession(request);



Calendar cal = Calendar.getInstance();
int day = cal.get(Calendar.DAY_OF_MONTH);
cal.set(Calendar.DATE,day+5);


//��ȡ����
String v_oid = request.getParameter("v_oid"); // ������/�̻����͵�v_oid�������;
String v_pstatus = request.getParameter("v_pstatus");//֧�������1������֧�����δȷ������20֧����ɣ�30֧�����ܾ���
String v_pstring = request.getParameter("v_pstring");//���ύ����v_pstatus=1ʱ����//֧����ɣ���v_pstatus=20ʱ����//ʧ��ԭ�򣨵�v_pstatus=30ʱ,�ַ�������
String v_pmode = request.getParameter("v_pmode");//֧����ʽ���ַ�������/֧����ʽ���ַ�������
String v_md5info = request.getParameter("v_md5info");// char* text     ƴ�����//          char* key     �Գ���Կv_md5infoУ���ĸ�������ƴ���ַ�����˳��Ϊ��v_oid��v_pstatus��v_pstring��v_pmode/
String v_amount = request.getParameter("v_amount");//�����ܽ��  ����ʵ��֧�����//
String v_moneytype = request.getParameter("v_moneytype");//7��v_moneytype ����ʵ��֧������//
String v_md5money = request.getParameter("v_md5money");//8��v_md5money=char* hmac_md5(char* text, char* key)//v_md5moneyЧ������������ƴ���ַ�����˳��Ϊ��v_amount��v_moneytype
String v_sign = request.getParameter("v_sign");


String v_oid_s[]=v_oid.split("\\|_\\|");
String v_pstatus_s[] = v_pstatus.split("\\|_\\|");//֧�������1������֧�����δȷ������20֧����ɣ�30֧�����ܾ���
String v_pstring_s[] = v_pstring.split("\\|_\\|");//���ύ����v_pstatus=1ʱ����//֧����ɣ���v_pstatus=20ʱ����//ʧ��ԭ�򣨵�v_pstatus=30ʱ,�ַ�������
String v_pmode_s[] = v_pmode.split("\\|_\\|");//֧����ʽ���ַ�������/֧����ʽ���ַ�������
String v_md5info_s[] = v_md5info.split("\\|_\\|");// char* text     ƴ�����//          char* key     �Գ���Կv_md5infoУ���ĸ�������ƴ���ַ�����˳��Ϊ��v_oid��v_pstatus��v_pstring��v_pmode/
String v_amount_s[] = v_amount.split("\\|_\\|");//�����ܽ��  ����ʵ��֧�����//
String v_moneytype_s[] = v_moneytype.split("\\|_\\|");//7��v_moneytype ����ʵ��֧������//
String v_md5money_s[] = v_md5money.split("\\|_\\|");//8��v_md5money=char* hmac_md5(char* text, char* key)//v_md5moneyЧ������������ƴ���ַ�����˳��Ϊ��v_amount��v_moneytype
String v_sign_s[] = v_sign.split("\\|_\\|");

if(v_oid_s.length>1)
{
  for(int i=0;i<v_oid_s.length;i++)
  {
    v_oid=v_oid_s[i];
    v_pstatus= v_pstatus_s[i];
    int ids =Ocean.getIdtoBeijingorder(v_oid);
    Ocean oce = Ocean.find(ids);
    StringBuffer str1 = new StringBuffer();
    if(oce.getOrderstatic()!=0)
    {
      int type=0;
      try
      {
        tea.service.SendEmaily se = new tea.service.SendEmaily(teasession._strCommunity);
        if ("1".equals(v_pstatus))
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
          str1.append("������ϵ�绰��010-62176655-6738��6799��6792��677").append("<br>");
          type=0;
          System.out.println("���׳ɹ�1:v_oid:"+v_oid);
          Ocean.updatetypebeijing(v_oid,1);
        } else if ("20".equals(v_pstatus))
        {
          type=1;
          Ocean.updatetypebeijing(v_oid,1);
          str1.append("���ã�").append("<br>");
          str1.append("��������֧���ɹ��������ȴ�������Ա�ƿ���Ԥ���߸������գ������Ķ������Ϊ"+oce.getOceanorder()).append("<br>");
          str1.append("�����ƿ���ɺ󣬹�����Ա�Ὣ�쿨֪ͨ�������ĵ������䣬�����հ�����̼������Ϣ�ɲ�ѯ�����������վwww.bj-sea.com ��").append("<br>");
          str1.append("������л������2010�꺣���գ���ϲ����Ϊ�������������Ա��").append("<br>");
          str1.append("����ƾ2011�꺣���տ���2012��4��30��ǰ���޴βι۱�������ݡ���������԰������è�ݣ��������Ʒ��ר����Ա����֪ͨ�����ֻ����ŵ���ʽ���͸����������������վ��Աר��Ҳ��ͬʱ���л���ݹ����������������������ʳ�������Żݣ�9���Żݡ�������Ʒ���⣩��").append("<br>");
          str1.append("������ܰ��ʾ�������ս��ޱ���ʹ�ã���ݼ����������Ż�ʱ��������ʾ�����ڷǱ���ʹ�ã���������ݽ��ջش˿���ͬʱ�����ǻ�Ҫ�ٴ����������˿��۳��󣬲����˻�����ʧ������").append("<br>");
          str1.append("������������ݻ�Ա�����Ժ��󻷱���ҵ���ذ�������������㹫�񡣱�������ݷḻ��ʵĺ�������չʾ�����ʵ����������벻����������Ա���ѹ�ͬ�İ��ĺǻ����������Եظ�л���Ա�������ݵ�֧����񰮡�ף��������죡").append("<br>");
          str1.append("���������������Զ�����������").append("<br>");
          str1.append("�����ٷ���վ��www.bj-sea.com").append("<br>");
          str1.append("������ϵ�绰��010-62176655-6738��6799��6792��6771").append("<br>");
            System.out.println("���׳ɹ�:20:v_oid:"+v_oid);
        }else if ("30".equals(v_pstatus))
        {
          type=0;
          Ocean.updatetypebeijing(v_oid,0);
          str1.append("���ã�").append("<br>");
          str1.append("��������ʧ�ܣ����������룡").append("<br>");
        }
        se.sendEmail(oce.getEmail(),"������֧����Ϣ��",str1.toString());
      }
      catch(Exception ex)
      {
        System.out.print(ex.toString());
      }
    }
  }
}
//v_md5infoУ���ĸ�������ƴ���ַ�����˳��Ϊ��v_oid��v_pstatus��v_pstring��v_pmode/
//6��v_amount����ʵ��֧�����//
//7��v_moneytype ����ʵ��֧������//
//8��v_md5money=char* hmac_md5(char* text, char* key)
//char* text     ƴ�����
//             char* key     �Գ���Կ
//v_md5moneyЧ������������ƴ���ַ�����˳��Ϊ��v_amount��v_moneytype
 String qs22=request.getQueryString();
 System.out.print(qs22.toString());
if(request.getMethod().equals("GET"))
{
  String qs=request.getQueryString();
  if(qs==null)
  return;
  String param[]=qs.split("&");
  for(int i=0;i<param.length;i++)
  {
    if(param[i].startsWith("v_pmode="))
    {
      v_pmode=java.net.URLDecoder.decode(param[i].substring("v_pmode=".length()),"GBK");
    }else if(param[i].startsWith("v_pstring="))
    {
      v_pstring=java.net.URLDecoder.decode(param[i].substring("v_pstring=".length()),"GBK");
    }
  }
}


String text = v_oid + v_pstatus + v_amount + v_moneytype;

//���Ź�Կ�ļ�
String publicKey = application.getRealPath("/WEB-INF/lib/Public1024_1459.key");

/////�����޸�
int ids =Ocean.getIdtoBeijingorder(v_oid);
Ocean oce = Ocean.find(ids);
StringBuffer str1 = new StringBuffer();
int type=0;
try
{
  tea.service.SendEmaily se = new tea.service.SendEmaily(teasession._strCommunity);
  if ("1".equals(v_pstatus))
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
    type=0;
    Ocean.updatetypebeijing(v_oid,1);
  } else if ("20".equals(v_pstatus))
  {
    type=1;
    Ocean.updatetypebeijing(v_oid,1);
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
  }else if ("30".equals(v_pstatus))
  {
    type=0;
    Ocean.updatetypebeijing(v_oid,0);
    str1.append("���ã�").append("<br>");
    str1.append("��������ʧ�ܣ����������룡").append("<br>");
  }
  se.sendEmail(oce.getEmail(),"������֧����Ϣ��",str1.toString());
}
catch(Exception ex)
{
  System.out.print(ex.toString());
}
%>

<html>
<head>
<link href="/tea/CssJs/bj-sea.css" rel="stylesheet" type="text/css">
<title>
���׳ɹ�
</title>
</head>
<body class="OceanPassport">
<div class="body">
  <table class="Flow1">
    <tr>
      <td class="td01"></td><td class="td02">��������</td><td class="td03">��д�ǼǱ�</td><td class="td04">ȷ�϶���</td><td class="td05">֧������</td>
    </tr></table>
    <div class="Ocean">
      <div class="Ocean_top"></div><div class="Ocean_con"><div class="Ocean_bottom">
        <div class="Success">
          <form  name="form1" action="/servlet/EditOcean" method="get" enctype="multipart/form-data">
          <input   type="hidden"  name="act"  value="OceanSuccess">
          <input   type="hidden"  name="ids"  value="<%=ids%>">
          <input type="hidden" name="type" value="<%=type%>" />

          <table id="tablecenter">
            <tr><td class="td01"><%if
            ("1".equals(v_pstatus))
            {
              out.print("���ύ��");
            } else if ("20".equals(v_pstatus))
            {
              out.print("���׳ɹ���");
              Ocean.updatetype(v_oid,1);
            }else if ("30".equals(v_pstatus))
            {
              out.print("����ʧ�ܣ�");
            }%></td>
            </tr>
            <tr><td class="td02">���ã�</td>
</tr>
<tr>
  <td class="td03"><%if
  ("1".equals(v_pstatus))
  {
    %>
    ���������ʽ����ύ����ȴ�������Ա����֧��ȷ�ϣ�<br>
    ����֧���ɹ��󣬹�����Ա�Ὣ֪ͨ���͵����ĵ������䡣<br>
    �������Ķ������Ϊ<%=oce.getOceanorder()%>�������հ�����̿��ڱ����������վ����ѯ�ƿ���Ϣ����Ŀ�в�ѯ��<br>
    <%
    } else if ("20".equals(v_pstatus))
    {

      %>
      ����֧���ɹ��������ȴ�������Ա�ƿ���Ԥ���߸������գ����ƿ���ɺ󣬹�����Ա�Ὣ�쿨֪ͨ�������ĵ������䣬��Ҳ�ɵ�½�����������վ���ڡ���ѯ�ƿ���Ϣ����Ŀ�н��к����հ�����̲�ѯ�����Ķ������Ϊ<%=oce.getOceanorder()%>��
      ��


      �����ʽ����ύ�ɹ���Ԥ���߸������գ���ɺ����ǻὫ֪ͨ�����������䣬Ҳ��ӭ����ʱ�ں������վ�ϵġ���ѯ�ƿ���Ϣ�С���ѯ�����Ķ������Ϊ<%=oce.getOceanorder()%>��<br>
      <%
      }else if ("30".equals(v_pstatus))
      {
        %>
        ����������ʧ�ܣ����������룡
        <%
        }%></td>
        </tr>

          </table>
          <div class="chaxunhuzxx"><a href="/jsp/ocean/OceanSearch.jsp"><img src="/res/bj-sea/u/0902/090264986.jpg"/></a></div>
          <div class="Success_bottom"><input type="button" onclick="window.open('/jsp/ocean/EditOceanRoll.jsp','_self')" value=""/></div>
          </form>
      </div>
    </div>
</div>
</div>
<div class="footer">Copyright(c)2001-2010 ��������ݡ���Ȩ���� ��ַ������������������б����18�ţ���������԰�����ڣ�</br>
��Ʊ���ߣ���010��62123910 ��ַ��www.BJ-sea.com</div>
</div>
</body>
</html>


