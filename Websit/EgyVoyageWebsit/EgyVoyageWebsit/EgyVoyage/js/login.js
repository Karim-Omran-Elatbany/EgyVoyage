const loginOverlay = document.getElementById('login-overlay');

window.onload = function() {
  loginOverlay.style.display = 'none';
};

const logIn = document.getElementById('lgn');
const body = document.body;
logIn.addEventListener('click', function() {
  loginOverlay.style.display = 'block';
  body.classList.add("stop-scrolling");
});

const closeButton = document.querySelector('.closeBtn');
closeButton.addEventListener('click', function() {
  loginOverlay.style.display = 'none';
  body.classList.remove("stop-scrolling");
});





// Start Alerrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrt
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
// End Alerrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrt




let loginBtn = document.getElementById('signin')
loginBtn.addEventListener("click" , function(event){
  event.preventDefault();
  let email = document.getElementById('username').value
  let password = document.getElementById('password').value
  if(email=='' || password == ''){
    showAlert("Email or Password is Empty",'danger',1300);
  }
  else{
    fetch(`http://egyvoyage2.somee.com/api/User/signin?email=${email}&password=${password}`)
    .then( (res)=> res.json())
    .then((response)=>{
      if (response != true) {
        console.log(response);
        showAlert("Wrong Email or Password",'danger',1400);
      }
      localStorage.setItem("email",email)
      localStorage.setItem("password",password)
      if(response == true){
          document.getElementById("login-overlay").style.display="none"
          fetch(`http://egyvoyage2.somee.com/api/User`)
          .then( (res)=> res.json())
          .then((response)=>{
            console.log( response)
            let user =response
            let email= localStorage.getItem("email")
            for(let i=0; i<user.length; i++){
                if(user[i].email == email){
                  showAlert("logged in successfully",'success',1500);
                  localStorage.setItem("fname",user[i].fName);
                  localStorage.setItem("lname",user[i].lName);
                  localStorage.setItem("country",user[i].nationality);
                  localStorage.setItem("birthdate",user[i].birthdate);
                  localStorage.setItem("gender",user[i].gender)
                  setTimeout(() => {
                    window.location = "/index.html";
                  }, 1200);
                }
            }
          })
          .catch(error =>{
            console.log(error)
          })
      }
    })
    .catch(error =>{
      console.log(error)
    })
  }
})


// Event listener for the first anchor element (triggering forgot password process)
document.querySelector('.first-a').addEventListener('click', function() {
document.getElementById('login-overlay').style.display = 'none';
document.getElementById('forgot-password-overlay').style.display = 'block';

// Event listener for the 'send-reset-link' button
let ContinueBtn = document.getElementById('send-reset-link');
ContinueBtn.addEventListener("click", function(event) {
    event.preventDefault();
    let email = document.getElementById('forgot-email').value;
    if (email === "") {
      showAlert("Code Verification is Empty",'danger',1300);
    } else {
        localStorage.setItem("email", email);
        fetch(`http://egyvoyage2.somee.com/api/User/ForgetPassword?email=${email}`)
            .then((response) => response.json())
            .then((response) => {
                document.getElementById('forgot-password-overlay').style.display = 'none';
                localStorage.setItem("code", response.code);
                document.getElementById('verify-code-overlay').style.display = 'flex';
                document.querySelectorAll('.closeBtn').forEach(function(closeBtn) {
                    closeBtn.addEventListener('click', function() {
                        closeBtn.parentElement.parentElement.parentElement.style.display = 'none';
                    });
                });
            })
            .catch((error) => {
              showAlert("Email Not Found",'danger',1300);
              console.log(error);
              localStorage.removeItem("email");
            });
    }
});

// Event listener for verifying the code
document.getElementById('verify-code-button').addEventListener('click', function(event) {
    event.preventDefault();
    let codeInput = document.getElementById('verify-code').value;
    const storedCode = localStorage.getItem("code");
    if (codeInput === "") {
        showAlert("danger","code field required");
    } 
    else {
      if (codeInput === storedCode) {
        let email = localStorage.getItem("email");
        fetch(`http://egyvoyage2.somee.com/api/User`)
            .then((res) => res.json())
            .then((users) => {
              showAlert("success","Done successful");
                let user = users.find(u => u.email === email);
                if (user) {
                    localStorage.setItem("fname", user.fName);
                    localStorage.setItem("lname", user.lName);
                    localStorage.setItem("country", user.nationality);
                    localStorage.setItem("birthdate", user.birthdate);
                    localStorage.setItem("gender", user.gender);
                    localStorage.setItem("password", user.password);
                    document.getElementById('verify-code-overlay').style.display = 'none'
                    window.location="/index.html"
                    
                } else {
                  showAlert("danger","User not found");
                }
            })
            .catch(error => {
              showFailAlert(error);
            });
      } else {
        document.getElementById('verify-code-overlay').style.display = 'flex';
        showAlert("danger","code not match");
      }
    }
    
});

// Event listeners for closing overlays (initial setup)
document.querySelectorAll('.closeBtn').forEach(function(closeBtn) {
    closeBtn.addEventListener('click', function() {
        document.getElementById('forgot-password-overlay').style.display = 'none';
        document.getElementById('verify-code-overlay').style.display = 'none';
    });
});

// Additional listeners for the initial setup
document.addEventListener('DOMContentLoaded', function() {
    document.querySelector('.first-a').addEventListener('click', function() {
        document.getElementById('login-overlay').style.display = 'none';
        document.getElementById('forgot-password-overlay').style.display = 'none';
    });
});
});



function setupUI(){
  const response = localStorage.getItem("response")
  const code= localStorage.getItem("code")
  const email= localStorage.getItem("email")
  let login =document.getElementById("lgn")
  if(email != null || code != null ){
    login.style.visibility= "hidden" 
    document.querySelector(".user-name").style.display="block"
    let lname = localStorage.getItem("lname");
    let fname = localStorage.getItem("fname");
    let name = fname.concat(" ").concat(lname);
    let userNameText = document.getElementById("user-name-text");
    userNameText.textContent = name;
    
  }
  else{
      login.style.visibility= "visible"
    document.querySelector(".user-name").style.display="none"
      
  }
}
setupUI()


setupUI()
let signoutBtn = document.getElementById("signout");
signoutBtn.addEventListener("click", function(event) {
event.preventDefault();
localStorage.removeItem("code");
localStorage.removeItem("email");
localStorage.removeItem("fname");
localStorage.removeItem("lname");
localStorage.removeItem("country");
localStorage.removeItem("birthdate");
localStorage.removeItem("gender");
localStorage.removeItem("password");
showAlert("You are logged out",'success',1000);
let login = document.getElementById("lgn");
setTimeout(() => {
  login.style.visibility = "visible";
  document.querySelector(".user-name").style.display = "none";
  location.href="/index.html"
}, 1000);
setupUI();
});

