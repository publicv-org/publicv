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

$(document).on('turbolinks:load', () => {
  handleSelect();

  $(document).on('input', '.limit-desc', function(){
    handleCount(this, this.value.length);
  });
});
