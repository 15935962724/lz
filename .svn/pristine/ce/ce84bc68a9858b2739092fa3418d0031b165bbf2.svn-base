<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.resource.*"%>
<%@page import="tea.db.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.util.*"%>

<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession = new TeaSession(request);

//  if (teasession._rv == null) {
  //    response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
  //    return;
  //  }

/**
要有参数 node  就是要提交到那个节点上面
*/

  String subject = teasession.getParameter("subject");
  if("请输入企业名称".equals(teasession.getParameter("subject")))
  {
    subject =null;
  }
  int City=0;
  if(teasession.getParameter("City")!=null && teasession.getParameter("City").length()>0)
  {
    City = Integer.parseInt(teasession.getParameter("City"));
  }
  int father1=0;
  if(teasession.getParameter("father1")!=null && teasession.getParameter("father1").length()>0)
  {
    father1 = Integer.parseInt(teasession.getParameter("father1"));
  }
  int father2=0;
  if(father1>0 && teasession.getParameter("father2")!=null && teasession.getParameter("father2").length()>0)
  {
    father2 = Integer.parseInt(teasession.getParameter("father2"));
  }

  /*****************************************企业上级***************************/
  int last = 0;
  StringBuffer f1=new StringBuffer();
  StringBuffer f2=new StringBuffer();
  DbAdapter db = new DbAdapter();
  try
  {  //"+Community.find(teasession._strCommunity).getNode()+"
  db.executeQuery("SELECT node FROM Node WHERE path LIKE '%/"+teasession._nNode+"/%' AND type=1 AND hidden=0 AND node IN ( select node from Category WHERE Category=21) ORDER BY father");
  //out.print("SELECT node FROM Node WHERE path LIKE '/65549/%' AND type=1 AND hidden=0 AND node IN ( select node from Category WHERE Category=21) ORDER BY father");
  while(db.next())
  {

    int nid = db.getInt(1);
    Node nodeobj=Node.find(nid);
    int fid=nodeobj.getFather();
    String ns=nodeobj.getSubject(teasession._nLanguage);
    if(last!=fid)
    {
      last=fid;
      Node fobj = Node.find(fid);
      
      if(fobj.getSubject(teasession._nLanguage)!=null && fobj.getSubject(teasession._nLanguage).length()>0 && !fobj.isHidden()){
        f1.append("<option value='"+fid+"'");
        //  System.out.println(nid+"---"+father1+"---"+Node.find(fid).getSubject(teasession._nLanguage));
                if(fid==father1)//Node.find(father).getFather()
                {
                    f1.append(" selected");
               }
          f1.append(">").append(Node.find(fid).getSubject(teasession._nLanguage));
        }

        f2.append("break;\r\n");
        f2.append("case ").append(fid).append(":");
      }
      f2.append("op[op.length]=new Option(\""+nodeobj.getSubject(teasession._nLanguage)+"\","+nid+");");
    }
  }finally
  {
    db.close();
  }
  /*****************************************企业上级***************************/

  %>


  <form action="http://<%=request.getServerName() %>:<%=request.getServerPort() %>/servlet/Folder?node=<%=teasession._nNode %>&language=<%=teasession._nLanguage%>" name="form1" method="GET">
<input name="node" value="<%=teasession._nNode %>" type="hidden">
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td id="sear_Entname"><input type="text" name="subject" onblur="if (value ==''){value='请输入企业名称'}" onmouseover=this.focus()
onfocus="if (value =='请输入企业名称'){value =''};this.select(); " value="<%if(subject!=null)out.print(subject);else{out.print("请输入企业名称");}%>"/></td>
    </tr>
    <tr>
    <td id="sear_Entcity">
        <select name=City >
          <option value="0">请选择城市
          <%
          //StringBuffer sb=new StringBuffer();
          java.util.Enumeration ce=Card.find(" AND card<100",0,100);
          while(ce.hasMoreElements())
          {
            Card card=(Card)ce.nextElement();
            int ids=card.getCard();
            out.print("<option value="+ids);
            if(City==ids)
               out.print(" selected");
            out.print(">"+card.getAddress());
          }
          %>
          </select>
      </td>
    </tr>
    <tr>
      <td id="sear_Entclass">
        <select name="father1" onchange="f_ch()">
          <option value="0">请选择一级分类</option>
          <%=f1.toString()%>
        </select>
      </td>
    </tr>

    <tr>
      <td id="sear_Entclass2">
        <select name="father2" >
          <option value="0">请选择二级分类</option>
        </select>

        <script type="">
        function f_ch()
        {
          var op=form1.father2.options;
          while(op.length>1)
          {
            op[1]=null;
          }
          switch(parseInt(form1.father1.value))
          {
            case 0:
            <%=f2.toString()%>
            break;
          }
        }
        f_ch();
         form1.father2.value="<%=father2%>";

        </script>
        </td>
    </tr>
    <tr><td id="sear_Entsubmit"> <input type="submit" value="提交"/></td></tr>
  </table>

  </form>
