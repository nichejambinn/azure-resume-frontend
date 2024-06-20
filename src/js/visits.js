document.addEventListener('DOMContentLoaded', (evt) => {
  fetch("https://resumeapp-engorge.azurewebsites.net/api/inc_visitors", { method: 'POST' })
    .then(response => response.json())
    .then(data => {
      console.log(data)
      const count = data
      document.getElementById("count").innerHTML = count;
    })
    .catch(error => {
      console.error('Error: ', error);
    });
});
