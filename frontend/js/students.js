$('document').ready(function (e) {
  var element = document.getElementById("name");
  var element2 = document.getElementById("name2");
  var nameU = localStorage.getItem('username');
  element.innerHTML = nameU;
  element2.innerHTML = nameU;
  //insertName(nameU);
  });

  /*
function insertName(user){
  $.ajax({
    url: 'http://35.225.18.238:5000/api/token',
    async: false,
    method: 'GET',
    headers: {
      "Authorization": 'Basic ' + localStorage.getItem('credentials').toString()
    },
    dataType: 'json',
    contentType: 'application/json',
    success: function (data) {
      var element = document.getElementById("name");
      element.innerHTML = completeName;
    },
    error: function (data) {
      alert("Problema con el nombre");
    }
  });
}*/

function createTable(){
  $.ajax({
    url: 'http://35.225.18.238:5000/api/grade/student',
    async: false,
    method: 'POST',
    headers: {
      "Authorization": 'Basic ' + localStorage.getItem('credentials').toString()
    },
    dataType: 'json',
    contentType: 'application/json',
    success: function (data) {
      var element = document.getElementById("name");
      element.innerHTML = completeName;
    },
    error: function (data) {
      alert("Problema con el nombre");
    }
  });
}