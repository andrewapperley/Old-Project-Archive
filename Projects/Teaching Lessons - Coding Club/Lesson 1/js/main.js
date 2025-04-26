/*Global Variables*/
var _age = 23;
var _name = "Andrew Apperley";
var _education = "Humber College - Multimedia Development";
var _profession = "Applications Developer @ Bitblitz Apps";
var _interests = "My beautiful fiancée, coffee, and backpacking";
var _myApps = [
	{
		"name" : "Sky",
		"slogan" : "A simplified weather app",
		"image" : "imgs/sky.png"
	},
	{
		"name" : "Blips",
		"slogan" : "Creating memories, one blip at a time",
		"image" : "imgs/blips.png"
	}
];

$(document).ready(function() {
	createBio();
});

function createBio() {
	var name = document.getElementById("_name");
	name.innerText = _name;
	// $("#_name").text(_name);
	$("#_age").append(_age);
	$("#_education").append(_education);
	$("#_profession").append(_profession);
	$("#_interests").append(_interests);

	for (var i = 0; i < _myApps.length; i++) {
		$("ul#_apps").append(
			"<li>"+
				"<img width='50' src='"+_myApps[i]["image"]+"' />"+
				"<p>"+ _myApps[i]["name"] +" - "+ _myApps[i]["slogan"] +"</p>"+
				"<div class='clear-fix'></div>"+
			"</li>");
	};
}