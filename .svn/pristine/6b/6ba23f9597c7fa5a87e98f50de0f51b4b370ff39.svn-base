<%@page contentType="text/html;charset=UTF-8"  %>
<%@include file="/jsp/Header.jsp"%>

<%request.setCharacterEncoding("UTF-8");
String community=request.getParameter("community");
if(community==null)
{
  community=node.getCommunity();
}
Purview purview=Purview.find(teasession._rv.toString(),community);
if(purview.isJob()||purview.isResume()||purview.isApply()||purview.isCompany()|| License.getInstance().getWebMaster().equals(teasession._rv.toString()))
{

}else
{  ts.outText(response,1, "你没有权限,访问本页.");
    return;
}
%><html>
<head>
<TITLE>应聘管理</TITLE>

<LINK REL=StyleSheet HREF>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

</head>
<h1><%=r.getString(teasession._nLanguage, "招聘系统管理后台")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

           <style type="text/css">
<!--
#menu2,
#info{line-height: 20px;vertical-align: middle;padding-left:40px;}


#Listing5821{clear:both; display:block; width:100%; background:#EBEBEB; border:1px solid #D8D8D8;border-bottom:0; margin-top:-5px; padding-left:10px; line-height: 20px; vertical-align: middle;}


#menu2ul{widht:100%;border:1px solid #D8D8D8;border-top:0px}
#NodeTitle{padding-top:5px;line-height:20px;height:20px}



-->
</style>
          <div style="width:100%;">
            <h1 id="lemma ">欢迎您来到招聘系统管理后台---请阅读以下说明，并点击进入相应栏目进行操作。</h1>
                  <table border="0" scellpadding="0" cellspacing="0" id="tablecenter">
                   <tr>
                      <td><Spane><A href="/jsp/type/company/yjobcompanymanage.jsp" ID=Listing5821>机构设置</A></Span>
			  </td>
					</tr>
					<tr>
                      <td><span>新增公司</span> </td>
                      <td>创建新的公司机构，可进行联系人、联系方式、公司简介等相关设置。</span> </td>
                    </tr>
                    <tr>
                      <td><span>公司管理</span> </td>
                      <td>对已建好的公司进行编辑和删除操作，只有指定了权限的用户可以对创建的公司进行编辑和删除操作， 并且公司的创建者可进行编辑、删除操作。</span></td>
                    </tr>
                  </table> <br>

                  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
                   <tr>
                      <td > <Span><A href="/jsp/community/yjobsubscribers.jsp" ID=Listing5821>用户管理</A></Span>
					  </td>
					</tr>

				    <tr>
                      <td> <Span>新增用户</Span></td>
                      <td>进行新用户的注册，可进行用户名、密码、联系方式等基本信息的设置。</Span> </td>
                    </tr>
                    <tr>
                      <td> <Span>用户管辖机构设置</Span></td>
                      <td>可指定用户都管辖哪些公司，一个用户可同时管辖多家公司。</Span> </td>
                    </tr>
                    <tr>
                      <td> <Span ID=menu2>用户权限设置</Span></td>
                      <td>分为职位管理、简历管理、应聘管理、公司设置四部分进行权限授予，授权后用户可进行指定的操作。</Span> </td>
                    </tr>
                    <tr>
                      <td> <Span>修改用户信息</Span></td>
                      <td>管理员可对用户信息进行修改、删除，用户可以对自已的密码进行更改及个人信息进行修改。 </Span> </td>
                    </tr>
                  </table> <br>

                  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
                   <tr>
                      <td> <Span><A href="/jsp/type/job/yjobjobmanage.jsp" ID=Listing5821>职位管理</A></Span>
					  </td>
					</tr>
					 <tr>
                      <td><span>新增职位</span></td>
                      <td>在指定权限的公司下新增职位，可进行职位基本信息的设置、并指定为保存和发布，保存则不会显示到前台去，要经过显示和隐藏的操作才能正式发布。</span></td>
                    </tr>
                    <tr>
                      <td><span>职位查询</span> </td>
                      <td>可根据职位的相关参数对已建职位进行查询。</span></td>
                    </tr>
                    <tr>
                      <td><span>职位模板实现　　　　　　　</span></td>
                      <td>把现有职位做为模板，用于方便的发布类似新职位，模板的使用方法：在新增职位操作时，选择任何一个以前建好的职位，做为模板，则该职位的选项会被自动填写到新的职位创建界面。</span></td>
                    </tr>
                    <tr>
                      <td><span>职位编辑</span></td>
                      <td>对建好的职位进行编辑、删除等操作。</span></td>
                    </tr>
                  </table> <br>

                  <table border="0" cellpadding="0" cellspacing="0" >
                    <tr>
                      <td> <Span><A href="/jsp/type/resume/yjobapplymanage.jsp" ID=Listing5821>应聘管理</A></Span>
					  </td>
					</tr>
					<tr>
                      <td><SPAN>应聘信息按条件列出</SPAN> </td>
                      <td>此部分主要实现对应聘信息的查看，查看某一职位的应聘信息列表，列表项实现动态更新，动态列项。</span></td>
                    </tr>
                    <tr>
                      <td><span>应聘信息检索 </span> </td>
                      <td>按登陆用户的指定权限可检索相应职位的应聘信息。</span></td>
                    </tr>
                    <tr>
                      <td><span>检索结果导出 </span></td>
                      <td>对检索条件可自定义，可把指定条件生成检索器，方便下次进行同条件职位检索。</span></td>
                    </tr>
                    <tr>
                      <td><span>应聘信息筛选 </span></td>
                      <td>可把应聘信息分为三级进行筛选，一级为备选人才，二级为有价值人才，三级为不合要求人才，些部分程序数据库结构建立完成，程序开发刚开始。</span></td>
                    </tr>
                    <tr>
                      <td><span>应聘统计</span></td>
                      <td>按职位对应聘情况进行统计，生成列表。可统计指定职位总共收到应聘简历数等信息</span></td>
                    </tr>
                    <tr>
                      <td><span>邮件回复 </span></td>
                      <td>按筛选后的分类应聘人员，或自动，或手动，发邮件给相应人员，可实现群发。</span></td>
                    </tr>
                  </table> <br>

                  <table width="100%"  border="1" style="border-collapse:collapse;border-color:#D8D8D8" cellpadding="0" cellspacing="0" >
                     <tr>
                      <td  colspan="2"> <Span ID=NodeTitle><A href="/jsp/type/resume/yjobresumemanage.jsp" ID=Listing5821>简历管理</A></Span>
					  </td>
					</tr>

					<tr>
                      <td width="18%"><SPAN id=menu2>简历列表 </SPAN> </td>
                      <td>可按条件列出所有在系统中登记的简历。</span></td>
                    </tr>
                    <tr>
                      <td><span>简历查询 </span> </td>
                      <td>可根据简历的相关参数对所有简历进行查询。</span></td>
                    </tr>
                  </table> <br>
               <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
                     <tr>
                      <td> <Span><A href="/jsp/type/job/yjobtalkback.jsp" ID=Listing5821>反馈管理</A></Span>
					  </td>
					</tr>
					<tr>
                      <td><SPAN></SPAN>反馈信息列表 </SPAN> </td>
                      <td>可按条件列出所有用户提交的在系统使用过程中发现问题的反馈信息。</span></td>
                    </tr>
                  </table>

                <br>

             </div>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>

