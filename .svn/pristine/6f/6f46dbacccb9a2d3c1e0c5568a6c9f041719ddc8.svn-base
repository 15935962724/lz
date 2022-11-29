<%@page contentType="text/html;charset=UTF-8"  %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="tea.db.*" %>
<%@ page import="tea.entity.bpicture.*" %>
<%@ page import="tea.entity.node.*" %>
<%@ page import="tea.entity.member.*" %>
<%@ page import="tea.service.SendEmaily"%>
<%
TeaSession teasession = new TeaSession(request);
request.setCharacterEncoding("UTF-8");

StringBuffer param=new StringBuffer("?community=").append(teasession._strCommunity).append("&id=").append(request.getParameter("id"));
StringBuffer sql = new StringBuffer(" and regstyle=0");

String audit = request.getParameter("audit");
String aid = request.getParameter("aid");
if(audit!=null&& aid!=null)
{
  int iaudit = Integer.parseInt(audit);
  int iaid = Integer.parseInt(aid);
  String saler = teasession.getParameter("saler");
  Bperson.upAudit(iaid,iaudit);

    Profile p = Profile.find(saler);
  try
  {
    SendEmaily se = new SendEmaily(teasession._strCommunity);
    String sexs =p.isSex()? "女士" : "先生";
    StringBuffer sb = new StringBuffer();
    if(iaudit == 1){
    sb.append("尊敬的&nbsp;" + p.getFirstName(teasession._nLanguage) + sexs + "&nbsp;您好:<br/>　　您所上传的样图和身份认证已通过审核，您可以登陆&nbsp;<a href='http://bp.redcome.com/jsp/bpicture/regist/BpNavigation.jsp?member="+java.net.URLEncoder.encode(saler,"utf-8")+"&type=1'>我的B-p----上传图片</a>&nbsp;上传更多的图片开始销售，您也可以登陆&nbsp;<a href='http://bp.redcome.com/jsp/bpicture/regist/BpNavigation.jsp?member="+java.net.URLEncoder.encode(saler,"utf-8")+"&type=2'>我的B-p-----帐户信息</a>&nbsp;对您的支付方式或个人资料进行进一步的完善<br/>");
    }
    else{
    sb.append("尊敬的&nbsp;" + p.getFirstName(teasession._nLanguage) + sexs + "&nbsp;您好:<br/>　　您所上传的样图和身份认证已被取消，具体情况您可以联系我们，进行进一步的咨询。<br/>");
    }
    se.sendEmail(saler,"B-picture商业图片网审核消息",sb.toString());

  } catch(Exception ex)
  {
    ex.printStackTrace();
    String url = "/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("邮件发送失败,请检查是否存在该邮箱！","UTF-8");
    response.sendRedirect(url);
    return;
  }finally{

  }
}

String member= request.getParameter("member");
if(member!=null&&member.length()>0)
{
  sql.append(" and  email like ").append(DbAdapter.cite("%"+member+"%"));
  param.append("&member=").append(DbAdapter.cite(member));
}

String name= request.getParameter("name");
if(name!=null&&name.length()>0)
{
  sql.append(" and email in (select member from profilelayer where firstname like "+DbAdapter.cite("%"+name+"%")+")");
  param.append("&name=").append(java.net.URLEncoder.encode(name,"UTF-8"));
}

String ad= "";
if(request.getParameter("ad")!=null&&request.getParameter("ad").length()>0&&!request.getParameter("ad").equals("2"))
{
  ad = request.getParameter("ad");
  String ads = " and auditsaler="+ad;
  if(ad.equals("0"))
  {
    ads = " and (auditsaler="+ad+" or auditsaler is null)";
  }
  sql.append(ads);
  param.append("&ad=").append(ad);
}

int pos=0;
if(request.getParameter("pos")!=null)
{
  pos=Integer.parseInt(request.getParameter("pos"));
}
param.append("&pos=").append(pos);


int count=Bperson.count(sql.toString());
%>
<html>
<HEAD>
  <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
  <SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type="" ></SCRIPT>
  <SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/jquery.js" type="" ></SCRIPT>
  <SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/zoomi.js" type="" ></SCRIPT>
  <SCRIPT LANGUAGE=JAVASCRIPT SRC="/jsp/csvclub/js.js" type=""></SCRIPT>
  <title>审核供应商身份</title>
  <style>
  #table005{width:95%;margin-top:15px;}
  #table005 td{background:#eee;padding:5px 10px;}
  .lzj_001{border:1px solid #7F9DB9;background:#fff;height:23px;line-height:20px;*line-height:16px;padding-bottom:5px;*padding-bottom:0;}
  </style>
</HEAD>
<body style="margin:0;">
<div id="wai">
<div id="li_biao"><a href="http://bp.redcome.com" target="_top">首页</a>&nbsp;>&nbsp;管理中心&nbsp;>&nbsp;审核供应商身份</div>
  <h1>审核供应商身份</h1>
  <form action="?" method="POST">
<input type="hidden" name="id" value="<%=request.getParameter("id")%>"/>
  <table border="0" cellpadding="0" cellspacing="2" id="table005">
  <tr>
  <td width="82">用户名</td><td width="328"><input type="text" name="member" value="<%if(member!=null)out.print(member);%>"/></td>
  <td width="112">姓名</td><td><input type="text" name="name" value="<%if(name!=null)out.print(name);%>"/></td>
  <td>状态</td><td><select name="ad">
    <option value="2">全部</option>
    <option value="0" <%if(ad.equals("0"))out.print("selected");%>>未审核</option>
    <option value="1" <%if(ad.equals("1"))out.print("selected");%>>已审核</option>
</select></td>
<td><input type="submit" value="查询"/></td>
  </tr>
  </table>
  </form>
  <h2>列表（<%=count%>）</h2>
  <table border="0" cellpadding="0" cellspacing="2" id="table005">
    <tr>
      <td width="3%" nowrap="nowrap">序号</td><td width="10%">用户名</td><td width="7%">姓名</td><td>手机号</td><td>复印件类型</td><td>身份证图片</td><td>样图</td><td>状态</td><td>操作</td>
    </tr>
    <%

    java.util.Enumeration  enumers =Bperson.findByCommunity(sql.toString(),pos,10);
    if(!enumers.hasMoreElements())
    {
      %>   <tr><td colspan="10">暂无信息</td>
      </tr>
      <%
      }
      int index = 1;
      while(enumers.hasMoreElements())
      {
        int ee=((Integer) enumers.nextElement()).intValue();
        Bperson b = Bperson.find(ee);
        String firstnames="";
        if(Profile.isExisted(b.getEmail()))
        {
          Profile pro =Profile.find(b.getEmail());
          firstnames  = pro.getFirstName(teasession._nLanguage);
        }
        String cardtype = "";
        if(b.getCard()!=null){
          if(b.getCard().split("!")[0].equals("1")){
            cardtype = "身份证";
          }else{
            cardtype = "军官证";
          }
        }
        String cd1 = "",cd2="";
        if(b.getCard()!=null){
          String cardArray[] = b.getCard().split("!");
          for(int z = 0; z < cardArray.length; z++){
            if(z==1){
              cd1 = cardArray[1];
            }
            if(z == 2){
              cd2 = cardArray[2];
            }
          }
        }
        %>
        <tr>
          <td><%=pos+index%></td>
          <td nowrap="nowrap"><%if(b.getMember()!=null){out.print(b.getMember());}%></td>
          <td nowrap="nowrap"><%=firstnames%></td>
          <td nowrap="nowrap"><%if(b.getMobile()!=null){out.print(b.getMobile());}%></td>
          <td><%=cardtype%></td>
          <td nowrap="nowrap">
            <%
            if(b.getCard()!=null){
             if(cd1.length()>0){
                %>
                <a href="###" onclick="window.open('<%=b.getCard().split("!")[1]%>','_blank');"><img id="<%=ee+'1'%>" width="120" height="60" onmouseover="zoom(<%=ee+'1'%>)" alt="" src="<%=b.getCard().split("!")[1]%>" /></a>
                <%
                }
                if(cd2.length()>0){
                %>
                <a href="###" onclick="window.open('<%=b.getCard().split("!")[2]%>','_blank');"><img id="<%=ee+'2'%>" width="120" height="60" onmouseover="zoom(<%=ee+'2'%>)" alt="" src="<%=b.getCard().split("!")[2]%>" /></a>
                <%
                }
              }
              %>
          </td>
          <td nowrap="nowrap">
          <%
          if(b.getTestpic()!=null){
            String[] testpic = b.getTestpic().split("!");

            if(testpic!=null){
              for(int j = 0; j < testpic.length; j++){

                if(testpic[j]!=null&&testpic[j].length()>0){
                  out.print("<a href=\"#\" onclick=window.open('"+testpic[j]+"','_blank');><img id='testpic"+j+"' src="+testpic[j]+"  onmouseover=zoom('testpic"+j+"'); width=120 height=60></a>&nbsp;");
                }
              }
            }
          }
          %>
          </td>
          <td><%if(b.getAuditsaler()==1){out.print("已审核");}else{out.print("未审核");}%></td>
          <td>
          <%if(b.getAuditsaler()!=1)
          {%>
          <input class="lzj_001" type="button" value="审核" onClick="if(confirm('再次确认'))window.location.href='/jsp/bpicture/saler/Audit_saler.jsp?saler=<%=b.getMember()%>&audit=1&pos=<%=pos%>&aid=<%=ee%>';"/>
          <%
          }else{
            %>
            <input class="lzj_001" type="button" value="取消" onClick="if(confirm('是否取消该摄影师的资格？'))window.location.href='/jsp/bpicture/saler/Audit_saler.jsp?saler=<%=b.getMember()%>&audit=0&pos=<%=pos%>&aid=<%=ee%>';"/>
            <%
            }
            %>
            </td>
        </tr>
        <%
        index++;
      }
      %>
      <tr>
        <td colspan="10" align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage,param.toString().replaceFirst("&pos=","&")+"&pos=",pos,count,10)%>
        </td>
      </tr>
  </table>

</div>
<script type="">
function zoom(obj)
{
$('#'+obj+'').zoomi();
}
</script>
</body>
</html>
