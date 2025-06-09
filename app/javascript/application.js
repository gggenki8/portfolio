document.addEventListener("turbolinks:load", function() {
    const input   = document.getElementById("imageInput");
    const imgElem = document.getElementById("currentProfileImage");
  
    if (!input || !imgElem) return;
  
    input.addEventListener("change", function(e) {
      const file = e.target.files[0];
      if (!file) return;
  
      const reader = new FileReader();
      reader.onload = function(evt) {
        imgElem.src = evt.target.result;
      };
      reader.readAsDataURL(file);
    });
  });
  