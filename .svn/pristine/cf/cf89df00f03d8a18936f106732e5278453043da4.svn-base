<%@page contentType="text/html; charset=UTF-8" %><%@ page import="tea.entity.*"%><%@ page import="tea.entity.admin.*"%><%@ page import="tea.resource.*"%><%@ page import="tea.entity.doctor.*"%><%




%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head profile="http://gmpg.org/xfn/11">
<script type="text/javascript" src="mootools.js"></script>
<script type="text/javascript" src="Fx.ProgressBar.js"></script>
<script type="text/javascript" src="Swiff.Uploader.js"></script>
</head>
<body>

<div id="demo"><div id="demo-portrait" style="background-image: url(http://127.0.0.1/res/1006/logo.gif)">
	ff
</div>
</div>
<a href="#" id="select-0">Upload new Photo</a>
<script type="text/javascript">


	var link = $('select-0');

	// Uploader instance
	var swf = new Swiff.Uploader({
		url: 'script.jsp',
		verbose: true,
		queued: false,
		multiple: false,
		target: link,
		instantStart: true,
		typeFilter:{'图片文件(*.jpg, *.jpeg, *.gif, *.png)': '*.jpg; *.jpeg; *.gif; *.png'},
		//fileSizeMax: 1024,
		appendCookieData: true,
		onQueue: function linkUpdate()
                {
                  link.innerHTML=swf.percentLoaded + '% 大小：' +Swiff.Uploader.formatUnit(this.size, 'b');
                },
		onFileComplete: function(file)
                {
                  alert(file.response.text);
                  file.remove();
                  this.setEnabled(true);
		}
	});

	// Button state
/*
	link.addEvents({
		click: function(){return false;},
		mouseenter: function() {
			this.addClass('hover');
			swf.reposition();
		},
		mouseleave: function() {
			this.removeClass('hover');
			this.blur();
		},
		mousedown: function(){this.focus();}
	});
*/

		/* ]]> */
	</script>



</body>
</html>
