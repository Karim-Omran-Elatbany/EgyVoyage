document.getElementById('login').addEventListener('click', function(event) {
    event.preventDefault();
    const email = document.getElementById('your_email');
    const password = document.getElementById('your_pass');

    // Check if email or password fields are empty
    if (!password.value) {
        password.setCustomValidity("Please fill this field");
        password.reportValidity();
    } else {
        password.setCustomValidity("");
    }

    if (!email.value || !password.value) {
        if (!email.value) {
            email.setCustomValidity("Please fill this field");
            email.reportValidity();
        } else {
            email.setCustomValidity("");
        }
        return;
    }
    password.setCustomValidity("");
    email.setCustomValidity("");
    
    axios.post('http://egyvoyage2.somee.com/api/Admin/LoginAdmin', 
        JSON.stringify({
            "email": email.value,
            "password": password.value,
        }), {
        headers: {
            "Content-type": "application/json"
        }
    }).then((res) => {
        console.log(res);
        showAlert("success", "Logged in successfully");
        scroll()
        setTimeout(() => {
            window.location = "all-hotels.html";
        }, 2000); 
        
    }).catch(error => {
        console.log(error);
        showAlert("danger"," This admin does not exist");
        scroll()
    });
});

function scroll(){
    window.scrollTo({
        top:0,
        behavior: "smooth",
    })
}

function showAlert(type,alert) {
    const alertPlaceholder = document.getElementById('alart');
    const wrapper = document.createElement('div');
    wrapper.innerHTML = [
        `<div class="alert alert-${type} alert-dismissible" role="alert">`,
        `  <div>${alert}</div>`,
        '  <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>',
        '</div>'
    ].join('');
    alertPlaceholder.append(wrapper);
}