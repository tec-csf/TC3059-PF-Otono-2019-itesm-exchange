$('document').ready(function (e) {
    var element = document.getElementById("name")
    var element2 = document.getElementById("name2")
    var nameUser = localStorage.getItem('name');
    element.innerHTML = nameUser
    element2.innerHTML = nameUser
    ///////////////////////////////////////////////
    var cali1 = document.getElementById("cali1");
    var cali2 = document.getElementById("cali2");
    checkGrades()
    cali1.innerHTML = localStorage.getItem('grade1');
    cali2.innerHTML = localStorage.getItem('grade2');
    ///////////////////////////////////////////////
    $('#boton1').click(function (e) {
      var cali1 = document.getElementById("cali1");
      updateGrade(2, parseInt(cali1.innerText));
      alert("Grades Updated")
    })
    $('#boton2').click(function (e) {
      var cali2 = document.getElementById("cali2");
      updateGrade(7, parseInt(cali2.innerText));
      alert("Grades Updated")
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
      data: JSON.stringify({"id": 2}),
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
      data: JSON.stringify({"id": 7}),
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

  function updateGrade(id, cali_t){
    $.ajax({
      url: 'http://35.225.18.238:5000/api/grade/update',
      async: false,
      method: 'PUT',
      headers: {
        "Authorization": 'Basic ' + localStorage.getItem('credentials').toString()
      },
      data: JSON.stringify({"id": id, "new_grade": cali_t}),
      dataType: 'json',
      contentType: 'application/json',
      success: function (data) {
      },
      error: function (data) {
        alert("Problema con la cali")
      }
    });
  }