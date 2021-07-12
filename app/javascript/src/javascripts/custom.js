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
  var sort_edu = document.getElementById('sortable-edu');
  var sortable = new Sortable(sort_edu, {
    handle: '.sort_handler',
    animation: 150,

    onEnd: function(event){
      sorting_section = document.querySelectorAll('.list_edu');
      var sorting_params = [];
      for (var i = 0; i < sorting_section.length; i++) {
        data = sorting_section[i].dataset['id'];
        sorting_params.push(data);
      }
      var json_arr = JSON.stringify(sorting_params);
      var xmlhttp = new XMLHttpRequest();
      var form = new FormData;
      form.append("education", json_arr);
      xmlhttp.open('POST', '/cv/educations/update_positions', true);
      xmlhttp.setRequestHeader('X-CSRF-Token', document.querySelector('meta[name="csrf-token"]').content);
      xmlhttp.send(form);
    }
  });
  var sort_exp = document.getElementById('sortable');
  var sortable = new Sortable(sort_exp, {
    handle: '.sort_handler',
    animation: 150,

    onEnd: function(event){
      sorting_section = document.querySelectorAll('.list_exp');
      var sorting_params = [];
      for (var i = 0; i < sorting_section.length; i++) {
        data = sorting_section[i].dataset['id'];
        sorting_params.push(data);
      }
      var json_arr = JSON.stringify(sorting_params);
      var xmlhttp = new XMLHttpRequest();
      var form = new FormData;
      form.append("experience", json_arr);
      xmlhttp.open('POST', '/cv/experiences/update_positions', true);
      xmlhttp.setRequestHeader('X-CSRF-Token', document.querySelector('meta[name="csrf-token"]').content);
      xmlhttp.send(form);
    }
  });
};

document.addEventListener('turbolinks:load', () => {
  handleSelect();
  window.enableSortable();
});
