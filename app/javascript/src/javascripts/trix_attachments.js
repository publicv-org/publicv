// Listen for the Trix attachment event to trigger upload
document.addEventListener("trix-attachment-add", function(event) {
  // debugger
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
  // form.append("attachment_type", file.type);
  form.append("attachment[file]", file); // change to suit your circumstances!!

  // Create our XHR request
  var xhr = new XMLHttpRequest;
  xhr.open("POST", "/attachments", true);

  // I am posting to the doucments route - your situation may be different!

  var csrfToken = $('meta[name="csrf-token"]').attr('content');
  xhr.setRequestHeader("X-CSRF-Token", csrfToken);  

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
      return attachment.setAttributes({
        attachment_id: data.attachment_id,
      })
    }
  }

  return xhr.send(form);
}

window.onload = function () {
  document.getElementById('newsletter_save').addEventListener('click',function(){
    for (let i=0; i<newsletterID.length; i++) {
      debugger
      var news = document.createElement("input");
      var att = document.createAttribute("name");
      news.setAttribute("type", "hidden");
      att.value = "newsletter[attachments][" + [i] + "][" + [newsletterID[i].attachment_id] + "]" ;
      news.setAttributeNode(att);
      document.getElementById("new-attachment").appendChild(news);
      // b =  document.getElementById("form_attachment_id").value = newsletterID[i].attachment_id

    };
  });
}
