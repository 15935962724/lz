<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="java.io.*" %>
<%@page import="java.util.*" %>
<% request.setCharacterEncoding("UTF-8");


TeaSession teasession=new TeaSession(request);

if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Resource r=new Resource().add("/tea/resource/deptuser");
if(teasession.getParameter("tp")==null){
%>
<HTML>
  <HEAD>
    <META http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
      <script src="/tea/tea.js" type="text/javascript"></script>
      <style type="text/css">
      <!--
      body {
      margin-left: 0px;
      margin-top: 0px;
      margin-right: 0px;
      margin-bottom: 0px;
      }
      -->
      </style>
      <script>

      function f_open(msnid)
      {
        window.open('http://settings.messenger.live.com/Conversation/IMMe.aspx?invitee='+msnid+'&mkt=zh-cn','','width=500px,height=400px');
      }
      function f_click(obj,id)
      {
        var div=document.getElementById("div"+id);
        if(div&&div.innerHTML!="")
        {
          var img,dis;
          if(obj.src.indexOf("tree_blank")!=-1)
          {
            dis="none";
            img="/tea/image/tree/tree_plus.gif";
          }else
          {
            dis="";
            img="/tea/image/tree/tree_blank.gif";
          }
          div.style.display=dis;
          obj.src=img;
        }
        obj.focus();
      }
      </script>
      </HEAD>
      <BODY id="sdf"><%}%>
        <div style="float:right;width:100%;text-align:right;<%if(teasession._strCommunity.equals("xiaoyoulu")||teasession._strCommunity.equals("wt89")||teasession._strCommunity.equals("Home")){out.print("display:none;");}%>"><a href="javascript:parent.topFrame.fright(0)"><img src="/tea/image/public/close.gif" width="20" height="20"></a></div>
<%if(teasession.getParameter("tp")!=null){%><marquee behavior=scroll direction=up scrollAmount=2 scrollDelay=1 <%--onmouseout=start()   onmouseover=stop()--%>><%}%>

          <TABLE id="tablecenter">

          <%
tree(out,teasession._strCommunity,AdminUnit.getRootId(teasession._strCommunity),teasession._nLanguage,1,r,true);    //树结构

//          if(teasession._strCommunity.equals("REDCOME")){
//            AdminUsrRole aur=AdminUsrRole.find(teasession._strCommunity,teasession._rv._strR);
//            int adminunit=aur.getUnit();
//            AdminUnit au = AdminUnit.find(adminunit);
//            if(au!=null){
//              String[] auList = au.getPath().split("/");
//              AdminUnit obj=AdminUnit.find(Integer.parseInt(auList[2]));
//
//              if(!auList[2].equals("199")){
//                tree(out,teasession._strCommunity,Integer.parseInt(auList[1]),teasession._nLanguage,1,r,false);
//              }else{
//                out.print("<tr><td colspan=2>&nbsp;<b>"+obj.getName()+"</b></td></tr>");
//              }
//              tree(out,teasession._strCommunity,Integer.parseInt(auList[2]),teasession._nLanguage,1,r,true);    //树结构
//              findMem(out,teasession._strCommunity,199,204,teasession._rv._strR,Integer.parseInt(auList[2]));
//            }
//          }else if(teasession._strCommunity.equals("xiaoyoulu")||teasession._strCommunity.equals("wt89")){
//            Enumeration eee = OnlineList.findByCommunity(teasession._strCommunity,"");
//            List olmem = new ArrayList();
//            while(eee.hasMoreElements())
//            {
//              String mem = eee.nextElement().toString();
//              OnlineList ol = OnlineList.find(mem);
//              String members = ol.getMember();
//              if(members!=null){
//                if(olmem.indexOf(members) == -1){
//                  olmem.add(members);
//                  Profile p=Profile.find(members);
//                  out.print("<tr><td>　　"+p.getName(1)+"</td></tr>");
//                }
//              }
//            }
//          }else
//          {
//            Enumeration e = AdminUnit.findByCommunity(teasession._strCommunity," AND father="+AdminUnit.getRootId(teasession._strCommunity));
//            if(e.hasMoreElements()){
//              tree(out,teasession._strCommunity,AdminUnit.getRootId(teasession._strCommunity),teasession._nLanguage,1,r,true);    //树结构
//              AdminUsrRole aur=AdminUsrRole.find(teasession._strCommunity,teasession._rv._strR);
//              int adminunit=aur.getUnit();
//              AdminUnit au = AdminUnit.find(adminunit);
//              if(au.getPath()!=null){
//                String[] auList = au.getPath().split("/");
//                findMem(out,teasession._strCommunity,199,204,teasession._rv._strR,Integer.parseInt(auList[2]));
//              }
//
//            }else
//            {
//              out.print("<tr><td colspan=2 nowrap=nowrap align=center><b>暂未创建组织机构</b></td></tr>");
//            }
//          }

          %>


          </TABLE>
<%if(teasession.getParameter("tp")==null){%>
          <BR>
            <div id="head6"><img height="6" src="about:blank"></div>

      </BODY>
</HTML>
<%}else{out.print("</marquee>");}%>

<%!
public static void tree(Writer out,String community,int father,int language,int setp,Resource r,boolean a)throws Exception
{
  Enumeration e = AdminUnit.findByCommunity(community," AND father="+father);//当前节点下所有部门
  ArrayList a2=new ArrayList();
  ArrayList a3=new ArrayList();
  for(int j=0;e.hasMoreElements();j++)
  {
    AdminUnit obj=(AdminUnit)e.nextElement();
    int id=obj.getId();

    Enumeration ee = OnlineList.findOnlineNew(community);//所有人员登录记录

    while(ee.hasMoreElements())
    {
      String mem = ee.nextElement().toString();


      AdminUsrRole aur=AdminUsrRole.find(community,mem);
      int adminunit=aur.getUnit();
      Enumeration au_enumer=AdminUnit.findByCommunity(community,"");
      while(au_enumer.hasMoreElements())
      {
        AdminUnit _au=(AdminUnit)au_enumer.nextElement();
        int iid=obj.getId();
        if(adminunit==iid)//这个人的部门存在
        {
          AdminUnit auobj = AdminUnit.find(adminunit);
          if(auobj.getName().equals(obj.getName())&& auobj.getFather() == obj.getFather())
          {
            if(a2.indexOf(obj.getName())==-1)//防重
            {
              a2.add(obj.getName());
              if(a){
                if(father!=199){
                  String name=AdminUnit.find(obj.getFather()).getName();
                  if(obj.getFather()!=1){
                    if(a3.indexOf(name) == -1)
                    {
                      a3.add(name);
                      out.write("<tr><td colspan=2 align=left nowrap=nowrap>");
                      for(int i=1;i<setp;i++)
                      {
                        out.write("　");
                      }
                      out.write("<b>├"+name+"</b></td></tr>");
                    }
                  }
                }
              }

              out.write("<tr><td align=left colspan=2 nowrap=nowrap>");
              if(a){
                for(int i=0;i<setp;i++)
                {
                  out.write("　");
                }

                // out.write("<img onclick=f_click(this,"+id+"); src=/tea/image/tree/tree_blank.gif align=absmiddle>");

                out.write("<b>├"+obj.getName()+"</b></td></tr>");
              }else{
                out.write("<b>&nbsp;&nbsp;"+obj.getName()+"</b></td></tr>");
              }
            }
          }
        }
      }
    }


    ArrayList al=new ArrayList();

    Enumeration eee = OnlineList.findOnlineNew(community);
    while(eee.hasMoreElements())
    {
      String mem = eee.nextElement().toString();
      Profile p=Profile.find(mem);

      AdminUsrRole aur=AdminUsrRole.find(community,mem);
      if(!aur.isProvider(1))
      {
        int adminunit=aur.getUnit();
        Enumeration au_enumer=AdminUnit.findByCommunity(community,"");
        while(au_enumer.hasMoreElements())
        {
            AdminUnit _au=(AdminUnit)au_enumer.nextElement();
            int iid=_au.getId();
          if(adminunit==iid)
          {
            AdminUnit auobj = AdminUnit.find(adminunit);
            if(auobj.getName().equals(obj.getName())&& auobj.getFather() == obj.getFather())
            {

              if(al.indexOf(mem)==-1)//防重
              {
                al.add(mem);
                if(p!=null)
                {

                  StringBuffer sb = new StringBuffer();
                  out.write("<tr><td nowrap=nowrap>　");
                  for(int i=0;i<setp;i++)
                  {
                    sb.append("　");
                  }

                  out.write(sb.toString()+p.getName(language)+"</td>");
                  String msnid = p.getMsnID();
                  out.write("<td>");
                  out.write("<A href=\"/jsp/message/NewMessage.jsp?community="+community+"&to="+java.net.URLEncoder.encode(mem,"UTF-8")+"\" target=_blank ><img src=/tea/image/public/message.gif></a>");
                  String mobile=p.getMobile();
                  if(mobile!=null&&mobile.length()>0)
                  {
                    out.write("<A href=\"/jsp/sms/EditSMSMessage.jsp?community="+community+"&to="+java.net.URLEncoder.encode(mem,"UTF-8")+"\" target=_blank ><img src=/tea/image/public/sms.gif></a>");//
                  }
                  if(msnid!=null)
                  {
                    out.write("<a href=# onclick=f_open('"+msnid+"'); ><img src='http://messenger.services.live.com/users/"+msnid+"/presenceimage/' /></a>");
                  }
                  out.write("</td></tr>");
                }
              }
            }
          }
        }
      }
    }
    if(a){
      out.write("<div id=div"+id+">");
      tree(out,community,id,language,setp+1,r,true);
      out.write("</div>");
    }
  }
}

//跨公司过滤显示
public void findMem(Writer out,String community,int unit1,int unit2,String mem,int checkunit)throws Exception
{

  Enumeration eu = AdminUnitSeq.findByCommunity(" and member='"+mem+"' and unit >="+unit1+" and unit <="+unit2);
  while(eu.hasMoreElements())
  {
    int id=((Integer)eu.nextElement()).intValue();

    if(id!=checkunit){

      AdminUnit obj=AdminUnit.find(id);
      out.write("<tr><td colspan=2>&nbsp;<b>"+obj.getName()+"</b></td></tr>");
      Enumeration eee = OnlineList.findOnlineNew(community);
      List l = new ArrayList();

      while(eee.hasMoreElements())
      {
        String member = eee.nextElement().toString();
        Enumeration eu1 = AdminUnitSeq.findByCommunity(" and member='"+member+"' and unit >="+unit1+" and unit <="+unit2);
        while(eu1.hasMoreElements())
        {
          int id1=((Integer)eu1.nextElement()).intValue();
          if(id1 == id){
            if(l.indexOf(member) == -1){
              l.add(member);
              Profile p=Profile.find(member);
              if(p!=null)
              {
                StringBuffer sb = new StringBuffer();
                out.write("<tr><td nowrap=nowrap>　");
                for(int i=0;i<1;i++)
                {
                  sb.append("&nbsp;&nbsp;");
                }
                out.write(sb.toString()+p.getName(1)+" ");
                out.write("<td ><A href=\"/jsp/message/NewMessage.jsp?community="+community+"&to="+java.net.URLEncoder.encode(member,"UTF-8")+"\" target=_blank ><img src=/tea/image/public/message.gif></a>");
                String mobile = p.getMobile();
                String msnid = p.getMsnID();
                if(mobile!=null&&mobile.length()>0)
                {
                  out.write("<A href=\"/jsp/sms/EditSMSMessage.jsp?community="+community+"&to="+java.net.URLEncoder.encode(member,"UTF-8")+"\" target=_blank ><img src=/tea/image/public/sms.gif></a>");//
                }
                if(msnid!=null)
                {
                  out.write("<a href=# onclick=f_open('"+msnid+"'); ><img src='http://messenger.services.live.com/users/"+msnid+"/presenceimage/' /></a>");
                }
                out.write("</td></tr>");
              }
            }
          }
        }
      }
    }
  }
}
%>

<!--
<h1>在线会员</h1>
<div id=head6><img height=6 src=about:blank></div>
  <br>
  -->
  <%--

  //Enumeration e=AdminUnit.findByCommunity(teasession._strCommunity,"");
  //for(int j=1;e.hasMoreElements();j++)
  //{
  //  int unltid=((Integer)e.nextElement()).intValue();
  //  AdminUnit au=AdminUnit.find(unltid);
  //  Enumeration e2=OnlineList.findByCommunity(teasession._strCommunity," AND member IN ( SELECT member FROM AdminUnit WHERE id="+unltid+" )");
  //  if(e2.hasMoreElements())
  //  {
  //    out.print("<h2>");
  //    if(au.isExists())
  //    {
  //      out.print(au.getPrefix()+au.getName());
  //    }else
  //    {
  //      out.print("无部门");
  //    }
  //    out.print("</h2><div id=head6><img height=6 src=about:blank></div> <table border=0 cellpadding=0 cellspacing=0 id=tablecenter>");
  //    while(e2.hasMoreElements())
  //    {
  //      String sid=(String)e2.nextElement();
  //      OnlineList ol=OnlineList.find(sid);
  //      String member=ol.getMember();
  //      Profile p=Profile.find(member);
  //      out.print("<tr><td>"+p.getName(teasession._nLanguage));
    //      out.print("<td><A href=\"/jsp/message/NewMessage.jsp?community="+teasession._strCommunity+"&to="+java.net.URLEncoder.encode(member,"UTF-8")+"\" target=_blank ><img src=/tea/image/public/message.gif></a>");
      //      out.print(" <A href=\"/jsp/sms/EditSMSMessage.jsp?community="+teasession._strCommunity+"&to="+p.getMobile()+"\" target=_blank ><img src=/tea/image/public/sms.gif></a>");//
      //    }
      //    out.print("</table>");
      //  }
      //}



      int old=-1;
      ArrayList al=new ArrayList();
      DbAdapter db = new DbAdapter(1);
      try
      {
      db.executeQuery("SELECT ol.member FROM OnlineList ol INNER JOIN AdminUsrRole aur ON ol.member=aur.member AND ol.community="+db.cite(teasession._strCommunity,1)+" AND aur.community="+db.cite(teasession._strCommunity,1)+" ORDER BY aur.unit DESC,aur.sequence");
      while (db.next())
      {
      String member=db.getString(1);
      if(al.indexOf(member)==-1)//防重
      {
      al.add(member);
      Profile p=Profile.find(member);
      AdminUsrRole aur=AdminUsrRole.find(teasession._strCommunity,member);
      if(old!=aur.getUnit())
      {
      old=aur.getUnit();
      out.print("</table><h2>");
      if(old==0)
      out.print("无部门");
      else{

      out.print( AdminUnit.find(old).getName());
      }
      out.print("</h2><div id=head6><img height=6 src=about:blank></div> <table border=0 cellpadding=0 cellspacing=0 id=tablecenter>");
      }
      out.print("<tr><td>"+p.getName(teasession._nLanguage));
        out.print("<td><A href=\"/jsp/message/NewMessage.jsp?community="+teasession._strCommunity+"&to="+java.net.URLEncoder.encode(member,"UTF-8")+"\" target=_blank ><img src=/tea/image/public/message.gif></a>");
        String mobile=p.getMobile();
        if(mobile!=null&&mobile.length()>0)
        {
        out.print(" <A href=\"/jsp/sms/EditSMSMessage.jsp?community="+teasession._strCommunity+"&to="+mobile+"\" target=_blank ><img src=/tea/image/public/sms.gif></a>");//
        }
        }
        }
        out.print("</table>");
        } finally
        {
        db.close();
        }

        --%>
