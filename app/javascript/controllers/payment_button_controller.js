import { Controller } from "@hotwired/stimulus"
// import _ from "lodash"

export default class extends Controller {

    static targets = [ "toggleable" ];                  

    // toggle function will be here 
  connect() {
    console.log('loaded');
    //this.element.textContent = "Hello World!!!"
  };

  toggle() {
    console.log(this.toggleableTarget);
    this.toggleableTarget.classList.toggle("hidden");    
 };


  handleClick() {
    console.log('clicked!!');
     this.element.textContent = "Validating ...";
     // document.getElementById("myBtn").disabled = true;
     //this.element.disabled = true;
     this.element.classList = "text-white bg-blue-400 dark:bg-blue-500 cursor-not-allowed font-medium rounded-lg text-sm px-5 py-3.5 text-center";
    //  rounded-lg py-3 px-5 bg-blue-600 text-white block font-medium
     //this.element.classList.toggle("hidden");
     // disabled
    //this.element.textContent = _.intersection([2, 1], [2, 3]);
  };
}
