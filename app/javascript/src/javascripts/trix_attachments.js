// Listen for the Trix attachment event to trigger upload
document.addEventListener("trix-attachment-add", function(event) {
  var attachment = event.attachment;
  if (attachment.file) {
    return uploadAttachment(attachment);
  }
});

var newsletterID = new Array();
function uploadAttachment(attachment) {

  // Create our form data to submit
  var file = attachment.file;
  var form = new FormData;
  form.append("attachment[file]", file);

  // Create our XHR request
  var xhr = new XMLHttpRequest;
  xhr.open("POST", "/attachments", true);

  xhr.setRequestHeader('X-CSRF-Token', document.querySelector('meta[name="csrf-token"]').content);

  // Report file uploads back to Trix
  xhr.upload.onprogress = function(event) {
    var progress = event.loaded / event.total * 100;
    attachment.setUploadProgress(progress);
  }

  // Tell Trix what url and href to use on successful upload
  xhr.onload = function() {
    if (xhr.status === 200) {
      var data = JSON.parse(xhr.responseText);
      newsletterID.push(data);
      var contentText = '';
      var content = document.getElementById("trix_editor_content").value
      contentText = content + '<img src="' + data.url + '"/>';
      document.getElementById("trix_editor_content").value = contentText;
    }
  }

  return xhr.send(form);
}

window.onload = function () {
  var save_newsletter = document.getElementById('newsletter_save')
  if (save_newsletter){
    save_newsletter.addEventListener('click',function(){
      for (let i=0; i<newsletterID.length; i++) {
        var news = document.createElement("input");
        var att = document.createAttribute("name");
        news.setAttribute("type", "hidden");
        att.value = "newsletter[attachments][" + [i] + "][" + [newsletterID[i].attachment_id] + "]" ;
        news.setAttributeNode(att);
        document.getElementById("new-attachment").appendChild(news);
      };
    });
  }
}
