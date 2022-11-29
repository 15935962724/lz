<%@page contentType="text/html;charset=UTF-8" %><%@page import="org.apache.poi.hwpf.extractor.WordExtractor"%><%@ page import="tea.entity.node.*"%><%@ page import="tea.entity.*"%><%@ page import="tea.resource.*"%><%@ page import="tea.ui.*"%><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
String community=teasession.getParameter("community");
if(request.getMethod().equals("POST"))
{
  Node obj=Node.find(teasession._nNode);
  if(obj.getType()>1)
  {
    teasession._nNode=obj.getFather();
    obj=Node.find(teasession._nNode);
  }
  int type=obj.getType();
  if(obj.getType()==1)
  {
    Category c=Category.find(teasession._nNode);
    type=c.getCategory();
  }
  StringBuffer sb=new StringBuffer();
  if(teasession.getParameter("wordsubmit")!=null)
  {
    byte by[]=teasession.getBytesParameter("word");
    if(by==null)
    {
      response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode("文件无效","UTF-8"));
      return;
    }
    java.io.ByteArrayInputStream bis=new java.io.ByteArrayInputStream(by);
    try
    {
		    WordExtractor wordExtractor = new WordExtractor(bis);
		    //System.out.println("【 使用getText()方法提取的Word文件的内容如下所示：】");
		    
		     String cs[]=wordExtractor.getText().split("<EDN>");
    for(int index=0;index<cs.length;index++)
    {
    	
    	cs[index]=cs[index].trim();
        if(cs[index].length()>0)
        {
        
		    String[] paragraph = wordExtractor.getParagraphText();
		   // System.out.println("该Word文件共有"+paragraph.length+"段。");
		    //新闻标题
		    String subject = null,content2="";
		   java.util.Date time = new java.util.Date();
		    
		    for(int i=0;i<paragraph.length;i++){
		     //System.out.println("< 第 "+(i+1)+" 段的内容为 >");
		     if(i==0&&paragraph[i]!=null&&paragraph[i].length()>0)//标题
		     {
		    	 subject=paragraph[i];
		     }else if(i==1&&paragraph[i]!=null&&paragraph[i].length()>0)//时间
		     {
		    	 time = Entity.sdf.parse(paragraph[i]);
		     }else if(paragraph[i]!=null&&paragraph[i].length()>0)
		     {
		    	 content2 = content2+"<p>"+paragraph[i]+"</p>";
		     }
		    // System.out.println(paragraph[i]);
		    
		    }
		     System.out.println(subject);
		     System.out.println(time);
		     System.out.println(content2);
		   int newnode=Node.create(teasession._nNode,0,community,teasession._rv,type,false,obj.getOptions(),obj.getOptions1(),obj.getDefaultLanguage(),null,null,
		    		time,0,0,0,0,"",null,teasession._nLanguage,subject,"",content2,null,"",0,null,"","","","",null,null);
	        obj.finished(newnode);
        }
    }
      
      
    }catch(java.io.IOException e)
    {
      response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode("文件无效,不是Word文件.","UTF-8"));
      return;
    }

  }


//  response.sendRedirect("/servlet/Node?node="+teasession._nNode);
  response.sendRedirect("/jsp/info/Succeed.jsp");
  return;
}





Resource r = new Resource();


%>
<html>
<head>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<link href="/res/<%=teasession._strCommunity%>/cssjs/upload/style.css" rel="stylesheet" type="text/css">
<link href="/res/<%=teasession._strCommunity%>/cssjs/upload/uploadify.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/upload/jquery-1.3.2.min.js" type=""></SCRIPT>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/upload/swfobject.js" type=""></SCRIPT>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/upload/jquery.uploadify.v2.1.0.min.js" type=""></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<style>

#fileQueue {
	width: 400px;
	height: 220px;
	overflow: auto;
	border: 1px solid #E5E5E5;
	margin-bottom: 10px;
	background-color: #ffF;

}



/* --Uploadify -- */
.uploadifyQueueItem {
	font: 11px Verdana, Geneva, sans-serif;
	border: 2px solid #E5E5E5;
	background-color: #F5F5F5;
	margin-top: 5px;
	padding: 10px;
	width: 350px;
}
.uploadifyError {
	border: 2px solid #FBCBBC !important;
	background-color: #FDE5DD !important;
}
.uploadifyQueueItem .cancel {
	float: right;
}
.uploadifyProgress {
	background-color: #FFFFFF;
	border-top: 1px solid #808080;
	border-left: 1px solid #808080;
	border-right: 1px solid #C5C5C5;
	border-bottom: 1px solid #C5C5C5;
	margin-top: 10px;
	width: 100%;
}
.uploadifyProgressBar {
	background-color: #0099FF;
	width: 1px;
	height: 3px;
}
#fileQueue .uploadifyQueueItem {
	font: 11px Verdana, Geneva, sans-serif;
	border: none;
	border-bottom: 1px solid #E5E5E5;
	background-color: #FFFFFF;
	padding: 5%;
	width: 90%;
}
#fileQueue .uploadifyError {
	background-color: #FDE5DD !important;
}
#fileQueue .uploadifyQueueItem .cancel {
	float: right;
}
.uploadifyQueueItem {
	font: 11px Verdana, Geneva, sans-serif;
	border: 2px solid #E5E5E5;
	background-color: #F5F5F5;
	margin-top: 5px;
	padding: 10px;
	width: 350px;
}
.uploadifyError {
	border: 2px solid #FBCBBC !important;
	background-color: #FDE5DD !important;
}
.uploadifyQueueItem .cancel {
	float: right;
}
.uploadifyProgress {
	background-color: #FFFFFF;
	border-top: 1px solid #808080;
	border-left: 1px solid #808080;
	border-right: 1px solid #C5C5C5;
	border-bottom: 1px solid #C5C5C5;
	margin-top: 10px;
	width: 100%;
}
.uploadifyProgressBar {
	background-color: #0099FF;
	width: 1px;
	height: 3px;
}
</style>

<script>
$(document).ready( function() {//jquery上传
		$("#uploadify").uploadify( {

			'uploader' :'/tea/upload/uploadify.swf',
			'script' :'/servlet/InsertPicture',//后台处理的请求
			'cancelImg' :'/tea/upload/images/cancel.png',
			//'folder' :'uploads',//您想将文件保存到的路径
			'queueID' :'fileQueue',//与下面的id对应
			'queueSizeLimit' :20,
			'fileDesc' :'请选择.doc文件',
			//'fileExt' :'*.jpg;*.gif;*.png;*.bmp', //控制可上传文件的扩展名，启用本项时需同时声明fileDesc
			'fileExt' :'*.doc;', 
            'buttonImg':'/tea/upload/images/br2.gif',
			'height':26,
			'width':86,
            'method':'GET',
            'scriptData':{'op':'ups','community':'<%=teasession._strCommunity%>','node':'<%=teasession._nNode%>','pictureName':'','changepic':'','flag':$('#ck').attr('checked')},

			'auto' :false,
			'multi' :true,
			'simUploadLimit' :1,
			//'buttonText' :'browse',
            'onComplete': function(event, queueID, fileObj,response,data) {
              var sp = data.speed;

              //sp = sp.substring(0,4);
              document.getElementById("msg").innerHTML+=("文件:&nbsp;<font style='font-weight:bold'>"+fileObj.name+"</font>&nbsp;&nbsp;上传成功!<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;上传速度:&nbsp;&nbsp;"+sp+" Kb/s<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;上传路径:&nbsp;&nbsp;<input style='width:300' type='text' value='"+response+"'><br><br>");
            },
            'onQueueFull':function(event,queueSizeLimit ) {
              alert("最多允许一次上传"+queueSizeLimit+"个文件");
            }
		});
});
function submitInteger(obj,text)
{
  if(obj.value.length>0&&isNaN(parseInt(obj.value)))
  {
    alert(text + "sss");
    obj.focus();
    return false;
  }

  return true;
}
</script>
<body onload="document.form1.word.focus();">
<h1>抽取内容</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<form action="<%=request.getRequestURI()%>" method="POST" enctype="multipart/form-data" name="form1" onsubmit="" >
  <input type="hidden" name="Node" value="<%=teasession._nNode%>">
  <input type="hidden" name="community" value="<%=community%>">

  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td>Word文件:</td>
      <td colspan="20"><input type="file" name=word  size=70 maxlength=255>
      </td>
    </tr>
    <tr>
      <td colspan="2"><input type="submit" name="wordsubmit" value="提交" onclick="return submitText(form1.word, '<%=r.getString(teasession._nLanguage, "InvalidFile")%>');"/>
      </td>
    </tr>
      
        <tr  id="ups2">
          <td><%=r.getString(teasession._nLanguage, "请选择上传文件")%>:</td>
          <td>
            <input type="file" name="picturess" id="uploadify" />
          </td>
        </tr>
     <tr  id="ups1">
           <td><%=r.getString(teasession._nLanguage, "上传文件列表")%>:</td>
           <td style="padding:5px"><div id="fileQueue"></div><div id="msg" style="font-size:14"></div></td>
        </tr>
     
        <tr  id="ups3">
          <td></td>
          <td>
            <input type="button" onClick="javascript:$('#uploadify').uploadifySettings('scriptData',{'flag':$('#ck').attr('checked')});jQuery('#uploadify').uploadifyUpload();" value="开始上传">&nbsp;
            <input type="button" onClick="javascript:jQuery('#uploadify').uploadifyClearQueue();" value="取消所有上传">
          </td>
        </tr>

    
  </table>

  

</form>

<div id="head6"><img height="6" src="about:blank"></div>
<br/>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr><td>注:</td></tr>
    <tr><td >1.Word文件格式: 第一行:主题, 第二行:时间(yyyy-MM-dd), 第三行:内容  分隔附:&lt;EDN&gt;</td></tr>
   
 
  </table>
</body>
</html>
