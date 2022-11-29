
//mt.adel=function(t)
//{
//  mt.tmp=t;
//  mt.show("确认删除附件吗？",2,"");
//  mt.ok=function()
//  {
//    var p=mt.tmp;while(p.type!='hidden')p=p.previousSibling;
//	var n=p.nextSibling;
//    n.value=p.value='';
//	n.style.backgroundImage="none";
//    mt.post(mt.tmp.form.action+'&act=clear&name='+p.name);
//  };
//};
mt.adel=function(t)
{
  var p=t;while(p.type!='hidden')p=p.previousSibling;
  var n=p.nextSibling;
  n.value=p.value='';
  n.style.backgroundImage="none";
  t.style.display='';//删除
  t.parentNode.removeChild(t.nextSibling);//下载
};
mt.abut=function(t,u)
{
  var p=t.previousSibling,p2=p.previousSibling;
  if(!u)u=p2.getAttribute('data');
  if(!u)u=p2.value;
  if(!u||u=='0')return;

  var d;
  if(u.indexOf('{')==0)
  {
    eval("d="+u);
	if(d.value=='0')return;
    p2.value=d.value;
    u=d.name||'不存在.jpg';
  }else
    p2.value=u;

  var name=u.substring(u.lastIndexOf('/')+1);
  p.value=name;
  p.style.backgroundImage="url('/tea/image/ico/"+name.substring(name.lastIndexOf('.')+1).toLowerCase()+".gif')";

  var n=t.nextSibling;
  if(n.tagName!='INPUT')n=n.nextSibling;
  if(t.getAttribute('delete')=='true')n.style.display='inline';
  var but=n.nextSibling;
  if(!but||but.className!='file3')
  {
    but=document.createElement('INPUT');
    but.type='button';
    but.value='查看';
    but.className='file3';
    t.parentNode.insertBefore(but,n.nextSibling);
  }
  if(d)
  but.onclick=function(){/.(jpg|png|gif|pdf)$/i.test(d.name)?window.open('/jsp/community/AttchPreview.jsp?attch='+d.attch):mt.post(HTTP_HOST+'/Attchs.do/'+encodeURIComponent(d.name)+'?act=down&attch='+d.attch)};
  else
  but.onclick=function(){location='/Utils.do?act=down&url='+encodeURIComponent(u)};
  //t.nextSibling.nextSibling.innerHTML=u?"&nbsp;<input type='button' value='删除' onclick=mt.adel('"+n+"',"+(eid||0)+") >":"";

  //p.setAttribute('menu',"<a href='"+u+"' target='_blank' hideFocus>打开</a><a href='/Utils.do?act=down&url="+encodeURIComponent(u)+"' hideFocus>下载</a>");
  //p.oncontextmenu=mt.menu;
};

mt.uploads=function(f)
{
  var arr=f.getElementsByTagName("INPUT");
  f.ups=[];

  for(var i=0;i<arr.length;i++)
  {
    if(arr[i].className.indexOf('file1')==-1)continue;

    //截取名称
    var par=arr[i].previousSibling.previousSibling.name;
	var j=par.indexOf('_');
	if(j>0)par=par.substring(0,j);
    //filePostName:par,
    var up=new Upload(arr[i],{fileSizeLimit:'1000 MB',buttonAction:-100,resize:arr[i].getAttribute('resize')||1000,fileTypes:arr[i].getAttribute('types')||"*.doc;*.docx;*.xls;*.xlsx;*.txt;*.pdf;*.jpg;*.gif;*.png;*.zip;*.rar;*.mp4"});
    up.fileQueued=function(f)
    {
	  if(this.but.onchange&&this.but.onchange()==false)return;
      f=this.getFile(f.id);
      var t=this.but.previousSibling;
	  t.value=f.name;
	  //var s=t.title;
	  //if(s)s+=f.type;
	  //t.value=s||f.name;

	  t.style.backgroundImage="url('/tea/image/ico/"+f.type.substring(1).toLowerCase()+".gif')";
	  //this.set('postParams',{'attchname':t.value});
	  if(this.but.getAttribute('start')=='true')
	  {
	    this.but.form.onsubmit();
	  }
    };
    up.uploadSuccess=function(file,d,responseReceived)
    {
	  d=decodeURIComponent(d);
      mt.abut(this.but,d.substring(d.indexOf('\n')+1));
    };
    up.complete=function()
    {
      mt.usubmit(this.but.form);
    };
    mt.abut(up.but);
	f.ups.push(up);
  }
};

mt.usubmit=function(f)
{
  var p=$$('dialog_content')?window:parent;
  for(var i=0;i<f.ups.length;i++)
  {
    var file=f.ups[i].getFile();
    if(file)
    {
      f.ups[i].start();
	  p.$$('dialog_content').innerHTML="文件：" +file.name+"<br/>总计：" + mt.f(file.size/1024,2)+' KB' + "　正在压缩中...";
	  p.$$('dialog_footer').innerHTML="<img src='/tea/mt/progress.gif'/>";
      return;
    }
  }
  p.$$('dialog_content').innerHTML="数据提交中,请稍等...";
  f.submit();
};


mt.uploads2=function(f)
{
  f.ups=[];
  var arr=f.getElementsByTagName("INPUT");
  for(var i=0;i<arr.length;i++)
  {
    if(arr[i].className.indexOf('file1')==-1)continue;

    var up1=new Upload(arr[i],{fileSizeLimit:'20 MB',filePostName:'file',resize:arr[i].getAttribute('resize')||1000,fileTypes:arr[i].getAttribute('types')||"*.doc;*.docx;*.xls;*.xlsx;*.txt;*.pdf;*.jpg;*.gif;*.png;*.zip;*.rar"});
    up1.fileQueued=function(f)
    {
	  f=this.getFile(f.id);
	  var t=document.createElement('SPAN');
	  t.id=f.id;
	  t.data=this;
	  t.innerHTML="<img src='/tea/image/ico/"+f.type.substring(1).toLowerCase()+".gif' class='ico' />"+f.name+"<img src='/tea/image/d7.gif' onclick='mt.fdel(this)' />";
	  this.but.previousSibling.appendChild(t);
    };
    up1.uploadSuccess=function(file,d,responseReceived)
    {
	  var t=this.but.previousSibling.previousSibling;
	  d=d.substring(d.indexOf('\n')+1);
	  d=decodeURIComponent(d);
	  eval('d='+d);
      t.value+=d.value+'|';
    };
    up1.complete=function()
    {
      mt.usubmit(this.but.form);
    };
	f.ups.push(up1);
  }
};








//收起_展开
mt.visible=function(a)
{
  var t=a.parentNode;
  t=(t.nextElementSibling||t.nextSibling);
  var b=(mt.isIE?t.currentStyle:getComputedStyle(t)).display=='none';
  t.style.display=b?'block':'none';
  a.innerHTML=b?'收起>>':'展开>>';
};

//更换验证码
mt.verify=function(a)
{
  var img=document.getElementById('img_verify'+(a||''));
  img.src=img.src.replace(/=\d+/,'='+new Date().getTime());
  form1.verify.value='';
  //form1.verify.focus();
};

//更新进度
mt.integrity=function(s,i)
{
  var p=$$('integrity0')?window:parent;if(!p.$$)return;
  var t=p.$$('integrity0');
  if(!t)return;

  if(i==100)
    s="";
  else
    s+='信息还不完整哦！';
  p.$$('hsubmit').style.display=i==100?'':'none';
  p.$$('integrity1').innerHTML=s;

  i+='%';
  t.innerHTML=i;
  t.style.width=i;
};


//悬浮
mt.ftip=function(d,a)
{
  mt.ft_t=mt.top(d);
  mt.ft_n=(d.nextElementSibling||d.nextSibling).style;
  mt.ft_s=d.style;
  mt.ft_a=a;
  a.b=cookie.get('tip_float')!='false';
  a.innerHTML=a.b?'取消悬浮':'跟随飘浮';
  a.onclick=function()
  {
    a.innerHTML=this.b?'跟随飘浮':'取消悬浮';
    this.b=!this.b;
    cookie.set('tip_float',this.b);
  };
  window.onscroll=function()//setInterval(function()
  {
    if(mt.ft_a.b&&document.body.scrollTop>mt.ft_t)
    {
      if(mt.isIE)
      {
        mt.ft_s.position='absolute';
		var sTop=(document.body.scrollTop+document.documentElement.scrollTop)-200;
        mt.ft_s.top=sTop;
		console.log(sTop)
      }else
      {
        mt.ft_s.position='fixed';
        mt.ft_s.top=0;
      }
      mt.ft_n.display='';
    }else
    {
      mt.ft_s.position='';
      mt.ft_n.display='none';
    }
  };
};


mt.birth=function(a)
{
  var min=new Date(),max=new Date(),year=min.getFullYear();
  min.setFullYear(year-65);
  max.setFullYear(year-18);
  mt.date(a,false,min,max);
};


//提取生日
mt.e_birth=function(a,d)
{
  var v=a.value;
  if(v.length==15)v=v.substring(0,6)+'19'+v.substring(6);
  var arr=new RegExp("^\\d{6}(\\d{4})(\\d{2})(\\d{2})").exec(v);
  if(!arr)return false;
  d.value=arr[1]+"-"+arr[2]+"-"+arr[3];
};

//资料规范性审核
mt.naudit=function(id,b)
{
  form2.act.value='audit';
  form2.subcontractor.value=id;

  var t=$$('_r'+id);
  mt.show("<form name='form4'><table><tr><td nowrap>状态：</td><td><input name='state' type='radio' value='3' id='state_3' onclick='mt.nreason(this)' /><label for='state_3'>通过</label>　<input name='state' type='radio' value='4' id='state_4' onclick='mt.nreason(this)' /><label for='state_4'>不通过</label><tr><td>原因：</td><td><textarea name='content' cols='23' rows='3' title='请填写不通过原因...'>"+(t?t.value:'')+"</textarea></table></form>",2,"资料规范性审核");
  mt.title(form4.content);
  $$('state_'+(b==4?4:3)).click();
  mt.ok=function()
  {
    form2.state.value=mt.value(form4.state);
	if(form2.state.value!='3')
	{
	  var t=form4.content;
	  form2.content.value=t.value==t.title?'':t.value;
	}
    form2.submit();
  };
};
mt.nreason=function(t,b)
{
  var tr=t.parentNode.parentNode.nextSibling;
  tr.style.display=t.value=='3'?"none":"";
};

//资料真实性审核
mt.raudit=function(id,s,b)
{
  form2.act.value='audit';
  form2.subcontractor.value=id;

  var t=$$('_r'+id);
  var h="<form name='form4'><table>"
  +"<tr><td nowrap>状态：</td><td><input name='state' type='radio' value='7' id='state_7' onclick='mt.rreason(this,"+b+")' /><label for='state_7'>通过</label>　<input name='state' type='radio' value='8' id='state_8' onclick='mt.rreason(this,"+b+")' /><label for='state_8'>不通过</label>　<input name='state' type='radio' value='5' id='state_5' onclick='mt.rreason(this,"+b+")' /><label for='state_5'>退回</label>";
  if(b)h+="<tr><td></td><td><input type='checkbox' name='recom' id='recom' checked ><label for='recom'>推荐至股份公司参加评审</label>";
  h+="<tr><td>原因：</td><td><textarea name='content' cols='23' rows='3' title='请填写原因...'>"+(t?t.value:'')+"</textarea></table></form>";
  mt.show(h,2,"资料真实性审核");
  mt.title(form4.content);
  $$('state_'+(s==8?8:7)).click();
  mt.ok=function()
  {
    form2.state.value=mt.value(form4.state);
	if(form4.recom)form2.recom.value=form4.recom.checked;
	if(form2.state.value!='7')
	{
	  var t=form4.content;
	  form2.content.value=t.value==t.title?'':t.value;
	}
    form2.submit();
  };
};
mt.rreason=function(t,b)
{
  var tr=t.parentNode.parentNode;
  if(b)
  {
    tr=tr.nextSibling;
    tr.style.display=t.value=='7'?"":"none";
  }

  tr=tr.nextSibling;
  tr.style.display=t.value=='7'?"none":"";
};

mt.back=function(id)
{
  form2.act.value='back';
  form2.subcontractor.value=id;

  mt.show("<table><form name='form4'><tr><td nowrap>确认要将该企业退回网站吗？<tr><td><textarea name='reason' cols='29' rows='3' title='请填写退回原因...'>"+(id<1?'':$$('_r'+id).value)+"</textarea></form></table>",2);
  mt.title(form4.reason);
  mt.ok=function()
  {
    form2.state.value=9;
    var t=form4.reason;
    form2.rreason.value=t.value==t.title?'':t.value;
    form2.submit();
  };
};

mt.tabx=function(i)
{
  form1.tabx.value=i;
  form1.submit();
};
//采购单位拆标
mt.tabx1=function(i)
{
  form1.tabx1.value=i;
  form1.submit();
};
//采购单位拆标-分项
mt.tabxs=function(i)
{
  form1.tabxs.value=i;
  form1.submit();
};

//添加供货范围第一级分类
mt.qua1=function()
{
  var div=$$('t_member');
  if(!div)return;
  var t=$$('qua2');if(t)div.removeChild(t);
  var t=$$('qua299');if(t)div.removeChild(t);
  var b2,b3,arr=div.getElementsByTagName('SPAN');
  for(var i=0;i<arr.length;i++)
  {
    var p=arr[i].getAttribute('path');
	if(!b2&&p.indexOf('|2|')!=-1)
	{
	  b2=true;
	  var t=document.createElement("SPAN");
	  t.id="qua2";
	  t.innerHTML="<input name='qualification' value='2' />";
	  div.insertBefore(t,arr[i]);
	}
	if(!b3&&p.indexOf('|299|')!=-1)
	{
	  b3=true;
	  var t=document.createElement("SPAN");
	  t.id="qua299";
	  t.innerHTML="<input name='qualification' value='299' />";
	  div.insertBefore(t,arr[i]);
	}
  }
};
