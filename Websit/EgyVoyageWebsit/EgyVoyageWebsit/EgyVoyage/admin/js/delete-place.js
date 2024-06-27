

function deletePlace(id){
    axios.get('http://egyvoyage2.somee.com/api/Place')
        .then(function (response) {
            let place = response.data;
            for (let i =0; i <place.length; i++) {
                if(place[i].id == id){
                    localStorage.setItem("name", place[i].name)    
                }
            }
            
            fetch(`http://egyvoyage2.somee.com/api/Place?id=${id}`, {
                method: "DELETE"
            })
            .then((res) =>{
                console.log(res)
                
                const div= document.getElementById(`place${id}`)
                div.style.display="none"
                let name = localStorage.getItem("name")
                showAlert('success',`${name} has been deleted successfully`)
                scroll()
                localStorage.clear()
            })
            .catch(error =>{
                console.log(error)
            })

        })
        .catch(function (error) {
            console.log(error);
        })
}

function scroll(){
    window.scrollTo({
        top:0,
        behavior: "smooth",
    })
}
function showAlert(type,message) {
    const alertPlaceholder = document.getElementById('alert');
    alertPlaceholder.innerHTML = `
    <div class="alert alert-${type} alert-dismissible fade show" role="alert">
        ${message}
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    `;
}
