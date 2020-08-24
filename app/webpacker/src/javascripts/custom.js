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

function handleCount(elem, count){
  if(count > 1000){
    elem.style.backgroundColor='rgb(255, 184, 194)';
    $(elem).next().removeClass('text-muted').addClass('text-danger').html('You have exceeded character limit!')
    $(elem).parents('form').find('.submit-dt').prop('disabled', true);
  }
  else{
    elem.style.backgroundColor='#ffffff';
    $(elem).next().removeClass('text-danger').html(count + '/1000');
    $(elem).parents('form').find('.submit-dt').prop('disabled', false);
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

  $(document).on('input', '.limit-desc', function(){
    handleCount(this, this.value.length);
  });
});
