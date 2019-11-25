$('document').ready(function (e) {
  insertName()
  var element = document.getElementById("name10")
  var element2 = document.getElementById("name20")
  var nameUser = localStorage.getItem('name');
  element.innerHTML = nameUser
  element2.innerHTML = nameUser

  var cali1 = document.getElementById("cali1");
  var cali2 = document.getElementById("cali2");
  checkGrades()
  cali1.innerHTML = localStorage.getItem('grade1');
  cali2.innerHTML = localStorage.getItem('grade2');

  $('#logout').click(function (e) {
    alert("Exit")
    window.location.href = 'login.html';
  })
});

function checkGrades(){
  $.ajax({
    url: 'http://35.225.18.238:5000/api/grade/id',
    async: false,
    method: 'POST',
    headers: {
      "Authorization": 'Basic ' + localStorage.getItem('credentials').toString()
    },
    data: JSON.stringify({"id": 1}),
    dataType: 'json',
    contentType: 'application/json',
    success: function (data) {
      var cali1_t = data.grade
      localStorage.setItem('grade1', cali1_t);
    },
    error: function (data) {
      alert("Problema con la cali 1")
    }
  });

  $.ajax({
    url: 'http://35.225.18.238:5000/api/grade/id',
    async: false,
    method: 'POST',
    headers: {
      "Authorization": 'Basic ' + localStorage.getItem('credentials').toString()
    },
    data: JSON.stringify({"id": 2}),
    dataType: 'json',
    contentType: 'application/json',
    success: function (data) {
      var cali1_t = data.grade
      localStorage.setItem('grade2', cali1_t);
    },
    error: function (data) {
      alert("Problema con la cali 2")
    }
  });
}