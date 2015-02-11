function initProgreeBar()
{
	alert();
	var progressBar = document.getElementById('progressbar');
	alert(progressBar);
	var height = 120;
	var width = 120;
	
	var top  = (document.body.clientHeight - height) / 2;
	var left = (document.body.clientWidth - width)  / 2;

	progressBar.top = top - 50;
	progressBar.left = left;
}

function loadProgreeBar()
{
	
	initProgreeBar();
	var progressBar = document.getElementById('progressbar');
	progressBar.style.display = '';
}


function unloadProgreeBar()
{
	var progressBar = document.getElementById('progressbar');
	progressBar.style.display = 'none';
}
