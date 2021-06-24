document.addEventListener("DOMContentLoaded", function(){
  document.querySelectorAll('.preference').forEach(function(item) {
    item.addEventListener('change', function(event) {
      updatePreference(item);
    })
  });
});

window.updatePreference = function updatePreference(e) {
  var data = e.getAttribute("name")
  var check = e.checked
  var form = new FormData;
  form.append(data, check)
  url = e.getAttribute("data-url");

  var xmlHttp = new XMLHttpRequest();
  xmlHttp.open("PUT", url, true);

  var csrfToken = $('meta[name="csrf-token"]').attr('content');
  xmlHttp.setRequestHeader("X-CSRF-Token", csrfToken);

  xmlHttp.send(form)
}
