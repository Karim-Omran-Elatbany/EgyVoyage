document.getElementById('toggle-password').addEventListener('click', function () {
  var passwordInput = document.getElementById('confirm-password');
  if (passwordInput.type === 'password') {
    passwordInput.type = "text";
    document.getElementById('toggle-password').innerHTML = `<i class="fa-regular fa-eye"></i>`;
  } else {
    passwordInput.type ="password";
    document.getElementById('toggle-password').innerHTML = `<i class="fa-regular fa-eye-slash"></i>`;
  }
});
document.getElementById('Toggle-password').addEventListener('click', function () {
  var passwordInput = document.getElementById('password');
  if (passwordInput.type === 'password') {
    passwordInput.type = "text";
    document.getElementById('Toggle-password').innerHTML = `<i class="fa-regular fa-eye"></i>`;
  } else {
    passwordInput.type ="password";
    document.getElementById('Toggle-password').innerHTML = `<i class="fa-regular fa-eye-slash"></i>`;
  }
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





function log(){
  document.getElementById("login-overlay").style.display="block"
  const closeButton = document.querySelector('.closeBtn');
  closeButton.addEventListener('click', function() {
    loginOverlay.style.display = 'none';
  });
}

function closeBtn(){
  document.getElementById("login-overlay").style.display = 'none';
}
const registerBtn = document.getElementById('register-btn');
registerBtn.addEventListener('click', function(event) {
  event.preventDefault(); 
  let firstName = document.getElementById('first-name').value.trim();
  let lastName = document.getElementById('last-name').value.trim();
  let gender = document.getElementById('gender').value.trim();
  let phone = document.getElementById('phone').value.trim();
  let country = document.getElementById('country').value.trim();
  let ssn = document.getElementById('ssn').value.trim();
  let birthDate = document.getElementById('bd').value.trim();
  let email = document.getElementById('email').value.trim();
  let password = document.getElementById('password').value.trim();
  let confirmPassword = document.getElementById('confirm-password').value.trim();

  clearErrorMessages();

  let isValid = true;

  if (firstName === '') {
    isValid = false;
    displayErrorMessage('first-name', 'Please enter your first name');
  }
  if (lastName === '') {
    isValid = false;
    displayErrorMessage('last-name', 'Please enter your last name');
  }
  if (gender === '') {
    isValid = false;
    displayErrorMessage('gender', 'Please enter your gender');
  }
  if (phone === '') {
    isValid = false;
    displayErrorMessage('phone', 'Please enter your phone number');
  }
  if (country === '') {
    isValid = false;
    displayErrorMessage('country', 'Please enter your country');
  }
  if (ssn === '') {
    isValid = false;
    displayErrorMessage('ssn', 'Please enter your SSN');
  }
  if (birthDate === '') {
    isValid = false;
    displayErrorMessage('bd', 'Please enter your birth date');
  }
  if (email === '') {
    isValid = false;
    displayErrorMessage('email', 'Please enter your email');
  }
  if (password === '') {
    isValid = false;
    displayErrorMessage('password', 'Please enter your password');
  }
  if (confirmPassword === '') {
    isValid = false;
    displayErrorMessage('confirm-password', 'Please confirm your password');
  }
  if (password !== confirmPassword) {
    isValid = false;
    displayErrorMessage('confirm-password', 'Passwords do not match');
  }

  // If any validation fails, stop further execution
  if (!isValid) {
    return;
  }

  // If all validations pass, proceed with form submission
  axios.post('http://egyvoyage2.somee.com/api/User', {
      "fName": firstName,
      "lName": lastName,
      "gender": gender,
      "phoneNumber": phone,
      "nationality": country,
      "ssn": ssn,
      "birthdate": birthDate,
      "email": email,
      "password": password,
    }, {
      headers: {
        "Content-type": "application/json"
      }
    })
    .then((res) => {
      console.log(res);
      let user = res.data.user;
      localStorage.setItem("code", res.data.code);
      localStorage.setItem("fname", user.fName);
      localStorage.setItem("lname", user.lName);
      localStorage.setItem("email", user.email);
      localStorage.setItem("phone", user.phoneNumber);
      localStorage.setItem("country", user.nationality);
      localStorage.setItem("password", user.password);
      localStorage.setItem("birthdate", user.birthdate);
      localStorage.setItem("ssn", user.ssn);
      localStorage.setItem("gender", user.gender);
      showAlert('Registeration Successfull','success',3000)
      setTimeout(() => {
        location.href="./index.html";
      }, 2000)
    })
    .catch(error => {
      showAlert('Registeration Failed, Please try again','danger',3000)
      console.error('Registration error:', error);
    });
});

function displayErrorMessage(inputId, message) {
  const inputField = document.getElementById(inputId);
  const errorMessage = document.createElement('div');
  errorMessage.className = 'invalid-feedback';
  errorMessage.textContent = message;
  inputField.classList.add('is-invalid');
  inputField.parentNode.appendChild(errorMessage);
}

function clearErrorMessages() {
  const errorMessages = document.querySelectorAll('.invalid-feedback');
  errorMessages.forEach(errorMessage => errorMessage.remove());
  const invalidInputs = document.querySelectorAll('.is-invalid');
  invalidInputs.forEach(input => input.classList.remove('is-invalid'));
}



let loginBtn = document.getElementById('signin')
  loginBtn.addEventListener("click" , function(event){
    event.preventDefault();
    
    let email = document.getElementById('username').value
    let password = document.getElementById('passwordd').value
    if(email==''){
      showAlert("danger","Email field required");
    }else if(password==''){
      showAlert("danger","Password field required");
    }else{
      fetch(`http://egyvoyage2.somee.com/api/User/signin?email=${email}&password=${password}`)
      .then( (res)=> res.json())
      .then((response)=>{
        console.log( response)
        localStorage.setItem("email",email)
        localStorage.setItem("password",password)
        if(response == true){
            document.getElementById("login-overlay").style.display="none"
            fetch(`http://egyvoyage2.somee.com/api/User  `)
            .then( (res)=> res.json())
            .then((response)=>{
              console.log( response)
              let user =response
              let email= localStorage.getItem("email")
              for(let i=0; i<user.length; i++){
                  if(user[i].email == email){
                    showSuccessAlert('success',"logged in successfully")
                    localStorage.setItem("fname",user[i].fName);
                    localStorage.setItem("lname",user[i].lName);
                    // localStorage.setItem("phone",user.phoneNumber);
                    localStorage.setItem("country",user[i].nationality);
                    localStorage.setItem("birthdate",user[i].birthdate);
                    localStorage.setItem("gender",user[i].gender)
                    window.location = "/index.html";
                  }
              }
            
            })
            .catch(error =>{
              console.log(error)
              showAlert('danger',"User not found");
            })
        }
      
      })
      .catch(error =>{
        showAlert('danger',"user not found");
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
          showAlert("danger","Email required");
      } else {
          localStorage.setItem("email", email);
          fetch(`http://egyvoyage2.somee.com/api/User/ForgetPassword?email=${email}`)
              .then((response) => response.json())
              .then((response) => {
                  document.getElementById('forgot-password-overlay').style.display = 'none';
                  localStorage.setItem("code", response.code);
                  document.getElementById('verify-code-overlay').style.display = 'flex';

                  // Event listener for closing overlays
                  document.querySelectorAll('.closeBtn').forEach(function(closeBtn) {
                      closeBtn.addEventListener('click', function() {
                          closeBtn.parentElement.parentElement.parentElement.style.display = 'none';
                      });
                  });
              })
              .catch((error) => {
                  console.log(error);
                  showAlert('danger',"Email not found");
                  localStorage.removeItem("email");
              });
      }
  });

  // Event listener for verifying the code
  document.getElementById('verify-code-button').addEventListener('click', function(event) {
      event.preventDefault();
      let codeInput = document.getElementById('verify-code').value;
      const storedCode = localStorage.getItem("code");
      let email = document.getElementById('forgot-email').value;
      if (codeInput === "") {
          showAlert("danger","code field required");
      } else {
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

