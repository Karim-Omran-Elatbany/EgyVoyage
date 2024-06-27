function deleteRoom(id){
    axios.get('http://egyvoyage2.somee.com/api/Room')
    .then(function (response) {
        let room = response.data;
        // console.log(room)
        for (let i =0; i <room.length; i++) {
            if(room[i].id == id){
                localStorage.setItem("name", room[i].name)     
            }
        }
        fetch(`http://egyvoyage2.somee.com/api/Room?id=${id}`, {
            method: "DELETE"
        })
        .then((res) =>{
            console.log(res)
            let div= document.getElementById(`room${id}`)
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