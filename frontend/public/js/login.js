$('document').ready(function (e) {
  $('#submit').click(function (e) {
    var user = $('#email').val();
    var password = $('#password').val();
    loginPag(user, password);
  })
});

function insertName(){
  $.ajax({
    url: 'http://35.225.18.238:5000/api/users/name',
    async: false,
    method: 'POST',
    headers: {
      "Authorization": 'Basic ' + localStorage.getItem('credentials').toString()
    },
    data: JSON.stringify({"username": localStorage.getItem('username')}),
    dataType: 'json',
    contentType: 'application/json',
    success: function (data) {
      var name = data.name
      localStorage.setItem('name', name);
    },
    error: function (data) {
      alert("Problema con el nombre")
    }
  });
}

function loginPag(user, pass) {
  var datos = user + ":" + pass ;
  var encodedString = btoa(datos);
  localStorage.setItem('credentials', encodedString);
  $.ajax({
    url: 'http://35.225.18.238:5000/api/token',
    async: false,
    method: 'GET',
    headers: {
      "Authorization": 'Basic ' + encodedString.toString()
    },
    dataType: 'json',
    contentType: 'application/json',
    success: function (data) {
      var type = parseInt(data.id_user_type);
      localStorage.setItem('username', user);
      insertName();
      if (type == 1){
        window.location.href = 'students.html';
      }
      else{
        window.location.href = 'teachers.html';
      }
    },
    error: function (data) {
      alert("Usuario y/o Contraseña Incorrectos");
    }
  });
}