		function login (username, password) {
			var data = {};
			if(getCookie('token') == '' || getCookie('token') == null) {
				data = {u: username, p: password};
			} else {
				data = {token: getCookie('token')};
			}
			$.getJSON('http://www.andrewapperley.ca/laura/login.php?callback=?',data,function(res){

				if(res.status == 'true') {
					createCookie(res.token);
					window.location = (getLastPage()['returnURL']);
				} else {
					alert("Incorrect login information, please try again.");
				}

			});
		}
	function checkLogin () {
		var token = getCookie('token');
		
		data = {token: token};
		$.getJSON('http://www.andrewapperley.ca/laura/login.php?callback=?',data,function(res){
			if(res.status == 'true') {
				$(".container").animate({opacity: 1}, 500);
			} else {
				returnURL = window.location;
				window.location = '/files/theme/login.html?returnURL='+returnURL;
			}
		});
	}
	function createCookie (token) {
		var exdays = 7;
		var exdate=new Date();
		exdate.setDate(exdate.getDate() + exdays);
		var c_value=escape(token) + ((exdays==null) ? "" : "; expires="+exdate.toUTCString());
		document.cookie = "token" + "=" + c_value+';path=/';
	}
	function getLastPage() {
	  var searchString = window.location.search.substring(1),
	      params = searchString.split("&"),
	      hash = {};

	  if (searchString == "") return {};
	  for (var i = 0; i < params.length; i++) {
	    var val = params[i].split("=");
	    hash[unescape(val[0])] = unescape(val[1]);
	  }
	  return hash;
	}
	function getCookie (c_name) {
		var c_value = document.cookie;
		var c_start = c_value.indexOf(" " + c_name + "=");
		if (c_start == -1)
		  {
		  c_start = c_value.indexOf(c_name + "=");
		  }
		if (c_start == -1)
		  {
		  c_value = null;
		  }
		else
		  {
		  c_start = c_value.indexOf("=", c_start) + 1;
		  var c_end = c_value.indexOf(";", c_start);
		  if (c_end == -1)
		    {
		    c_end = c_value.length;
		    }
		  c_value = unescape(c_value.substring(c_start,c_end));
		  }
		return c_value;
	}