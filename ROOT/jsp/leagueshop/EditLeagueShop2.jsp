<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.net.*"%><%@ page import="java.util.*"%><%@ page import="java.text.*"%><%@ page import="java.security.*"%><%@ page import="com.capinfo.crypt.*"%><%@ page import="tea.entity.member.*"%>
<%@ page import="tea.ui.*"%><%@ page import="java.math.*"%><%@ page import="tea.entity.csvclub.alipay.*"%><%@ page import="tea.entity.csvclub.encrypt.*" %><%@ page import="tea.entity.admin.mov.*" %><%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.entity.league.*" %><%@page import="tea.entity.admin.*" %><%@page import="tea.entity.util.*" %>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession = new TeaSession(request);
String community=teasession._strCommunity;
StringBuffer param=new StringBuffer();
String menu_id=(request.getParameter("id"));
if(menu_id!=null&&menu_id.length()>0)
{
  param.append("&id=").append(menu_id);
}

String num="0";// 不同参数代表的意识   0 总部添加或修改加盟点信息。1 分店修改分店信息
if(teasession.getParameter("num")!=null)
{
  num=teasession.getParameter("num");
}
int idss =0;
if(teasession.getParameter("idss")!=null && teasession.getParameter("idss").length()>0)
{
  idss = Integer.parseInt(teasession.getParameter("idss"));
}

int lsaddtype=0;
int bumenx=0;
if(teasession.getParameter("lsaddtype")!=null && teasession.getParameter("lsaddtype").length()>0)
{
  lsaddtype = Integer.parseInt(teasession.getParameter("lsaddtype"));

  AdminUsrRole adminobj = AdminUsrRole.find(teasession._strCommunity,teasession._rv.toString());
  bumenx=adminobj.getUnit();
  idss= LeagueShop.findid(adminobj.getUnit());

  if(idss==0)
  {
    response.sendRedirect("/jsp/leagueshop/LeagueShopInfoOver.jsp");
  }
}
LeagueShop leaobj = LeagueShop.find(idss);

LeagueShopbackup leaobj2 = LeagueShopbackup.find(idss);
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script> if(parent.lantk) { document.getElementsByTagName("LINK")[0].href="/res/csvclub/cssjs/community_02.css"; } </script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type="" ></SCRIPT>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/jsp/csvclub/js.js" type=""></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache"/>
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache"/>
<META HTTP-EQUIV="Expires" CONTENT="0"/>
<title>分店信息审核</title>

<link href="style.css" rel="stylesheet" type="text/css" />
<link href="../about/style.css" rel="stylesheet" type="text/css" />
</head>


<body>
<h1>
分店
</h1>
<h2>分店登记信息</h2>
<form name="form3" action="/servlet/EditLeagueShop" method="POST" enctype="multipart/form-data">


<input type="hidden" name="idss" value="<%=idss%>" />
<TABLE border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter">

  <input type="hidden" name="act" value="EditLeagueAuditlist" />
  <tr><td height="30"><div align="right">关联内网部门：</div></td>
    <td>
    <%
    AdminUnit obja=AdminUnit.find(leaobj.getBumen());
    out.print(obja.getName());

    AdminUnit obja2=AdminUnit.find(leaobj2.getBumen());
    if(obja.getName()!=obja2.getName())
    {
      if(obja2.getName()!=null)
      out.print("　　<font color=red>"+obja2.getName()+"</font>");
    }
    %>
    </td>
</tr>


<tr>
  <td height="30"><font color="red"></font><div align="right">分店名称:</div></td><td>
  <%
  if(leaobj.getLsname()!=null)
  {
    out.print(leaobj.getLsname());
    if(leaobj.getLsname().equals(leaobj2.getLsname()))
    {

    }
    else
    {
      if(leaobj2.getLsname()!=null)
      out.print("　　<font color=red>"+leaobj2.getLsname()+"</font>");
    }
  }
  else
  {
    if(leaobj2.getLsname()!=null)
    out.print("　　<font color=red>"+leaobj2.getLsname()+"</font>");
  }

  %></td>
  </tr>
  <tr>
    <td height="30"><div align="right">营业执照注册店名:</div></td><td>
    <%if(leaobj.getLsbusiness()!=null)
    {
      out.print(leaobj.getLsbusiness());
      if(leaobj.getLsbusiness().equals(leaobj2.getLsbusiness())&& leaobj2.getLsbusiness()!=null)
      {
      }
      else
      {
        if(leaobj2.getLsbusiness()!=null)
        out.print("　　<font color=red>"+leaobj2.getLsbusiness()+"</font>");
      }
    }

    %></td>
    </tr>
    <tr>
      <td height="30"><div align="right">卫生登记证书:</div></td><td>
      <%if(leaobj.getHealth()!=null)
      {out.print(leaobj.getHealth());
      if(leaobj.getHealth().equals(leaobj2.getHealth())&& leaobj2.getHealth()!=null)
      {
      }else
      {
        if(leaobj2.getHealth()!=null)
        out.print("　　<font color=red>"+leaobj2.getHealth()+"</font>");
      }
    }

      %></td>
      </tr>
      <tr>
        <td height="30"><div align="right">法人：</div></td><td>
        <%if(leaobj.getLegalperson()!=null)
        {out.print(leaobj.getLegalperson());
        if(leaobj.getLegalperson().equals(leaobj2.getLegalperson())&& leaobj2.getLegalperson()!=null)
        {
        }
        else
        {
          if(leaobj2.getLegalperson()!=null)
          out.print("　　<font color=red>"+leaobj2.getLegalperson()+"</font>");
        }
      }


        %></td>
        </tr>
        <tr>
          <td height="30"><div align="right">经营性质：</div></td><td>
          <%if(leaobj.getBuytype()!=null)
          {
            out.print(leaobj.getBuytype());
            if(leaobj.getBuytype().equals(leaobj2.getBuytype())&& leaobj2.getHealth()!=null)
            {
            }
            else
            {
              if(leaobj2.getBuytype()!=null)
              out.print("　　<font color=red>"+leaobj2.getBuytype()+"</font>");
            }
          }

          %> </td>
          </tr>
          <tr>
            <td height="30"><div align="right">营业地址：</div></td><td>
            <%
            out.print(LeagueShop.CSAREA[leaobj.getCsarea()]+"　　");
            if(leaobj.getCsarea()==(leaobj2.getCsarea()))
            {
            }
            else
            {
              if(leaobj2.getCsarea()!=0)
              out.print("　　<font color=red>"+LeagueShop.CSAREA[leaobj2.getCsarea()]+"</font>");
            }

            Card dd = Card.find(leaobj.getCity());
            Card dd2 = Card.find(leaobj2.getCity());

            %>
            <%out.print(dd.toString().replaceAll("/","　　"));


            if(dd.toString().equals(dd2.toString()))
            {
            }
            else
            {
              if(dd2.isExists())
              {
                out.print("　　<font color=red>"+dd2.toString().replaceAll("/","　　")+"</font>");
              }
            }
            %>

            <%if(leaobj.getRegion()!=null){
              out.print(leaobj.getHealth());
              if(leaobj.getRegion().equals(leaobj2.getRegion()))
              {

              }
              else
              {
                if(leaobj2.getRegion()!=null)
                out.print("　　<font color=red>"+leaobj2.getRegion()+"</font>");
              }
            }


            %>
            区
            <%if(leaobj.getPort()!=null)
            {out.print(leaobj.getPort());
            if(leaobj.getPort().equals(leaobj2.getPort()))
            {

            }
            else
            {
              if(leaobj2.getPort()!=null)
              out.print("　　<font color=red>"+leaobj2.getPort()+"</font>");
            }
          }

            %>
            巷
            <%if(leaobj.getNumber()!=null)
            {out.print(leaobj.getNumber());
            if(leaobj.getNumber().equals(leaobj2.getNumber()))
            {

            }
            else
            {
              if(leaobj2.getNumber()!=null)
              out.print("　　<font color=red>"+leaobj2.getNumber()+"</font>");
            }
          }
            %>
            号 （必填）</td>
          </tr>
          <tr>
            <td height="30"><div align="right">营业电话：</div></td><td>
            <%if(leaobj.getTel()!=null)
            {out.print(leaobj.getTel());
            if(leaobj.getTel().equals(leaobj2.getTel())&& leaobj2.getTel()!=null)
            {

            }
            else
            {
              if(leaobj2.getTel()!=null)
              out.print("　　<font color=red>"+leaobj2.getTel()+"</font>");
            }
          }

            %>
            （必填）</td>
          </tr>
          <tr>
            <td height="30"><div align="right">加盟商姓名：</div></td><td>
            <%if(leaobj.getLsbuyname()!=null){out.print(leaobj.getLsbuyname());
            if(leaobj.getLsbuyname().equals(leaobj2.getLsbuyname())&& leaobj2.getLsbuyname()!=null)
            {

            }
            else
            {
              if(leaobj2.getLsbuyname()!=null)
              out.print("　　<font color=red>"+leaobj2.getLsbuyname()+"</font>");
            }
          }
            %>
            <%
            out.print(LeagueShop.SHOWSEX[leaobj.getLsbuysex()]+"　");
            if(leaobj.getLsbuysex()==(leaobj2.getLsbuysex()))
            {

            }
            else
            {
              if(leaobj2.getLsbuysex()!=0)
              out.print("　　<font color=red>"+LeagueShop.SHOWSEX[leaobj2.getLsbuysex()]+"</font>");
            }
            %>
            手机电话：
            <%if(leaobj.getLsbuytel()!=null)
            {out.print(leaobj.getLsbuytel());
            if(leaobj.getLsbuytel().equals(leaobj2.getLsbuytel()))
            {

            }
            else
            {
              if(leaobj2.getLsbuytel()!=null)
              out.print("　　<font color=red>"+leaobj2.getLsbuytel()+"</font>");
            }
          }
            %>"
            (必填）</td>
          </tr>
          <tr>
            <td height="30"><div align="right">加盟商最高学历：</div></td><td>
            <%if(leaobj.getLsbuyschool()!=null){out.print(leaobj.getLsbuyschool());
            if(leaobj.getLsbuyschool().equals(leaobj2.getLsbuyschool()))
            {

            }
            else
            {
              if(leaobj2.getLsbuyschool()!=null)
              out.print("　　<font color=red>"+leaobj2.getLsbuyschool()+"</font>");
            }
          }

            %></td>
            </tr>
            <tr>
              <td height="30"><div align="right">加盟前所从事的职业：</div></td><td>
              <%if(leaobj.getLsbuyjob()!=null)
              {out.print(leaobj.getLsbuyjob());
              if(leaobj.getLsbuyjob().equals(leaobj2.getLsbuyjob()))
              {

              }
              else
              {
                if(leaobj2.getLsbuyjob()!=null)
                out.print("　　<font color=red>"+leaobj2.getLsbuyjob()+"</font>");
              }
            }

              %>
              职务
              <%if(leaobj.getLsbuypost()!=null)
              {out.print(leaobj.getLsbuypost());
              if(leaobj.getLsbuypost().equals(leaobj2.getLsbuypost()))
              {

              }
              else
              {
                if(leaobj2.getLsbuypost()!=null)
                out.print("　　<font color=red>"+leaobj2.getLsbuypost()+"</font>");
              }
            }
              %></td>
              </tr>
              <tr>
                <td height="30"><div align="right">是否专职经营连锁店：</div></td><td>
                <%
                out.print(LeagueShop.FALGS[leaobj.getLsbuycsfalg()]+"　");

                if(leaobj.getLsbuycsfalg()==(leaobj2.getLsbuycsfalg()))
                {

                }
                else
                {
                  if(leaobj2.getLsbuycsfalg()!=0)
                  out.print("　　<font color=red>"+LeagueShop.FALGS[leaobj2.getLsbuycsfalg()]+"　"+"</font>");
                }
                %>
                </td>
              </tr>
              <tr>
                <td height="30"><div align="right">店长姓名：</div></td><td>
                <%if(leaobj.getShopkeepername()!=null)
                {
                  out.print(leaobj.getShopkeepername());
                  if(leaobj.getShopkeepername().equals(leaobj2.getShopkeepername()))
                  {

                  }
                  else
                  {
                    if(leaobj2.getShopkeepername()!=null)
                    out.print("　　<font color=red>"+leaobj2.getShopkeepername()+"　"+"</font>");
                  }
                }

                %>
                <%

                out.print(LeagueShop.SHOWSEX[leaobj.getSksex()]);
                if(leaobj.getSksex()==(leaobj2.getSksex()))
                {

                }
                else
                {
                  if(leaobj2.getSksex()!=0)
                  out.print("　　<font color=red>"+LeagueShop.SHOWSEX[leaobj2.getSksex()]+"　"+"</font>");
                }


                %>
                手机电话：
                <%if(leaobj.getSktel()!=null){
                  out.print(leaobj.getSktel());
                  if(leaobj.getSktel().equals(leaobj2.getSktel()))
                  {

                  }
                  else
                  {
                    if(leaobj2.getSktel()!=null)
                    out.print("　　<font color=red>"+leaobj2.getSktel()+"</font>");
                  }
                }

                %></td>
                </tr>
                <tr>
                  <td height="30"><div align="right">店长最高学历：</div></td><td>
                  <%if(leaobj.getSkschool()!=null){
                    out.print(leaobj.getSkschool());
                    if(leaobj.getSkschool().equals(leaobj2.getSkschool()))
                    {

                    }
                    else
                    {
                      if(leaobj2.getSkschool()!=null)
                      out.print("　　<font color=red>"+leaobj2.getSkschool()+"</font>");
                    }
                  }

                  %></td>
                  </tr>
                  <tr>
                    <td height="30"><div align="right">加盟前所从事的职事：</div></td><td>
                    <%if(leaobj.getSkjob()!=null)
                    {out.print(leaobj.getSkjob());
                    if(leaobj.getSkjob().equals(leaobj2.getSkjob()))
                    {

                    }
                    else
                    {
                      if(leaobj2.getSkjob()!=null)
                      out.print("　　<font color=red>"+leaobj2.getSkjob()+"</font>");
                    }
                  }

                    %>
                    职务:
                    <%if(leaobj.getSkpost()!=null)
                    {
                      out.print(leaobj.getSkpost());
                      if(leaobj.getSkpost().equals(leaobj2.getSkpost()))
                      {

                      }
                      else
                      {
                        if(leaobj2.getSkpost()!=null)
                        out.print("　　<font color=red>"+leaobj2.getSkpost()+"</font>");
                      }
                    }

                    %></td>
                    </tr>
                    <tr>
                      <td height="30">&nbsp;</td>
                    </tr>
</table>
<h2>连锁店基本信息</h2>
<TABLE border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter">
  <tr>
    <td height="30"><span style="font-weight:bold; font-size: 16px;">连锁店基本信息</span></td>
  </tr>
  <tr>
    <td height="30">


      <div align="right">加盟类型：</div></td><td>
        <input type="hidden" name="lstype" value="<%=leaobj.getLstype()%>" />
        <input type="hidden" name="lsstype" value="<%=leaobj.getLsstype()%>" />
        <%
        LeagueShopType objty = LeagueShopType.find(leaobj.getLstype());
        LeagueShopServer objtys = LeagueShopServer.find(leaobj.getLsstype());
        LeagueShopServer objtys2 = LeagueShopServer.find(leaobj2.getLsstype());
        out.print(objty.getLstypename());
        %>
        　级别：<%
        if(objtys.getLssname()!=null)out.print(objtys.getLssname());

        if(leaobj.getLsstype()==(leaobj2.getLsstype()))
        {

        }
        else
        {
          if(leaobj2.getLsstype()!=0)
          out.print("　　<font color=red>"+objtys2.getLssname()+"</font>");
        }



        %>
        加盟时间：<%if(leaobj.getAdddate()!=null)out.print(leaobj.getAdddateToString());%>
    </td>
  </tr>
  <tr>
    <td height="30"><div align="right">开业时间:</div></td><td>
    <%if(leaobj.getStartdate()!=null){
      out.print(leaobj.getStartdateToString());
      if(leaobj.getStartdate().equals(leaobj2.getStartdate()))
      {

      }
      else
      {
        if(leaobj2.getStartdate()!=null)
        out.print("　　<font color=red>"+leaobj2.getStartdateToString()+"</font>");
      }
    }

    %>　　
    美容床数：
    <%if(leaobj.getBednum()!=null){
      out.print(leaobj.getBednum());
      if(leaobj.getBednum().equals(leaobj2.getBednum()))
      {

      }
      else
      {
        if(leaobj2.getBednum()!=null)
        out.print("　　<font color=red>"+leaobj2.getBednum()+"</font>");
      }
    }


    %>
    张（必填）</td>
  </tr>
  <tr>
    <td height="30"><div align="right">经营面积：</div></td><td>
    <%if(leaobj.getShoparea()!=null)
    {
      out.print(leaobj.getShoparea());
      if(leaobj.getShoparea().equals(leaobj2.getShoparea()))
      {

      }
      else
      {
        if(leaobj2.getShoparea()!=null)
        out.print("　　<font color=red>"+leaobj2.getShoparea()+"</font>");
      }
    }

    %>
    是否有SPA：
    <%
    out.print(LeagueShop.YESNO[leaobj.getComputernum()]);

    if(leaobj.getComputernum()==(leaobj.getComputernum()))
    {

    }
    else
    {
      if(leaobj.getComputernum()!=0)
      out.print("　　<font color=red>"+LeagueShop.YESNO[leaobj2.getComputernum()]+"</font>");
    }


    %>
    </td>
  </tr>
  <tr>
    <td height="30"><div align="right">店长：</div></td><td>
    <%if(leaobj.getShopkeeper()!=null)
    {
      out.print(leaobj.getShopkeeper());
      if(leaobj.getShopkeeper().equals(leaobj2.getShopkeeper()))
      {

      }
      else
      {
        if(leaobj2.getShopkeeper()!=null)
        out.print("　　<font color=red>"+leaobj2.getShopkeeper()+"</font>");
      }
    }
    %>
    人 　　前台顾问：
    <%if(leaobj.getAdviser()!=null){
      out.print(leaobj.getAdviser());
      if(leaobj.getAdviser().equals(leaobj2.getAdviser()))
      {

      }
      else
      {
        if(leaobj2.getAdviser()!=null)
        out.print("　　<font color=red>"+leaobj2.getAdviser()+"</font>");
      }
    }


    %>
    人 　　　美容师：
    <%if(leaobj.getHairdresser()!=null){
      out.print(leaobj.getHairdresser());
      if(leaobj.getHairdresser().equals(leaobj2.getHairdresser()))
      {

      }
      else
      {
        if(leaobj2.getHairdresser()!=null)
        out.print("　　<font color=red>"+leaobj2.getHairdresser()+"</font>");
      }
    }


    %>
    人</td>
  </tr>
  <tr>
    <td height="30"><div align="right">固定（办卡）会员：</div></td><td>
    <%if(leaobj.getFixmember()!=null){
      out.print(leaobj.getFixmember());
      if(leaobj.getFixmember().equals(leaobj2.getFixmember()))
      {

      }
      else
      {
        if(leaobj2.getFixmember()!=null)
        out.print("　　<font color=red>"+leaobj2.getFixmember()+"</font>");
      }
    }


    %>人　　
    流动顾客：约
    <%if(leaobj.getMovemember()!=null){
      out.print(leaobj.getMovemember());
      if(leaobj.getMovemember().equals(leaobj2.getMovemember()))
      {

      }
      else
      {
        if(leaobj2.getMovemember()!=null)
        out.print("　　<font color=red>"+leaobj2.getMovemember()+"</font>");
      }
    }


    %>
    人</td>
  </tr>
  <tr>
    <td height="30"><div align="right">连锁店是否有电脑：</div></td><td>
    <%
    out.print(LeagueShop.FALGS[leaobj.getComputernum()]);


    if(leaobj.getComputernum()==(leaobj2.getComputernum()))
    {

    }
    else
    {
      if(leaobj2.getComputernum()!=0)
      out.print("　　<font color=red>"+LeagueShop.FALGS[leaobj2.getComputernum()]+"</font>");
    }
    %>
    </td>
  </tr>
  <tr>
    <td height="30"><div align="right">是否有网络连接：</div></td><td>
    <%
    out.print(LeagueShop.FALGS[leaobj.getNetwork()]+"　");

    if(leaobj.getNetwork()==(leaobj2.getNetwork()))
    {

    }
    else
    {
      if(leaobj2.getNetwork()!=0)
      out.print("　　<font color=red>"+LeagueShop.FALGS[leaobj2.getNetwork()]+"</font>");
    }
    %>
    </td>
  </tr>
  <tr>
    <td height="30"><div align="right">上网方式：</div></td><td>

    <%
    out.print(LeagueShop.INTERNETTYPES[leaobj.getInternettype()]);

    if(leaobj.getInternettype()==(leaobj.getInternettype()))
    {

    }
    else
    {
      if(leaobj2.getInternettype()!=0)
      out.print("　　<font color=red>"+LeagueShop.INTERNETTYPES[leaobj2.getInternettype()]+"</font>");
    }
    %>
    </td>
  </tr>
  <tr>
    <td height="30"><div align="right">是否能操作内部会员系统：</div></td><td>
    <%
    out.print(LeagueShop.FALGS[leaobj.getSystemtype()]);

    if(leaobj.getSystemtype()==(leaobj2.getSystemtype()))
    {

    }
    else
    {
      if(leaobj2.getSystemtype()!=0)
      out.print("　　<font color=red>"+LeagueShop.FALGS[leaobj2.getSystemtype()]+"</font>");
    }
    %>
    </td>
  </tr>
  <tr>
    <td height="20">&nbsp;</td><td></td>
  </tr>
  <tr><td></td>
    <td>　　　　　　　　　　　　　　　　　
      <input name="Submit4" type="submit" class="input3" value="审核通过" onClick="return checkuser();" />　

      <input type=button value="返回" onClick="javascript:history.back()"/></td>
</tr>
</table>
</body>
</html>

