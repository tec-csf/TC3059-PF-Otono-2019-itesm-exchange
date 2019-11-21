$('document').ready(function (e) {
    $('#boton1').click(function (e) {
        alert("Grades Updated")
      })
      $('#boton2').click(function (e) {
        alert("Grades Updated")
      })
    var element = document.getElementById("name");
    var element2 = document.getElementById("name2");
    var nameU = localStorage.getItem('username');
    element.innerHTML = nameU;
    element2.innerHTML = nameU;
    //insertName(nameU);
    });