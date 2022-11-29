<%@page contentType="text/html;charset=UTF-8" import="java.util.*" %>
<%@page import="tea.html.*" %>
<%@ page import="tea.htmlx.Languages"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="tea.entity.site.*" %>
<%@page import="tea.entity.node.*" %>
<%@ page import="tea.http.RequestHelper"%>
<%@ page import = "tea.resource.Resource" %>
<%@ page import = "tea.entity.node.Sms" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="java.io.*" %>
<%@page import="tea.db.*"%>
<%@page import="tea.entity.util.*"%>
<%@page import="java.lang.*"%>
<%

request.setCharacterEncoding("UTF-8");
TeaSession teasession = new TeaSession(request);

String value = teasession.getParameter("value");
String name =  teasession.getParameter("name");

if(value!=null && value.length()>0)
{
  if("MemberId".equals(name))//用户名检测
  {
    if(Profile.isExisted(value))
    {
       out.print("<font color=red>很遗憾，该账号已经被注册，请另选一个</font>");
    }else
    {
      out.print("<font color=green>恭喜，该账号可以使用!</font>");
    }
  }
  if("EnterPassword".equals(name))
  {
    out.print("<font color=green>密码设置成功！</font>");
  }
  if("ConfirmPassword".equals(name))
  {
    String ps = teasession.getParameter("ps");
    if(ps.equals(value))
    {
        out.print("<font color=green>确认密码设置成功！</font>");
    }else
    {
      out.print("<font color=red>两次输入的密码不一致，请重新输入！</font>");
    }
  }
//  if("Name".equals(name))
//  {
//    out.print("<font color=green>企业名称添加成功！</font>");
//  }
//  if("father1".equals(name))
//  {
//    if("0".equals(value)){
//      out.print("<font color=red>请选择所属行业</font>");
//    }else
//    {
//          out.print("<font color=green>所属行业选择成功！</font>");
//    }
//  }
//  if("City2".equals(name))
//  {
//     out.print("<font color=green>所属地区选择成功！</font>");
//  }
//   if("Address".equals(name))
//  {
//    out.print("<font color=green>企业地址添加成功！</font>");
//  }
//   if("Zip".equals(name))
//  {
//    if(value.length()>6 || value.length()<6)
//    {
//      out.print("<font color=red>邮编必须是6位数字!</font>");
//    }else
//    {
//      for(int i=0;i<6;i++)
//      {
//         if(!Character.isDigit(value.charAt(i)))
//         {
//            out.print("<font color=red>你输入非法字符，邮编必须是数字!</font>");
//            break;
//         }
//      }
//
//    }
////    if(value.length()>6 || value.length()<6){
////
////      for(int i =1;i<6;i++){
////        if(!Character.isDigit(value.charAt(i)))
////          {
////            out.print("<font color=red>你输入非法字符，邮编必须是数字!</font>");
////          }
////        }
////
////      }else
////      {
////        out.print("<font color=red>邮编必须是6位数字!</font>");
////      }
////    }else
////    {
////      out.print("<font color=green>邮编添加成功！</font>");
////    }
//  }
//   if("WebPage".equals(name))
//  {
//    out.print("<font color=green>企业网址添加成功！</font>");
//  }
//   if("Country".equals(name))
//  {
//    out.print("<font color=green>网站说明添加成功！</font>");
//  }
//   if("Telephone".equals(name))
//  {
//    out.print("<font color=green>电话添加成功！</font>");
//  }
//
//   if("Fax".equals(name))
//  {
//    out.print("<font color=green>传真添加成功！</font>");
//  }
//
//   if("Email".equals(name))
//  {
//    out.print("<font color=green>邮箱添加成功！</font>");
//  }
//  if("Text".equals(name))
//  {
//  out.print("<font color=green> 企业简介添加成功！</font>");
//  }
}
//
//else
//{
//   out.print("<font color=red>不能为空!</font>");
//}

%>

