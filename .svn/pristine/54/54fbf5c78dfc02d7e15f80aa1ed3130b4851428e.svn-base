<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.yl.shop.*"%><%@page import="tea.db.*"%><%@page import="tea.ui.yl.shop.*"%>
<%@page import="tea.entity.sup.*"%><%@page import="tea.entity.admin.*"%>
<%@page import="tea.entity.*"%>
<%@page import="util.DateUtil"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

    StringBuffer sql=new StringBuffer(),par=new StringBuffer();
    String name = h.get("name");
    if(!"".equals(name) && name != null){
        sql.append(" AND name like'%" + name + "%'");
        par.append("&name="+name);
    }

    int pos=h.getInt("pos");
    par.append("&pos=");

    int sum=ProcurementUnit.count(sql.toString());
    String acts=h.get("acts","");

    AdminUsrRole aur = AdminUsrRole.find(h.community,h.member);  //
    boolean falg = false;   //判断当前用户的角色是否包含以下其中任何一个角色，如果包含返回true

    int flag = 0;
    int crole= AdminRole.findByName("采购员", "Home");//角色
    if (aur.getRole().indexOf(String.valueOf(crole))!= -1){
        flag = 1;
    };
     crole= AdminRole.findByName("采购负责人", "Home");//角色
    if (aur.getRole().indexOf(String.valueOf(crole))!= -1){
        flag = 2;
    };
     crole= AdminRole.findByName("质量管理员", "Home");//角色
    if (aur.getRole().indexOf(String.valueOf(crole))!= -1){
        flag = 3;
    };
     crole= AdminRole.findByName("质量负责人", "Home");//角色
    if (aur.getRole().indexOf(String.valueOf(crole))!= -1){
        flag = 4;
    };








//
//    String []roles = {"采购员","采购负责人","质量管理员","质量负责人"};
//    for (String role : roles) {
//        int crole= AdminRole.findByName(role, "Home");//角色
//        System.out.println(aur.getRole()+"----"+crole);
//            if (aur.getRole().indexOf(String.valueOf(crole))!= -1){
//
//            };
//    }






%>
<!DOCTYPE html><html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/yl/jquery-1.7.js"></script>
<script src="/tea/yl/top.js"></script>
<script type="text/javascript" src="/tea/Calendar.js"></script>
<style>
    .textView{
        display: flex;
        justify-content: flex-start;
    }
</style>
</head>
<body>
<h1>厂商管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form id='form1' name="form1" action="?" >
<input type="hidden" name="community" value="<%=h.community%>"/>
<table id="tablecenter" cellspacing="0">

  	<tr>
        <td><input type="text" name="name" value="<%= MT.f(name)%>" />　<button class="btn btn-primary" onclick="findhosp()" type="button">查询</button></td>
	</tr>
</table>
</form>

<form name="form2" action="/ProcurementUnitServlet.do" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="puid"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<input type="hidden" name="status"/>
<input type="hidden" name="message"/>
<input type="hidden" name="type"/>
<input type="hidden" name="time"/>

<div class='radiusBox'>
    <table cellspacing="0" class='newTable'>
        <thead>
            <tr><td colspan='20'>列表<span class='sum'></span></td></tr>
        </thead>
        <tr>
        <th width='60'><input type="checkbox" id="all"/>全选</th>
            <th width='60'>序号</th>
            <th>厂商名称</th>
            <th>创建日期</th>
            <th>关联医院数量</th>
            <th>关联服务商数量</th>
            <th>关联药品数量</th>
            <th>排序</th>
            <th>操作</th>
            <th>审核状态</th>
            <th>操作</th>
        </tr>
        <tbody class='mytab'>

        </tbody>
        <tr class="ggpage"><td colspan='10' align='right' id='ggpage'></td></tr>
    </table>
</div>
<div class='mt15'><a class="btn btn-primary" type="button" onclick="myact('edit','-1')">添加</a></div>

</form>

<script type="text/javascript" >

    var open = <%=flag%>;

form2.nexturl.value=location.pathname+location.search;
function loadlist(pos){
	mypos = pos;
	var listtb = new page.loadPage({"url":"/ProcurementUnitServlet.do?act=findProcurementUnit&"+$("#form1").serialize(),"callBackFunc":createList,'page_size':'10','type':2,'page_size_max':'10','par':myurl,'showtype':1,'pos':pos,'showfun':loadlist});
	listtb.show();
}
loadlist(0);

function findhosp(){
	loadlist(0);
}
//待办
function createList(resultlist){
    if(resultlist.sum<=10){
        $(".ggpage").hide();
    }
	if(resultlist.type==1){
		return;
	}
	if(resultlist.type==2){
		mtDiag.show(resultlist.mes);
		return;
	}
	$(".sum").html(resultlist.sum);
	var listDiv = $(".mytab");
	listDiv.html("");
	if(resultlist.data_list!=''){//是否存在数据
		for(var i=0;i<resultlist.data_list.length;i++){
			var proObj = resultlist.data_list[i];
			var boxDiv = $("<tr></tr>");
			var text = '';
            var shenhe = "<button type='button' class='btn btn-link' style='cursor: pointer' >不可操作</button>";
            var yanqi = "";
			if(proObj.obj.status == 1){
                text = '采购员审核通过';
                if (open==2){
                    shenhe = "<button type='button' class='btn btn-link' style='cursor: pointer' onclick='showExamine("+proObj.obj.status+","+proObj.obj.puid+")'>审核</button>";
                }
            }else if(proObj.obj.status == 2){
                text = '采购负责人审核通过';
                if (open==3){
                    shenhe = "<button type='button' class='btn btn-link' style='cursor: pointer' onclick='showExamine("+proObj.obj.status+","+proObj.obj.puid+")'>审核</button>";
                }
            }else if(proObj.obj.status == 3){
                text = '质量管理员审核通过';
                if (open==4){
                    shenhe = "<button type='button' class='btn btn-link' style='cursor: pointer' onclick='showExamine("+proObj.obj.status+","+proObj.obj.puid+")'>审核</button>";
                }
            }else if(proObj.obj.status == 4){
                text = '质量负责人审核通过';
            }else if(proObj.obj.status == '-1'){
                text = '采购员审核未通过';
            }else if(proObj.obj.status == '-2'){
                text = '采购负责人审核未通过';
            }else if(proObj.obj.status == '-3'){
                text = '质量管理员审核未通过';
            }else if(proObj.obj.status == '-4'){
                text = '质量负责人审核未通过';
            }else {
                text = '待审核';
                console.log(open+":open")
                if (open==1){
                    shenhe = "<button type='button' class='btn btn-link' style='cursor: pointer' onclick='showExamine("+proObj.obj.status+","+proObj.obj.puid+")'>审核</button>";

                }
            }

            if (open==1){
                if (queryIsCertificater(proObj.obj.puid)){
                    yanqi = "<button type='button' class='btn btn-link' onclick=myact('delay',"+proObj.obj.puid+")>延期申请</button>";
                }
            }

            var yanqishenhe = "";
			if (open>0&&proObj.obj.status>=0){

                if (queryCertificaters(proObj.obj.puid).length>0){
                    yanqishenhe = "       <button type='button' class='btn btn-link' style='cursor: pointer' onclick='extensionApply("+proObj.obj.status+","+proObj.obj.puid+")'>延期审核</button>";
                }
                shenhe+yanqishenhe;
            }

			var $name = $("<td><input type='checkbox' /></td><td>"+(parseInt(i)+1+parseInt(mypos))+"</td><td>"+proObj.obj.name+"</td><td>"+proObj.obj.time+"</td><td>"+proObj.puCount+"</td><td>"+proObj.proCount+"</td><td>"+proObj.drugCount+"</td><td>"+proObj.obj.sort+"</td><td><a href='javascript:;' class='btn btn-link' onclick=myact('info','"+proObj.obj.puid+"')>查看详情</a>&nbsp;&nbsp;<button type='button' class='btn btn-link' onclick=myact('edit','"+proObj.obj.puid+"')>编辑</button>&nbsp;&nbsp;<button type='button' class='btn btn-link' onclick=myact('del','"+proObj.obj.puid+"')>删除</button>&nbsp;&nbsp;<button type='button' class='btn btn-link' onclick=myact('joinProfile','"+proObj.obj.puid+"')>关联服务商</button>&nbsp;&nbsp;<button type='button' class='btn btn-link' onclick=myact('joinDrug','"+proObj.obj.puid+"')>关联药品</button>&nbsp;&nbsp;<button type='button' class='btn btn-link' onclick=myact('joinHosp','"+proObj.obj.puid+"')>关联医院</button>"+yanqi+"</td><td>"+text+"</td><td >"+shenhe+"</td>");
			//&nbsp;&nbsp;<button type='button' class='btn btn-link' onclick=myact('joinHosp','"+proObj.obj.puid+"')>关联医院</button>
			boxDiv.append($name);
			listDiv.append(boxDiv);
		}
	}else{
		listDiv.append("<tr><td colspan='9'>暂无厂商</td></tr>");
	}

}


function showExamine(obj,id) {


    var tongguo = obj+1
    var jujue =  -(tongguo);
    mt.show("审核：<select style='width: 100px' id='status" +
        "' name='status'><option value='"+tongguo+"'>通过</option><option value='"+jujue+"'>拒绝</option></select><div class='textView'>描述：<textarea id='_q' cols='28' rows='5'></textarea></div>",2,"审核");
    mt.ok=function(){
        var status = $('#status').val();
        var message = $('#_q').val();
        form2.act.value='updateStatus';
        form2.puid.value=id;
        form2.status.value = status;
        form2.message.value = message;
        form2.submit();
        form2.nexturl.value = "/jsp/yl/shop/ProcurementUnit.jsp";
        mtDiag.show("操作执行成功!","alert",null,form2.nexturl.value);
    }
}


    //延期申请弹窗
    function extensionApply(obj,id) {
        var list = queryCertificaters(id);
        console.log(list);
        var html = '<option value="">请选择</option>';
        for(var i = 0; i < list.length; i++){
            html += '<option value="'+i+'">'+list[i].name+'</option>';
        }
        var newlist = JSON.stringify(list)
        mt.show("审核：<select style='width: 100px' onchange='changeSelect("+newlist+",this)' name='status'>"+html+"</select><div class='textView'>描述：<textarea id='textView_q' cols='28' rows='5' disabled></textarea></div><div class='textView'><a id='textView_a' target='_blank'>查看提交文件<a></div><div class='textView'>日期：<input type='text' id='delayTime' placeholder='选择有效期'  onclick='new Calendar().show(\"delayTime\");'/></div>",2,"审核");
        mt.ok=function(){
            var status = $("select[name='status']").find('option:checked').val();
            // var message = $('#textView_q').val();
            // var href = $('#textView_a').attr("href");
            var time = $('#delayTime').val();
            if(status == ''){
                alert("请选择审核证书！")
                return false;
            }
            if(time == ''){
                alert("请选择日期！")
                return false;
            }

            form2.act.value='updateCertificates';
            form2.puid.value=id;
            form2.status.value = 1;
            form2.time.value=time;
            form2.submit();
            form2.nexturl.value = "/jsp/yl/shop/ProcurementUnit.jsp";
            mtDiag.show("操作执行成功!","alert",null,form2.nexturl.value);
        }
    }

    function changeSelect(list,_this) {
        console.log(list);
        console.log(_this);
        var text = $(_this).find("option:checked").val();
        if(text == ''){
            $("#textView_q").val('');
            $("#textView_a").removeAttr("href");
            form2.type.value='';
        }else{
            $("#textView_q").val(list[text].delayMessage);
            $("#textView_a").attr("href",list[text].delayUrl);
            form2.type.value=list[text].type;
        }
    }








//查询是否有过期证件
function queryIsCertificater(puid) {
    var flag;
    console.log(puid)
    fn.ajax("/ProcurementUnitServlet.do?act=queryIsCertificater","puid="+puid,function(data){
        flag = data.flag;
    });
    console.log(puid+"????"+flag);
    return flag;
}

//查询延期审核
function queryCertificaters(puid) {
    var flag;
    fn.ajax("/ProcurementUnitServlet.do?act=queryCertificaters","puid="+puid,function(data){
        flag = data.certificates;
    });

    console.log(flag.length)
    return flag;
}

function myact(a,id){

  form2.act.value=a;
  form2.puid.value=id;
  form2.nexturl.value = "/jsp/yl/shop/ProcurementUnit.jsp";
  if(a=='del')
  {
      mtDiag.show("您确定要删除吗?","confirm",function(){
          fn.ajax("/ProcurementUnitServlet.do?act=delPU","puid="+id,function(data){
              if(data.type==0){
                  mtDiag.show("操作执行成功!","alert",null,form2.nexturl.value);
              }else{
                  mtDiag.show("系统异常，请重试!","msg");
              }
          });
      },function(){
          mtDiag.show("取消删除!");
      });


  }else{
    if(a=='view'){
      form2.action='';
      form2.target=form2.method='';
      form2.submit();
    }else if(a=='edit'){
      form2.action='/jsp/yl/shop/ProcurementUnitEdit.jsp';
      form2.target=form2.method='';
      form2.submit();
	}else if(a=='info'){
        form2.action='/jsp/yl/shop/ProcurementUnitInfo.jsp';
        form2.target=form2.method='';
        form2.submit();
    }else if(a=="joinHosp"){
        location.href="/jsp/yl/shop/JoinHospitals.jsp?puid="+id;
    }else if (a=="joinProfile"){
        layer.open({
            type: 2,
            title: '关联服务商',
            shadeClose: true,
            area: ['80%', '80%'],
            closeBtn:1,
            content: '/jsp/yl/shop/JoinProfile.jsp?puid='+id, //iframe的url /jsp/yl/shop/ExpExcel.jspw
        });
    }else if (a=="joinDrug"){
        console.log(id);
        layer.open({
            type: 2,
            title: '关联药品',
            shadeClose: true,
            area: ['80%', '80%'],
            closeBtn:1,
            content: '/jsp/yl/shop/JoinDrug.jsp?puid='+id, //iframe的url /jsp/yl/shop/ExpExcel.jspw
        });
    }else if(a=='delay'){
        form2.action='/jsp/yl/shop/ProcurementUnitDelay.jsp';
        form2.target=form2.method='';
        form2.submit();
    }
  }
}
</script>
</body>
</html>
