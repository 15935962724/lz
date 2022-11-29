<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head profile="http://gmpg.org/xfn/11">
	<title>Attach a File » FancyUpload - Swiff meets Ajax Showcase » digitarald:Harald Kirschner</title>
	<!--
		digitarald.de, 2.2
		Look and learn, but don't steal. Gracias!
	-->
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="keywords" content="freelancer, developer, ajax, javascript, MooTools, FancyUpload, Fileinput, Uploader, Swiff, FileReference, ExternalInterface" />
	<meta name="description" content="digitarald:Harald K - Consultant &amp; Contractor - Attach a File &Acirc;&raquo; FancyUpload - Swiff meets Ajax Showcase - Swiff meets Ajax for powerful and elegant uploads.FancyUpload is a file-input replacement which features an unobtrusive, multiple-file selectionmenu and queued upload with an animated progress bar. It is easy to setup, is server independent,completely styleable via CSS and XHTML and uses MooTools to work in all modern browsers." />

	<meta name="geo.placename" content="Chemin Du Ruisselet, 13, 1009, Pully, Switzerland" />
	<meta name="geo.position" content="46.51408;6.6654" />
	<meta name="geo.region" content="CH-VD" />
	<meta name="ICBM" content="46.51408, 6.6654" />

	<link rel="shortcut icon" type="image/ico" href="http://digitarald.de/favicon.ico" />

	<link rel="alternate" type="application/rss+xml" title="Combined feed" href="http://feeds.feedburner.com/digitarald" />
	<link rel="alternate" type="application/rss+xml" title="Journal feed" href="http://feeds.feedburner.com/digitarald-journal" />
	<link rel="alternate" type="application/rss+xml" title="Project changelog feed" href="http://feeds.feedburner.com/digitarald-projects" />
	<link rel="alternate" type="application/rss+xml" title="Comments feed" href="http://feeds.feedburner.com/digitarald-comments" />

	<link rel="openid.server" href="http://www.myopenid.com/server" />
	<link rel="openid.delegate" href="http://digitarald.myopenid.com" />

	<link rel="stylesheet" type="text/css" href="/css/blueprint/screen.css" media="screen, projection" />
	<link rel="stylesheet" type="text/css" href="/css/blueprint/print.css" media="print" />
	<!--[if IE]><link rel="stylesheet" href="/css/blueprint/ie.css" type="text/css" media="screen, projection" /><![endif]-->
	<link rel="stylesheet" type="text/css" href="/css/site.css" media="screen, projection" />

	<!-- dynamic assets -->
	<style type="text/css">

a.hover {
	color: red;
}

#demo-list {
	padding: 0;
	list-style: none;
	margin: 0;
}

#demo-list .file-invalid {
	cursor: pointer;
	color: #514721;
	padding-left: 48px;
	line-height: 24px;
	background: url(assets/error.png) no-repeat 24px 5px;
	margin-bottom: 1px;
}
#demo-list .file-invalid span {
	background-color: #fff6bf;
	padding: 1px;
}

#demo-list .file {
	line-height: 2em;
	padding-left: 22px;
	background: url(assets/attach.png) no-repeat 1px 50%;
}

#demo-list .file span,
#demo-list .file a {
	padding: 0 4px;
}

#demo-list .file .file-size {
	color: #666;
}

#demo-list .file .file-error {
	color: #8a1f11;
}

#demo-list .file .file-progress {
	width: 125px;
	height: 12px;
	vertical-align: middle;
	background-image: url(../../assets/progress-bar/progress.gif);
}

	</style>

	<script type="text/javascript" src="mootools.js"></script>
	<script type="text/javascript" src="Fx.ProgressBar.js"></script>
	<script type="text/javascript" src="Swiff.Uploader.js"></script>
	<script type="text/javascript" src="FancyUpload3.Attach.js"></script>
	<script type="text/javascript">
		/* <![CDATA[ */

/**
 * FancyUpload Showcase
 *
 * @license		MIT License
 * @author		Harald Kirschner <mail [at] digitarald [dot] de>
 * @copyright	Authors
 */

window.addEvent('domready', function() {

	/**
	 * Uploader instance
	 */
	var up = new FancyUpload3.Attach('demo-list', '#demo-attach, #demo-attach-2', {
		path: 'Swiff.Uploader.swf',
		url: 'script.jsp',
		fileSizeMax: 2 * 1024 * 1024,

		verbose: true,

		onSelectFail: function(files) {
			files.each(function(file) {
				new Element('li', {
					'class': 'file-invalid',
					events: {
						click: function() {
							this.destroy();
						}
					}
				}).adopt(
					new Element('span', {html: file.validationErrorMessage || file.validationError})
				).inject(this.list, 'bottom');
			}, this);
		},

		onFileSuccess: function(file) {
			new Element('input', {type: 'checkbox', 'checked': true}).inject(file.ui.element, 'top');
			file.ui.element.highlight('#e6efc2');
		},

		onFileError: function(file) {
			file.ui.cancel.set('html', 'Retry').removeEvents().addEvent('click', function() {
				file.requeue();
				return false;
			});

			new Element('span', {
				html: file.errorMessage,
				'class': 'file-error'
			}).inject(file.ui.cancel, 'after');
		},

		onFileRequeue: function(file) {
			file.ui.element.getElement('.file-error').destroy();

			file.ui.cancel.set('html', 'Cancel').removeEvents().addEvent('click', function() {
				file.remove();
				return false;
			});

			this.start();
		}

	});

});

		/* ]]> */
	</script>



</head>
<body>



	<div id="demo">

<a href="#" id="demo-attach">Attach a file</a>

<ul id="demo-list"></ul>

<a href="#" id="demo-attach-2" style="display: none;">Attach another file</a>
	</div>


</body>
</html>
