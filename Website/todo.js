onload = todoMain;

function todoMain(){
  let inputElem,
      ulElem;

  getElements();
  addListeners();

  function getElements(){
    inputElem = document.getElementsByTagName("input")[0];
    ulElem = document.getElementsByTagName("ul")[0];
  }

  function addListeners(){
    inputElem.addEventListener("change", onChange, false);
  }

  function onChange(event){
    let inputValue = inputElem.value;
    //ulElem.innerHTML += `<li>${inputValue}</li>`;
    inputElem.value = "";

    let liElem = document.createElement("li");
    liElem.innerText = inputValue;

    let spanElem = document.createElement("span");
    spanElem.innerText = "delete";
    spanElem.className = "material-icons";

    spanElem.addEventListener("click", deleteItem, false);

    liElem.appendChild(spanElem);

    ulElem.appendChild(liElem);

    function deleteItem(){
      liElem.remove();
    }
  }
}