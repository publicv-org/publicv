let selectTag;

function handleSelect(){
  selectTag = document.getElementsByClassName("language-switcher")[0];
  if (selectTag && selectTag.length > 0) {
    if (window.currentLocale == 'en') selectTag.getElementsByTagName('option')[0].selected = 'selected';
    else selectTag.getElementsByTagName('option')[1].selected = 'selected';

    selectTag.addEventListener('change', function(){
      let arr = window.location.host.split('.');
      arr[arr.length-1] = this.value;
      window.location = "http://"+arr.join('.')
    })
  }
}

window.enableSortable = function(){
  $('#sortable, #sortable-edu').sortable({
      axis: 'y',
      stop: function (event, ui) {
        let data = $(this).sortable('serialize');
        let dataURL = this.getAttribute('data-url');

        console.log(data); // serialize data

        $.ajax({
            data: data,
            type: 'POST',
            url: dataURL
        });
      }
  });

  $('#sortable, #sortable-edu').disableSelection();
}

$(document).on('turbolinks:load', () => {
  handleSelect();
  window.enableSortable();
});

(function() {
  const send = XMLHttpRequest.prototype.send
    XMLHttpRequest.prototype.send = function() {
      this.addEventListener('load', function() {
      $('[data-toggle="tooltip"]').tooltip();
      })
      return send.apply(this, arguments)
    }
})()
