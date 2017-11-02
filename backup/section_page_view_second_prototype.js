var time_spent_accumulated = [];
var time_spent_discrete = [];
var t;
var timer_is_on = 0;
var current_date = [];
var first_name = getCookie("first_name");
var last_name = getCookie("last_name");

function getCookie(cname) {
    var name = cname + "=";
    var ca = document.cookie.split(';');
    for(var i = 0; i <ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0)==' ') {
            c = c.substring(1);
        }
        if (c.indexOf(name) == 0) {
            return c.substring(name.length,c.length);
        }
    }
    return "";
}

function CookieExist(name) {
    var dc = document.cookie;
    var prefix = name + "=";
    var begin = dc.indexOf("; " + prefix);
    if (begin == -1) {
        begin = dc.indexOf(prefix);
        if (begin != 0) return null;
    }
    else
    {
        begin += 2;
        var end = document.cookie.indexOf(";", begin);
        if (end == -1) {
        end = dc.length;
        }
    }
    // because unescape has been deprecated, replaced with decodeURI
    //return unescape(dc.substring(begin + prefix.length, end));
    return decodeURI(dc.substring(begin + prefix.length, end));
} 

function CheckCookieExist() {
  var myCookie1 = CookieExist("first_name");
  var myCookie2 = CookieExist("last_name");

  if ((myCookie1 == null) || (myCookie2 == null)) {
      alert("Firstname or Lastname empty");
      document.location = "identify.html";
  } else {
      alert("Welcome " + first_name + " " + last_name);
      document.getElementById("first_name").value = first_name;
      document.getElementById("last_name").value = last_name;
  }
}

function timedCount(id) {
    if (time_spent_accumulated[id] == null){
      time_spent_accumulated[id] = 0;
    }
    if (time_spent_discrete[id] == null){
      time_spent_discrete[id] = 0;
    }
    document.getElementById("duration_accumulated"+id).value = time_spent_accumulated[id];
    time_spent_accumulated[id] = time_spent_accumulated[id] + 1;
    document.getElementById("duration_discrete"+id).value = time_spent_discrete[id];
    time_spent_discrete[id] = time_spent_discrete[id] + 1
    t = setTimeout(function(){ timedCount(id) }, 1000);
}

function get_current_date(id) {
    current_date[id] = new Date();
    document.getElementById("current_date"+id).value = current_date[id];
}

function startCount(id) {
    if (!timer_is_on) {
        timer_is_on = 1;
        timedCount(id);
        get_current_date(id);
    }
    document.getElementById("first_name"+id).value = first_name;
    document.getElementById("last_name"+id).value = last_name;
}

function stopCount(id) {
    clearTimeout(t);
    timer_is_on = 0;
    time_spent_accumulated[id] = time_spent_accumulated[id] - 1; //accuracy
    time_spent_discrete[id] = 0; //reset
}

function submitFunction(id) {
    document.getElementById(id).submit();
}

//document.getElementsByTagName("body")[0].innerHTML = "<form> <div>"+document.getElementsByTagName("body")[0].innerHTML+"</div> </form>";

//for (i = 0; i < document.getElementsByTagName("h1").length; i++) { 
//    document.getElementsByTagName("h1")[i].innerHTML = '</div> </form><form id="'+(i+1)+'" action="section_page_view_prototype_api_store" target="dummyframe" method="GET" onmouseleave="submitFunction('+(i+1)+')"> <div onmouseenter="startCount('+(i+1)+')" onmouseleave="stopCount('+(i+1)+')">'+document.getElementsByTagName("h1")[i].innerHTML;
    //document.getElementsByTagName("h1")[i].innerHTML = document.getElementsByTagName("h1")[i].innerHTML;
//}

var j = 0;
var i = 1;
var k = 0;
var l = 0;

var submit_element = [];
submit_element[j] = document.createElement("form");
submit_element[j].setAttribute("id", j); 
submit_element[j].setAttribute("action", "section_page_view_prototype_api_store");
submit_element[j].setAttribute("target", "dummyframe");
submit_element[j].setAttribute("method", "GET");
submit_element[j].setAttribute("onmouseleave", "submitFunction("+j+")");
document.body.insertBefore(submit_element[j], document.body.children[k]);

var track_element = [];
track_element[j] = document.createElement("div");
track_element[j].setAttribute("id", j);
track_element[j].setAttribute("onmouseenter", "startCount("+j+")");
track_element[j].setAttribute("onmouseleave", "stopCount("+j+")");
submit_element[j].appendChild(track_element[j]);

var record_element = [];

record_element[j] = document.createElement("form");
record_element[j].setAttribute("action", "section_page_view_prototype_api_show");
record_element[j].setAttribute("method", "GET");
track_element[j].appendChild(record_element[j]);

var record_input_element = [];
record_input_element[j] = [];

record_input_element[j][l] = document.createElement("input");
record_input_element[j][l].setAttribute("type", "text");
record_input_element[j][l].setAttribute("id", "first_name");
record_input_element[j][l].setAttribute("name", "first_name");

record_input_element[j][l+1] = document.createElement("input");
record_input_element[j][l+1].setAttribute("type", "text");
record_input_element[j][l+1].setAttribute("id", "last_name");
record_input_element[j][l+1].setAttribute("name", "last_name");

record_input_element[j][l+2] = document.createElement("input");
record_input_element[j][l+2].setAttribute("type", "submit");
record_input_element[j][l+2].setAttribute("name", "submit");
record_input_element[j][l+2].setAttribute("value", "records");

record_element[j].appendChild(record_input_element[j][l]);
record_element[j].appendChild(record_input_element[j][l+1]);
record_element[j].appendChild(record_input_element[j][l+2]);

var record_dummy_frame = document.createElement("iframe");
record_dummy_frame.setAttribute("width", "0");
record_dummy_frame.setAttribute("height", "0");
record_dummy_frame.setAttribute("border", "0");
record_dummy_frame.setAttribute("name", "dummyframe");
record_dummy_frame.setAttribute("id", "dummyframe");
track_element[j].appendChild(record_dummy_frame);

while(document.body.children.length > (document.getElementsByTagName("H1").length)+1){
    if ((document.body.children[i].tagName.localeCompare("H1") == 0) || (document.body.children[i].tagName.localeCompare("H2") == 0) || (document.body.children[i].tagName.localeCompare("H3") == 0)){
      j++;
      k++;
      i++;

      submit_element[j] = document.createElement("form");
      submit_element[j].setAttribute("id", j); 
      submit_element[j].setAttribute("action", "section_page_view_prototype_api_store");
      submit_element[j].setAttribute("target", "dummyframe");
      submit_element[j].setAttribute("method", "GET");
      submit_element[j].setAttribute("onmouseleave", "submitFunction("+j+")");
      document.body.insertBefore(submit_element[j], document.body.children[k]);

      track_element[j] = document.createElement("div");
      track_element[j].setAttribute("id", j);
      track_element[j].setAttribute("onmouseenter", "startCount("+j+")");
      track_element[j].setAttribute("onmouseleave", "stopCount("+j+")");
      submit_element[j].appendChild(track_element[j]);

	  record_input_element[j] = [];

	  record_input_element[j][l] = document.createElement("input");
	  record_input_element[j][l].setAttribute("type", "text");
	  record_input_element[j][l].setAttribute("id", "first_name"+j);
	  record_input_element[j][l].setAttribute("name", "first_name");

	  record_input_element[j][l+1] = document.createElement("input");
	  record_input_element[j][l+1].setAttribute("type", "text");
	  record_input_element[j][l+1].setAttribute("id", "last_name"+j);
	  record_input_element[j][l+1].setAttribute("name", "last_name");

	  record_input_element[j][l+2] = document.createElement("input");
	  record_input_element[j][l+2].setAttribute("type", "text");
	  record_input_element[j][l+2].setAttribute("id", "section"+j);
	  record_input_element[j][l+2].setAttribute("name", "section");
	  record_input_element[j][l+2].setAttribute("value", document.body.children[i].innerHTML);

	  record_input_element[j][l+3] = document.createElement("input");
	  record_input_element[j][l+3].setAttribute("type", "text");
	  record_input_element[j][l+3].setAttribute("id", "current_date"+j);
	  record_input_element[j][l+3].setAttribute("name", "current_date");

	  record_input_element[j][l+4] = document.createElement("input");
	  record_input_element[j][l+4].setAttribute("type", "text");
	  record_input_element[j][l+4].setAttribute("id", "duration_accumulated"+j);
	  record_input_element[j][l+4].setAttribute("name", "duration_accumulated");

	  record_input_element[j][l+5] = document.createElement("input");
	  record_input_element[j][l+5].setAttribute("type", "text");
	  record_input_element[j][l+5].setAttribute("id", "duration_discrete"+j);
	  record_input_element[j][l+5].setAttribute("name", "duration_discrete");

	  track_element[j].appendChild(record_input_element[j][l]);
	  track_element[j].appendChild(record_input_element[j][l+1]);
	  track_element[j].appendChild(record_input_element[j][l+2]);
	  track_element[j].appendChild(record_input_element[j][l+3]);
	  track_element[j].appendChild(record_input_element[j][l+4]);
	  track_element[j].appendChild(record_input_element[j][l+5]);
    }
    //alert(document.body.children[i].tagName);
    track_element[j].appendChild(document.body.children[i]);
}
