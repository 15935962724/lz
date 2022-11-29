<%@page contentType="text/html; charset=UTF-8" %><%@ page import="tea.entity.*"%><%@ page import="tea.entity.admin.*"%><%@ page import="tea.resource.*"%><%@ page import="tea.entity.doctor.*"%><%




%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head profile="http://gmpg.org/xfn/11">
<link rel="stylesheet" type="text/css" href="Roar.css" />
<script type="text/javascript" src="mootools.js"></script>
<script type="text/javascript" src="Fx.ProgressBar.js"></script>
<script type="text/javascript" src="Swiff.Uploader.js"></script>
<script type="text/javascript" src="Roar.js"></script>
<script type="text/javascript">

window.addEvent('domready', function() {

	// One Roar instance for our notofications, positioned in the top-right corner of our demo.
	var log = new Roar({
		container: $('demo'),
		position: 'topRight',
		duration: 5000
	});

	var link = $('select-0');
	var linkIdle = link.get('html');

	function linkUpdate()
        {
		if (!swf.uploading) return;
		var size = Swiff.Uploader.formatUnit(swf.size, 'b');
		link.set('html', '<span class="small">' + swf.percentLoaded + '% of ' + size + '</span>');
	}

	// Uploader instance
	var swf = new Swiff.Uploader({
		path: 'http://127.0.0.1/fancyupload/Swiff.Uploader.swf',
		url: '/script.jsp',
		verbose: true,
		queued: false,
		multiple: false,
		target: link,
		instantStart: true,
		typeFilter:{'图片文件(*.jpg, *.jpeg, *.gif, *.png)': '*.jpg; *.jpeg; *.gif; *.png'},
		fileSizeMax: 1024,
		onSelectSuccess: function(files)
                {
			if (Browser.Platform.linux) window.alert('Warning: Due to a misbehaviour of Adobe Flash Player on Linux,\nthe browser will probably freeze during the upload process.\nSince you are prepared now, the upload will start right away ...');
			log.alert('Starting Upload', 'Uploading <em>' + files[0].name + '</em> (' + Swiff.Uploader.formatUnit(files[0].size, 'b') + ')');
			this.setEnabled(false);
		},
		onSelectFail: function(files)
                {
			log.alert('<em>' + files[0].name + '</em> was not added!', 'Please select an image smaller than 2 Mb. (Error: #' + files[0].validationError + ')');
		},
		appendCookieData: true,
		onQueue: linkUpdate,
		onFileComplete: function(file)
                {
			// We *don't* save the uploaded images, we only take the md5 value and create a monsterid ;)
			if (file.response.error)
                        {
				log.alert('Failed Upload', 'Uploading <em>' + this.fileList[0].name + '</em> failed, please try again. (Error: #' + this.fileList[0].response.code + ' ' + this.fileList[0].response.error + ')');
			} else
                        {
				var md5 = JSON.decode(file.response.text, true).hash; // secure decode
				log.alert('Successful Upload', 'an MD5 hash was created from <em>' + this.fileList[0].name + '</em>: <code>' + md5 + '</code>.<br />gravatar.com generated a fancy and unique monsterid for it, since we did not save the image.');
				var img = $('demo-portrait');
				img.setStyle('background-image', img.getStyle('background-image').replace(/\w{32}/, md5));
				img.highlight();
			}
			file.remove();
			this.setEnabled(true);
		},
		onComplete: function()
                {
			link.set('html', linkIdle);
		}
	});

	// Button state
	link.addEvents({
		click: function() {
			return false;
		},
		mouseenter: function() {
			this.addClass('hover');
			swf.reposition();
		},
		mouseleave: function() {
			this.removeClass('hover');
			this.blur();
		},
		mousedown: function() {
			this.focus();
		}
	});

});

		/* ]]> */
	</script>



</head>
<body>

<div id="demo">

<div id="demo-portrait" style="background-image: url(http://127.0.0.1/res/1006/logo.gif)">
	ff
</div>
</div>
<a href="#" id="select-0" title="Please upload only images, maximal 2 Mb filesize!">Upload new Photo</a>

</body>
</html>
