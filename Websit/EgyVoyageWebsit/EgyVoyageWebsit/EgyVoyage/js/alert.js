

function showAlert(message, type, duration) {
  var alertBox = document.getElementById("alertBox");
  var alertMessage = document.getElementById("alertMessage");
  alertBox.className = "alert"; // Reset class names
  alertMessage.innerHTML = message;

  if (type === "success") {
    alertBox.classList.add("alert-success");
  } else if (type === "danger") {
    alertBox.classList.add("alert-danger");
  }

  alertBox.classList.add("show");

  setTimeout(function () {
    alertBox.classList.remove("show");
  }, duration);
}

function closeAlert() {
  var alertBox = document.getElementById("alertBox");
  alertBox.classList.remove("show");
}


// Selected Section in Hotels Details
document.addEventListener('DOMContentLoaded', function () {
  const tabs = document.querySelectorAll('.tab');

  tabs.forEach(tab => {
      tab.addEventListener('click', function () {
          tabs.forEach(t => t.classList.remove('active'));
          this.classList.add('active');
      });
  });
});