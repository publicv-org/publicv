document.addEventListener("DOMContentLoaded", function(){
  document.querySelectorAll('.preference').forEach(function(item) {
    item.addEventListener('change', function(event) {
      updatePreference(item);
    })
  });
});

window.updatePreference = function updatePreference(e) {
  $.ajax({
    url: e.getAttribute("data-url"),
    type: 'PUT',
    beforeSend: function (xhr) {
      xhr.setRequestHeader('X-CSRF-Token', document.querySelector('meta[name="csrf-token"]').content)
    },
    data: e.getAttribute("name") + '=' + e.checked
  });
}
